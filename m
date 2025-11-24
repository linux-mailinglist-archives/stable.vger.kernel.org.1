Return-Path: <stable+bounces-196824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05561C82B14
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 23:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A58D5343C00
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93876218AAF;
	Mon, 24 Nov 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luF4Lg6J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB92264A7
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023981; cv=none; b=IfxLyF4dkmrj3P3jrsnqe47ns/XBsE1+kPiSRF/zS5ISlME0X6S9uX/oLGwPDdWSoV5ItgXCza2doeFLzZNYqqYMIDFNPm05jC+0pF/cX1mjyJ1jK1Y8r1J1c9mc6XJgO5O0+qHvq82arPDBd8EizXublRQJZJOQBa6O7bASadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023981; c=relaxed/simple;
	bh=A1Zz6AAfrWut3n6gsdsrm82jUG16jnauv8KvJMHfJlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4+IUTxK1XFdRkkUyAI9m5rryeyf1ciTRXe0g7gpLBGfGsG3tZhEQou+4hYWQLaPMdBWazEyTSHzqhMIjM33Varw5pR5bVvM9UUZCGawxzaCU6Z9h3lkOLHsrPiF/PoICMHlmNKav/81RJmVKYIye4RnSP4MqA3xzvUDJCY4vYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luF4Lg6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3066FC4CEF1;
	Mon, 24 Nov 2025 22:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764023980;
	bh=A1Zz6AAfrWut3n6gsdsrm82jUG16jnauv8KvJMHfJlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luF4Lg6JSOAWTwhEQ5IkzRqfCBCyOJXXJfXGT7IWjrNU3aasRWH2k+jU+EXrqLfts
	 rW48PBJapvTmU+rMKlYeqnVHgOIiuwRtZFggcemzNh5BdGL2oAqNH61dALeioHQDBg
	 We4m02JYR/M5ev54oqRcqbY47/OhyufTmjT9VTnq5wRTH3GbR7tBzEy96f8/ZbJMiV
	 4Xuef6rpl7LpQIvBBww8hMmREAgG1zGdJj0yUUbn7z+b/D2l53Txv4vvDlCA/8X700
	 QM2mzHja4l8bWtElffSyKSdA4MErYSj91XecEnR9biTDC4zuU+XXMk09do7/VAb6uD
	 Vglte8oYb4fnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fix ack generation for fallback msk
Date: Mon, 24 Nov 2025 17:39:38 -0500
Message-ID: <20251124223938.74969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112448-naming-survey-424d@gregkh>
References: <2025112448-naming-survey-424d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 5e15395f6d9ec07395866c5511f4b4ac566c0c9b ]

mptcp_cleanup_rbuf() needs to know the last most recent, mptcp-level
rcv_wnd sent, and such information is tracked into the msk->old_wspace
field, updated at ack transmission time by mptcp_write_options().

Fallback socket do not add any mptcp options, such helper is never
invoked, and msk->old_wspace value remain stale. That in turn makes
ack generation at recvmsg() time quite random.

Address the issue ensuring mptcp_write_options() is invoked even for
fallback sockets, and just update the needed info in such a case.

The issue went unnoticed for a long time, as mptcp currently overshots
the fallback socket receive buffer autotune significantly. It is going
to change in the near future.

Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/594
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-1-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a71ef6de8c682..b4237e50e23fd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -810,8 +810,11 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	opts->suboptions = 0;
 
+	/* Force later mptcp_write_options(), but do not use any actual
+	 * option space.
+	 */
 	if (unlikely(__mptcp_check_fallback(msk)))
-		return false;
+		return true;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
@@ -1222,6 +1225,20 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 }
 
+static void mptcp_track_rwin(const struct tcp_sock *tp)
+{
+	const struct sock *ssk = (const struct sock *)tp;
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+
+	if (!ssk)
+		return;
+
+	subflow = mptcp_subflow_ctx(ssk);
+	msk = mptcp_sk(subflow->conn);
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
+}
+
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 {
 	struct csum_pseudo_header header;
@@ -1283,6 +1300,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		return;
 	}
 
+	/* Fallback to TCP */
+	if (unlikely(!opts->suboptions)) {
+		mptcp_track_rwin(tp);
+		return;
+	}
+
 	/* DSS, MPC, MPJ and ADD_ADDR are mutually exclusive, see
 	 * mptcp_established_options*()
 	 */
-- 
2.51.0


