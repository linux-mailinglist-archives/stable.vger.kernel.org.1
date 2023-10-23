Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5427D31E0
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjJWLOO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjJWLON (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:14:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761192
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:14:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D431CC433CA;
        Mon, 23 Oct 2023 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059651;
        bh=Mcgxmv966d/BJ5PzBJr+ITFjo9S7TIGK0oxKSjmM3pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rU798zzNwiOjg95tKAhmvELNSzwkyqYfyoz2FDdU96N8CTDs3km0MMGXPmDGEhZw0
         rR1goakY/Ipmsv1a5Pzf3ZhO03S4F6JYXcCPO6f0/HSYjfF1Gilp50nKWQ4qBfnwRM
         b31FVZV5MVwcTfKB4xe5vaGTwSN3+ocymcCjkQFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matttbe@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 241/241] selftests: mptcp: join: correctly check for no RST
Date:   Mon, 23 Oct 2023 12:57:07 +0200
Message-ID: <20231023104839.751827901@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts <matttbe@kernel.org>

commit b134a5805455d1886662a6516c965cdb9df9fbcc upstream.

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
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1383,7 +1383,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
-	elif [ $count -lt $rst_tx ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_tx -ne 0 ] && [ $count -lt $rst_tx ]; } ||
+	     { [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
 	else
@@ -1394,7 +1396,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
-	elif [ "$count" -lt "$rst_rx" ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_rx -ne 0 ] && [ $count -lt $rst_rx ]; } ||
+	     { [ $rst_rx -eq 0 ] && [ $count -ne 0 ]; }; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
 	else


