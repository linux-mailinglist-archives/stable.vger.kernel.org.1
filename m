Return-Path: <stable+bounces-197645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F0C9449A
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 17:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FFB3A4F1D
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5C238C16;
	Sat, 29 Nov 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1EHhbRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7B1A704B;
	Sat, 29 Nov 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435477; cv=none; b=AWjFbA5IgMl5OJjJZqexMgr4qQBPbRBKh8KTPrC4zngIass1xjVs4qffr5eOfQVqVjjK/lAQqqyTZcqoSlknSuDnTR4xf1qsDixPxhv8JNjVALg85mJpmaxpYroL6R8lxpPh+EE3QXl+fJmOhelLa6x0e5h9OX9b1vuXUeMr1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435477; c=relaxed/simple;
	bh=WXLhyQiuglGPMn0zoKp2j+6zR3d0d/j7TJ6XYWa7DNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoR7xpoutG56lftJA21uGmRmuM9HS1BuRHbHKa1kc8B20NFpLyOgr2GgCd1NyIm5a42/zozGWa5aMR5nx0vGdCOD33V2T7U/6SuSN7Uu9VIIbfn5a9YXjmSZ+7QEoJeWN4DTZzPEbYGcrS5Gn+mVi6KV54DuDrZLXoROn1Uh4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1EHhbRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5279FC4CEF7;
	Sat, 29 Nov 2025 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764435476;
	bh=WXLhyQiuglGPMn0zoKp2j+6zR3d0d/j7TJ6XYWa7DNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1EHhbRZqdgcDANF1GPrHlMEexpaaGyUhJOaFoXzqv8neQef+5rQNnrO1dRy06/NP
	 YP/fYGiOmeph/Zf/0aTYOqa/SzO4vltKTNSjGKoAeVcH3UgBZVMwxCiap6fBpXvMl9
	 FxoFs+3wjDin/DHUq+yi8+no8owQf/ly89waE+xDmw23doHt0QzGRMz8Hps/44rk4G
	 0CTYV2IKN0NfMjXLAuB71gn8/sWvM7XWnHiIaz92KSVvF+63avgn/eIn5clWZpl+xg
	 AOZq+lsaHVwKrIotd3GN5M1f8/tEW8kXyvX3RlUJNwxQDTgrkHnMhfDOVHcybl2lUz
	 rxiSTJPrL5Jaw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: join: rm: set backup flag
Date: Sat, 29 Nov 2025 17:57:30 +0100
Message-ID: <20251129165729.2127525-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112013-amusable-thesis-e973@gregkh>
References: <2025112013-amusable-thesis-e973@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8090; i=matttbe@kernel.org; h=from:subject; bh=WXLhyQiuglGPMn0zoKp2j+6zR3d0d/j7TJ6XYWa7DNQ=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK1VX+J+bXt3/j10ukr3EpP+n/cPFjK82rNQ0bVZlPrR UmTkzPWd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEQZSR4XJIsE1o+1Rzb65I szOPfs3c3NGzzbWMx2VzQVej3qo9LYwMc55Fet2/tHyaQpppl52BT8+D2ydEpm49H9K0O0W5L+A WKwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit aea73bae662a0e184393d6d7d0feb18d2577b9b9 upstream.

Some of these 'remove' tests rarely fail because a subflow has been
reset instead of cleanly removed. This can happen when one extra subflow
which has never carried data is being closed (FIN) on one side, while
the other is sending data for the first time.

To avoid such subflows to be used right at the end, the backup flag has
been added. With that, data will be only carried on the initial subflow.

Fixes: d2c4333a801c ("selftests: mptcp: add testcases for removing addrs")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-2-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ The subtests structure has changed quite a bit in newer versions, see
  commit c7d49c033de0 ("selftests: mptcp: join: alt. to exec specific
  tests") and commit ae7bd9ccecc3 ("selftests: mptcp: join: option to
  execute specific tests") for example.
  To resolve the conflicts, the same principle has been applied: adding
  ',backup' for each non-ID0 endpoint in remove_tests. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 +++++++++----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2cf9bb39b22b..33d60d0f9885 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1269,7 +1269,7 @@ remove_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "remove single subflow" 1 1 1
 	chk_rm_nr 1 1
@@ -1278,8 +1278,8 @@ remove_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,backup
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 	chk_join_nr "remove multiple subflows" 2 2 2
 	chk_rm_nr 2 2
@@ -1287,7 +1287,7 @@ remove_tests()
 	# single address, remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
@@ -1297,9 +1297,9 @@ remove_tests()
 	# subflow and signal, remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1308,10 +1308,10 @@ remove_tests()
 	# subflows and signal, remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
 	chk_join_nr "remove subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1320,9 +1320,9 @@ remove_tests()
 	# addresses remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup id 250
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
@@ -1332,10 +1332,10 @@ remove_tests()
 	# invalid addresses remove
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal,backup
 	# broadcast IP: no packet for this address will be received on ns1
-	ip netns exec $ns1 ./pm_nl_ctl add 224.0.0.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 224.0.0.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
@@ -1345,10 +1345,10 @@ remove_tests()
 	# subflows and signal, flush
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1358,9 +1358,9 @@ remove_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,backup id 150
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
 	chk_rm_nr 3 3
@@ -1368,9 +1368,9 @@ remove_tests()
 	# addresses flush
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup id 250
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
@@ -1380,9 +1380,9 @@ remove_tests()
 	# invalid addresses flush
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal,backup
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal,backup
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
-- 
2.51.0


