Return-Path: <stable+bounces-33733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC68920EC
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED625B2645E
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADB149C5F;
	Fri, 29 Mar 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPWOFJoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4E1E864;
	Fri, 29 Mar 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723078; cv=none; b=h4dC9VkeDA+gRz6I10YNdb4KK+7FLilxgMzcrfWxB2CSqEXrTbvNFf6gUh/Wu4V2S90Eal1zwPSXJxO3T0tnqli//hGITTVjXxolTIY6bmEYp139Az52eu2wHeiokY5YQrQD8pLOG9zGlkr0Vvwx9r5Qd398RaL5mQ65LIA5SH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723078; c=relaxed/simple;
	bh=aawvTve4Y9WgnT6+sFyQUfYp31jBJ86++8t/3b7K6Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhYQNJiZ7Tq+navd09huOXLfidOmPlILUfIf7zWvo7Py+UuVoQ9YJ/faLFi9ByRPK5JZAsqzGml+dms6rxqyGty+OZaSRRiQtqR/fBSMlYU884YpKroPlVDyoj4WSgwnR4EL/0ezcjhk0dkyymrNVONbPoj+lEDTsofC26h4FyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPWOFJoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5661BC433C7;
	Fri, 29 Mar 2024 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711723077;
	bh=aawvTve4Y9WgnT6+sFyQUfYp31jBJ86++8t/3b7K6Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPWOFJoY2csNT30rPeV14R9EAlS9zgZcRaaAo1hNX2w5IL4ZI0QEznEpahBguZjLa
	 +SjatAohnnA+tc0uTV4Knq7FnX+it14IjOBoD0EacHh8iH4b5vizVpnK8XjdA+va/u
	 upq6cNbduxh8uGM4nIgUdRA3tiMG/cIFLMlibYHWBWwxq1l47pSFMYp6xkNvU4EnmT
	 b7Ww04yy6d+SEQ6Oo1YMeTG4gmtRoD9wZ5V35KH2RQj9zbR8H1cD6Dvt1S//csL63r
	 2jyuqzaV73aAuaUvuRQz66D1QN56mn3/NiDQZXuD4LIimN3vI48Df2wnHe6Q2GX+Eq
	 lZHuQQ+bSJRxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y] selftests: mptcp: diag: return KSFT_FAIL not test_cnt
Date: Fri, 29 Mar 2024 15:36:17 +0100
Message-ID: <20240329143617.1542073-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024032708-vagrancy-backlash-61dd@gregkh>
References: <2024032708-vagrancy-backlash-61dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=matttbe@kernel.org; h=from:subject; bh=IVvL+BstqGTkKemPvikpqqYWg2b6AFVxMhI5dXVY6LE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmBtHhRb7/sOVvps6KL9bGjQvWgVhy37zfzRGgc PGssI78b3iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZgbR4QAKCRD2t4JPQmmg c8lcEAC4T8dHCd/R7CQsA+IcL4P0/GL/Z/15fH5ub+DwAwWdf7DxELUNrlS2kYNWtT5fkktr6gY qn91d9146uSyvcuQ6OVe+BTjA0SxqvSDiNfDxZgS7W115vA8zSF8fTbij2LiPtxQudwgXWypoAF 8vxfjMSwtBV/mr1hR/HXUkcQj6lWuS510fxKruj27QuF23jO9a4xGwkAgDYbHKwyoWSrrQ3MC5r yPOM3iq96VM+h6AM2Hs0gYqfyAlJfM/gsPzh6HzAa9fRTqg+ZZvYpjjhbpD8mMNmi+ECO8VMu1X lwdMq/HqLQa7rrLq222bgrrudfAhtf4NZeStZ9poWEDWodHz9EfBR807nFbU/DiCpFCuUHBVis+ QuwREgMipojhfwteDTq5JXFCn0OXnbrIm1CEAzyKa7pHXaXx2l7m6cDK3oNsGiw2CTAA2NSXhiz c+CtIfko2SbdW3+ukHSUAh6b4DYhfrHiw/5izW5srqXT+qmXUm39soV3dfXo2xJvz35vyopfSkb U8iOQYg+bAob8Ed3Dmty9QVTODvxiSO3QvDiMWJncEAJr6lZVdfqqUigfdBuEcGOBEpOLU4ApQY bzBZkIxuq+soHTh+0WizeJAmfbqRg0AnNGiOr6hIAN/WH4/0u5oNsBZN5ZUIOtp1BVXjH0XhvnF oEx92ApZj9BVz/g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
(cherry picked from commit 45bcc0346561daa3f59e19a753cc7f3e08e8dff1)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Conflicts in diag.sh because the commit ce9902573652 ("selftests:
   mptcp: diag: format subtests results in TAP") is not in v6.1 tree.
   There were conflicts in the context for an unrelated feature.
---
 tools/testing/selftests/net/mptcp/diag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 400cf1ce96e3..3df4a8103c76 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -56,7 +56,7 @@ __chk_nr()
 			echo "[ skip ] Feature probably not supported"
 		else
 			echo "[ fail ] expected $expected found $nr"
-			ret=$test_cnt
+			ret=${KSFT_FAIL}
 		fi
 	else
 		echo "[  ok  ]"
@@ -100,10 +100,10 @@ wait_msk_nr()
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 	fi
-- 
2.43.0


