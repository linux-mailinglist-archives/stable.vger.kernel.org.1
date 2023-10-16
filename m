Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04C7CA257
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjJPItD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjJPIs7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:48:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37295E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:48:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C79CC433CD;
        Mon, 16 Oct 2023 08:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446136;
        bh=DtwHixXwr7vUTutv/mnmV2YFruZSaxDlgXUQTAUvjSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNt513pforac7STwRhlkowSTadTRPf5tWiJwqR3YQWXHV+OsQPenyFc2zvahvKt5V
         36IlSDE9pcR7OinUeGdaXO6DtxicL3ER727daiOhCqZtERLfBg09BjnzLD5hpC2Khl
         /WBBq6UZqQ3uyDoBG8Wyw6zKxDlVQ8r0vE/GAfPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.15 075/102] pinctrl: avoid unsafe code pattern in find_pinctrl()
Date:   Mon, 16 Oct 2023 10:41:14 +0200
Message-ID: <20231016083955.696905357@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit c153a4edff6ab01370fcac8e46f9c89cca1060c2 upstream.

The code in find_pinctrl() takes a mutex and traverses a list of pinctrl
structures. Later the caller bumps up reference count on the found
structure. Such pattern is not safe as pinctrl that was found may get
deleted before the caller gets around to increasing the reference count.

Fix this by taking the reference count in find_pinctrl(), while it still
holds the mutex.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/ZQs1RgTKg6VJqmPs@google.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/core.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1007,17 +1007,20 @@ static int add_setting(struct pinctrl *p
 
 static struct pinctrl *find_pinctrl(struct device *dev)
 {
-	struct pinctrl *p;
+	struct pinctrl *entry, *p = NULL;
 
 	mutex_lock(&pinctrl_list_mutex);
-	list_for_each_entry(p, &pinctrl_list, node)
-		if (p->dev == dev) {
-			mutex_unlock(&pinctrl_list_mutex);
-			return p;
+
+	list_for_each_entry(entry, &pinctrl_list, node) {
+		if (entry->dev == dev) {
+			p = entry;
+			kref_get(&p->users);
+			break;
 		}
+	}
 
 	mutex_unlock(&pinctrl_list_mutex);
-	return NULL;
+	return p;
 }
 
 static void pinctrl_free(struct pinctrl *p, bool inlist);
@@ -1126,7 +1129,6 @@ struct pinctrl *pinctrl_get(struct devic
 	p = find_pinctrl(dev);
 	if (p) {
 		dev_dbg(dev, "obtain a copy of previously claimed pinctrl\n");
-		kref_get(&p->users);
 		return p;
 	}
 


