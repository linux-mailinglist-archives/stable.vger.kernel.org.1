Return-Path: <stable+bounces-73613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A396DC33
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05921C228C5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BE5168DC;
	Thu,  5 Sep 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKaKYchq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A60175AB;
	Thu,  5 Sep 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547467; cv=none; b=QUJ5h7xXijOxzEr3u3JwgnwTxmK4UsebsX6MKzusxSchoNSACslGf8W/HrJd9RwQQpnAmyVf6Vd2IstuCjMF/o35/xw7lW796CsHMlN73EZk4FiabL/E99DsZh6scqwjCNTmVeCyrQBC4CNaQjlpokh+kr1oB3jq1xcc0WYwQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547467; c=relaxed/simple;
	bh=wIoARWWEEBq356u2HfG9nx6K+xewKZiLEnJlAh2rauM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtzlYypPwS0O5oM16vypHOrEdmK+p9MjHOSE3A3DlpYKH9fHtJF12hRxqFXL7wbjRmJt7/2Xayf+X17nIcYMtwlr5Gw5TYD8ozDldlgNeE5/oUCGreVak4Fnv0IjvU7IJD5hOYJpCO8oQiTfD64uweU7jdCoD8J5ChCtERdn3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKaKYchq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A6CC4CECA;
	Thu,  5 Sep 2024 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725547466;
	bh=wIoARWWEEBq356u2HfG9nx6K+xewKZiLEnJlAh2rauM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKaKYchqWf6TW8NBf1WKeYcCbtGSyZAaRAwGVVNAiE4dUSgxGnStigTd56fwpwTTQ
	 thKcZZ75gCd/jFykHs6cAOp5SM1WBIgFoY/TpGj70BiPP9PRt5l0HOBGovI/DUOVUs
	 80YgArczZlFjlQSItIcJZtiyabKYrq3bc4fxUy9m6OYqZZR9UaMCudscboT48LC+mM
	 5Um4VJzRcspuz02qP5WHhMdgtf2cAfN/yTHhV1/2Jn0xVFX5FjDsEVeUN4OsIWTNPu
	 eULuBiyT0MOLFkmOA172lfv1dT6qFw3nG3pRTDZeAc1WGAzYgTos/KU04TaMlXtnXp
	 nQEhJO17tQ9iA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y 3/3] selftests: mptcp: join: check re-re-adding ID 0 signal
Date: Thu,  5 Sep 2024 16:43:10 +0200
Message-ID: <20240905144306.1192409-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
References: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=matttbe@kernel.org; h=from:subject; bh=wIoARWWEEBq356u2HfG9nx6K+xewKZiLEnJlAh2rauM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2cN7CDNTZ/PoGf/LCdyafjTgUIt3FOuYE4zpp ieA2xcnxT6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtnDewAKCRD2t4JPQmmg c224D/0QNqK61v0yQO0e0216JBYWK+iuQDG3jpZmTFoqpgpgQc5mxb56tZ03KbafJOZEhBseR1k R++QzE/W3srddUhP+ldg2D95sXIpBt7FhnO9RKwVes73W9wkaeFvZTx15Hd6IDYZ6vn/1HmaY4L J5+itpOGfsdDAGQ2klCWvZlDrmUyoRyxt9Z10bsL6SKmoXWEbaoPsPlH6gTC10G7Z9us7NAAVND 6l9wFqiZ0j4x6LpcsZE2n0i8/23/VsBEIcvgGxd0ZXTRSt3mURgwARD3+KO6Z6ez/NGTM0d1aH+ yRY+OaKwTKjFWPC283m66K+xW0AaV14PBtMWDCqDftV3REDyn0YSBiFj9LWvwzfbBkRhMbNrY8n KiRn+JrN3snMxMGsWWyCNKxYFOmlScjeqknlJ7DryZSkk/mBtAhPHwAWnnnJd5hye/AGdLXVzY1 jXryj8SXldhYlkYQngjiPUfGReKvT7zS6rEZ3utAlReMARBZ3Vrn7Iz9qRla5joAFQb9cHZgb3F zaT1luoTALReUC6M99LYtC0GLIhHS3/KQejvhEhdMXCWkd6F1Yc40GiHid1Mg6wGy/jTXHLl0hs 8tLkb8MjY83RZaZasqxwQlf+l7sABWn47WSU1ZkYVeAIj9cKXdEJlPgi4FQSxMtZhLVxO5749N/ y7MbMO3UH2EFj0Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit f18fa2abf81099d822d842a107f8c9889c86043c upstream.

This test extends "delete re-add signal" to validate the previous
commit: when the 'signal' endpoint linked to the initial subflow (ID 0)
is re-added multiple times, it will re-send the ADD_ADDR with id 0. The
client should still be able to re-create this subflow, even if the
add_addr_accepted limit has been reached as this special address is not
considered as a new address.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh, because the helpers are different in this
  version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index adfdcf1ffef9..446b8daa23e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3387,7 +3387,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3409,7 +3409,15 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 3
+		chk_subflow_nr "" "after re-add ID 0" 3
+
+		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "" "after re-delete ID 0" 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-re-add ID 0" 3
 
 		kill_wait "${tests_pid}"
 		kill_events_pids
@@ -3419,19 +3427,19 @@ endpoint_tests()
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
-		chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
+		chk_join_nr 5 5 5
+		chk_add_nr 6 6
+		chk_rm_nr 4 3 invert
 	fi
 
 	# flush and re-add
-- 
2.45.2


