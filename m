Return-Path: <stable+bounces-192078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0257BC29597
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670FA188CCCA
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEC4282EB;
	Sun,  2 Nov 2025 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUU3Z7Tz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDF2BCFB
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110006; cv=none; b=dkhaJ1DKz3K14gdLxUHxIOkIGbT8sh4JR4kNHKNfEa92a/JCrv2aFt/2aIIPQtSUGiiZesZpyaZ/zGOHDE67Ojt4p7S8Zn8dBdu1TmfBoZXJ4U6uGqWh2NwtE4Q3aehV6A9CkxYWn19kg+UAuxaZg/sOC0Vlj2G6vvHiq/nWs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110006; c=relaxed/simple;
	bh=NNHwOVruxhh6UsyxJ/cUU+uAhkft7WfDhQmUBoWK9B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PB1lKgDykYWU7jqjaFEC/IwO7Y1e7yI6BZTFoTsLr9SvAuIi8Uynao4UfpBbJRZ+mSVD57YzsviJhntNPBEshDi3W7DVnQI8HIStl45M9wa7UbtVWLADAtP2SeVH1PVjTSh+ktwluwp+4oZs8rZe/qG5D3aDJmI6+pzWlxgjuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUU3Z7Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF76C4CEF7;
	Sun,  2 Nov 2025 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762110006;
	bh=NNHwOVruxhh6UsyxJ/cUU+uAhkft7WfDhQmUBoWK9B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUU3Z7TzGlffrmEG0s5r1KFZpP5tNBltSdXifluf+FXYYuVMsm0x3GJRlBpWUr49E
	 5Xdj1OPpIuIanHdxK/it7uqh+7ga+KDnT8ot4ivABsPzYHNKVVwMnIRkb6jxtUa8bW
	 fFKEnTbuS+xF81PGrBWUEBr2x96VR0tBzm/VVlo2iZmFWCYCrsx2J4dxk+hsvLkjfA
	 v3X/8MGF9Cd32AToU57RLejqNPHjw1lICPAHGU8ONBIONSwSS8ZzxfdqUCTetRIkPm
	 RuOtDIS5Ur9q7TN8AcPPKt6R1Zg/r050LXJCt1WSJ9thqNMx4FsovErbb+8aTVEC0D
	 gb4MoPnkDUkGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mptcp: change 'first' as a parameter
Date: Sun,  2 Nov 2025 14:00:02 -0500
Message-ID: <20251102190003.3553215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110239-gender-concise-c9df@gregkh>
References: <2025110239-gender-concise-c9df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

[ Upstream commit 73a0052a61f98354f39f461e03f1a7e513b84578 ]

The function mptcp_subflow_process_delegated() uses the input ssk first,
while __mptcp_check_push() invokes the packet scheduler first.

So this patch adds a new parameter named 'first' for the function
__mptcp_subflow_push_pending() to deal with these two cases separately.

With this change, the code that invokes the packet scheduler in the
function __mptcp_check_push() can be removed, and replaced by invoking
__mptcp_subflow_push_pending() directly.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 27b0e701d387 ("mptcp: drop bogus optimization in __mptcp_check_push()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ea715a1282425..cfbc7ef3b211d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1701,7 +1701,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		mptcp_check_send_data_fin(sk);
 }
 
-static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
@@ -1710,7 +1710,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1720,8 +1719,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
+			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
 			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
@@ -3496,16 +3494,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk, false);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
@@ -3600,7 +3592,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk, long status)
 	if (status & BIT(MPTCP_DELEGATE_SEND)) {
 		mptcp_data_lock(sk);
 		if (!sock_owned_by_user(sk))
-			__mptcp_subflow_push_pending(sk, ssk);
+			__mptcp_subflow_push_pending(sk, ssk, true);
 		else
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
-- 
2.51.0


