Return-Path: <stable+bounces-172425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D9FB31B5B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938176415B5
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6122B30E82A;
	Fri, 22 Aug 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0VmuuER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D630DED8;
	Fri, 22 Aug 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872315; cv=none; b=SrRn9CMEpFNhdVdejNbGbUpEOOPMBG9HmGo9Ln3i31MvrWEjZ3MNoIZ4qh7f+CchUda47NnYcxT4ObuY2kIvkhiM9Kq+N7tbr0BiR+4ar2AX3lojTZFkUv/V89Y7FXc3do985/9WRwDjO0cjMEvg3mSAxxGtuYZmo4k3abdlhTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872315; c=relaxed/simple;
	bh=6bFa9fPxNY3+q5whHPEc+1EaORiYqtuwfH3QyCrobYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU8TAaArkuGmtsS0bOx2ry8IaDVsQ1JyMGJqiRJVCHJ2z9+u+JNNJavNkH9p9ioGUYcr9kAfSNxcX0pTvqnc4vwAxCoNA3aYuTYBj7eYaNwlu2KVQf7FHoLv6oxfGxzyLXrtzzJY8xT3XICK9L8z6G+yyBl1Wb/SlpDu203SZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0VmuuER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35401C113CF;
	Fri, 22 Aug 2025 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872313;
	bh=6bFa9fPxNY3+q5whHPEc+1EaORiYqtuwfH3QyCrobYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0VmuuER3NUzjs25xmrHUXxcdJo2GrfiuzDw6ZurIgH3g4YXhkr/w5VezVU0BuBgE
	 HvwDqobXnK2p/S6dxk3DsvlkhRSEyv7OMPk9tvQaqrISqew+i1HLs5udoi8l5Sxo6/
	 opm4hQCxeUEUYcyhcvydo2y8yh/loggWKD3xRkInc9U5kcB+PE9CduOX3II28QkIaL
	 GX/kr8kw3lo0pCuTrLurrsGsoBC9hkluuLYbSjlLPCzAjBTa5/qagzKXgt3bQ2mmMS
	 PT8uM0a0KXY2F7cWo4A0pFGROrNazY0asR96TyPkhFY9e3VCxJiK8jHCzYMgHKHwuN
	 JcYcn014t5g1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 2/2] selftests: mptcp: pm: check flush doesn't reset limits
Date: Fri, 22 Aug 2025 16:18:19 +0200
Message-ID: <20250822141816.61599-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822141816.61599-4-matttbe@kernel.org>
References: <20250822141816.61599-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=matttbe@kernel.org; h=from:subject; bh=6bFa9fPxNY3+q5whHPEc+1EaORiYqtuwfH3QyCrobYA=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJW1Og4NLl8E5v8UfRvymfThzsz12hVnLvy7Hl69omc8 0U9R5496yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIfTDDf7f8Jcp/Pj6c7bOA YcvbjSnvt1tbL2CMU1RoSJR7yiIb+IiR4azBBs3bHS9Ef/h2zrwtef9P18WvD4rlent8p1RJcW2 9xwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 452690be7de2f91cc0de68cb9e95252875b33503 upstream.

This modification is linked to the parent commit where the received
ADD_ADDR limit was accidentally reset when the endpoints were flushed.

To validate that, the test is now flushing endpoints after having set
new limits, and before checking them.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-3-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.sh, because some refactoring have been done
  later on: commit 3188309c8ceb ("selftests: mptcp: netlink:
  add 'limits' helpers") and commit c99d57d0007a ("selftests: mptcp: use
  pm_nl endpoint ops") are not in this version. The same operation can
  still be done at the same place, without using the new helper. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 306372b1526a..68e05bd3526e 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -131,6 +131,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
 subflows 8" "set limits"
 
-- 
2.50.0


