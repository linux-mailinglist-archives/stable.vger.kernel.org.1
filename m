Return-Path: <stable+bounces-73055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D1A96BEC6
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E287F287980
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825EF1DB934;
	Wed,  4 Sep 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj6mYE2l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6431DA115;
	Wed,  4 Sep 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457097; cv=none; b=Bo7JYfQ3vDbJfhf5vsKLlbqScPl4Y1Wl+nutqN0EcvIcCScb+fB56CVW1ShCvYn6jnKHvu7gno33RsTNH02j6ds4KI0cJBDTj7ocu2HPS6rCnUBddE6cxbXuYEDfGdeZ44IIFWe5VM/yKr5rHS2vvzZ/feIznKF5Xivwo64dxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457097; c=relaxed/simple;
	bh=5i3YS1VlQeBlgEef2/qpbyEC6KCMl93C2rgBvUGpsVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG0C2seG3YWKLcbjHSsfQjb6XfLHBMzb+qJntIG+xofMB/JZNP8BPsDsRZ6fWsag+sq5ZLZ4DwNNhFPX1lKzFbN2GRSczBl+plOdx952J2i0EFatocbDd3BsKd/TSaspm4TGW+Qt3NbpU6YTaidWmcZIXaVmVBjO/HZGMtn+ecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj6mYE2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F63C4CEC2;
	Wed,  4 Sep 2024 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725457096;
	bh=5i3YS1VlQeBlgEef2/qpbyEC6KCMl93C2rgBvUGpsVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hj6mYE2lrHxGphhCjK80KcjLsZyU0MlFFpjeNfG7VB+rKO6Jg0kdkYWm40bGWZZX4
	 NNWCGm0ohxToTS0ZL7ZVaHRXHI/VCr++74zUsYGOlGeTZ4BX1gwtbEjV9ETbfBBB1T
	 xqVhIk+80l+tlrVTNemyspko4Uv5UvVCnvSIOJAGx1pOlmOSskHTsJTWnZVMszZMWa
	 S4zESB36hVqbYpL0n/ur2WKHNmSfaLLkWT48Xx2HufVErVRHYjQNY7zhMudciycLTR
	 2UsNIze+0VIL435VLhEBIJzEgAZCxv5TrEmec1jbiGFGA9VUUN6A4FBnBpbruLtOat
	 xvS93C3OUcvTg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 2/2] selftests: mptcp: join: stop transfer when check is done (part 2.2)
Date: Wed,  4 Sep 2024 15:37:58 +0200
Message-ID: <20240904133755.67974-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904133755.67974-4-matttbe@kernel.org>
References: <20240904133755.67974-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=matttbe@kernel.org; h=from:subject; bh=5i3YS1VlQeBlgEef2/qpbyEC6KCMl93C2rgBvUGpsVA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2GK0QzhdcUzI6tR20UTnwKwFvcXBAv9aqIhPC a9yXXR3vpSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthitAAKCRD2t4JPQmmg czzkEADWyjKEllhCPwrsC0BSXUTQogNEJAi8fzQPnawXcKNIvA43xuA0nCgNTvLtX1kdc94NKPN 5icTl0iUCvfjDJbK6VSBfbGxu8bXgC0Mwbpc4Hu7iI9XcU6XRAWXwbf6rEwpSvaOoCDSbrM17hK atsgUyMyAaPwR4jwneh9LHkW/fuiJmM945olZpSGWjABqeQ4Q2eexggQyzrANvKWyXWOyfhQ0Aj PRBcTbYZKi1CgfLNt4uRo5D/vtKieCKLACbrABlfMf3i8yzFT5O/dhLF8TnPkUBPS7Z616W/l5X AjyzhkxyoHXI7bjhglzORYCjsMT0INoFn1XBkpclAL6vC114oC7u8hcARGvtMa4+ky1ouHFJ/WN 4/FhDOQhiJg+AUMpIAlRSvzt4mBfB6n4EguhIGYtAgFgHr+5u0JqhB4hdHoUhXa2JAvMzq9JgyM 88je06RjsuA/q8TOqfeszTx/r+ZxECEasDlV2O47c6T8o+86TccHB9OXEDDgCAjDDU5Dah7+7X5 8deUVWum+Kn9PgnSZx5CQF3PTqDZnu/N0VJddshGteeshwytLMMPyC0Kzb1H1HyTVjYSB0stxkm 0v8D6Ovt0RUhLQTD70e+gaj9zt0dw1WuyPNZWUfFb085gIJPqbpfZwLorTQedjkp+bN7EB8rKzs deSjl1ojNPtgEcw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Use mptcp_lib_kill_wait in "userspace pm create id 0 subflow" subtest.

This new test has recently been queued to v6.6 [1] with the backport of
commit b2e2248f365a ("selftests: mptcp: userspace pm create id 0
subflow").

The modification here was part of commit 04b57c9e096a ("selftests:
mptcp: join: stop transfer when check is done (part 2)") that has been
backported to v6.6 a few months ago -- see commit 358f02b84fbb
("selftests: mptcp: join: stop transfer when check is done (part 2)") --
but it was not modifying this subtest as it was not present in v6.6.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=bd2122541bd8 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 14c80f980396..2fd83f2a93e3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3645,7 +3645,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 
-- 
2.45.2


