Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9427D150F
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377710AbjJTRmj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377950AbjJTRmi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:42:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52785FA
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:42:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B4AC433C8;
        Fri, 20 Oct 2023 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697823757;
        bh=0AVdu4TcFnM1sXR4gdK84lrwdbnIUzQHQsddwQCyIeg=;
        h=Subject:To:Cc:From:Date:From;
        b=FQfo6yxDXTVZR63O/DTGT8p0eniUSPEf4ZfydulfzAYMcEGRtAukG8XjNvpTlHFbk
         YKB4nHEVsN7i+DzdnGFXLZbjUCGmUccW/ktQA01wCZX7+VvGRMOAEsCny6sRRKKufr
         k8ZqJo5pwcBky4B7R2cPLWxFCdledpy3g7sJ+nsQ=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: correctly check for no RST" failed to apply to 6.5-stable tree
To:     matttbe@kernel.org, kuba@kernel.org, martineau@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:42:34 +0200
Message-ID: <2023102034-patience-flaring-b32f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x b134a5805455d1886662a6516c965cdb9df9fbcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102034-patience-flaring-b32f@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b134a5805455d1886662a6516c965cdb9df9fbcc Mon Sep 17 00:00:00 2001
From: Matthieu Baerts <matttbe@kernel.org>
Date: Wed, 18 Oct 2023 11:23:52 -0700
Subject: [PATCH] selftests: mptcp: join: correctly check for no RST

The commit mentioned below was more tolerant with the number of RST seen
during a test because in some uncontrollable situations, multiple RST
can be generated.

But it was not taking into account the case where no RST are expected:
this validation was then no longer reporting issues for the 0 RST case
because it is not possible to have less than 0 RST in the counter. This
patch fixes the issue by adding a specific condition.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231018-send-net-20231018-v1-1-17ecb002e41d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..27953670206e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1432,7 +1432,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
-	elif [ $count -lt $rst_tx ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_tx -ne 0 ] && [ $count -lt $rst_tx ]; } ||
+	     { [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
 		fail_test "got $count MP_RST[s] TX expected $rst_tx"
 	else
 		print_ok
@@ -1442,7 +1444,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
-	elif [ "$count" -lt "$rst_rx" ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_rx -ne 0 ] && [ $count -lt $rst_rx ]; } ||
+	     { [ $rst_rx -eq 0 ] && [ $count -ne 0 ]; }; then
 		fail_test "got $count MP_RST[s] RX expected $rst_rx"
 	else
 		print_ok

