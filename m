Return-Path: <stable+bounces-152544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD58AD6B24
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 10:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E472F7AEFB6
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783022126E;
	Thu, 12 Jun 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hneDcHjl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C32153CB
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717672; cv=none; b=s2sN0NXA9aILJ8h/Q13ReI4LYU2BQCFugePrljwGBc6+OUmzovUIuwkHIdGlRV2WJPxOnvG1/cSSlsreP0qgUDSnm3W3rJmKXk9YCDiB1m8x+ulB/V+HPaVoByw9ZaLvxyzlko9Sf46g8p4tlMtWSBz+ewAW/lYHbI2cTcWCIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717672; c=relaxed/simple;
	bh=hSqx4txxq8gI1uF8LcZg7h66OFOVPUieInvvRk7qxzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjzmd21Sgo1EHIQjSYGyHk1gvLw7lQLF5lq41275WeiyGXnS9xy8EZxu34aTgJAj3uBiw3lWhgNdrtlqXiFPjFJsOB/7+Sdod87qopKbq2eJzT4AYKAQzHnXeItLvXJzwIEJjDyDpTqrypVdgzhpIHtKA6mBnlBVg94mY7KyW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hneDcHjl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a4323fe8caso5295591cf.2
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749717669; x=1750322469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG4m3qnxqkuuUaaqQ/lqlW3im/VPaeSofB2HpjpdB08=;
        b=hneDcHjlhtfq5pZ2RzSe/0fTtP0+PpAkgBzTfMn0FPxq0JersW+Tw7mo5ar/m53Neh
         owhBBlpxoIlKdbWRO4XrYlpKIm1JnVv3bu60RQ56XLFvnOfhd6HWhsnY8/i6BWWZfn4K
         lgjChOG2Y3W1Pa961AjxBLPk8E6ycWuHy8Q1QTYF+DCSCwu59oqoUW5nZSgtzwG2TL1T
         sreUp2Dszx2C05HQ5LnvFbjtkFUjF9xs2AqbFQNaMwGI4bh5CCCMgDzdrEDknRGsiyGG
         +UFA00lXCiokvPYouEG4vOkrcxb4LLBBNumzzy9VXcnkshoOL9zeu0CpQgRiqRx1EBWK
         v11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717669; x=1750322469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG4m3qnxqkuuUaaqQ/lqlW3im/VPaeSofB2HpjpdB08=;
        b=CcNxVVfscODV9lDFJvbdrASusqEKYtxagsa7VpdnkNcDqy2chzZJoRfQuKsa6bJiTN
         0veEKBMEzlwGmhI1OSbvAnUwMuH0gqfywyjF2v1UWyiLiEkrelBe4dFi297EbO0q1Zjj
         9bsG6OQpAB1Jbl6GVktMPE7MRrgWCOsRRHAfXZv4o2TgBAKVMyvXDpHKH7QiRRY93CDe
         /bta4UebfzjwBDLZ15xlDcmZkizU1ukydSPFs4vHV72uiFSIZ9vg5iKSWKk4hW+93SUW
         Iom0EETPGMy2HGXf4SVK1AFhyCCL3QFGhiE/lcfqswOow6bHHuV8vyfy7Ao0hjO+S1tV
         8NBw==
X-Gm-Message-State: AOJu0YxBe3FTReh0tWyqAquNfKdqNlqZyeYIoqkrW9ZUbAZqf1PspbCw
	NT6zi/vGeWZ31mb8y2UWRN+ICe+z3JSdSmPvgZXakasCOtG0peUoCkNKC5fsSiUYz13VZIczugL
	NTFsn7Y1va7CJYiPZ8ha/XtYYySNQWMLyJaYYaJxU0B6oMHP+sCXwhSSl7Ps=
