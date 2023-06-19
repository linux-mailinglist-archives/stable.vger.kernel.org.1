Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0169573555C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjFSLEB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjFSLDI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C9910F9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B27C60B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8153DC433C0;
        Mon, 19 Jun 2023 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172540;
        bh=l1wGd2yotprsgEzyO3Jgy40iDfQxl8stbi8bxWzyJdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laZe62m38janRApKqSCBsvlYVrGjrUqMNqwsfa980vkEqc7SGNwI1hUUCk9ek98lz
         e3Seby1Wc+HWGwBRYilzB1IHs4opUEkjDxPJipu2lQyKYFIXW+ja6E9I2Zlnh2gPn5
         7fJHl/zw4PSAE8pg3j9/KleOEEhgPMHhGFkw59g4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.15 105/107] of: overlay: add entry to of_overlay_action_name[]
Date:   Mon, 19 Jun 2023 12:31:29 +0200
Message-ID: <20230619102146.321876642@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

commit 1ac17586c950a2c129393f8a92901a2b357acf24 upstream.

The values of enum of_overlay_notify_action are used to index into
array of_overlay_action_name.  Add an entry to of_overlay_action_name
for the value recently added to of_overlay_notify_action.

Array of_overlay_action_name[] is moved into include/linux/of.h
adjacent to enum of_overlay_notify_action to make the connection
between the two more obvious if either is modified in the future.

The only use of of_overlay_action_name is for error reporting in
overlay_notify().  All callers of overlay_notify() report the same
error, but with fewer details.  Remove the redundant error reports
in the callers.

Fixes: 067c098766c6 ("of: overlay: rework overlay apply and remove kfree()s")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220502181742.1402826-2-frowand.list@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/overlay.c |   27 +++++----------------------
 include/linux/of.h   |   13 +++++++++++++
 2 files changed, 18 insertions(+), 22 deletions(-)

--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -152,13 +152,6 @@ int of_overlay_notifier_unregister(struc
 }
 EXPORT_SYMBOL_GPL(of_overlay_notifier_unregister);
 
-static char *of_overlay_action_name[] = {
-	"pre-apply",
-	"post-apply",
-	"pre-remove",
-	"post-remove",
-};
-
 static int overlay_notify(struct overlay_changeset *ovcs,
 		enum of_overlay_notify_action action)
 {
@@ -178,7 +171,7 @@ static int overlay_notify(struct overlay
 		if (notifier_to_errno(ret)) {
 			ret = notifier_to_errno(ret);
 			pr_err("overlay changeset %s notifier error %d, target: %pOF\n",
-			       of_overlay_action_name[action], ret, nd.target);
+			       of_overlay_action_name(action), ret, nd.target);
 			return ret;
 		}
 	}
@@ -926,10 +919,8 @@ static int of_overlay_apply(struct overl
 		goto out;
 
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
-	if (ret) {
-		pr_err("overlay changeset pre-apply notify error %d\n", ret);
+	if (ret)
 		goto out;
-	}
 
 	ret = build_changeset(ovcs);
 	if (ret)
@@ -952,12 +943,9 @@ static int of_overlay_apply(struct overl
 	/* notify failure is not fatal, continue */
 
 	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_APPLY);
-	if (ret_tmp) {
-		pr_err("overlay changeset post-apply notify error %d\n",
-		       ret_tmp);
+	if (ret_tmp)
 		if (!ret)
 			ret = ret_tmp;
-	}
 
 out:
 	pr_debug("%s() err=%d\n", __func__, ret);
@@ -1193,10 +1181,8 @@ int of_overlay_remove(int *ovcs_id)
 	}
 
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_REMOVE);
-	if (ret) {
-		pr_err("overlay changeset pre-remove notify error %d\n", ret);
+	if (ret)
 		goto err_unlock;
-	}
 
 	ret_apply = 0;
 	ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
@@ -1219,12 +1205,9 @@ int of_overlay_remove(int *ovcs_id)
 	 * OF_OVERLAY_POST_REMOVE returns an error.
 	 */
 	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_REMOVE);
-	if (ret_tmp) {
-		pr_err("overlay changeset post-remove notify error %d\n",
-		       ret_tmp);
+	if (ret_tmp)
 		if (!ret)
 			ret = ret_tmp;
-	}
 
 	free_overlay_changeset(ovcs);
 
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1493,6 +1493,19 @@ enum of_overlay_notify_action {
 	OF_OVERLAY_POST_REMOVE,
 };
 
+static inline char *of_overlay_action_name(enum of_overlay_notify_action action)
+{
+	static char *of_overlay_action_name[] = {
+		"init",
+		"pre-apply",
+		"post-apply",
+		"pre-remove",
+		"post-remove",
+	};
+
+	return of_overlay_action_name[action];
+}
+
 struct of_overlay_notify_data {
 	struct device_node *overlay;
 	struct device_node *target;


