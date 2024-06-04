Return-Path: <stable+bounces-47909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159EE8FAA94
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 08:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA471F21D4B
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918AA13D517;
	Tue,  4 Jun 2024 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EHRjcEO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADA136E2B
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481699; cv=none; b=O/Oe4f28Nzb7Nf7Hnv+KYe5iBIe5ZXYGcR1DqpgwV2u+ZVd1/Dnb/Tg2fjPXUSLy3cqhl60b1uQk+9ceMAFPRJF5Cc0DtyonavQVJFhhOLfesxWW4bDxCi9f9bEHl1SZ129bZvirMs7B2NopkBAfCbv7zaIHebLG5l3wMNZyCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481699; c=relaxed/simple;
	bh=4hIQQi3dXMlNsoeK8RqHMsi4O+6Mj+5pg/TWlF0xkts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/3RWfXW2H2MJOJgvOv1iN+DO2T3b9Z7+ug8PEHEmw8Ke3yli5fViemrrM2unsw4cFFgSB/KDW+lZLMFr797SHMUuSNjL+iRFCRL3m22A+vbfOW0kE4D0QQv4cqg+lOuWFhhhv/LJ4dMm9opJMW/rkZ57dacqd/i2ExIzKxP+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EHRjcEO0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3B3E03F2A2
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717481690;
	bh=1WeR8EGjanFo/UpdB5WDNqel6tIBsDJjn/aZGqNsPZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=EHRjcEO0NVwpDZhwqTbuRj48Do9UiFqwvZndQ7PWRA0KoP/BtlFVFBURiNIdyn/eG
	 0Pys8boY3CzAmQs6z+BIOS/8Dh0TBrKc94JxxN+vvd/vXiwHzhIaRV4wNg+Z2Tuy+i
	 aLFzXH1XQznEzURu29JiOyK3D5HIt7GwCG2ZmTna0b6rKKd0xEvDj8f3x/1cGAeNkx
	 9Vdp417o8cBiQ2jRocMLhb7PZiZnhlLzjRnIVQiD5JqESM4F1PETCk8Nfowrhe07MA
	 PgK3JrtXcnPY5GdvEK0wpztFXIR4zI9CdTOLVtn6madMeDH5DpsfTcCuC5GgJO212L
	 zYseik80brLMA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a68ea01c455so13158566b.0
        for <stable@vger.kernel.org>; Mon, 03 Jun 2024 23:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717481689; x=1718086489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WeR8EGjanFo/UpdB5WDNqel6tIBsDJjn/aZGqNsPZw=;
        b=ORkzlF/lk2Bwuuind877fgkw2yixn5qAV++30rSPfCG8un/NDp07HiE+x/Xt/ijgzO
         bmazPbAugdu0Nb4HnrNjN7oemyvwng8/46q97QJhN9QC48SRZfEQexvn/oH9QY9qXA37
         3H4ROJCDLofHwd2hzYR14VoP0EVVnshYgz4KPJpxwvpk/vr06GILS4Rv2HnG9gCLJH3G
         Gv5q8RdhANvM08RmhvT/fI/v1n3laPP6mQ66MxxhgZltUUrvcfKE0NPI6o6j7aES8z/5
         vJ9N9KwaubFTf5YdlcOto80RlO9wriLFiN0lFgO4cXC8gPPQ7h1dGPxaeMlC7Gcparjb
         8lkg==
X-Forwarded-Encrypted: i=1; AJvYcCWwgzMT4q/H+RG/vIAR5rqoFNlpW1q6hKTmKJ94Z4I7BBPLQS8pb6V59ZBh+nWllgbn7NXHJbTHzUIsEWTphoV5r4DPYIFD
X-Gm-Message-State: AOJu0YzajrgzhqtZ5/aKGf0aS5KUmZy8xmh5g3kNG6NvEjzmqlbLc5Ln
	soXJ8+ZZD+xbCYKGQMnYASxBhGt8HrC0/dC8iJYz/CmzRyIt60N6qQjIZg3lDrpDGy/6KkNXM5q
	tRZYGmF49uGpxx2CNvfh8vNT7YG8+fcwRpCNx9X1SfNi2fty58I7YBY1tnavlRNFr5J0kCATdk3
	JGsBzyGfb6+O/pfnXGsDtkFxiWP2xLXxCtJwn9J6MQbFrE