X-Gm-Gg: ASbGncumW5Qu43dtAsPyhKzFB+5baRVzS4co9JnqiM2TMwKY0CGyYWkSxd3GJDwvv4c
	kMAzgxG17GQMTd9gRxuNyOG7qVPnRYvCSSWjfk+sWqDFEUo6Boz93sj3oj+9cpOXkCUEcFQZWmB
	YcmJNalCbV4ZHgzI9nfMuHcW4TIHv+ALw35kYv7/t7Ud4=
X-Google-Smtp-Source: AGHT+IGq1tKCdpl5eOp5ScpqnO2GB6G3iipZVjzMXjVS5r9PAygfJq0a4mklQG4ibHkpsp/sULi5Enycx2K+YPe7MoU=
X-Received: by 2002:a05:622a:5c8d:b0:4a6:f587:ade2 with SMTP id
 d75a77b69052e-4a72425a642mr34685001cf.18.1749717668636; Thu, 12 Jun 2025
 01:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522224433.3219290-1-sashal@kernel.org>
In-Reply-To: <20250522224433.3219290-1-sashal@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Jun 2025 01:40:57 -0700
X-Gm-Features: AX0GCFvpfZhZhtuk65OozudfpPY6ypAmouJwPqzPqBaFkMfCwP7QQASrRaoz9Dw
Message-ID: <CANn89i+jADLAqpg-gOyHFZiFEb0Pks46h=9d8-FiPa1_HEv3YA@mail.gmail.com>
Subject: Re: Patch "tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()"
 has been added to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, ij@kernel.org, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 3:44=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      tcp-reorganize-tcp_in_ack_event-and-tcp_count_delive.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>

May I ask why this patch was backported to stable versions  ?

This is causing a packetdrill test to fail.

Ilpo, can you take a look ?

# packetdrill --ip_version=3Dipv6 --mtu=3D1520 dctcp-plb-simple.pkt
dctcp-plb-simple.pkt:49: error handling packet: inconsistent
flowlabels for this packet: expected: 0x1c50c vs actual: 0xb867c
script packet:  0.032224 P.W 5001:6001(1000) ack 1 <nop,nop,TS val 100 ecr =
100>
actual packet:  0.032209 P.W 5001:6001(1000) ack 1 win 255 <nop,nop,TS
val 124 ecr 100>

$ cat dctcp-plb-simple.pkt
// DCTCP PLB Test
// Check that DCTCP rehashes based on PLB congestion conditions

`sysctl -qw net/ipv4/tcp_ecn=3D1 \
            net/ipv4/tcp_congestion_control=3Ddctcp \
            net/ipv4/tcp_plb_enabled=3D1 \
            net/ipv4/tcp_rmem=3D"4096 131072 15000000"`

// Initialize connection
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

// ECN handshake: send EW flags in SYN packet, E flag in SYN-ACK response
   +0 < SEW 0:0(0) win 32792 <mss 1460,sackOK,TS val 100 ecr 100,nop,wscale=
 6>
   +0 > (flowlabel 0x1) SE. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100
ecr 100,nop,wscale 8>
   +0 < . 1:1(0) ack 1 win 257
   +0 accept(3, ..., ...) =3D 4
   +0 getsockopt(4, IPPROTO_TCP, TCP_CONGESTION, "dctcp", [5]) =3D 0

   +0 write(4, ..., 1000) =3D 1000
   +0 > (flowlabel 0x1) P. 1:1001(1000) ack 1 <nop,nop,TS val 100 ecr 100>
   +0 < . 1:1(0) ack 1001 win 1000 <nop,nop,TS val 100 ecr 100>
   // no ECN mark, flowlabel won't change.

   +0 write(4, ..., 1000) =3D 1000
   +0 > (flowlabel 0x1) P. 1001:2001(1000) ack 1 <nop,nop,TS val 100 ecr 10=
0>
   +0 < . 1:1(0) ack 2001 win 1000 <nop,nop,TS val 100 ecr 100>
   // No packets ECN-marked.

   +0 write(4, ..., 1000) =3D 1000
   +0 > (flowlabel 0x1) P. 2001:3001(1000) ack 1 <nop,nop,TS val 100 ecr 10=
