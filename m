Return-Path: <stable+bounces-71603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D42965F26
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2BCB28F37
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2E170826;
	Fri, 30 Aug 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WDx83lQR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD4188CA4
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013665; cv=none; b=EoeW2lEQ6C1Vc/Faxok3FaJGHBisSd4SStIi09NgrsesHSHuYug4m2qXAQyGX3UR/+BLyS2ykPi34WL1Y+2WlwwVeOLeWk+qf00Yyj5tqOYdsYvsRlbOHvyLHC99tMNAFLUcA3C/1qFmfFcZB2Z0D+LgbApRlY0+csEFto1QjSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013665; c=relaxed/simple;
	bh=0dwDFiAOWJ8c2F25MKC9SrYLN/nPxPIDnjkYM45Ay4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e2H1A2GqAW+pPjL4Ub7w+VJOp8D3SAz4yG+yuK8BTwvYgXFsemT7bVcn9oYuT2Wlp/uXMmtMJPAJHZ2lnKwBllV66T9MIiVwYqkWF2spflgZeJAGXEE2o3OAV/TfgcQQys90o/8FT40/DBQ+LUAa3QwWCN1aWVy2Gf8BgcYAylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WDx83lQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB56C4CEC2;
	Fri, 30 Aug 2024 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013665;
	bh=0dwDFiAOWJ8c2F25MKC9SrYLN/nPxPIDnjkYM45Ay4g=;
	h=Subject:To:Cc:From:Date:From;
	b=WDx83lQR5um5JKdH+zzbOb+LoxB7f1ozDvyWyJ1Apt9a/zCAG+E0R74ZGdXzqNtUG
	 L6dgkGdzfyvBPo94bdImmuJa6+O7iyam2hCD3DKqE7nZIzdwUYyL80OPd/HVB0xeuP
	 2DFHlerJkh3KSdNyMg8+njmxS76BNxZbRGvrQcWk=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: no extra msg if no counter" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,geliang@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:27:34 +0200
Message-ID: <2024083034-turret-available-e570@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 76a2d8394cc183df872adf04bf636eaf42746449
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083034-turret-available-e570@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

76a2d8394cc1 ("selftests: mptcp: join: no extra msg if no counter")
e7c42bf4d320 ("selftests: mptcp: use += operator to append strings")
e3aae1098f10 ("selftests: mptcp: connect: fix shellcheck warnings")
61c131f5d4d2 ("selftests: mptcp: add mptcp_lib_get_counter")
b850f2c7dd85 ("selftests: mptcp: add mptcp_lib_is_v6")
bdbef0a6ff10 ("selftests: mptcp: add mptcp_lib_kill_wait")
757c828ce949 ("selftests: mptcp: update userspace pm test helpers")
80775412882e ("selftests: mptcp: add chk_subflows_total helper")
06848c0f341e ("selftests: mptcp: add evts_get_info helper")
629b35a225b0 ("selftests: mptcp: display simult in extra_msg")
9168ea02b898 ("selftests: mptcp: fix wait_rm_addr/sf parameters")
4d016ae42efb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76a2d8394cc183df872adf04bf636eaf42746449 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:31 +0200
Subject: [PATCH] selftests: mptcp: join: no extra msg if no counter

The checksum and fail counters might not be available. Then no need to
display an extra message with missing info.

While at it, fix the indentation around, which is wrong since the same
commit.

Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if MIB counter not supported")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 75458ade32c7..a10714b6952f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1112,26 +1112,26 @@ chk_csum_nr()
 
 	print_check "sum"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns1" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg+=" ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		fail_test "got $count data checksum error[s] expected $csum_ns1"
 	else
 		print_ok
 	fi
 	print_check "csum"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns2" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg+=" ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		fail_test "got $count data checksum error[s] expected $csum_ns2"
 	else
 		print_ok
@@ -1169,13 +1169,13 @@ chk_fail_nr()
 
 	print_check "ftx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
-	if [ "$count" != "$fail_tx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg+=",tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		fail_test "got $count MP_FAIL[s] TX expected $fail_tx"
 	else
 		print_ok
@@ -1183,13 +1183,13 @@ chk_fail_nr()
 
 	print_check "failrx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
-	if [ "$count" != "$fail_rx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg+=",rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		fail_test "got $count MP_FAIL[s] RX expected $fail_rx"
 	else
 		print_ok


