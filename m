Return-Path: <stable+bounces-73008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A439496B99B
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82071C2179C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4D1CF7A4;
	Wed,  4 Sep 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAdI0d9c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0C126C01;
	Wed,  4 Sep 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447925; cv=none; b=UtsQNPESlGW4htyN1iKFkpXo8S4GdwBQfGOeHM8bi+58Y9CHt0qa6DsVJgs/LWQMcoWlyNHQCA1ZhuAm3YEORp/GaepvXIH6LcnakawSEsc8SwWEHnl0JeVJiR5Ehy8UIW4Ucc6NHQ683dQzsjLeRmQ5w6SVr6AM+pmMZbh+gkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447925; c=relaxed/simple;
	bh=rIBulq1yja5ya8JUs5vsTUjwU1FjvnkCMei6Eo1QpRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6AbxVQgAF/hpd7Ap+F3pf3w9edcVpXFAQflgFKJcQ+v/OM+Hsk/I5/qTcTS917CIa/pbufp1TFPdEHpC0tf1n2MxyGB6/vbTFF6e8IJPGftFv91YP2JIlF52itfEqVfXd+al/QTx6b1soFtTqoJO3+0nROntaXJSr2yvkXIdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAdI0d9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A220C4CEC2;
	Wed,  4 Sep 2024 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447923;
	bh=rIBulq1yja5ya8JUs5vsTUjwU1FjvnkCMei6Eo1QpRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAdI0d9c19SzUvnlSbT3BydgEKonXFE369b6tC19GEKUzFU6HPCW98lBYsfAQvJ4a
	 Vm6x457vLivGpflggVEONRa26VsjqEH58DiFXD4N3zuIgaTiIHloZAGuIlvJNeGPSd
	 Jj56qBqFonGLFkcno9GlcWhalqEZFYlPzN5xkChR3JcwQt5B5OV/BnS+ktqzIHp+I4
	 ed+0PGmL0tkQ3aI4zCa1nEtUV/dywI90CgVqMYXRrQdYiOC4bxf8jQHpa3gTnTrVvp
	 kRLJpkE/PxkeBxSdT5Yi8WnPraMXcIwW07Mn5PN2xnZ374Ayw7kMo2TAn5//7Eij0t
	 qDK4rwO6c2j7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: check re-using ID of closed subflow
Date: Wed,  4 Sep 2024 13:05:11 +0200
Message-ID: <20240904110510.4085066-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082600-chokehold-shininess-0f20@gregkh>
References: <2024082600-chokehold-shininess-0f20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=matttbe@kernel.org; h=from:subject; bh=rIBulq1yja5ya8JUs5vsTUjwU1FjvnkCMei6Eo1QpRs=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D7m0AXGV4LrnqMZxn35Hz2deMzcnNTYEwqxe A+sV5SBS4yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg+5gAKCRD2t4JPQmmg c00zEADlVgqoCIX0hBZLSjBMMYlfYRBy+5RIOL4eZOGvo+IBfiBAlV126WWkWOGXpjQWvHV92f4 piP9A9OT0rXsm+hnZRDeR1BCPjUfo/GyTW5PHhMNfr0YpePGxCJT8wy8N7V1pbZ6TutkxUCcZ6W I/N7YBCjWVwnBqaTY4D1w/drWKBUDuQY/3BBc9ZPuvqOdNr7a3OJp1coR3cPJ4JhDijfquPyJhO Q2ED67zTVgxGB8mMEXiMdlD1yIygSsDjg3LTW5GFsZGPJ3+FOaFokPdevG7s99FiBYbZiPceqEm g6vfvp+DgbMc7SEFMddENkoesARgxi/anUNvWgA+M08mIPKFnYYTEQi0J0RyhG9VV4TpxQwF1zp tPmXKusMggt+X7X0FvZzwTYmBJbVh7AHrRB9bfbBi8dv37/0tXZXG980aZ4lOGVIjMQVEBfwnuq inYE0s++iVnGyiGSOIwWPiEF6ZBbwqSTENS2WNIsj3zYsZ8KAnxDFLnLwr/i1htU2fnSX52qsis gRz40FtszEe2Qe+FEmIzJjH7Ibg+XYEG3H5K7U9nz+dyF/baVyeJMsOHWXVBzsjrkBv4qRWI6Yg a2pHhF0IhAi9162INs/+6R2a50lDNSmnhiKYp97zrb0CeWdNWmxkADG8nooxZsHSI50PhJg5k8F IYpYfihiKWEg14A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 65fb58afa341ad68e71e5c4d816b407e6a683a66 upstream.

This test extends "delete and re-add" to validate the previous commit. A
new 'subflow' endpoint is added, but the subflow request will be
rejected. The result is that no subflow will be established from this
address.

Later, the endpoint is removed and re-added after having cleared the
firewall rule. Before the previous commit, the client would not have
been able to create this new subflow.

While at it, extra checks have been added to validate the expected
numbers of MPJ and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-4-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because this subtest has been modified in
  newer versions, e.g. commit 9095ce97bf8a ("selftests: mptcp: add
  mptcp_info tests") added chk_mptcp_info check, commit 03668c65d153
  ("selftests: mptcp: join: rework detailed report") changed the way
  the info are displayed, commit 04b57c9e096a ("selftests: mptcp: join:
  stop transfer when check is done (part 2)") uses the new
  mptcp_lib_kill_wait helper instead of kill_tests_wait.
  Conflicts have been resolved by not using the new helpers, the rest
  was the same. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3d6d92d448c6..c54df4a6627c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -402,9 +402,10 @@ reset_with_tcp_filter()
 	local ns="${!1}"
 	local src="${2}"
 	local target="${3}"
+	local chain="${4:-INPUT}"
 
 	if ! ip netns exec "${ns}" ${iptables} \
-			-A INPUT \
+			-A "${chain}" \
 			-s "${src}" \
 			-p tcp \
 			-j "${target}"; then
@@ -3265,10 +3266,10 @@ endpoint_tests()
 		kill_tests_wait
 	fi
 
-	if reset "delete and re-add" &&
+	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 
@@ -3277,10 +3278,24 @@ endpoint_tests()
 		sleep 0.5
 		chk_subflow_nr needtitle "after delete" 1
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
+
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_attempt_fail $ns2
+		chk_subflow_nr "" "after new reject" 2
+
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "" "after no reject" 3
+
 		kill_tests_wait
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 1 1
 	fi
 }
 
-- 
2.45.2


