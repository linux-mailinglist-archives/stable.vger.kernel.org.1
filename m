Return-Path: <stable+bounces-15091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55428383D6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC05295BAD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2F657B5;
	Tue, 23 Jan 2024 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LAclnXZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61D65191;
	Tue, 23 Jan 2024 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975076; cv=none; b=qH21FaxAcmZdpqE4ISL9ZpCe5U/6JBt5jnyDLcFYme/FnRtmDwMcfbEyBZeu648kvdgQbTLIf6CmOrPcTCqZyV8rOEXcH1SZVEqD5plxEmFEjWLoikvw39oRChy3c4/gMlELQzSkR5Rd8oqhWa2z1eZm/upc2L9YRXjXraN8bnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975076; c=relaxed/simple;
	bh=KJ36RA+xRAVVfdbMCGegi6eD5ZVG8vYfdQlUFfFAHq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9JYI7vJpLt0oMfSISrgCXyaMAfz6yFC1Jie/6yXCTj179sva369C1Ml0VxT0nuBmG8LAK9OiuhSx4n6IleV8FBHJVLrepbN1mrxj+D+XE0mxC9gbSWKQvxedbq8Qn9NphGXFaqoICCB5PjpsZdBHhyRYT+fVL9cxauv/IgR518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LAclnXZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6CDC43394;
	Tue, 23 Jan 2024 01:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975076;
	bh=KJ36RA+xRAVVfdbMCGegi6eD5ZVG8vYfdQlUFfFAHq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAclnXZ6qijvnDodStHbOVWWCOHCh4hkbl6qCQTecIxyJl+jud+5LL0z94sOFaLAL
	 bKsHmOexq08ly39sGrVLNNUjJwd1NIVCo4hcoMgQi7+KiucJFbkTxwNVcdtwox2e7L
	 4L0TVSK/qhPLbQPpss7hzep+2DzA5az0hOimGhKE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Julian Anastasov <ja@ssi.bg>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 355/374] ipvs: avoid stat macros calls from preemptible context
Date: Mon, 22 Jan 2024 16:00:11 -0800
Message-ID: <20240122235757.289067824@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit d6938c1c76c64f42363d0d1f051e1b4641c2ad40 ]

Inside decrement_ttl() upon discovering that the packet ttl has exceeded,
__IP_INC_STATS and __IP6_INC_STATS macros can be called from preemptible
context having the following backtrace:

check_preemption_disabled: 48 callbacks suppressed
BUG: using __this_cpu_add() in preemptible [00000000] code: curl/1177
caller is decrement_ttl+0x217/0x830
CPU: 5 PID: 1177 Comm: curl Not tainted 6.7.0+ #34
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xbd/0xe0
 check_preemption_disabled+0xd1/0xe0
 decrement_ttl+0x217/0x830
 __ip_vs_get_out_rt+0x4e0/0x1ef0
 ip_vs_nat_xmit+0x205/0xcd0
 ip_vs_in_hook+0x9b1/0x26a0
 nf_hook_slow+0xc2/0x210
 nf_hook+0x1fb/0x770
 __ip_local_out+0x33b/0x640
 ip_local_out+0x2a/0x490
 __ip_queue_xmit+0x990/0x1d10
 __tcp_transmit_skb+0x288b/0x3d10
 tcp_connect+0x3466/0x5180
 tcp_v4_connect+0x1535/0x1bb0
 __inet_stream_connect+0x40d/0x1040
 inet_stream_connect+0x57/0xa0
 __sys_connect_file+0x162/0x1a0
 __sys_connect+0x137/0x160
 __x64_sys_connect+0x72/0xb0
 do_syscall_64+0x6f/0x140
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7fe6dbbc34e0

Use the corresponding preemption-aware variants: IP_INC_STATS and
IP6_INC_STATS.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 8d8e20e2d7bb ("ipvs: Decrement ttl")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index cd2130e98836..c87dbc897002 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -271,7 +271,7 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
 			skb->dev = dst->dev;
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
 				    ICMPV6_EXC_HOPLIMIT, 0);
-			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
+			IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 
 			return false;
 		}
@@ -286,7 +286,7 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
 	{
 		if (ip_hdr(skb)->ttl <= 1) {
 			/* Tell the sender its packet died... */
-			__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
+			IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
 			icmp_send(skb, ICMP_TIME_EXCEEDED, ICMP_EXC_TTL, 0);
 			return false;
 		}
-- 
2.43.0




