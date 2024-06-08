Return-Path: <stable+bounces-50025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28853900F4A
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 05:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3F0282C2F
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C1DDA0;
	Sat,  8 Jun 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nR+7qnKn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1CB67E
	for <stable@vger.kernel.org>; Sat,  8 Jun 2024 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717816047; cv=none; b=d484xQbFEc5oY3HKPS5wOpCrxiw3M5aftDI0hDAFF5tNfF/h1mVT/NxDUlCoesTCG9x3+8HFIfmM0beqR47bfgMF2sFrSPUS94jCJx01NVcc4KhSw1RNolv+pZM9dO5PSh/04/ZBjTe0Z3mNd8hJFsEjrN/m8E4L9xWKkzZSlsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717816047; c=relaxed/simple;
	bh=YCObB8/eNnw7bH9wygFij4MX3iWIIHfFl8zrZ541hJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvH6X1l5YojhzbYldMCIC9byr7GI+a9VsyqH9aaBCUGkz62vU9twIPdlHCweaGAUi99GkHgqgtnWK0syTgQmp4oKgCsBIyDMf0JusiNhlKtWc6CslzYoCkd/21dF9JjLNBVcB+BEWTSl+oskf6D04zGbDDwtjoxCbVMbRzaBNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nR+7qnKn; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 10EF83F68D
	for <stable@vger.kernel.org>; Sat,  8 Jun 2024 03:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717816043;
	bh=SV2i825P+LfRV4oSqK4GX2whZN31Ww/kuL3Go7+NkF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nR+7qnKn5UxNYS8M4Yoq/T6FrVbUdCtO7pj/gyulJlQ6A8jONscDj3G91AE6rGxjP
	 AhPD7FdpOmfb1lNKVgWsLTP2Td1hgSnB6IRcn6v1DeahpZYfssGAW27XUhzWUNlv/i
	 e0rPL3l25t2Z7mN+nOnPR83vO+NTP7gbvVQkXzZDFqRVAgAsBK8mbpKGnqsosETBBf
	 GGFiGivobLut26qfKVqvz7P0UVXll5YnXNjQe8gzhGL+DJ9Bcm7Rm2qNTEvvjn5Sgy
	 za3Z1tOsg5arU/Lb1Du4lSrkjeanXdjo0m+sk3Svb3h41Wtg+vVEH6H5zg5/TywK4u
	 wD69wjrcAXVtQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a68f654dc69so194992966b.1
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 20:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717816042; x=1718420842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV2i825P+LfRV4oSqK4GX2whZN31Ww/kuL3Go7+NkF0=;
        b=oY7Dxh4wS3JV1aHUKcIP0LtJ1TWD+0+HJ32hzFS15+mO+qpyKlYbfszKcKeKEuZIc8
         5EkiJ6mnnEuNL8PuO2ieagyiHokO5gLFJbXMrquVZY7xPqPHcADYCZqYKjNkoDbqFEEk
         ReKsNaVjE8i3dgQW55NllzGTFwk+Qpj4vxVtZKeqZh7IuplgM8h6O04pX+Jj7EQRTgYW
         ckQU/v7y+fwgToAYqjRtqq9iSjYiiT/He2H+/B7Glf/lflTQAwiWGxzPTkyVYuFYishT
         ejigOZfFHKjzTzYxx+m2KgTJkb0QF0mFKeQBDYYghqOX3zMQd0hR/y1AFax1ILGn2Bzq
         5s8w==
X-Forwarded-Encrypted: i=1; AJvYcCV1NfQQm12KQcjkXMfgdL5ZN4hpwtwrW5AI1ft7+c2s18RTK8NKas15Ue1EX7uA3l9WTZcue+C2axGcQE2YVinKZdVbr/Gc
X-Gm-Message-State: AOJu0YwbU1YVzFDOifzVDRGkyOKHcN7ugB9E2Xkg0HrNOTR6yNGJD+rZ
	i95NS1BuSVeGa7akNLSOXnWJ2cJH82ZZW7r1MNz4flnkohX6yCpr901yxLh6lf2dwFq0AUg9U6o
	19UbLGohZ2de21CKdIYCAD3Aeiixhh0/Wx1Gl+PvVmTT+C18tZOCvSC+SCXRUoZV4t7NIGQF6rO
	MGRAlIZ56QIlv25ebTIAiEB1MJuJLwS/W/eOJFHTIeoZct
X-Received: by 2002:a17:906:1b03:b0:a64:7c8d:96ed with SMTP id a640c23a62f3a-a6cda9ed2f0mr323316066b.54.1717816042187;
        Fri, 07 Jun 2024 20:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXue1qIPWNKzwrSpiUjmwLUVDiz56tiuygGsbdv/rhDZomoHAj8NYz164W5Sz75yNVDi9rmfP6Lri0MY9Uv2M=
