Return-Path: <stable+bounces-66135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729094CCFB
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAED72832C8
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8D19148A;
	Fri,  9 Aug 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrzCdi0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75DD190686;
	Fri,  9 Aug 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194611; cv=none; b=iOTJ+mT2MOF4y70RDbdAh3iiG6xHT60Xm652RBl9J8NOWONH8eI2yZ7fzwEycqQrJpAAOSjo4wXOmsw3qWe7/KML0SPVwzBchjrhEQmLnne6VkefO4dLDaH5u1LJlnKVeT5GpM9LWics3i1WLNKiKyu/F7iKFkYmdcpGAJjs+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194611; c=relaxed/simple;
	bh=fSNUHZG7zAnG51HSZkxuVGpiYu//yAaf0JAgTKCH2TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1NtWTx9nGKxJBY9VRe2mh+Cw4J7Y/JyAWxJBlZPIW3e9krEfdCIEbmogGNOL4g8kVp21M8v15PbgXsU5c2F0XYjzx8YX7/5DbHXnzYLSFYz5tvtk5EVmTPCBudoVRz4W79sgpj8rinUCs5Rjtjaj8ZsNQimlizuv7jqwIlsQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrzCdi0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07425C4AF0D;
	Fri,  9 Aug 2024 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194610;
	bh=fSNUHZG7zAnG51HSZkxuVGpiYu//yAaf0JAgTKCH2TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrzCdi0VVpa3HKsnmK/2COWRR7LLFjVq54eaWcMzH7VsmdkSsMrKojF4z/L5vriXI
	 k/MVVWdX4uKjfxtUE32bEGhmuxXzjUc43KDVmXWuxrNSYgV9VVCz4v39IQTMr6CjDo
	 vYDaj53ZBscDUUL45wlgju0+UXsbJgCbOby4RB/Qhp9ZD2rvwpBVbwh1ULzLPyYSKo
	 pNw1s9FpfjWmNdKW4TOXGyFW5yx+YxUvnYT9494/c25cuY7Szku+ajGlDyHECOnkk8
	 SGClusw2HO3/auISO6rX5fk1D/3e/1aNxrSfYLfMO74qfp9PWjvPKzZELDAVIqfsBf
	 dC5voKSNjmS4Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] selftests: mptcp: join: validate backup in MPJ
Date: Fri,  9 Aug 2024 11:10:03 +0200
Message-ID: <20240809091002.2702612-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080707-embassy-deepness-401f@gregkh>
References: <2024080707-embassy-deepness-401f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3392; i=matttbe@kernel.org; h=from:subject; bh=fSNUHZG7zAnG51HSZkxuVGpiYu//yAaf0JAgTKCH2TE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdzqEkJ6gCXZBwBhZHYvA8WzsFVf7tWB1e18i ot8t32ARGyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXc6gAKCRD2t4JPQmmg c37tEADEIYh3k0TWvPZ0dvrtAmvplllVzt673HpkI98WFNn9IQU0YahjgYa4D/fx+LQyf9+mf6O Srefnm/4VcS84kIXvyp34WVu3aagfhx+bPTrf+wTSssJsH4lhPno0foMdkxf6tRgRRO8sdblSGz ccnTJjX2KxRH/gd9hAsbiMTYoyWfNz14Gc8GhDXji30fIWNLieR+AAHVbHVAcVOCOK9/QqpkDPN N4oDOxkBK4u4hSY2kMxUtHUeC+KWhYsGTticngwGzopJKPg0SMmbsHPAUtmHjAMYmBM4SyksiGZ dUB+R5HxqDtkyA7iUL1WzX678jEWrJwuzl85jfq7q6CkEUy8Jyjys3JljQbva11nkS09Og+1slU 5RIHhRN6bXQk6xtw75ZzWJyKg2J7r4B39h399CHbIdvYJSR+8S84P+0fstIrLtM6ev5kUL8coQw L+8sw//h+fsHs6kat8RVNsGjSphn5Q8FXDmCxoZYUf8OBjEXImPrpOLvE7jKW2CN3s6z1sEbG4d 3OO/XI0KeVeyN55Q49ZkUwtnH0AWZQcOQDN0w+p2VV0McE65x6L/UzWmD42MsrKIZDVtXlUfMzC ijKDdjwhE9gN8l8PNeHvado3Z/O900r6GNHfpbpz6Jp5Z14zbtks6ep+Ec0Hao2uU28wCYh9FXI ToeViB4bCwtYmsA==
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
  to what is done just above.
  Also, in this version, some subtests are missing. Only the two using
  chk_prio_nr() have been modified. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e725285298a0..182323b1acc5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -925,6 +925,8 @@ chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
+	local mpj_syn=$3
+	local mpj_syn_ack=$4
 	local count
 	local dump_stats
 
@@ -952,6 +954,30 @@ chk_prio_nr()
 		echo "[ ok ]"
 	fi
 
+	printf "%-39s %s" " " "bkp syn"
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynBackupRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mpj_syn" ]; then
+		echo "[fail] got $count JOIN[s] syn with Backup expected $mpj_syn"
+		ret=1
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
+		ret=1
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
 	if [ "${dump_stats}" = 1 ]; then
 		echo Server ns stats
 		ip netns exec $ns1 nstat -as | grep MPTcp
@@ -1557,7 +1583,7 @@ backup_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
-	chk_prio_nr 0 1
+	chk_prio_nr 0 1 1 0
 
 	# single address, backup
 	reset
@@ -1567,7 +1593,7 @@ backup_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
-	chk_prio_nr 1 0
+	chk_prio_nr 1 0 0 0
 }
 
 add_addr_ports_tests()
-- 
2.45.2