X-Received: by 2002:a17:907:97c6:b0:a69:2553:5806 with SMTP id a640c23a62f3a-a6925535850mr262892066b.52.1717481689405;
        Mon, 03 Jun 2024 23:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvx/vKndWMOo5cyA00mATkJWNLrPzXj/JWEyhCiBwE05EjvuiGQN6kfnvCuj3/g62wh9eWFw8QRCyL5AR+jTM=
X-Received: by 2002:a17:907:97c6:b0:a69:2553:5806 with SMTP id
 a640c23a62f3a-a6925535850mr262890266b.52.1717481688973; Mon, 03 Jun 2024
 23:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604054823.20649-1-chengen.du@canonical.com>
In-Reply-To: <20240604054823.20649-1-chengen.du@canonical.com>
From: Chengen Du <chengen.du@canonical.com>
Date: Tue, 4 Jun 2024 14:14:37 +0800
Message-ID: <CAPza5qeVMqpvjwMeBdAfvp=MFxxJv9xS4JfJ9rig9-rNVdKTjA@mail.gmail.com>
Subject: Re: [PATCH v5] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

Thank you for your comments on patch v4.
I have made some modifications and would like to discuss some of your
suggestions in detail.



On Tue, Jun 4, 2024 at 1:50=E2=80=AFPM Chengen Du <chengen.du@canonical.com=
> wrote:
>
> The issue initially stems from libpcap. The ethertype will be overwritten
> as the VLAN TPID if the network interface lacks hardware VLAN offloading.
> In the outbound packet path, if hardware VLAN offloading is unavailable,
> the VLAN tag is inserted into the payload but then cleared from the sk_bu=
ff
> struct. Consequently, this can lead to a false negative when checking for
> the presence of a VLAN tag, causing the packet sniffing outcome to lack
> VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
> tool may be unable to parse packets as expected.
>
> The TCI-TPID is missing because the prb_fill_vlan_info() function does no=
t
> modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
> payload and not in the sk_buff struct. The skb_vlan_tag_present() functio=
n
> only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
> is stripped, preventing the packet capturing tool from determining the
> correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> which means the packet capturing tool cannot parse the L3 header correctl=
y.
>
> Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@ca=
nonical.com/T/#u
> Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..53d51ac87ac6 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -538,6 +538,52 @@ static void *packet_current_frame(struct packet_sock=
 *po,
>         return packet_lookup_frame(po, rb, rb->head, status);
>  }
>
> +static u16 vlan_get_tci(struct sk_buff *skb)
> +{
> +       unsigned int vlan_depth =3D skb->mac_len;
> +       struct vlan_hdr vhdr, *vh;
> +       u8 *skb_head =3D skb->data;
> +       int skb_len =3D skb->len;
> +
> +       if (vlan_depth) {
> +               if (WARN_ON(vlan_depth < VLAN_HLEN))
> +                       return 0;
> +               vlan_depth -=3D VLAN_HLEN;
> +       } else {
> +               vlan_depth =3D ETH_HLEN;
> +       }
> +
> +       skb_push(skb, skb->data - skb_mac_header(skb));
> +       vh =3D skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
> +       if (skb_head !=3D skb->data) {
> +               skb->data =3D skb_head;
> +               skb->len =3D skb_len;
> +       }
> +       if (unlikely(!vh))
> +               return 0;
> +
> +       return ntohs(vh->h_vlan_TCI);
> +}

