Return-Path: <stable+bounces-66069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0CB94C196
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4040D2812E9
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A018E77B;
	Thu,  8 Aug 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJwFrzO7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E8018F2EE;
	Thu,  8 Aug 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131462; cv=none; b=hoM+tC81MYSk6kmXVokYFvf3wcWU/AeRPxo70nd0PrgCjELplWV2WhZGlASIyfixd94aDIAZWckFSoTWmqMDdtKBFyNpFd2aSroHyF6mm5lwoSr/xEg16mB3iX5Th9Wym4qQADx+D+sRaXAoidYoG1Is/MqxN8vnmq+9qr/Za2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131462; c=relaxed/simple;
	bh=U73bvWCtUeZ4anSH81C8YpsQtwUujHEQDq1o9VE1pak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eECGBWirtP9oNMx1wDQxhO5VZE8gg/bbz/uBbo2I2DEs+bOKwYF+CcNOovEczE5spNxlHmnECcLhSW+b2VQPsiIwKGyoPf/2y2wkfezWJPFeZ0mzc/oXru/yKim2oRfA10l/1ImrFuUlx7wTeG5e/JzM8PfaZXVrkozXIJXL4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJwFrzO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639D1C32782;
	Thu,  8 Aug 2024 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131461;
	bh=U73bvWCtUeZ4anSH81C8YpsQtwUujHEQDq1o9VE1pak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJwFrzO7AyaPsWBh3Dt3RhlBD7Qd5IGDXP7ax+N2lC5bMJYSJH0NWglDXssPw++SC
	 DIjqxf1dRhZy+6j6XRZjIQfof9AGowe4DBO94uU/mb9FSHeVX3XaGmktF3F4jjGfgo
	 Bp/XoJvPC9h3Thqmn6N4YMEBwSoKpXoKSZq+zMCbZU0mpK5aElHy+Hdk1lpBh8zRF+
	 Jf/gktYgNyCRYMqTYiHHp0tgzgJXru7kzDpOn+cpDHoXuNSRxRKLG2nIgbgX1ifQee
	 JMNtQXNDVxB4IKIxEDzkBB+BAesAqAKCXwOgQlYdZdF0l9WYfKfXdj/UfRImlKuDSW
	 MjwmaBNgNzmjg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: join: validate backup in MPJ
Date: Thu,  8 Aug 2024 17:36:58 +0200
Message-ID: <20240808153657.2317378-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080706-cognitive-parsnip-7428@gregkh>
References: <2024080706-cognitive-parsnip-7428@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5154; i=matttbe@kernel.org; h=from:subject; bh=U73bvWCtUeZ4anSH81C8YpsQtwUujHEQDq1o9VE1pak=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtOYZEKT4e0cUrDQESh989rtBnFTaF2h9VKYOJ tSJhXBKVzSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrTmGQAKCRD2t4JPQmmg c4TfD/wL21tvkemRTnpZ9/LYX1o5OEpGYZeZdNJFsP7fpphhegHS8mr+pnPNfjuLKThReEiQRWv 4S/+yIf+TxqA/+0sgSXhYiT5C0iGA861RTarestqx9VDdbAVBLcQHAX4VjzR2xbRxPC7MdItSJz /x4R9LmGgBsvYiFge1fCyKl0QIK5ge3QQE/3eA87mh7iZpvps8y/qVm9UGf/rstXGfoc8eoG34L uOyD2/eeM7nq78kzE9NY0+cZGtJhjUQumgyFkWQVXICdB0sTRqqIXJgWzMw6RES4LdkJs+ReYtv bzXaGojQp5462ntKhN4268Np049rRl2eIroBHFSFfZ0oY7PMs8rkRSqpvYf6MnUO6hWpWcEtEMw Jjpe1NR05VT9XVVZFe4NSxnz9juSCugN2F/sxkYSW8cJsOj/Vs1Ts8he4fQ7lmMLvG/yXEOUGuy MCu7/WSBlp+cz4fTPZs7bnEULwBNCEDkF9hIOrcgZmsNjIFFYG9Q5WKiWrpJxbz+mhTPqeaSakz j/7HwuJo05QWmFDsT30/Kug9fl/IU03OK++fg3rCr+Dqf9jG4p13vgfeibsU9kvRtNNEl2MWqw/ o58ycAUrIUQPhFnMhqimcnsDjfiOpNXM+RBePZU7FTyl/l4A0eDDBgl4K2/KyrUEusitV61ZkB3 mAfIYLFlZrfoJ4Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 935ff5bb8a1cfcdf8e60c8f5c794d0bbbc234437 upstream.

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
[ Conflicts in mptcp_join.sh because the check are done has changed,
  e.g. in commit 03668c65d153 ("selftests: mptcp: join: rework detailed
  report"), or commit 985de45923e2 ("selftests: mptcp: centralize stats
  dumping"), etc. Adaptations have been made to use the old way, similar
  to what is done just above. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++----
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 51f68bb6bdb8..daa437df8115 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1800,6 +1800,8 @@ chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
+	local mpj_syn=$3
+	local mpj_syn_ack=$4
 	local count
 	local dump_stats
 
@@ -1827,6 +1829,30 @@ chk_prio_nr()
 		echo "[ ok ]"
 	fi
 
+	printf "%-${nr_blank}s %s" " " "bkp syn"
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynBackupRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mpj_syn" ]; then
+		echo "[fail] got $count JOIN[s] syn with Backup expected $mpj_syn"
+		fail_test
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - synack   "
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckBackupRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mpj_syn_ack" ]; then
+		echo "[fail] got $count JOIN[s] synack with Backup expected $mpj_syn_ack"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
 	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
@@ -2633,7 +2659,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 		chk_join_nr 1 1 1
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 	fi
 
 	# single address, backup
@@ -2645,7 +2671,7 @@ backup_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	# single address with port, backup
@@ -2657,7 +2683,7 @@ backup_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc backup" &&
@@ -2665,7 +2691,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc backup both sides" &&
@@ -2674,7 +2700,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc switch to backup" &&
@@ -2682,7 +2708,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc switch to backup both sides" &&
@@ -2691,7 +2717,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 }
 
@@ -3022,7 +3048,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 4 4
 		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 
@@ -3034,7 +3060,7 @@ fullmesh_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 }
@@ -3140,7 +3166,7 @@ userspace_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 1 1 0
-		chk_prio_nr 0 0
+		chk_prio_nr 0 0 0 0
 	fi
 
 	# userspace pm type prevents rm_addr
-- 
2.45.2


