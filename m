Return-Path: <stable+bounces-65573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C037194A9CB
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFABB2AA19
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60A339B1;
	Wed,  7 Aug 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="biDZOVJV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E929D06
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040170; cv=none; b=DYQms6SWf7LHpZg5xwJoqQtEZRftpyatihBuqDDthAbyta6QSxK8W8XtRMfR0gartmjp1bvXMNpP67V8MnLJQ134H4plKyVMjh0mjioOVWb2J2X5BHQzYjy+WRWJZmfIVD8WXcHBBk4xo27d3r/vfUCsnag3zlnCyh8YRMA8uzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040170; c=relaxed/simple;
	bh=n++BAY60kdKDo5jJ6RrPiWfOzjosrWjY//c5aXF2EJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sN0E2dkF/w8z5f1Yzsoew2CHHeI96yFo/WFHLzTSzpbviAneOUTgh6fD13OTIAMyEg+PHttQRxAeyAORbcmsPTTwS3LIbcCAzbKqVgeRSvlo1oegfkvN3IYlGPYw+v3Lp7c9SWS9CUwnYIOdvuRKwp19QNSM8hF6ljn8HF8iuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=biDZOVJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4646C32781;
	Wed,  7 Aug 2024 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040170;
	bh=n++BAY60kdKDo5jJ6RrPiWfOzjosrWjY//c5aXF2EJU=;
	h=Subject:To:Cc:From:Date:From;
	b=biDZOVJVPVS3Zu8T+wnHI0bJdJWWN0/pCzjCPXGVP1fP7CGHBoilLxv0FxFeP3yiR
	 tZym01ICCTGMmE2aeDZZbif/7GVW7XvJwPdrwj2KjflskXPjjYjP0j5KhnyH4e96Kn
	 1bIjf5hM6tNmHOEv8qLc68mL3nKJLSgmPTl4xh/k=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: validate backup in MPJ" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:16:06 +0200
Message-ID: <2024080706-cognitive-parsnip-7428@gregkh>
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
git cherry-pick -x 935ff5bb8a1cfcdf8e60c8f5c794d0bbbc234437
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080706-cognitive-parsnip-7428@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

935ff5bb8a1c ("selftests: mptcp: join: validate backup in MPJ")
985de45923e2 ("selftests: mptcp: centralize stats dumping")
0639fa230a21 ("selftests: mptcp: add explicit check for new mibs")
9095ce97bf8a ("selftests: mptcp: add mptcp_info tests")
070d6dafacba ("selftests: mptcp: stop tests earlier")
a635a8c3df66 ("selftests: mptcp: allow more slack for slow test-case")
a3735625572d ("selftests: mptcp: make evts global in mptcp_join")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 935ff5bb8a1cfcdf8e60c8f5c794d0bbbc234437 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:27 +0200
Subject: [PATCH] selftests: mptcp: join: validate backup in MPJ

A peer can notify the other one that a subflow has to be treated as
"backup" by two different ways: either by sending a dedicated MP_PRIO
notification, or by setting the backup flag in the MP_JOIN handshake.

The selftests were previously monitoring the former, but not the latter.
This is what is now done here by looking at these new MIB counters when
validating the 'backup' cases:

  MPTcpExtMPJoinSynBackupRx
  MPTcpExtMPJoinSynAckBackupRx

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it will help to validate a new fix for an issue introduced by this
commit ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55d84a1bde15..e6c8d86017f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1634,6 +1634,8 @@ chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
+	local mpj_syn=$3
+	local mpj_syn_ack=$4
 	local count
 
 	print_check "ptx"
@@ -1655,6 +1657,26 @@ chk_prio_nr()
 	else
 		print_ok
 	fi
+
+	print_check "syn backup"
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynBackupRx")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$mpj_syn" ]; then
+		fail_test "got $count JOIN[s] syn with Backup expected $mpj_syn"
+	else
+		print_ok
+	fi
+
+	print_check "synack backup"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckBackupRx")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$mpj_syn_ack" ]; then
+		fail_test "got $count JOIN[s] synack with Backup expected $mpj_syn_ack"
+	else
+		print_ok
+	fi
 }
 
 chk_subflow_nr()
@@ -2612,7 +2634,7 @@ backup_tests()
 		sflags=nobackup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 	fi
 
 	# single address, backup
@@ -2625,7 +2647,7 @@ backup_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	# single address with port, backup
@@ -2638,7 +2660,7 @@ backup_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc backup" &&
@@ -2647,7 +2669,7 @@ backup_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc backup both sides" &&
@@ -2657,7 +2679,7 @@ backup_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc switch to backup" &&
@@ -2666,7 +2688,7 @@ backup_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc switch to backup both sides" &&
@@ -2676,7 +2698,7 @@ backup_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 }
 
@@ -3053,7 +3075,7 @@ fullmesh_tests()
 		addr_nr_ns2=1 sflags=backup,fullmesh speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 
@@ -3066,7 +3088,7 @@ fullmesh_tests()
 		sflags=nobackup,nofullmesh speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 }
@@ -3318,7 +3340,7 @@ userspace_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 0
-		chk_prio_nr 0 0
+		chk_prio_nr 0 0 0 0
 	fi
 
 	# userspace pm type prevents rm_addr


