Return-Path: <stable+bounces-73021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93ED96B9F1
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE0E1C21F4B
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D31D1728;
	Wed,  4 Sep 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXNVua+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CC1CFEC2;
	Wed,  4 Sep 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448393; cv=none; b=g3XDHOZItLDYMrxnBBA0j2U0i29gUDOkHSolpHNEWIRcmOIuHc8rERt9+sUKexjeCVMW5KkAp4ks1M33OkekIX7j6pNzTaXxrlU1tUutcZmaz60SjdAfRQh3eXTI2IaFPKvlQ7WBb9/53B8PdQG7UU/7ZBKT5ylc1WZowC9LYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448393; c=relaxed/simple;
	bh=PsBUFqO+FxJenhNFv480ZA6O2LgWVXLUWHGUuLoiU6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2QkMgc9ryLqIWh3F+FGTlXt+9qzspSH4YCyaUrXbAxJoQVBZkaHqkObvXXmmELu6yU9ETtdkuKBwcPT378oeIOJoc+G43tCHfWg4mkPU/iUrSDfvqD6QLg0ijFOkk7NHr9c0LxxQAwt0SCg4vm3hbYbJno1+k415RO9K/vB3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXNVua+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCCDC4CEC6;
	Wed,  4 Sep 2024 11:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448392;
	bh=PsBUFqO+FxJenhNFv480ZA6O2LgWVXLUWHGUuLoiU6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXNVua+2bILVaxgE2330YhIcFA/4wev9pq8AQhbyMtg/fu0YYez2M8M0wqXp48tX+
	 nIvrNb08biQS3mwZ9zMme6yHtFz13hcwxrLTrdcJHaRSSvxh0OIuKmyY8MPdkfirpF
	 2jCN18z4ttLBCZ7AK4a6hirsjf1L25YbwdKAIBjdxlCtx9rT/yUYTDGfzCMP5Kj3JF
	 Ls2mUm8tMyKJGtdHJIRviCybgLIo1CS+IBBhI5xFB4exkiHzxcQ31aQUdr6UdSCDKA
	 /pimSk6Bv82jIgkH+7yzpMmLjWDUKz487GQoX/0nyFYQpjQBrP9iWR0TJZY9uzJhpB
	 fxTQOcWlr9ypw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: join: check re-re-adding ID 0 endp
Date: Wed,  4 Sep 2024 13:13:02 +0200
Message-ID: <20240904111302.4095059-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083056-curable-silencer-80fc@gregkh>
References: <2024083056-curable-silencer-80fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862; i=matttbe@kernel.org; h=from:subject; bh=PsBUFqO+FxJenhNFv480ZA6O2LgWVXLUWHGUuLoiU6Y=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2EC+9PHdake2AXbbRgYdXzQ/gS5c9ts2fU4Ny ojN/RHYnJmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthAvgAKCRD2t4JPQmmg c1oSD/0eVPNRhMbJgwFEwAHe2DfKmx7JmJiN06ZtZ7tyswR3ejf7qz7zsIiG1jWYAn/6C5BOAAI xPay2ukFeSBXasltoq8YidrbgIMW4f5llwqL780jQViH7WPUiEUc0vTMitaJ+geNpTXblDQuk4Q yrBNF8FiTmFKzizQNOKai0QsGs5U+qCIYVc7eeEyPcFDk/6ceZv6TbMkxw8/DBtKZk09g/rth7i ffgSXEBZiYLtXuZtu2xtmZcbZ/noTwyWfuVXAw2xWKs7ErAK4CRUWrcaJXxCB8KQ22q6xXFO+6X XWFd5PjicoTqUBjZ5mSPVWE8ePRksHHkBRZ4xfTUg2kM9inLFYe5i5nPHKFJlxf9NF8VWFykrbL lw54NHI6ZYKGC7WWvSo+Bt56L3hk2wLjJSZvLjwW8YC7qrkm2HVXs5K5yHBRzQL5qil9lr4ClgN 3/WGUmiPX6RxcFaYqf8wZreqL/7JGukS8vZOR5df8aRRbnYTHgEaAdypR/fWxqAGO6UXxZgUMia cPS6ACImfOVrayEr7q2zxuEyHf5LsWNkvmdKOeL0zV7yNt8eZHhVCr+zifK/xhVYnSaVrLKgIo2 yMhmiMWuS3NiboEcEYcsNUZYwiKKWwsetl7S5Wd5BMGd8w+QVly+qw7A/nJuzQ18HLSUGdBhU+2 B7w3/gEMkc61Sjg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit d397d7246c11ca36c33c932bc36d38e3a79e9aa0 upstream.

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
[ Conflicts in mptcp_join.sh, because the helpers are different in this
  version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bed980b04624..79e9cac89cd2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3272,7 +3272,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
@@ -3293,18 +3293,21 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "" "after no reject" 3
 
-		pm_nl_del_endpoint $ns2 1 10.0.1.2
-		sleep 0.5
-		chk_subflow_nr "" "after delete id 0" 2
+		local i
+		for i in $(seq 3); do
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			sleep 0.5
+			chk_subflow_nr "" "after delete id 0 ($i)" 2
 
-		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
-		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add id 0" 3
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+			wait_mpj $ns2
+			chk_subflow_nr "" "after re-add id 0 ($i)" 3
+		done
 
 		kill_tests_wait
 
-		chk_join_nr 4 4 4
-		chk_rm_nr 2 2
+		chk_join_nr 6 6 6
+		chk_rm_nr 4 4
 	fi
 
 	# remove and re-add
-- 
2.45.2