X-Received: by 2002:a17:906:1b03:b0:a64:7c8d:96ed with SMTP id
 a640c23a62f3a-a6cda9ed2f0mr323313866b.54.1717816041518; Fri, 07 Jun 2024
 20:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608025347.90680-1-chengen.du@canonical.com>
In-Reply-To: <20240608025347.90680-1-chengen.du@canonical.com>
From: Chengen Du <chengen.du@canonical.com>
Date: Sat, 8 Jun 2024 11:07:10 +0800
Message-ID: <CAPza5qfuNhDbhV9mau9RE=cNKMwGtJcx4pmjkoHNwpfysnw5yw@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to provide some additional explanations about the patch.


On Sat, Jun 8, 2024 at 10:54=E2=80=AFAM Chengen Du <chengen.du@canonical.co=
m> wrote:
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
>  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..8cffbe1f912d 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_sock=
 *po,
>         return packet_lookup_frame(po, rb, rb->head, status);
>  }
>
> +static u16 vlan_get_tci(struct sk_buff *skb)
> +{
> +       struct vlan_hdr vhdr, *vh;
> +       u8 *skb_orig_data =3D skb->data;
> +       int skb_orig_len =3D skb->len;
> +
> +       skb_push(skb, skb->data - skb_mac_header(skb));
> +       vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr);
> +       if (skb_orig_data !=3D skb->data) {
> +               skb->data =3D skb_orig_data;
> +               skb->len =3D skb_orig_len;
> +       }


The reason for not directly using skb_header_pointer(skb,
skb_mac_header(skb) + ETH_HLEN, ...) to get the VLAN header is due to
the check logic in skb_header_pointer. In the SOCK_DGRAM and
PACKET_OUTGOING scenarios, the offset can be a negative number, which
causes the check logic (i.e., likely(hlen - offset >=3D len)) in
__skb_header_pointer() to not work as expected.

While it is possible to modify __skb_header_pointer() to handle cases
where the offset is negative, this change could affect a wider range
of code.

Please kindly share your thoughts on this approach.


> +       if (unlikely(!vh))
> +               return 0;
> +
> +       return ntohs(vh->h_vlan_TCI);
> +}
> +
> +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> +{
> +       __be16 proto =3D skb->protocol;
> +
> +       if (unlikely(eth_type_vlan(proto))) {
> +               u8 *skb_orig_data =3D skb->data;
> +               int skb_orig_len =3D skb->len;
> +
> +               skb_push(skb, skb->data - skb_mac_header(skb));
> +               proto =3D __vlan_get_protocol(skb, proto, NULL);
> +               if (skb_orig_data !=3D skb->data) {
> +                       skb->data =3D skb_orig_data;
> +                       skb->len =3D skb_orig_len;
> +               }
> +       }
> +
> +       return proto;
> +}
> +
>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
>         del_timer_sync(&pkc->retire_blk_timer);
> @@ -1007,10 +1044,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_=
core *pkc,
>  static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>                         struct tpacket3_hdr *ppd)
>  {
> +       struct packet_sock *po =3D container_of(pkc, struct packet_sock, =
rx_ring.prb_bdqc);
> +
>         if (skb_vlan_tag_present(pkc->skb)) {
>                 ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
>                 ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
>                 ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> +       } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && eth_type_=
vlan(pkc->skb->protocol))) {
> +               ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb);
> +               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> +               ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
>         } else {
>                 ppd->hv1.tp_vlan_tci =3D 0;
>                 ppd->hv1.tp_vlan_tpid =3D 0;
> @@ -2428,6 +2471,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct=
 net_device *dev,
>                         h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
>                         h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
>                         status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> +               } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM && eth_=
type_vlan(skb->protocol))) {
> +                       h.h2->tp_vlan_tci =3D vlan_get_tci(skb);
> +                       h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> +                       status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
>                 } else {
>                         h.h2->tp_vlan_tci =3D 0;
>                         h.h2->tp_vlan_tpid =3D 0;
> @@ -2457,7 +2504,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
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
> @@ -3482,7 +3530,8 @@ static int packet_recvmsg(struct socket *sock, stru=
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
> @@ -3539,6 +3588,10 @@ static int packet_recvmsg(struct socket *sock, str=
uct msghdr *msg, size_t len,
>                         aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
>                         aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
>                         aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> +               } else if (unlikely(sock->type =3D=3D SOCK_DGRAM && eth_t=
ype_vlan(skb->protocol))) {
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

