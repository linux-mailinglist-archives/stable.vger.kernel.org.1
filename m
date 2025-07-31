Return-Path: <stable+bounces-165650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8BAB17054
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831BA172509
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B862BE059;
	Thu, 31 Jul 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFtD+14T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F82BDC38;
	Thu, 31 Jul 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961067; cv=none; b=cTbY/iM9lTi+8wtEArW9gfrqVIvUIiu6YzlFYiSxOM/Xa2e/2tSjW8f7hQlZLDu34PEXuStBUgtGoa5eOSlVzLHL7B0lfci7ghI2ZnnldhOIO0MOoSHvnQZPs787PR4SdLuCQCVZKhR4Dvaa8g1EawPitQu4M/kojNyf0iMVb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961067; c=relaxed/simple;
	bh=qsuwWXAEWIUGdv6z5360HT5Jt2fvcIuLGXiOq1jBtO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cukG+URVUXTroY5hE42BfozZwxj2gwt/FsiOrVlYsyzHycJJzrCQkIDSMQpBU8V4+uLUfvHh+ipIbnpEar7ilqPThRQdXuYOedItMcOxt/LM8dicvKiM0+KtB991w/9iZIzWryRfSTk0tLux6ajIvLtlOVeP3VcadGvjKYPqK/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFtD+14T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77AEC4CEF9;
	Thu, 31 Jul 2025 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961066;
	bh=qsuwWXAEWIUGdv6z5360HT5Jt2fvcIuLGXiOq1jBtO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFtD+14TaYHtUB6on4nPIafpHvUfUYluHdf/sgPNEQyFn9i1bHmV+Aj9VFvWZlFM3
	 WiU8m5wQRzzPhKzlnUHzvSaz8xe8yk8jzbJ/OUprIk+sJTqI8GSzZ5H2DBS5CjGOKx
	 1S6Mo41ETzSzxgQDBqFi9/GLiZasY4uIIBCwDGJk0Te+Fg8nY8WqvQp7dzi5xy6hwN
	 bEK0VeRZw1UOjAWJEhwldTnElb8M2BZNC3GlP4VQdUY1q++1Y5qecTek2KEikOKLQV
	 dz54v3HZhEKfxca1ScuCoy4obrF4z6u3o1KBmL2dRrqVVbknqwEVCwUATaaanQglfe
	 DT7s8QF+wF8Jw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	sashal@kernel.org,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15.y 5/6] mptcp: drop unused sk in mptcp_push_release
Date: Thu, 31 Jul 2025 13:23:59 +0200
Message-ID: <20250731112353.2638719-13-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731112353.2638719-8-matttbe@kernel.org>
References: <20250731112353.2638719-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=matttbe@kernel.org; h=from:subject; bh=8BnuahpnPWZHdWUWpoSh5WXCdjsdDHoVpCUrBM9zpq4=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK6g0J3qOx/PuU4RxrPpOppx4x7/I2qln9OKplVovs7M vKsumV+RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERMjjAynFrk/faJtGF9ZNki /m0LnWc7Z155eE3gQMxS9ivO59xkShkZ3v9wtFzcXxO6grVq97ZJPjriJ9hPL/t4RnCWg/c0Z76 7DAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

commit b8e0def397d7753206b1290e32f73b299a59984c upstream.

Since mptcp_set_timeout() had removed from mptcp_push_release() in
commit 33d41c9cd74c5 ("mptcp: more accurate timeout"), the argument
sk in mptcp_push_release() became useless. Let's drop it.

Fixes: 33d41c9cd74c5 ("mptcp: more accurate timeout")
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c886d70286bf ("mptcp: do not queue data on closed subflows")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c6a11d6df516..6e9d1a749950 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1568,8 +1568,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return NULL;
 }
 
-static void mptcp_push_release(struct sock *sk, struct sock *ssk,
-			       struct mptcp_sendmsg_info *info)
+static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
 	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
 	release_sock(ssk);
@@ -1626,7 +1625,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			 * the last round, release prev_ssk
 			 */
 			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(sk, prev_ssk, &info);
+				mptcp_push_release(prev_ssk, &info);
 			if (!ssk)
 				goto out;
 
@@ -1639,7 +1638,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
-				mptcp_push_release(sk, ssk, &info);
+				mptcp_push_release(ssk, &info);
 				goto out;
 			}
 
@@ -1654,7 +1653,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
-		mptcp_push_release(sk, ssk, &info);
+		mptcp_push_release(ssk, &info);
 
 out:
 	/* ensure the rtx timer is running */
-- 
2.50.0


