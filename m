Return-Path: <stable+bounces-66756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3615A94F1C9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49EFB22F8B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702F184522;
	Mon, 12 Aug 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngxs08mP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D471474C3;
	Mon, 12 Aug 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476703; cv=none; b=CvIBK8zvjGvo0dIQBvBPcPPQRgu8EA+JuyyLv1TGlfr+U5/zvquO5tBOKCsljyYbvZK5UVS0U6p+p9IEP5enRlBmWMJ8dCz4Ylh31z27P8FJ4akATEHyVJA65reBdL9poiA77+uagNnDNiFzoZq1IDL9W7ZmzVlq9kGBNmq8MZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476703; c=relaxed/simple;
	bh=P+QsUlCcfPi1/dyKtbJzvyLKcRaNy7L5pLLnD9TCSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5FEUtkH+Z3dZCsea9KSzjw3J8Nu3mnggB8KjhwXatlJJHenQrd82ZZmp+YF4IukK7pPK0Sr20PhqNmRbufBGhgRhYnyKHJV6XEFsKUSCOhm5zfVMYsw2ZDF12nTIO57lrzR1xf3RbXfTZ+JhIabZyKsUuaKlUSDG6G6HawlnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngxs08mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829C4C4AF0D;
	Mon, 12 Aug 2024 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476703;
	bh=P+QsUlCcfPi1/dyKtbJzvyLKcRaNy7L5pLLnD9TCSRc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ngxs08mPDaXQhNfFPA8TNhbi2vgS5dMd9fhkJVm0cUavLP7whpAe4joRl7NdHWvHz
	 8P2RMSmrdCavGNNTusONHnHkrjLWN54GrXXtUmtOUoU/n0jbWkdP/C0OKPXoKqc0qZ
	 fKX46uAYGln+Omeu+RGDWvBGYF7C4+il4sv1U33A4cVHiBo87dTzFzxzJ0FpbHrJ6p
	 NkSIz87yO+hPUaEsBarTSWh583m9++b0q1teJfFdyfMYy4Q357F+oezwifan25Flw7
	 fMRIk5oeYelKFaiGbQOrV9X35tZwcPS/WhMZmGNzzEd23qos0zowLEw2TjlWtP6MHs
	 ZRbk+cj5nEMFA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y] Revert "selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky"
Date: Mon, 12 Aug 2024 17:31:34 +0200
Message-ID: <20240812153133.574382-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=matttbe@kernel.org; h=from:subject; bh=P+QsUlCcfPi1/dyKtbJzvyLKcRaNy7L5pLLnD9TCSRc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuirVt9Aggs0WAW2mCgVlto08Sm13Lk8U18moQ BWE6LXDGN+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroq1QAKCRD2t4JPQmmg czciEACfaTukOgzNwCHA9vPHI7qaxmg9U5s7ZlXXTQ3UBH0AHAOieomRA9DgBmdVHfbefc1/ojr GgMfccpazDqGB2SdSQaFp/D3/vafob2Ek7imW/0a6jG6FFBYezZ/dju5+D5D2I/+UknzdcAxul4 1AaTxfDPyLEwz74Vaj4ViBvBfCzf5Odi8aTqiZMiM/fjNSK1OA/GGK+vmAUT4MjJsQwx9/xFNYC h9UNIai9awJRFH0NNYNp1fswmCPO/Y4zUPRq7VvfzqAk21SzxR37N57BKeQfy3fqOU+0Xs1CGmb lCAccRAsPuDjs80klpQ7WmRqEIHoy4YmvFn9DUvUvj1VjsikC0WGddL/oZ3Gb3p0lUvC7aQ0xnx UuNF5s+Dt/ffcuXpBw5x2Fm2Orhq0ukgfEFTwOwDg/d1O5ILwRGqxCe0WqfUOFyRVyZRUkHeOwJ UUGWT+qOX5aLpOHWzIpDk3G/W/tNbbGAByXazfCo/JIq4P7kv3g9heMxb9pB3eweqvFq/XL6Wto Bl3w0TAa5M679ugqv7Tg/sN6KrdvEgTFDbVhGui5p5HTDMNxVo3mIy94PryP5hAHpkcjH+ZxTD1 S+LDj8Zzoc7qPw9qTRA8ehGeSLQ8DuSD3bc3s/p+GSob9hA6b0pg8S55N54BVnyDn1q7iy5lvtG AxO78eUzKIKjtTQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This reverts commit 052c9f0c140c78e5d6826688b5d2f33e19db0ae7.

If the test doesn't pass, we can get this error:

  # ./simult_flows.sh: line 275: mptcp_lib_subtest_is_flaky: command not found

This patch is not needed in v6.6: it is there to mark a test as "flaky",
but the MPTCP selftests infrastructure in v6.6 doesn't support them. So
it looks better to revert this patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index be97a7ed0950..f24bd2bf0831 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -262,7 +262,7 @@ run_test()
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
+	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -272,7 +272,7 @@ run_test()
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
+	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -305,7 +305,7 @@ run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 0 0 "unbalanced bwidth"
 run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
 run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 
-- 
2.45.2


