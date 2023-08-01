Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D7676A883
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 07:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjHAFwQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 01:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHAFwP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 01:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2E1B5
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 22:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B8AA6146F
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 05:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28440C433C8;
        Tue,  1 Aug 2023 05:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690869133;
        bh=KQ6VXnKvJkwdOMAPsJp7ePVqBxJx5TAk5LfT9yoTK8g=;
        h=Subject:To:Cc:From:Date:From;
        b=oeEnTja8WFkwy4ovR5aLTBYdueK9+kywAPGR0RhyRdgnGTSaRdm34ZLEPzcKHQ+/8
         psiGwj2BaPyuh10KRIaYFO/ghpFp1ynghFMtzRqe0NTYIMdHMZXhP86MqSoyEMToEx
         T+1iaaLxVsziNTiUKEGiDVHyQr7yz8O1M7ZsKYvA=
Subject: FAILED: patch "[PATCH] net: ipa: only reset hashed tables when supported" failed to apply to 6.1-stable tree
To:     elder@linaro.org, dianders@chromium.org, kuba@kernel.org,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 01 Aug 2023 07:52:10 +0200
Message-ID: <2023080110-landscape-probiotic-1f99@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e11ec2b868af2b351c6c1e2e50eb711cc5423a10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080110-landscape-probiotic-1f99@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e11ec2b868af ("net: ipa: only reset hashed tables when supported")
6337b147828b ("net: ipa: use ipa_table_mem() in ipa_table_reset_add()")
8defab8bdfb1 ("net: ipa: don't assume 8 modem routing table entries")
0439e6743c5c ("net: ipa: determine route table size from memory region")
fc094058ce01 ("net: ipa: record the route table size in the IPA structure")
73da9cac517c ("net: ipa: check table memory regions earlier")
5444b0ea9915 ("net: ipa: verify table sizes fit in commands early")
cf13919654d5 ("net: ipa: validate IPA table memory earlier")
fb4014ac76b8 ("net: ipa: kill two constant symbols")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e11ec2b868af2b351c6c1e2e50eb711cc5423a10 Mon Sep 17 00:00:00 2001
From: Alex Elder <elder@linaro.org>
Date: Mon, 24 Jul 2023 17:40:55 -0500
Subject: [PATCH] net: ipa: only reset hashed tables when supported

Last year, the code that manages GSI channel transactions switched
from using spinlock-protected linked lists to using indexes into the
ring buffer used for a channel.  Recently, Google reported seeing
transaction reference count underflows occasionally during shutdown.

Doug Anderson found a way to reproduce the issue reliably, and
bisected the issue to the commit that eliminated the linked lists
and the lock.  The root cause was ultimately determined to be
related to unused transactions being committed as part of the modem
shutdown cleanup activity.  Unused transactions are not normally
expected (except in error cases).

The modem uses some ranges of IPA-resident memory, and whenever it
shuts down we zero those ranges.  In ipa_filter_reset_table() a
transaction is allocated to zero modem filter table entries.  If
hashing is not supported, hashed table memory should not be zeroed.
But currently nothing prevents that, and the result is an unused
transaction.  Something similar occurs when we zero routing table
entries for the modem.

By preventing any attempt to clear hashed tables when hashing is not
supported, the reference count underflow is avoided in this case.

Note that there likely remains an issue with properly freeing unused
transactions (if they occur due to errors).  This patch addresses
only the underflows that Google originally reported.

Cc: <stable@vger.kernel.org> # 6.1.x
Fixes: d338ae28d8a8 ("net: ipa: kill all other transaction lists")
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/r/20230724224055.1688854-1-elder@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index f0529c31d0b6..7b637bb8b41c 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -273,16 +273,15 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
 	if (ret)
 		return ret;
 
+	ret = ipa_filter_reset_table(ipa, false, true, modem);
+	if (ret || !ipa_table_hash_support(ipa))
+		return ret;
+
 	ret = ipa_filter_reset_table(ipa, true, false, modem);
 	if (ret)
 		return ret;
 
-	ret = ipa_filter_reset_table(ipa, false, true, modem);
-	if (ret)
-		return ret;
-	ret = ipa_filter_reset_table(ipa, true, true, modem);
-
-	return ret;
+	return ipa_filter_reset_table(ipa, true, true, modem);
 }
 
 /* The AP routes and modem routes are each contiguous within the
@@ -291,12 +290,13 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
  * */
 static int ipa_route_reset(struct ipa *ipa, bool modem)
 {
+	bool hash_support = ipa_table_hash_support(ipa);
 	u32 modem_route_count = ipa->modem_route_count;
 	struct gsi_trans *trans;
 	u16 first;
 	u16 count;
 
-	trans = ipa_cmd_trans_alloc(ipa, 4);
+	trans = ipa_cmd_trans_alloc(ipa, hash_support ? 4 : 2);
 	if (!trans) {
 		dev_err(&ipa->pdev->dev,
 			"no transaction for %s route reset\n",
@@ -313,10 +313,12 @@ static int ipa_route_reset(struct ipa *ipa, bool modem)
 	}
 
 	ipa_table_reset_add(trans, false, false, false, first, count);
-	ipa_table_reset_add(trans, false, true, false, first, count);
-
 	ipa_table_reset_add(trans, false, false, true, first, count);
-	ipa_table_reset_add(trans, false, true, true, first, count);
+
+	if (hash_support) {
+		ipa_table_reset_add(trans, false, true, false, first, count);
+		ipa_table_reset_add(trans, false, true, true, first, count);
+	}
 
 	gsi_trans_commit_wait(trans);
 

