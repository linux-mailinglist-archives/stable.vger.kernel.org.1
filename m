Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF0B7A3BEF
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbjIQUYd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbjIQUYF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518FE10B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:24:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA50C433C8;
        Sun, 17 Sep 2023 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982240;
        bh=wlgbcoC9w7KL3CY1ae5nit3CoQFYc5LqtnoWGrTz6Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCoOOpP4H70+VZhoIxuq7mQdX1B/N030r22/xExbRhiNl2XjvaN5S9559zwZpTSsH
         5j3xYUOYrqa+Q0K1P+D208mOIOC4XiOntek25ApEZ57innplvLXRBeok+8Ci2WKnqf
         pNcUunzqMgTpqPLvLUDmuLRTqFrtTu5vGoBs2zb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Corey Minyard <minyard@acm.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 193/511] ipmi:ssif: Add check for kstrdup
Date:   Sun, 17 Sep 2023 21:10:20 +0200
Message-ID: <20230917191118.481520022@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit c5586d0f711e9744d0cade39b0c4a2d116a333ca ]

Add check for the return value of kstrdup() and return the error
if it fails in order to avoid NULL pointer dereference.

Fixes: c4436c9149c5 ("ipmi_ssif: avoid registering duplicate ssif interface")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Message-Id: <20230619092802.35384-1-jiasheng@iscas.ac.cn>
Signed-off-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_ssif.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index a3745fa643f3b..87aa12ab8c66f 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1614,6 +1614,11 @@ static int ssif_add_infos(struct i2c_client *client)
 	info->addr_src = SI_ACPI;
 	info->client = client;
 	info->adapter_name = kstrdup(client->adapter->name, GFP_KERNEL);
+	if (!info->adapter_name) {
+		kfree(info);
+		return -ENOMEM;
+	}
+
 	info->binfo.addr = client->addr;
 	list_add_tail(&info->link, &ssif_infos);
 	return 0;
-- 
2.40.1



