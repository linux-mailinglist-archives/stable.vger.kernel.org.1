Return-Path: <stable+bounces-25400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E3486B5D0
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E9281F33
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5A3FBBE;
	Wed, 28 Feb 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ37gq8e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4E22EED;
	Wed, 28 Feb 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140915; cv=none; b=RNAEROgjwVw8OY3/i1GwSDvPnZCiN16IV68NAXVBhefSXMb7hyeROCVYGNrLHCgmiaphF5a9gmxTz6XZd+c78e+c70WWeqy3AsQl1OEzXZKQNlzSb/WJ3N0bPgK0J01BgiGRDca7E1euWNI1BaG4gOvtk/0rXfGBngS0uoOHB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140915; c=relaxed/simple;
	bh=/dEb0ZgxzJCc665N5E52mcNPlgkWeMzlcJnG/uW01QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1UDOnl9HkUJnjl169WN3MVS7ekhK0TGYme7niavbWPSrgCCGvWKnqiQZD3EqsWkCGlHynKi3eWe+czMGElcFVVPcrNmddc0Qkt3xYfz40JWbS1iFLscHhRVtmWuAhG3H8ly//wYkegzZQwqCULkbGZaP++w/SyGlXuQ2Vler24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ37gq8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8BDC43390;
	Wed, 28 Feb 2024 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709140915;
	bh=/dEb0ZgxzJCc665N5E52mcNPlgkWeMzlcJnG/uW01QQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iZ37gq8eHaQ5aE3zuXggCI4rjthSRS3Bf4JpCU9a2qgntOzGv7kCAjR5IsVnve6OD
	 Nx2fjiP9rGlom8K0FPZcwRYap3DmghOHICY1Ip4rG0F9Qp+/zGnHIF1rirKAlIF3KI
	 cMvlSSCK/tFW56wn1GDbozzesWFTaMsuzPr2ILrY+Txoq4aiHhLeSaf15LtRiR8zqh
	 etw/KN9bTiUcA+Fq3MfjAsa9xjhw+tx8r9H3Ztd9WcAGtmEy4GqwQ4JTQx2sMxSuEH
	 Uk45xHoYPvnxSCRUXvSq95pW7RKSMX9kPFyIPmoZbohcRRc5UtVv5/Vk4Fmmm2jcvQ
	 tNTSQUzuf7jdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1.y] mptcp: continue marking the first subflow as UNCONNECTED
Date: Wed, 28 Feb 2024 18:21:21 +0100
Message-ID: <20240228172121.243458-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=matttbe@kernel.org; h=from:subject; bh=/dEb0ZgxzJCc665N5E52mcNPlgkWeMzlcJnG/uW01QQ=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl32uRg1dBPl2Mh1SfZ40uPmZll1xmdxvmMvqLB kiNrkNVX1iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd9rkQAKCRD2t4JPQmmg c+sMD/0Tihf3Iw8q3bj0AId9/vwv24rnCA2Ld0NmCNIJDpQZHdX21pQ5Dj7flUCZ63CBN+BKX2x kxUfzw03Qwpo76mh7AFDgBr6V2gzXwtCFzketT7h9EpOBxByBTITgS3lATGC+LOb3IJv5wK1OrH D8H5hbWX7Hohf5mWhMz/uuOskIrl55VZ/g5mltJFyg5VPkBoNO1qcA8hZE+vkrHIrcdtJzv7sCp O9Bts8J2eqVcWxCt7TW3AO1xrBcrVg6ttcdnzbQnOqs7C5WVvXl6WRQxbb8+N1pY4xUKa3K90AC mBgCnJwq92dGA+XFUefuOzfAfv1jrn8I1sSovOBaGBM2EORO3gLYEGUlNSwS2YSxTNKL+ogddow 4yRJdcjIHW0ox4neOam0fe1nWESNYTWFy7das6ZJhzOpfBrjrqsb8emLxfP+84zNlsaefvETgTd 3IrBMSiMUL7VetNmR3dVDY0/Si4EJojEchavtsOGG5itG1eB+DkgFko6YEhHXti309l10z4T/7h dTjbMIj0O2f4JFPy3UAq0r8AuC4EqdqbLECebQr0Uo1X0IoPFbwAzSIu7TzNAimCs5qIgsGx1yc UgfXH7Nm/fIpXeYNtobzGcLRwyPrJ9kbDJI2WzGFRMluXJl7jmk4hA7UmyfguNaWbS+UN3JC1CF MC2j0vXoNZ0HYCw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

After the 'Fixes' commit mentioned below, which is a partial backport,
the MPTCP worker was no longer marking the first subflow as "UNCONNECTED"
when the socket was transitioning to TCP_CLOSE state.

As a result, in v6.1, it was no longer possible to reconnect to the just
disconnected socket. Continue to do that like before, only for the first
subflow.

A few refactoring have been done around the 'msk->subflow' in later
versions, and it looks like this is not needed to do that there, but
still needed in v6.1. Without that, the 'disconnect' tests from the
mptcp_connect.sh selftest fail: they repeat the transfer 3 times by
reconnecting to the server each time.

Fixes: 7857e35ef10e ("mptcp: get rid of msk->subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - This is specific to the 6.1 version having the partial backport.
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cdabb00648bd2..125825db642cc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2440,6 +2440,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
 		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		if (msk->subflow && ssk == msk->subflow->sk)
+			msk->subflow->state = SS_UNCONNECTED;
 		release_sock(ssk);
 
 		goto out;
-- 
2.43.0


