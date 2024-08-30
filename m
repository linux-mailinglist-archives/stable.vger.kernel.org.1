Return-Path: <stable+bounces-71605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873B965F29
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B336628C527
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559B18E37C;
	Fri, 30 Aug 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TTTfxDmj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF218E34B
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013680; cv=none; b=tPzIH4e5j6NYIh4A1R1+OXLBoaAoOaZE4Vcf/lkhYym6A9PqU4zEz/KLB0uoVf2RLNeDhZ3IUj7BChJAyB0X5DIhFndDqj124e0FxhezXbn6aOMWRK7eyBDQ/P9ydE6ZN1GodZ5Hhj5QcedK+/30FgfOYlxxaIbBrP4TvcHz8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013680; c=relaxed/simple;
	bh=eC6r+7J6pQkU4v6hQO/6DXudnkNZ0bL4i5ZlQcdo1rk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ht/+UI7D+f9MduiqMeCuX6HZPeX0jGM1t3c/XY4FSW1SDJPKPQ38y48a5r5obMvoHsnC9jW3b2TETh1vUJS55ScMHaFI3eF9UOsAN3cVB0i0pPT32ohpqFQ2to4bcBFpJyVwQFbouei5P6+RSdCXT+pxWFgUs/+x3np14vSewYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TTTfxDmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A144CC4CEC4;
	Fri, 30 Aug 2024 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013680;
	bh=eC6r+7J6pQkU4v6hQO/6DXudnkNZ0bL4i5ZlQcdo1rk=;
	h=Subject:To:Cc:From:Date:From;
	b=TTTfxDmjO/eWjEAiLm+z1lKNyXx87IrDgg7xQh0a3Ve3im3JM8qkoM3o/Fc/Sk2pm
	 dxxXMVvvdqZxdfjAHqOrX2uPfUn29lgywwSe3umEN1jClBhnkG3IR+xmFXzQss6EfS
	 dd0XFQu6Y2gD8wJ+OuQ8d5cfRSh0OnY65N/gLgjE=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: check re-re-adding ID 0 endp" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:27:57 +0200
Message-ID: <2024083056-curable-silencer-80fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d397d7246c11ca36c33c932bc36d38e3a79e9aa0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083056-curable-silencer-80fc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d397d7246c11 ("selftests: mptcp: join: check re-re-adding ID 0 endp")
5f94b08c0012 ("selftests: mptcp: join: check removing ID 0 endpoint")
65fb58afa341 ("selftests: mptcp: join: check re-using ID of closed subflow")
40061817d95b ("selftests: mptcp: join: fix dev in check_endpoint")
04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")
b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")
03668c65d153 ("selftests: mptcp: join: rework detailed report")
7f117cd37c61 ("selftests: mptcp: join: format subtests results in TAP")
e571fb09c893 ("selftests: mptcp: add speed env var")
4aadde088a58 ("selftests: mptcp: add fullmesh env var")
080b7f5733fd ("selftests: mptcp: add fastclose env var")
662aa22d7dcd ("selftests: mptcp: set all env vars as local ones")
9e9d176df8e9 ("selftests: mptcp: add pm_nl_set_endpoint helper")
1534f87ee0dc ("selftests: mptcp: drop sflags parameter")
595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2 parameters")
0c93af1f8907 ("selftests: mptcp: drop test_linkfail parameter")
be7e9786c915 ("selftests: mptcp: set FAILING_LINKS in run_tests")
d7ced753aa85 ("selftests: mptcp: check subflow and addr infos")
4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d397d7246c11ca36c33c932bc36d38e3a79e9aa0 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:34 +0200
Subject: [PATCH] selftests: mptcp: join: check re-re-adding ID 0 endp

This test extends "delete and re-add" to validate the previous commit:
when the endpoint linked to the initial subflow (ID 0) is re-added
multiple times, it was no longer being used, because the internal linked
counters are not decremented for this special endpoint: it is not an
additional endpoint.

Here, the "del/add id 0" steps are done 3 times to unsure this case is
validated.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a10714b6952f..965b614e4b16 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3576,7 +3576,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 speed=20 \
+		test_linkfail=4 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3608,20 +3608,23 @@ endpoint_tests()
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
-		pm_nl_del_endpoint $ns2 1 10.0.1.2
-		sleep 0.5
-		chk_subflow_nr "after delete id 0" 2
-		chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
+		local i
+		for i in $(seq 3); do
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			sleep 0.5
+			chk_subflow_nr "after delete id 0 ($i)" 2
+			chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
 
-		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
-		wait_mpj $ns2
-		chk_subflow_nr "after re-add id 0" 3
-		chk_mptcp_info subflows 3 subflows 3
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+			wait_mpj $ns2
+			chk_subflow_nr "after re-add id 0 ($i)" 3
+			chk_mptcp_info subflows 3 subflows 3
+		done
 
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 4 4 4
-		chk_rm_nr 2 2
+		chk_join_nr 6 6 6
+		chk_rm_nr 4 4
 	fi
 
 	# remove and re-add


