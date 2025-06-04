Return-Path: <stable+bounces-151111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19308ACD3F9
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D93188EA40
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78692266571;
	Wed,  4 Jun 2025 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCmZ64yK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5E265CCD;
	Wed,  4 Jun 2025 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998973; cv=none; b=Aq2ZH1cBV1BfFBw/dYAtaCTZCvmzOlheaRx47bggd+QFqfFFNDo1B3AP6adY1QRnEXTAm6QPijW6Ux5tca29rOMKO6k2pzQMfvCC1wPhXXtkpgjC0c+qwttx/Oi8wwaG1C2tYCTemPaILzxqTHoW9mKMePYlAu+xqu4szn6LGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998973; c=relaxed/simple;
	bh=xKIB3UOETbteYgKqk0AesarY5B+Fo6NV9BEbSRirIIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EboEZqYSXQFOdn1oYDrpGwTZC+xoQIj/in/zowvw5PWgAw63NCwHpzlggKy+F5x2GbFCKZCxW36fAw7BEFt42XYJ/yR5o+3V0pCsKrAv8n/A3T35BRmGdf1qKvUJf4/XVwWf0JUr5HbTDHVew53RtlMttRtiH0XTESmBZwtwKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCmZ64yK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E880CC4CEED;
	Wed,  4 Jun 2025 01:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998973;
	bh=xKIB3UOETbteYgKqk0AesarY5B+Fo6NV9BEbSRirIIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCmZ64yKWdLva4qgrjb8ioQYn/nnRoJNvKI+zx6T1peJ1nbqb3nCWe+UxAa/dJ+an
	 i3HF+dos7B5h2bccpY2d6VBtkea6K7BU6u2WweUowNw+hJeN/3UM00M/RDGosTbKI1
	 WKUqmeTOKrG06G2EdNeVxzDrbr/JuOBUYmkDBA+1cYg+cTxJ0MR2tZ2RtmlFwjvT7+
	 CCq/6Q+K7yR4pLMzkiiFOc48UfiHQLFkVKZuJPurpsy4JpZlMYZ3FfK1XfYeR4Dc8g
	 BN8KVkSShkyQxNqtnAROdmtwjgC7xRf5eV0CTFKTxXSM44oGJw4D8ZDdpB5M4hsr5h
	 TDRpna9fi9Epw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Wei Wang <weiwan@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ncardwell@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 21/62] tcp: fix initial tp->rcvq_space.space value for passive TS enabled flows
Date: Tue,  3 Jun 2025 21:01:32 -0400
Message-Id: <20250604010213.3462-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010213.3462-1-sashal@kernel.org>
References: <20250604010213.3462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cd171461b90a2d2cf230943df60d580174633718 ]

tcp_rcv_state_process() must tweak tp->advmss for TS enabled flows
before the call to tcp_init_transfer() / tcp_init_buffer_space().

Otherwise tp->rcvq_space.space is off by 120 bytes
(TCP_INIT_CWND * TCPOLEN_TSTAMP_ALIGNED).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
Link: https://patch.msgid.link/20250513193919.1089692-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Detailed Analysis ### Nature of the Fix This commit addresses a **subtle
but significant bug** in the TCP receive buffer space initialization for
passive (server-side) connections when TCP timestamps are enabled. The
fix is a simple 2-line reordering that moves the `advmss` adjustment for
timestamp options **before** the call to `tcp_init_transfer()`. ### The
Problem 1. **Root Cause**: In `tcp_rcv_state_process()` for
`TCP_SYN_RECV` state, the `tp->advmss` reduction for timestamp options
(`TCPOLEN_TSTAMP_ALIGNED = 12 bytes`) was happening **after**
`tcp_init_transfer()` was called. 2. **Impact**: Since
`tcp_init_transfer()` calls `tcp_init_buffer_space()`, which initializes
`tp->rcvq_space.space` using the formula: ```c tp->rcvq_space.space =
min3(tp->rcv_ssthresh, tp->rcv_wnd, (u32)TCP_INIT_CWND linux
tp->advmss); ``` The calculation was using an **unadjusted `advmss`
value**, leading to a 120-byte overestimate: - `TCP_INIT_CWND (10) ×
TCPOLEN_TSTAMP_ALIGNED (12) = 120 bytes` 3. **Consequence**: The
`rcvq_space.space` field is critical for TCP receive buffer auto-tuning
in `tcp_rcv_space_adjust()`, and this miscalculation could lead to
suboptimal buffer management and performance issues. ### Why This Should
Be Backported #### ✅ **Bug Fix Criteria Met**: 1. **Clear Bug**: This
fixes a real initialization ordering bug that affects TCP performance 2.
**User Impact**: Affects all passive TCP connections with timestamp
options enabled (very common) 3. **Minimal Risk**: The fix is a simple
2-line reordering with no functional changes 4. **Contained Scope**:
Only affects the initialization path in `tcp_rcv_state_process()` #### ✅
**Follows Stable Tree Rules**: 1. **Important**: TCP receive buffer
tuning affects network performance for most connections 2. **Small &
Contained**: The change moves just 2 lines of existing code 3. **No
Regression Risk**: The fix corrects an obvious ordering error without
introducing new logic 4. **No Architectural Changes**: No new features
or major changes to TCP stack #### ✅ **Comparison with Similar
Backported Commits**: The provided reference commits show a pattern of
TCP receive buffer and `rcvq_space` related fixes being consistently
backported: - Integer overflow fixes in `tcp_rcv_space_adjust()` ✅
**Backported** - Data race fixes for `sysctl_tcp_moderate_rcvbuf` ✅
**Backported** - MPTCP `rcv_space_init` fixes ✅ **Backported** -
Timestamp handling in `tcp_rcv_space_adjust()` ✅ **Backported** This fix
follows the exact same pattern: a small, surgical fix to TCP receive
buffer initialization logic. ### Technical Verification Looking at the
code change in `/home/sasha/linux/net/ipv4/tcp_input.c:6872-6873`, the
fix simply moves: ```c if (tp->rx_opt.tstamp_ok) tp->advmss -=
TCPOLEN_TSTAMP_ALIGNED; ``` from **after** `tcp_init_transfer()` to
**before** it. This ensures that when `tcp_init_buffer_space()` is
called within `tcp_init_transfer()`, it uses the correct timestamp-
adjusted `advmss` value. The change is **safe, targeted, and addresses a
clear functional bug** that affects TCP performance for a large class of
connections. It meets all criteria for stable tree backporting.

 net/ipv4/tcp_input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1f06ffa5f8a1b..7617d4920ed59 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6691,6 +6691,9 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (!tp->srtt_us)
 			tcp_synack_rtt_meas(sk, req);
 
+		if (tp->rx_opt.tstamp_ok)
+			tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
+
 		if (req) {
 			tcp_rcv_synrecv_state_fastopen(sk);
 		} else {
@@ -6715,9 +6718,6 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->snd_wnd = ntohs(th->window) << tp->rx_opt.snd_wscale;
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 
-		if (tp->rx_opt.tstamp_ok)
-			tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
-
 		if (!inet_csk(sk)->icsk_ca_ops->cong_control)
 			tcp_update_pacing_rate(sk);
 
-- 
2.39.5


