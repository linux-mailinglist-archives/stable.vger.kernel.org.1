Return-Path: <stable+bounces-158087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD4BAE56E8
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232864C304B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425522370A;
	Mon, 23 Jun 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYtnJC9S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F02192EC;
	Mon, 23 Jun 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717450; cv=none; b=rZAMZMP/mthvva96n3urS1LPRZBBm2ohGFUVVoukKMHxIPmrTaao+cwPRmQoZj49wtQJi3KxWRfzagg0J62VFYYukfOKS68AOCuQr3gpiJ5nytzauDvN7IV3zfwn8Hm9qos9m86uRMur6aRXkP1FG6r96kOGEgrl5hE2u6MORQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717450; c=relaxed/simple;
	bh=sGZyw89uT7Y/BehjPnTXfNIkCgIoKW2YyVXkHyB334A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8JfqggafWN1/RCCcWip+mqPWToreXrcwpszSrIv7rv3bV+UU3EAvWf75Ubfdav6zCZeUBPegpkMpwwhqORP3lsocCWVhs3KobZOW2h7Ghh+7JkWdytI7j++H6LlP3En8IYRDoymHTIX5pzb+JrqPO7drQ2UD/Zyaw+//XZKxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYtnJC9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF9AC4CEEA;
	Mon, 23 Jun 2025 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717450;
	bh=sGZyw89uT7Y/BehjPnTXfNIkCgIoKW2YyVXkHyB334A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xYtnJC9SkfLzLGY0K4Kzrs6K75vBcrsZ7GP4c5Cw2gWK+MhkFxuZD/lg4BKewXxEu
	 SgHWBXXwRTB/ntUTfZTRbsX4HjxE88adcpr3rCEW8s9H1feImBcbyYHwKg8J4jE0yS
	 aBtK/t3MtfLdRmhRZsSeIKH1fUKsZokTwppgWKwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 429/508] bpf, sockmap: Fix data lost during EAGAIN retries
Date: Mon, 23 Jun 2025 15:07:54 +0200
Message-ID: <20250623130655.733394219@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 7683167196bd727ad5f3c3fc6a9ca70f54520a81 ]

We call skb_bpf_redirect_clear() to clean _sk_redir before handling skb in
backlog, but when sk_psock_handle_skb() return EAGAIN due to sk_rcvbuf
limit, the redirect info in _sk_redir is not recovered.

Fix skb redir loss during EAGAIN retries by restoring _sk_redir
information using skb_bpf_set_redir().

Before this patch:
'''
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
Setting up benchmark 'sockmap'...
create socket fd c1:13 p1:14 c2:15 p2:16
Benchmark 'sockmap' started.
Send Speed 1343.172 MB/s, BPF Speed 1343.238 MB/s, Rcv Speed   65.271 MB/s
Send Speed 1352.022 MB/s, BPF Speed 1352.088 MB/s, Rcv Speed   0 MB/s
Send Speed 1354.105 MB/s, BPF Speed 1354.105 MB/s, Rcv Speed   0 MB/s
Send Speed 1355.018 MB/s, BPF Speed 1354.887 MB/s, Rcv Speed   0 MB/s
'''
Due to the high send rate, the RX processing path may frequently hit the
sk_rcvbuf limit. Once triggered, incorrect _sk_redir will cause the flow
to mistakenly enter the "!ingress" path, leading to send failures.
(The Rcv speed depends on tcp_rmem).

After this patch:
'''
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
Setting up benchmark 'sockmap'...
create socket fd c1:13 p1:14 c2:15 p2:16
Benchmark 'sockmap' started.
Send Speed 1347.236 MB/s, BPF Speed 1347.367 MB/s, Rcv Speed   65.402 MB/s
Send Speed 1353.320 MB/s, BPF Speed 1353.320 MB/s, Rcv Speed   65.536 MB/s
Send Speed 1353.186 MB/s, BPF Speed 1353.121 MB/s, Rcv Speed   65.536 MB/s
'''

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/r/20250407142234.47591-2-jiayuan.chen@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e5ba57a5db126..2aa6262f19e84 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -688,7 +688,8 @@ static void sk_psock_backlog(struct work_struct *work)
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
 					sk_psock_skb_state(psock, state, len, off);
-
+					/* Restore redir info we cleared before */
+					skb_bpf_set_redir(skb, psock->sk, ingress);
 					/* Delay slightly to prioritize any
 					 * other work that might be here.
 					 */
-- 
2.39.5




