Return-Path: <stable+bounces-260151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TvJHHIFeIGoZ2AAAu9opvQ
	(envelope-from <stable+bounces-260151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 19:04:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC763A04E
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 19:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lAoOHqiH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260151-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260151-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ADD83235A59
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 16:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA83E9C14;
	Wed,  3 Jun 2026 16:27:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802423E5EFD
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 16:27:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504075; cv=none; b=IDi8ZcPCT50HYzbJNN9zVQNNTJk0pbD044/Q3frl0TDwcyEf1Vgv6C7SfG70QqbmKwBs7JkH8ITQ5Dxq6EnU7sCYVz3vUghoIUxmco8kHhJkTzKRwdix653w87W1vvFEh/mhgE2mlLlAh5iRt7QKrYmdrZj17pvoEkMekDY8fxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504075; c=relaxed/simple;
	bh=bZWAhI/SNWesR7lukDoX5NGLCgeYv7Rk10k9NwhATLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THxuDI/c6Xu5bD9wQxuKzFVoCufLjqn1RuychAi030e7EpAyvFsog7Y9d4iW5n4KXYljspRMQ5Zxqxop0JzTMzXnUfrzDj1iCX+YGpPd8ZnIo0bC9UAFEnC0GtvzPcdkH1f0wXQUVZfOjdErV+abyJTdcdqf8MUaUgHCljESB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAoOHqiH; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842319576d5so2204341b3a.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504074; x=1781108874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd5YhtxLNp2KnXGrb45Y+o+N5pgMe2J5d5AaYwVVkHo=;
        b=lAoOHqiHkGUQKO158ZG8BXYY7dp+xUKGtR0Uqd7YQ3hzvXx8cbmitf8nBbmDHGUO3X
         WyCHEdkkzlYQ9bm4hhSJ2jgxQyMFzh4egE6wSU4BeeTtf0++tTZHjpjceEYm5nVXzEPq
         8s5mh9hCc5fC/aqtto6ILqCCRK5A0Hw06w6cT9A5GZvdxVMDtRr3onb1WslsiwKGrLWS
         SFH58u91/hd5ZmBxXAkOfeSZb9kT2qSxrG3u2f7zL/IueAtb12AJCucNLp5LoaT+0Yr3
         AcvSJQPYP0upHmUbLwGjP6loiveY6Emstqzo9CEgm+aHFTxckrMN2xzHZBSO+NaalPBl
         pChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504074; x=1781108874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd5YhtxLNp2KnXGrb45Y+o+N5pgMe2J5d5AaYwVVkHo=;
        b=hRdEXwqlBxvQZj04HUPqU2U5z16Nif49la7ANIPPrw1FrIYaD8V1CV4+h/kkvHKDE0
         b2/wFTedru7OKymiea6pA4N1Yt5hsMmwBUJO8CC3KdYkDr7+3nXkA1ib/6mP7zT/Bf3i
         Egt6TeTR5aaG8XAsUvzgn4yjfFQZ1UFIPzt3hRlzSvCJDADmoYpvyOphK3upXj4PQXhj
         EB5VqLNdtzFLRyOrrau/81ozGCZ1vfhQcqOEtLQdceUAPGG8brJOtIWfcQqVwKlmQMYK
         CiOvpj+mxND1F0Aw1Hu1gHUEMPhdfTSfNXUKbgI1DSXr1fTa3onHjWIqbmKEFunLV2yu
         u3sg==
X-Forwarded-Encrypted: i=1; AFNElJ8s6js+8xAGZFn2+/Mocn25Pl63mkjzbpVkTwVnLdJgiYPAahoKeorTjj7dUnV/KJ00UnRnma8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrj5gF47E/j5Exs8Z4i77k9Lv6Vl28EGCF7TwnHV+0cg0TOctO
	WrNjbtA9QNbWqDerMPIYINuTURaoRXhHONdHhl8rIZtzGPUcj58Fwk9lOD+yVudT
X-Gm-Gg: Acq92OH/pk24zbakT717AbgmlNZ5L/V5wKJpKyoqkZahy0cE8I4l00TVcGQM2OFzwX7
	ybM0f834YeHh35Whj8jrr43CUFPWPc+N8gIMUdC1leN2J1kdeubP4BDYAY29AyU/191OAzHfQPF
	YqUFDhlE6ycF56RDuspCnqoD+iQxJTPk1gPLeiVAQ7px3Hi6vd9C3sGcnIdsc/JjrL7br2ayNQ9
	SHDdybqDgw3AadZw4o3tRYxCMQN38PKrX3FF0eDp1escEf0ZDNMx/Zjd0Nuz4O5/vCF/tAkTgVh
	IxY51s3WqTQNTuil/B7U0TbdO8luXQdZ8BBW0gh5HYb60sLBPMWQUdR2p8SN53bIfXMkLOXsix4
	c3FDr227lsn1XRdlq+KwBMxRWaXCUzuXK6kSlDWbqtvX3mbYpUt5iubYo6sB/dVbD6CUV3BIeey
	HcXeBuTWgkf2YGwHrMCqEE/TpTxJLTCSeOt/ZVfOzdu2zWQMLbn6SxPhRBOfSdZU/7KMzk8HWOR
	oHL6Sr1oCw=
X-Received: by 2002:a05:6300:67ca:b0:3b4:813d:dae with SMTP id adf61e73a8af0-3b4978049femr4892709637.16.1780504073819;
        Wed, 03 Jun 2026 09:27:53 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4e59sm2930976a12.16.2026.06.03.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:27:53 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] udp: clear skb->dev before running a sockmap verdict
