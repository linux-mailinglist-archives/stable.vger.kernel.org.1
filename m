Return-Path: <stable+bounces-70202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41F95F0F5
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCC51C2386A
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9803918891E;
	Mon, 26 Aug 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODEFaTGy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585FE18891B
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674160; cv=none; b=uuziK3Qbwt7LzbIYF2vNTP45/9d2R/D2GDYlSfUwtCmDMauRdACZS+HQOiFn1OT3QCnfA85XDn2MiMOr191H/84PDK0sp3aRkggflmOug3V1ZchkZd9UyCyaOmP4FetPntPhskLBiSW9Sniq7O+LtYTOxMvWIQX8AWDk0fOViV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674160; c=relaxed/simple;
	bh=ZOz8fpw2rxgRXv5D/w11jjCO9Kr3wRXQoPYtCPk+lks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=no3iXe7JNKGTqf3HiLjd4okZ3/ABtlzJaOc8+NgKJAUsMJliudcWAEP/5COSjlwYUF79AEhfcyJCJUPDPsIwJfFsGVgrRTQRym97ze1VdJvQAE7WNTfNQ0UnwclAGtWa+CDH3FFxG1oeZ7wha0LhNHDv6TTHUEPrb4uAUubv2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ODEFaTGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D501BC4DDEC;
	Mon, 26 Aug 2024 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674160;
	bh=ZOz8fpw2rxgRXv5D/w11jjCO9Kr3wRXQoPYtCPk+lks=;
	h=Subject:To:Cc:From:Date:From;
	b=ODEFaTGyZT3Rrkc2E3vS97sU4ea+qIa52kF2vaWiLP0LrfGg2rFD/OWrpNE28XF33
	 s2M6A3YxB0SILcI8mcGh0pTbFShr2oLJigpwYP1rGG1y+lm2SQ8NFioquDFWmPRlKg
	 hmUIbGzmPsCKcOw+2ve4bBNXzOXHUqJ2ZiRMDan4=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: test for flush/re-add endpoints" failed to apply to 6.10-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:09:17 +0200
Message-ID: <2024082617-malt-arbitrary-2f17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x e06959e9eebdfea4654390f53b65cff57691872e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082617-malt-arbitrary-2f17@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e06959e9eebdfea4654390f53b65cff57691872e Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:24 +0200
Subject: [PATCH] selftests: mptcp: join: test for flush/re-add endpoints

After having flushed endpoints that didn't cause the creation of new
subflows, it is important to check endpoints can be re-created, re-using
previously used IDs.

Before the previous commit, the client would not have been able to
re-create the subflow that was previously rejected.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-6-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fbb0174145ad..f609c02c6123 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3651,6 +3651,36 @@ endpoint_tests()
 		chk_rm_nr 2 1 invert
 	fi
 
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr "before flush" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]


