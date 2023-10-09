Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB60D7BDF37
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376791AbjJIN1s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376813AbjJIN1r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:27:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DADE9D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:27:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28ECC433C9;
        Mon,  9 Oct 2023 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858065;
        bh=hzMWnHRNw13u6jmE/XQkDrcLZucuig/x8S7A59PjNgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+2KOEzmMK/UJpl5wUisKqW+hVGtmkaCSjCmSjhfUD6IhR0z4HRRvPi8o7908lHLi
         jUEfaLixTc7DGmnC7vAYmqbxG5VvJoNI6cp470g9Eiu9GBOSi74gbClFxWCAmX/Ty4
         6zHy/MS0pcGQsoeoxWD/9nNoAvyVG3E+3MmMZZko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.15 65/75] of: dynamic: Fix potential memory leak in of_changeset_action()
Date:   Mon,  9 Oct 2023 15:02:27 +0200
Message-ID: <20231009130113.533659904@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 55e95bfccf6db8d26a66c46e1de50d53c59a6774 upstream.

Smatch complains that the error path where "action" is invalid leaks
the "ce" allocation:
    drivers/of/dynamic.c:935 of_changeset_action()
    warn: possible memory leak of 'ce'

Fix this by doing the validation before the allocation.

Note that there is not any actual problem with upstream kernels. All
callers of of_changeset_action() are static inlines with fixed action
values.

Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/dynamic.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -901,13 +901,13 @@ int of_changeset_action(struct of_change
 {
 	struct of_changeset_entry *ce;
 
+	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
+		return -EINVAL;
+
 	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
 	if (!ce)
 		return -ENOMEM;
 
-	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
-		return -EINVAL;
-
 	/* get a reference to the node */
 	ce->action = action;
 	ce->np = of_node_get(np);