As you mentioned, we need the outermost VLAN tag to fit the protocol
we referenced in tp_vlan_tpid.
In if_vlan.h, __vlan_get_protocol() only provides the protocol and may
affect other usage scenarios if we modify it to also provide TCI.

There is a similar function called __vlan_get_tag(), which also aims
to extract TCI from the L2 header, but it doesn't check the header
size as __vlan_get_protocol() does.
To prevent affecting other usage scenarios, I introduced a new
function to achieve our purpose.

Additionally, the starting point of skb->data differs in SOCK_RAW and
SOCK_DGRAM cases.
I accounted for this by using skb_push to ensure that skb->data starts
from the L2 header.

Would you recommend modifying __vlan_get_tag() to add the size check
logic instead?
If so, we would also need to consider how to integrate the size check
logic into both __vlan_get_protocol() and __vlan_get_tag().

> +
> +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> +{
> +       __be16 proto =3D skb->protocol;
> +
> +       if (unlikely(eth_type_vlan(proto))) {
> +               u8 *skb_head =3D skb->data;
> +               int skb_len =3D skb->len;
> +
> +               skb_push(skb, skb->data - skb_mac_header(skb));
> +               proto =3D __vlan_get_protocol(skb, proto, NULL);
> +               if (skb_head !=3D skb->data) {
> +                       skb->data =3D skb_head;
> +                       skb->len =3D skb_len;
> +               }
> +       }
> +
> +       return proto;
> +}
> +
>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
>         del_timer_sync(&pkc->retire_blk_timer);
> @@ -1011,6 +1057,10 @@ static void prb_fill_vlan_info(struct tpacket_kbdq=
_core *pkc,
>                 ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
>                 ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
>                 ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> +       } else if (unlikely(eth_type_vlan(pkc->skb->protocol))) {
> +               ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb);
> +               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> +               ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
>         } else {
>                 ppd->hv1.tp_vlan_tci =3D 0;
>                 ppd->hv1.tp_vlan_tpid =3D 0;
> @@ -2428,6 +2478,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct=
 net_device *dev,
>                         h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
>                         h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
>                         status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> +               } else if (unlikely(eth_type_vlan(skb->protocol))) {
> +                       h.h2->tp_vlan_tci =3D vlan_get_tci(skb);
> +                       h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> +                       status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
>                 } else {
>                         h.h2->tp_vlan_tci =3D 0;
>                         h.h2->tp_vlan_tpid =3D 0;
> @@ -2457,7 +2511,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
>         sll->sll_family =3D AF_PACKET;
>         sll->sll_hatype =3D dev->type;
> -       sll->sll_protocol =3D skb->protocol;
> +       sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> +               vlan_get_protocol_dgram(skb) : skb->protocol;
>         sll->sll_pkttype =3D skb->pkt_type;
>         if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>                 sll->sll_ifindex =3D orig_dev->ifindex;
> @@ -3482,7 +3537,8 @@ static int packet_recvmsg(struct socket *sock, stru=
ct msghdr *msg, size_t len,
>                 /* Original length was stored in sockaddr_ll fields */
>                 origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
>                 sll->sll_family =3D AF_PACKET;
> -               sll->sll_protocol =3D skb->protocol;
> +               sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) ?
> +                       vlan_get_protocol_dgram(skb) : skb->protocol;
>         }
>
>         sock_recv_cmsgs(msg, sk, skb);
> @@ -3539,6 +3595,10 @@ static int packet_recvmsg(struct socket *sock, str=
uct msghdr *msg, size_t len,
>                         aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
>                         aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
>                         aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> +               } else if (unlikely(eth_type_vlan(skb->protocol))) {
> +                       aux.tp_vlan_tci =3D vlan_get_tci(skb);
> +                       aux.tp_vlan_tpid =3D ntohs(skb->protocol);
> +                       aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
>                 } else {
>                         aux.tp_vlan_tci =3D 0;
>                         aux.tp_vlan_tpid =3D 0;
> --
> 2.43.0
>

