Return-Path: <stable+bounces-48548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FAE8FE978
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E714282356
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EFA19AA57;
	Thu,  6 Jun 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ds2RHbNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B719645B;
	Thu,  6 Jun 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683028; cv=none; b=MMCx2SfHTPvzek64qVOU3UpQQox8wArpMpV/P436H4BjQLe8qgFLcqeETTnX1pkA2dJeTIBcQCAi7a212qYqKQIXbpesFr4f04yqTBB4eSF1rIlz5J0nVF6P54rt1yB8AAR2+82xmoV7cCtii8Yd7/TCxgg2qHLoHj2YLL9D10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683028; c=relaxed/simple;
	bh=NLhxo9T39QlNmQcpPZlAtehdHN8mVyXvVAk4fM2ugw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLiPThXhrkoBYNAdBmyQWLGVWakQy+G9ZYZcEKiAve/gm8Phy8EwdZh9YsDrcQ/d1w//cSyWay0Y5/JGmrsGQm18zNLx8CZWrnSBvMbN9PIQHgTXNeGMNW+tqKzuISzcqhe3zythpNeSdJvrLegHqnN4TuoxqnyLbm5+sV7N+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ds2RHbNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B44C32782;
	Thu,  6 Jun 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683028;
	bh=NLhxo9T39QlNmQcpPZlAtehdHN8mVyXvVAk4fM2ugw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ds2RHbNFBwYWZGBzDojn0Z6nWwk+/DXlFNbEUi8oVR6pKJ+buIJ8blIjYyHimFeE1
	 2NC34oQp2bTVsAMPSs2OtaDpAblb2ID0SBb+G9NcfHC+VKWnqBjSTJ+2jotQ8ahKJR
	 nWkR4TqUj9K0MUecO4oM+xGRCchUwFmFpaNCDnnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 248/374] selftests: forwarding: Have RET track kselftest framework constants
Date: Thu,  6 Jun 2024 16:03:47 +0200
Message-ID: <20240606131700.127664592@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit 596c8819cb78c047acc0cab03a863a9983a3cc62 ]

The variable RET keeps track of whether the test under execution has so far
failed or not. Currently it works in binary fashion: zero means everything
is fine, non-zero means something failed. log_test() then uses the value to
given a human-readable message.

In order to allow log_test() to report skips and xfails, the semantics of
RET need to be more fine-grained. Therefore have RET value be one of
kselftest framework constants: $ksft_fail, $ksft_xfail, etc.

The current logic in check_err() is such that first non-zero value of RET
trumps all those that follow. But that is not right when RET has more
fine-grained value semantics. Different outcomes have different weights.

The results of PASS and XFAIL are mostly the same: they both communicate a
test that did not go wrong. SKIP communicates lack of tooling, which the
user should go and try to fix, and as such should not be overridden by the
passes. So far, the higher-numbered statuses can be considered weightier.
But FAIL should be the weightiest.

Add a helper, ksft_status_merge(), which merges two statuses in a way that
respects the above conditions. Express it in a generic manner, because exit
status merge is subtly different, and we want to reuse the same logic.

Use the new helper when setting RET in check_err().

Re-express check_fail() in terms of check_err() to avoid duplication.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Link: https://lore.kernel.org/r/7dfff51cc925c7a3ac879b9050a0d6a327c8d21f.1711464583.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: ea63ac142925 ("selftests/net: use tc rule to filter the na packet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/lib.sh | 21 ++++++++-----
 tools/testing/selftests/net/lib.sh            | 30 +++++++++++++++++++
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9042fe92ca465..258d2082aa991 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -358,14 +358,24 @@ EXIT_STATUS=0
 # Per-test return value. Clear at the beginning of each test.
 RET=0
 
+ret_set_ksft_status()
+{
+	local ksft_status=$1; shift
+	local msg=$1; shift
+
+	RET=$(ksft_status_merge $RET $ksft_status)
+	if (( $? )); then
+		retmsg=$msg
+	fi
+}
+
 check_err()
 {
 	local err=$1
 	local msg=$2
 
-	if [[ $RET -eq 0 && $err -ne 0 ]]; then
-		RET=$err
-		retmsg=$msg
+	if ((err)); then
+		ret_set_ksft_status $ksft_fail "$msg"
 	fi
 }
 
@@ -374,10 +384,7 @@ check_fail()
 	local err=$1
 	local msg=$2
 
-	if [[ $RET -eq 0 && $err -eq 0 ]]; then
-		RET=1
-		retmsg=$msg
-	fi
+	check_err $((!err)) "$msg"
 }
 
 check_err_fail()
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 56a9454b7ba35..b0bbde83b8461 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -14,6 +14,36 @@ NS_LIST=""
 
 ##############################################################################
 # Helpers
+
+__ksft_status_merge()
+{
+	local a=$1; shift
+	local b=$1; shift
+	local -A weights
+	local weight=0
+
+	for i in "$@"; do
+		weights[$i]=$((weight++))
+	done
+
+	if [[ ${weights[$a]} > ${weights[$b]} ]]; then
+		echo "$a"
+		return 0
+	else
+		echo "$b"
+		return 1
+	fi
+}
+
+ksft_status_merge()
+{
+	local a=$1; shift
+	local b=$1; shift
+
+	__ksft_status_merge "$a" "$b" \
+		$ksft_pass $ksft_xfail $ksft_skip $ksft_fail
+}
+
 busywait()
 {
 	local timeout=$1; shift
-- 
2.43.0