0>
   +0 < E.  1:1(0) ack 3001 win 1000 <nop,nop,TS val 100 ecr 100>
   // ECN-marked. 1 congested round.

   +0 write(4, ..., 1000) =3D 1000
   +0 > (flowlabel 0x1) PW. 3001:4001(1000) ack 1 <nop,nop,TS val 100 ecr 1=
00>
   +0 < E.  1:1(0) ack 4001 win 1000 <nop,nop,TS val 100 ecr 100>
   // ECN-marked. 2 congested round.

   +0 write(4, ..., 1000) =3D 1000
   +0 > (flowlabel 0x1) PW. 4001:5001(1000) ack 1 <nop,nop,TS val 100 ecr 1=
00>
   +0 < E. 1:1(0) ack 5001 win 1000 <nop,nop,TS val 100 ecr 100>
   // ECN-marked. 3 congested round.

   +0 write(4, ..., 1000) =3D 1000
   // Flowlabel will change next round
   +0 > (flowlabel 0x1) PW. 5001:6001(1000) ack 1 <nop,nop,TS val 100 ecr 1=
00>
   +0 < .  1:1(0) ack 6001 win 1000 <nop,nop,TS val 100 ecr 100>
   // No packets ECN-marked. 0 congested round.

   +0 write(4, ..., 1000) =3D 1000
   +0 > (flowlabel 0x2) P. 6001:7001(1000) ack 1 <nop,nop,TS val 100 ecr 10=
0>
   +0 < .  1:1(0) ack 7001 win 1000 <nop,nop,TS val 100 ecr 100>
   // No packets ECN-marked. Verify new flowlabel

   +0 write(4, ..., 1000) =3D 1000
   +0 > (flowlabel 0x2) P. 7001:8001(1000) ack 1 <nop,nop,TS val 100 ecr 10=
0>
   +0 < .  1:1(0) ack 8001 win 1000 <nop,nop,TS val 100 ecr 100>
   // No packets ECN-marked. New flowlabel should stick


