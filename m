Return-Path: <stable+bounces-73023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3066996BA0A
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89698B235C5
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03561D54D9;
	Wed,  4 Sep 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV4lU7yG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD71CF2B0;
	Wed,  4 Sep 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448508; cv=none; b=i9Bic2KHu7oKfRQVFItiTbHE15bHdxwV3ZOu0NVeGITf+uNgTTEujg7FpCTJTfYYG2Ou58kNH7p8aYpyv8OP6/Hb6lN+l9iSEvj6Pz5MrqPTV0TXqz9WWHxxBUR/0HaGmWrUVPotGFcgEQBcwFC0ATczO/M3QEYFM9TevwfxMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448508; c=relaxed/simple;
	bh=uYNsJqnkyHpkK5uNB6NpPRGRu7ZQUrF6rHKdA4DIVGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCLYcVMMvbUKQAaZ3MuW9D7hdKlTen6gLFmc6vB5HB0e/3dwW5EUTi79N9Et0CuLV8cjUkqnLLxEj0nwFt/BaEd9e7i8Kr6LXJxlGKXTaSql05x2eFOfobBS5j5J4y8mtRIdr3OVToAOdw7lnfe4K/xaArbqu4y/rKz0cRUeSR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV4lU7yG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9574CC4CEC2;
	Wed,  4 Sep 2024 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448508;
	bh=uYNsJqnkyHpkK5uNB6NpPRGRu7ZQUrF6rHKdA4DIVGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OV4lU7yGbgKXjKpmoSDVw4j1CQxTO7MXoTgsOoUZoO6aRR/EFDaEZ57+PU2MslSeU
	 mozuDfsYqdauupR5sfeIYdDhKvVly0squy6L1YIYvDQjcg0s9lrlti/iOCiX37XD/t
	 EEvcBA9FTl0dd4/F/tZ58SreO9lGcrYzXRE02mmGbsBLrAU6iOhhQfBIKDkFOPblvF
	 oWvL6CDY7yWck091jd7OKzrB0Ani5gxRphW31PchIotux0WBB6bSZd9z8Re1kU73Vd
	 zh97NqI+1zhDHuA6f8U3NJIO3kjyYtNuZrzpoVtTxg60nKEUN9uCOs1GhG2q1SObrO
	 awETkwILV1pLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: join: check re-re-adding ID 0 signal
Date: Wed,  4 Sep 2024 13:15:01 +0200
Message-ID: <20240904111500.4097532-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083033-whoopee-visa-f9dd@gregkh>
References: <2024083033-whoopee-visa-f9dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=matttbe@kernel.org; h=from:subject; bh=uYNsJqnkyHpkK5uNB6NpPRGRu7ZQUrF6rHKdA4DIVGM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2EE0mWSu3ZiN1/O7Pb86Uqg73jKugEB48i0Jx suvHs9ATIeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthBNAAKCRD2t4JPQmmg c7W8D/9/L+U1kFLc/Qw5eMbEF0VLVAnzkdxWTW2VbzNZksmMzhsoVL6rhhdU9gOx8bqJRsTW1Cq R15eClkMYu7L00IOmuqldz/zs8dOhdnNZNnZZcfWO0lCKOvdpQGxCcW/67eAIb3hqpWkIiOqZmt Bi1Jbb9NAiMXjC/iSokjSYOFtP1gquayYGOEsYPRNve6ANJgG68zcr9DLwjTBat7prQcdlGbOE5 5FUsJa9iCC2nhnEw2a2aIC/h4deMaPBHdwEb6CRdkQpIgIyp6r6kEt7G6eEtfkByq0N6m91HaTc FZvv4Fh7GhOg2ptxNSmzrBz8QRhEEBW2zmQJYm5hHLIJIJRWqMBeEaEUTYMgH5lyIvLhMN32ggL CK1BAMguti3uYFuFEGH1pjF6ae8xF3Ve+HLI/rAlOXeD8/3VD3wd74NwJHwRCpYoGcaZj4liwSR lEfYUud8sQlSCtGMFxMmAosSMo8Cn2UMjU62mM19zR8MjQ6KOZpDWXLZ0SKFVuCWRqjQdAkiMnI sFWRFnU+OKgXO+YLu/uugwJrA4+WqjwZYaglPp8Y5QSq2piHI2kZl8cKGb6Wp+WJyIvBme85FvJ d+J048h+VGwBR6E1kdmyjfElunIAg4flevDwowZTPNcPLG3uK3Ajn4KbS3RpG4ssQ/aJ1iwis+C V+kgr9R/6JdvviA==
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
index 79a39e30842b..20561d569697 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3390,7 +3390,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3412,7 +3412,15 @@ endpoint_tests()
 
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
@@ -3422,19 +3430,19 @@ endpoint_tests()
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


