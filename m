Return-Path: <stable+bounces-86858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EA9A4309
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F402878B9
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6116202632;
	Fri, 18 Oct 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTq6GghC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A878165EFC;
	Fri, 18 Oct 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267066; cv=none; b=WH55cwZg7hLZ0K/o8nBygboYfu136Biy8hdx5n2yPr1ztMwPRJfggPXXuaxy/1+3438dUNoJZA8KGFyEpLDS9VV17Dpzi7piZTBhg77c7FKUYuHU2PgQro62ykfwwASkgtT6XZ8w0O1LmyKTOF9mxNhvj3ryf79dw+eAu6Adzqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267066; c=relaxed/simple;
	bh=tWNhPea+zirvXFgOKuVM0VMVU2hRLLxF5oPkOM1U2pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqdJV5VrRLhdRwbJoxJdV0NYpY5gYtROhd9et5Q7mkoMQEgbgQ3z3se0MHRO9yGA0qFJdptI9hYn9nAd3EEOL7xPmRdsPhf+EdKUCuCe58Xa6HpbOAOLEw+O49vgIejOOP0ZbJBovJrMi7Ni3tDdJu7ALdrTuISgLtUudsSqD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTq6GghC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977A3C4CECF;
	Fri, 18 Oct 2024 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267066;
	bh=tWNhPea+zirvXFgOKuVM0VMVU2hRLLxF5oPkOM1U2pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTq6GghCnHXrCXv4RaI/CKlzSXkFy3eYC5hMObpku8xzqj26VhC8NzzMAplFJMjNr
	 9EfcV38+UgCQUOUhW4RU6ER7KvtBq8kGUdJoT6lONNS4zbFcNyPSUftbuZYwcS+fHu
	 MNI7wejR2hS3BXmXAgD84tJJK4CICY43QPv6zH6aBDg/R/h0XPobXVleHeFiBeQUMs
	 RsobSDkZbU9gcKA/ldUuZ955oXgMX3VC/vZi5T7kiW4NYvIp4GBJ1wc8bAxNNPtdhZ
	 hiLG/4gotZMHwU7NRBpxHvMQr666YNRo02ylGe+wpiOaqrXINew2apUKMsndtKkeAu
	 kzpqKfMY1IH6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/4] selftests: mptcp: join: change capture/checksum as bool
Date: Fri, 18 Oct 2024 17:57:37 +0200
Message-ID: <20241018155734.2548697-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018155734.2548697-6-matttbe@kernel.org>
References: <20241018155734.2548697-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062; i=matttbe@kernel.org; h=from:subject; bh=/+HyxqZPJ7nD2CH4P7GeX+tTHgjxcRy0VEoFaYxH6Qc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEoVu9sf/XKTUIiZwZQNDff4werXAxBnC6CLX/ LV58nHlXm2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxKFbgAKCRD2t4JPQmmg c/qLEADnMLWhrS2OSENiGcv8ewn7gh4jWJoxY45wOnoC4+lSaR4nSDX9DdAyUIUlaONum1Fd2QX 4H0EENqKHlmEYqFYVFFWK25W1Vvm+PLe7V+GOSIZDbPs+71i85pCKCNevQ1Bny290jFjQHU5uVL 9JOLTPGzbGw/KA2XBbyc7VQXsIIrW3TmeYwyVA1PkDIcXvA1jeae0zdqsHa60IDi5AW1eRtbFvb RQKG1BzzN4ZrwhqX18DvMvzqOXBO8aybFCuGgbjzED/NNHKbco+eXngJI/NpZOEDp9+oXMy2lVm 9It/WmuWRcA6pcPvgosY6OlBHYhoKxfwpKHSz1urcYsDduKm1Pi52O+RamlJwH8maAvzholLBwd tnx17aYCrI8AcVcw4APwDqLFxK8FGI3NtuUEcFQLY8DJeaUtcjgGlJ2SG6u6K361Y8k/JB7opmX eCK37sJHm2kSbd4ezV6P4KnUELG2f+LzGCjT9xR2JVrMnBq4ZNPI6CH56ESlM8E1/oWpb8OreGL FG5lBV6/+8YW/osV+NJ6vuA4rx7EeBH0nZySH5OwUfAZZIUNOTnNKUgBTblOP9S7UQL4zv3aVyu owJFFlHteI3RkVctQPZBPpkI3gDANU6yhY5cGX0dy7Qwtyf7Jto/NZ1n0u/23p4bKkLMT1iA5Fi yFvhgViwaDL7q9w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 8c6f6b4bb53a904f922dfb90d566391d3feee32c upstream.

To maintain consistency with other scripts, this patch changes vars
'capture' and 'checksum' as bool vars in mptcp_join.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-next-20240223-misc-improvements-v1-7-b6c8a10396bd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to port-based endp")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3c286fba8d5d..a21376b0f61d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -30,11 +30,11 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=0
-checksum=0
+capture=false
+checksum=false
 ip_mptcp=0
 check_invert=0
-validate_checksum=0
+validate_checksum=false
 init=0
 evts_ns1=""
 evts_ns2=""
@@ -99,7 +99,7 @@ init_partial()
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
-		if [ $checksum -eq 1 ]; then
+		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
 	done
@@ -386,7 +386,7 @@ reset_with_checksum()
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 
-	validate_checksum=1
+	validate_checksum=true
 }
 
 reset_with_allow_join_id0()
@@ -419,7 +419,7 @@ reset_with_allow_join_id0()
 setup_fail_rules()
 {
 	check_invert=1
-	validate_checksum=1
+	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
 	local tables
@@ -1024,7 +1024,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
@@ -1125,7 +1125,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -1514,7 +1514,7 @@ chk_join_nr()
 	else
 		print_ok
 	fi
-	if [ $validate_checksum -eq 1 ]; then
+	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -3960,10 +3960,10 @@ while getopts "${all_tests_args}cCih" opt; do
 			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
-			capture=1
+			capture=true
 			;;
 		C)
-			checksum=1
+			checksum=true
 			;;
 		i)
 			ip_mptcp=1
-- 
2.45.2