>
> commit c39f5ebea6713c908f64e4682c26d144d9a659de
> Author: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Date:   Wed Mar 5 23:38:41 2025 +0100
>
>     tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
>
>     [ Upstream commit 149dfb31615e22271d2525f078c95ea49bc4db24 ]
>
>     - Move tcp_count_delivered() earlier and split tcp_count_delivered_ce=
()
>       out of it
>     - Move tcp_in_ack_event() later
>     - While at it, remove the inline from tcp_in_ack_event() and let
>       the compiler to decide
>
>     Accurate ECN's heuristics does not know if there is going
>     to be ACE field based CE counter increase or not until after
>     rtx queue has been processed. Only then the number of ACKed
>     bytes/pkts is available. As CE or not affects presence of
>     FLAG_ECE, that information for tcp_in_ack_event is not yet
>     available in the old location of the call to tcp_in_ack_event().
>
>     Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
>     Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 10d38ec0ff5ac..a172248b66783 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -425,6 +425,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_so=
ck *tp, const struct tcphdr
>         return false;
>  }
>
> +static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
> +{
> +       tp->delivered_ce +=3D ecn_count;
> +}
> +
> +/* Updates the delivered and delivered_ce counts */
> +static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
> +                               bool ece_ack)
> +{
> +       tp->delivered +=3D delivered;
> +       if (ece_ack)
> +               tcp_count_delivered_ce(tp, delivered);
> +}
> +
>  /* Buffer size and advertised window tuning.
>   *
>   * 1. Tuning sk->sk_sndbuf, when connection enters established state.
> @@ -1137,15 +1151,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_=
buff *skb)
>         }
>  }
>
> -/* Updates the delivered and delivered_ce counts */
> -static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
> -                               bool ece_ack)
> -{
> -       tp->delivered +=3D delivered;
> -       if (ece_ack)
> -               tp->delivered_ce +=3D delivered;
> -}
> -
>  /* This procedure tags the retransmission queue when SACKs arrive.
>   *
>   * We have three tag bits: SACKED(S), RETRANS(R) and LOST(L).
> @@ -3816,12 +3821,23 @@ static void tcp_process_tlp_ack(struct sock *sk, =
u32 ack, int flag)
>         }
>  }
>
> -static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
> +static void tcp_in_ack_event(struct sock *sk, int flag)
>  {
>         const struct inet_connection_sock *icsk =3D inet_csk(sk);
>
> -       if (icsk->icsk_ca_ops->in_ack_event)
> -               icsk->icsk_ca_ops->in_ack_event(sk, flags);
> +       if (icsk->icsk_ca_ops->in_ack_event) {
> +               u32 ack_ev_flags =3D 0;
> +
> +               if (flag & FLAG_WIN_UPDATE)
> +                       ack_ev_flags |=3D CA_ACK_WIN_UPDATE;
> +               if (flag & FLAG_SLOWPATH) {
> +                       ack_ev_flags |=3D CA_ACK_SLOWPATH;
> +                       if (flag & FLAG_ECE)
> +                               ack_ev_flags |=3D CA_ACK_ECE;
> +               }
> +
> +               icsk->icsk_ca_ops->in_ack_event(sk, ack_ev_flags);
> +       }
>  }
>
>  /* Congestion control has updated the cwnd already. So if we're in
> @@ -3938,12 +3954,8 @@ static int tcp_ack(struct sock *sk, const struct s=
k_buff *skb, int flag)
>                 tcp_snd_una_update(tp, ack);
>                 flag |=3D FLAG_WIN_UPDATE;
>
> -               tcp_in_ack_event(sk, CA_ACK_WIN_UPDATE);
> -
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
>         } else {
> -               u32 ack_ev_flags =3D CA_ACK_SLOWPATH;
> -
>                 if (ack_seq !=3D TCP_SKB_CB(skb)->end_seq)
>                         flag |=3D FLAG_DATA;
>                 else
> @@ -3955,19 +3967,12 @@ static int tcp_ack(struct sock *sk, const struct =
sk_buff *skb, int flag)
>                         flag |=3D tcp_sacktag_write_queue(sk, skb, prior_=
snd_una,
>                                                         &sack_state);
>
> -               if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb))) {
> +               if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb)))
>                         flag |=3D FLAG_ECE;
> -                       ack_ev_flags |=3D CA_ACK_ECE;
> -               }
>
>                 if (sack_state.sack_delivered)
>                         tcp_count_delivered(tp, sack_state.sack_delivered=
,
>                                             flag & FLAG_ECE);
> -
> -               if (flag & FLAG_WIN_UPDATE)
> -                       ack_ev_flags |=3D CA_ACK_WIN_UPDATE;
> -
> -               tcp_in_ack_event(sk, ack_ev_flags);
>         }
>
>         /* This is a deviation from RFC3168 since it states that:
> @@ -3994,6 +3999,8 @@ static int tcp_ack(struct sock *sk, const struct sk=
_buff *skb, int flag)
>
>         tcp_rack_update_reo_wnd(sk, &rs);
>
> +       tcp_in_ack_event(sk, flag);
> +
>         if (tp->tlp_high_seq)
>                 tcp_process_tlp_ack(sk, ack, flag);
>
> @@ -4025,6 +4032,7 @@ static int tcp_ack(struct sock *sk, const struct sk=
_buff *skb, int flag)
>         return 1;
>
>  no_queue:
> +       tcp_in_ack_event(sk, flag);
>         /* If data was DSACKed, see if we can undo a cwnd reduction. */
>         if (flag & FLAG_DSACKING_ACK) {
>                 tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &fla=
g,