Date: Wed,  3 Jun 2026 16:27:33 +0000
Message-ID: <20260603162737.697215-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,cloudflare.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260151-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:aleksander.lobakin@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4EC763A04E

On the UDP receive path skb->dev is repurposed as dev_scratch (the
truesize/state cache set by udp_set_dev_scratch()), through the
union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff.

When a UDP socket is in a sockmap, sk_data_ready is
sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor()
(sk_psock_verdict_recv) to run the attached SK_SKB verdict program in softirq.
If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
bpf_skc_lookup_tcp), bpf_skc_lookup() does:

	if (skb->dev)
		caller_net = dev_net(skb->dev);

skb->dev still holds the dev_scratch value (a non-NULL integer), so dev_net()
dereferences it as a struct net_device * and the kernel takes a general
protection fault on a non-canonical address in softirq:

  Oops: general protection fault, probably for non-canonical address 0x1010000800004a0
  CPU: 1 UID: 0 PID: 1406 Comm: syz.2.19 Not tainted 7.1.0-rc6 #1 PREEMPT(full)
  RIP: 0010:bpf_skc_lookup net/core/filter.c:7033 [inline]
  RIP: 0010:bpf_sk_lookup+0x45/0x160 net/core/filter.c:7047
  Call Trace:
   <IRQ>
   bpf_prog_4675cb904b7071f8+0x12e/0x14e
   bpf_prog_run_pin_on_cpu+0xc6/0x1f0
   sk_psock_verdict_recv+0x1ba/0x350
   udp_read_skb+0x31a/0x370
   sk_psock_verdict_data_ready+0x2e3/0x600
   __udp_enqueue_schedule_skb+0x4c8/0x650
   udpv6_queue_rcv_one_skb+0x3ec/0x740
   udp6_unicast_rcv_skb+0x11d/0x140
   ip6_protocol_deliver_rcu+0x61e/0x950
   ip6_input_finish+0xa9/0x150
   NF_HOOK+0x286/0x2f0
   ip6_input+0x117/0x220
   NF_HOOK+0x286/0x2f0
   __netif_receive_skb+0x85/0x200
   process_backlog+0x374/0x9a0
   __napi_poll+0x4f/0x1c0
   net_rx_action+0x3b0/0x770
   handle_softirqs+0x15a/0x460
   do_softirq+0x57/0x80
   </IRQ>

The rmem charge that dev_scratch accounted for is released by skb_recv_udp() on
dequeue, just above, so the scratch is dead by the time recv_actor() runs. Clear
skb->dev so bpf_skc_lookup() falls back to sock_net(skb->sk), which
skb_set_owner_sk_safe() set just above.

Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
Cc: stable@vger.kernel.org
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - add blank lines around the added codes (Olek)
 - use generic block comment style (Olek)
 - Cc: stable

 net/ipv4/udp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759..70f6cbd4ef73 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2011,6 +2011,14 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+
+	/*
+	 * skb->dev still aliases the UDP rx dev_scratch (its charge was freed
+	 * on dequeue above); a sockmap verdict program may deref it via
+	 * bpf_sk_lookup_*(), so clear it -> bpf_skc_lookup() uses skb->sk
+	 */
+	skb->dev = NULL;
+
 	return recv_actor(sk, skb);
 }
 
-- 
2.43.0


