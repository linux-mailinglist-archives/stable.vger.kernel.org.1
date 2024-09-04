Return-Path: <stable+bounces-73054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67596BEC5
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 15:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B0B1F2124F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1D31DB930;
	Wed,  4 Sep 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/vGYJ97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE71DB92F;
	Wed,  4 Sep 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457095; cv=none; b=jI5JDZLe0OeCgJHutGMlTQv2YLHU0s0uGOfcPvh3Odf4Oba8wX4LQXk+mCpkPumQljC9SyO3IyIEi898udEpnxZwcvkPxwYMu+SHU+xmO5iwAD7AwgYb6GuRdx3LtEP71Dfv6yuFWEXtnoL+jRxn67NnMcRIZkY4iDAyvycIQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457095; c=relaxed/simple;
	bh=OH71BZDujm8DL2ax1TpHk8KVwxCwBWAV8nDBrlPLPkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsNmNU5hcywNe/EOlf8Z5Ytqa5bqubJhjUCauWLANEETCA4Qec27SH2VLqrd18pI18G+iMNm9/P6gxPqdb41zOfimdbNsDp/8cz5EeFnfehkdKFX6fKB/HqBKLq4ns1uifNeCpEJ6RJWCM8zVlA9ah7bR8vw53Jn8q/OsXn3C5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/vGYJ97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3990C4CEC6;
	Wed,  4 Sep 2024 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725457095;
	bh=OH71BZDujm8DL2ax1TpHk8KVwxCwBWAV8nDBrlPLPkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/vGYJ97VdjiesVmpcGArcUBD5bn4K28rwtBfId7cqnu5h0i1v1RpNMdq2XvULh4v
	 oU2EtK4EAgaR4FTOpN3VLkic3ukNqWKwfWFVm1aXuIQqpkswzmeM13h3XXnh63xmzE
	 Luj9Ui2/wYjRWQSSatQsmtjnQBWVJUsg4llI8zdJ37Ys35k9r55G9fR0eWpoMwZjTu
	 /0l4Ni1S0aF7EaZY6QFQ2uAck53n8g93ykKogPgw5ezMp1deVo1L0VaQl6hqqCmAUX
	 iTDXCsmrFmTjbYl92RTognhf4YgYIbCxwmuZWfNFQbdVAwiQEzD0x+3/34D2ClgKsP
	 JGEJjaAM8UQEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 1/2] selftests: mptcp: join: disable get and dump addr checks
Date: Wed,  4 Sep 2024 15:37:57 +0200
Message-ID: <20240904133755.67974-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904133755.67974-4-matttbe@kernel.org>
References: <20240904133755.67974-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=matttbe@kernel.org; h=from:subject; bh=OH71BZDujm8DL2ax1TpHk8KVwxCwBWAV8nDBrlPLPkk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2GK0jRU9RpxUMHG5nJSQzK7ejzEmuWBbbENIc PawL9FQpiOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthitAAKCRD2t4JPQmmg cwiiEACZGMGzAUrm73Uc00EomvCmLdnQFtI4PfYpxxoSEF8uOsn154osh/c3kFt8hTnmX98RrjZ mMLOzpa/WoJGmKwZ197i9XKwiwO+zM0IyWwlFaAfiTj/NNxZxfwMnmAB5NAjjD94R6GofnbI6xI iauXf4+fYi0YI2ESsCXlERPvA/MV4YrRBsTSFiTyichSP2N7HoSgFCrYOUzDKK6pUjYpZKYI/vG TvewVIxzTjKUars4q+Nt8i0DfL/tRNbxb9uuDK2OVMo9cZ4bHPxQ9al8dVIGxeq7vccMzwdabTI uKvRsx4v0L4u7ud3drerzWrVprdBX1LkEn4gvAsnG+bZOGHfNt4akBInUnmJIQGXzkNbkCE5B5Q NXGxH+gy6zfK1eQqKxgEcVGd5LfKA8P3xYMfkF9aJE+kmaWMHyosPIyCpi7nz+SP5q8G0ccS007 OGNzpZwobXvks035it8wL7Yyq1uGNnK3INwnm2GDqlQEOHy9AB7Xo5C61FUh00OA0Tl4BQassx4 AajqEO1Pfn7XEYpvb83YHLTUc2m9D5IEqrwyWhVWyoqpqjiMDOjBg9QEvB25HfEZ2QKGTSYqmZa z6QpE2YkqljokBO38ZKtx4sQQZmjBoTFtCjv/OBG4lox8DeT2e+HzU72tdiKYvhRiRZ/zDOsIqU 9Vtjf7i2x1UVAQw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

These new checks have been recently queued to v6.6 [1] with the backport
of commit 38f027fca1b7 ("selftests: mptcp: dump userspace addrs list"),
and commit 4cc5cc7ca052 ("selftests: mptcp: userspace pm get addr
tests").

On v6.6, these checks will simply print 'skip', because the associated
features are not available in this version. That's fine, except that the
MPTCP CI sets the SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1 env var,
which will force these subtests to fail when using the selftests from
v6.6 on a v6.6 kernel, because the feature is not available.

To ease the backports (and possible future ones), I suggest to keep the
recent backports, but skip calling mptcp_lib_kallsyms_has() not to have
the CIs setting this env var complaining about the associated features
not being available.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=bd2122541bd8 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0ff60b3744c0..14c80f980396 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3469,7 +3469,7 @@ userspace_pm_chk_dump_addr()
 
 	print_check "dump addrs ${check}"
 
-	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+	if false && mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
 		check_output "userspace_pm_dump ${ns}" "${exp}"
 	else
 		print_skip
@@ -3484,7 +3484,7 @@ userspace_pm_chk_get_addr()
 
 	print_check "get id ${id} addr"
 
-	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
+	if false && mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
 		check_output "userspace_pm_get_addr ${ns} ${id}" "${exp}"
 	else
 		print_skip
-- 
2.45.2


