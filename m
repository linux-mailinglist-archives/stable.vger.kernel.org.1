Return-Path: <stable+bounces-32966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D188E83E
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E82A708E
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB44514A08F;
	Wed, 27 Mar 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="otJw1cLI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6B14A089
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550777; cv=none; b=DlGxGqnYWlGARdPXxDKHpDcaOaJaNIqX8htRHNHvgbkPj/DK3op0NLYfeyqFaA62sd8ON1J8ZmXfQunEYRBWXxK5dUcUVfQ3cJisMww0XKf9Yo+V6cAF5weDqgGJ3PwDKjBUDhN0yQNkOaMW/C+FBLKqp1n+uc32mRrJVPLwrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550777; c=relaxed/simple;
	bh=5fvHtDC1YExdkcQy2LTqqNgh8KpC1Z3EmtoXTNTwjLE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZBIVqvlVLnAFxqSoMS3bIhYV0aDUrf4u1fb54PWb5SFj6WOpsVeCz1oTmsmzcqtb0tWMtFXtE35Isu9fXkYacpXqyqevEriviD/hcaDN/4Yh/nPENhXrYbMeKs+OqXmjp8Jm3tj4+yVv/dlmvltvRqLrOtA9C0G0btJnBRCcEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=otJw1cLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F4AC433F1;
	Wed, 27 Mar 2024 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711550777;
	bh=5fvHtDC1YExdkcQy2LTqqNgh8KpC1Z3EmtoXTNTwjLE=;
	h=Subject:To:Cc:From:Date:From;
	b=otJw1cLIScf3szgCpPz0QiScLG9NkFzSUN50RKySj2BumIv1LnBvxfccNdrly0NMi
	 P3v7BMZJokX56n9gKw+u3nY6mokuFX6Z3UvXiq5LY4xCpphCtW7buaEoOxezG5wQs+
	 tHY9SaOXH0F14Exnyb8e9ksnKDjprY3cKT2xzpes=
Subject: FAILED: patch "[PATCH] selftests: mptcp: diag: return KSFT_FAIL not test_cnt" failed to apply to 5.15-stable tree
To: tanggeliang@kylinos.cn,davem@davemloft.net,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 15:46:13 +0100
Message-ID: <2024032713-identity-slightly-586d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 45bcc0346561daa3f59e19a753cc7f3e08e8dff1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032713-identity-slightly-586d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

45bcc0346561 ("selftests: mptcp: diag: return KSFT_FAIL not test_cnt")
ce9902573652 ("selftests: mptcp: diag: format subtests results in TAP")
dc97251bf0b7 ("selftests: mptcp: diag: skip listen tests if not supported")
e04a30f78809 ("selftest: mptcp: add test for mptcp socket in use")
42fb6cddec3b ("selftests: mptcp: more stable diag tests")
f2ae0fa68e28 ("selftests/mptcp: add diag listen tests")
0cd33c5ffec1 ("selftests: mptcp: fix diag instability")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45bcc0346561daa3f59e19a753cc7f3e08e8dff1 Mon Sep 17 00:00:00 2001
From: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 1 Mar 2024 18:11:22 +0100
Subject: [PATCH] selftests: mptcp: diag: return KSFT_FAIL not test_cnt

The test counter 'test_cnt' should not be returned in diag.sh, e.g. what
if only the 4th test fail? Will do 'exit 4' which is 'exit ${KSFT_SKIP}',
the whole test will be marked as skipped instead of 'failed'!

So we should do ret=${KSFT_FAIL} instead.

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Fixes: 42fb6cddec3b ("selftests: mptcp: more stable diag tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index f300f4e1eb59..18d37d4695c1 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -69,7 +69,7 @@ __chk_nr()
 		else
 			echo "[ fail ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=${KSFT_FAIL}
 		fi
 	else
 		echo "[  ok  ]"
@@ -124,11 +124,11 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"


