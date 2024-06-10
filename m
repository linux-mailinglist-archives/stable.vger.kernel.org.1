Return-Path: <stable+bounces-50097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8F9024F1
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFBE1C22CCC
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC613774B;
	Mon, 10 Jun 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kIxjJUWR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630913212B
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031984; cv=none; b=HJcH3cLrcHbpEakcZktrdZWIPd8Jw/1yOYmLc4ZrEZnHTSJ5YkAZqzDzraUjcpopoDZqKifWlZdDD0Yn0g0vJt2PhZNy/jCwZ08gV2WZiEwCs2Ma/IkCl8DOH2zUJojEZ2Th8cNXU/2G2STP4S4aRg0WhhpKrVUFYZ4UzGwWoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031984; c=relaxed/simple;
	bh=aDAccP97Vrv882n4aLdL6X9An1ESDEwpDibDVG0Cpgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l57HZniIatj7iIIavAVKJFUfUDVKbDY5bF3dRdlrlByEfAqli6ZFE7eHD7khSf5+nKHPYpeTN29DB6znq2hFip6ykB6LCaYhfIDte7TF9DQS9CWZeEHOKUZ6Jq2R7F6siv+FWd6p4+V8D0W9YOp0aQ/UfUcZyF9enl6m1FIYiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kIxjJUWR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 031C33F670
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718031974;
	bh=mMes71e0JY86wpVNx6ZKgnFS0gZH4kPa59mAztM3PFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=kIxjJUWR/fVQFiaLdl7NGGNc1cBIoUVk9RK3FPWCNlmoYyB5+UDPOyZWCHKu7vrLd
	 Q9sh4zlK9tFcvJW/upegrMSotO/vPP0RjFkrTF7Aa3w/P8BN1w3C/Opnfh3MB3SwJP
	 tdgvD9byiCaNR5AS4upNiHX1waJHVhvXKjC1VuYtrnZtThAcx2DdfzIE6oz2JRWTHj
	 sFYRXCl857Bph+SViaVvny1z39hb8FlmY3HlMCgYZPY5YUugauLBg7qBVkxeljFZrn
	 uonEz813E9UvK3YQVvw2UXX8sPoWAPqtimlgGpy/bep2t2RJSsuIQtslnI3wAPfJ6d
	 SAxufh62Nb1Yg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6f0f7d6eaaso192023366b.1
        for <stable@vger.kernel.org>; Mon, 10 Jun 2024 08:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718031973; x=1718636773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMes71e0JY86wpVNx6ZKgnFS0gZH4kPa59mAztM3PFg=;
        b=k0DUtT1mDTWn6wcrLyqdR66t2dWD7v2XpdXgvdugRNKj20wiCM5w51qVmTRIsuwLWy
         +kzN7bl2PTI7zuY3pwXT4a0OLgIS+xm2sho9sYqNCLFuDC1Nq7TR+iuquPKila8cpXjN
         PT7iks/rgHkVtSESgRzvCD4g6V5M6Y7CdmMwL1wUiIzPb1chRC4Yz/ulC/IAnJbGTFu5
         dB4dvXGm/6uVUeklKQJmvhinmCbH3uRyWPM9cUUqnjmi6EnK0MhtvQS4mAwoOKGBgb6+
         yHkiP9x4UiuE0BTtDXiLgxOto4J4qUtSPwdKxukbnCrh5foNoala4InjQWGDwYySE3vN
         18wA==
X-Forwarded-Encrypted: i=1; AJvYcCU+SfcCAxHKS87JfSU7Z15+Whqgvf1fxGXnB/tZoYCR461hsrDNr3QL56cT5Ff4nD1ttnIlm2TLKW4eJHTd4lCMyYASXYL1
X-Gm-Message-State: AOJu0YzhXOmU4kxYpbWPEAsmrJlRRvrZRObK1AuWaxQ+HRtsjBpigNr/
	RFGWnACQ03EREWZMPa74qFdJ/ttEN9jDrw2GbrXRnePrGlzEHdT1UPLh2gtqPGe1ccDB7a/wUe3
	pFAzeKfCGtyF9QuRM+Q10g+bu7rh+UvrIG6sYaiudfxKCBHEhQ0XA6fEEW0My3vsb5Pf27JtRoi
	Njnv1m+dUBXWSHrTtijRW17UhbBEEXRxmisM+v+pxh8yy3
X-Received: by 2002:a17:906:394c:b0:a6e:f53c:8da0 with SMTP id a640c23a62f3a-a6ef53c9238mr604627266b.8.1718031973171;
        Mon, 10 Jun 2024 08:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrmJ35SEN1PL/TpF5aHavYb6tYg73JpLbRO8e6rXdtU1yng691KZtQfvzY9ns5aX5osUkfarAW018EnSL3A58=
X-Received: by 2002:a17:906:394c:b0:a6e:f53c:8da0 with SMTP id
 a640c23a62f3a-a6ef53c9238mr604624866b.8.1718031972662; Mon, 10 Jun 2024
 08:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608025347.90680-1-chengen.du@canonical.com> <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
In-Reply-To: <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Mon, 10 Jun 2024 23:06:01 +0800
Message-ID: <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

I'm sorry, but I would like to confirm the issue further.

On Mon, Jun 10, 2024 at 4:19=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > The issue initially stems from libpcap. The ethertype will be overwritt=
en
> > as the VLAN TPID if the network interface lacks hardware VLAN offloadin=
g.
> > In the outbound packet path, if hardware VLAN offloading is unavailable=
,
> > the VLAN tag is inserted into the payload but then cleared from the sk_=
buff
> > struct. Consequently, this can lead to a false negative when checking f=
or
> > the presence of a VLAN tag, causing the packet sniffing outcome to lack
> > VLAN tag information (i.e., TCI-TPID). As a result, the packet capturin=
g
> > tool may be unable to parse packets as expected.
> >
> > The TCI-TPID is missing because the prb_fill_vlan_info() function does =
not
> > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in th=
e
> > payload and not in the sk_buff struct. The skb_vlan_tag_present() funct=
ion
> > only checks vlan_all in the sk_buff struct. In cooked mode, the L2 head=
er
> > is stripped, preventing the packet capturing tool from determining the
> > correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> > which means the packet capturing tool cannot parse the L3 header correc=
tly.
> >
> > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@=
canonical.com/T/#u
> > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
>
> Overall, solid.
>
> > ---
> >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 55 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index ea3ebc160e25..8cffbe1f912d 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_so=
ck *po,
> >       return packet_lookup_frame(po, rb, rb->head, status);
> >  }
> >
> > +static u16 vlan_get_tci(struct sk_buff *skb)
> > +{
> > +     struct vlan_hdr vhdr, *vh;
> > +     u8 *skb_orig_data =3D skb->data;
> > +     int skb_orig_len =3D skb->len;
> > +
> > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > +     vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr);
>
> Don't harcode Ethernet.
>
> According to documentation VLANs are used with other link layers.
>
> More importantly, in practice PF_PACKET allows inserting this
> skb->protocol on any device.
>
> We don't use link layer specific constants anywhere in the packet
> socket code for this reason. But instead dev->hard_header_len.
>
> One caveat there is variable length link layer headers, where
> dev->min_header_len !=3D dev->hard_header_len. Will just have to fail
> on those.

Thank you for pointing out this error. I would like to confirm if I
need to use dev->hard_header_len to get the correct header length and
return zero if dev->min_header_len !=3D dev->hard_header_len to handle
variable-length link layer headers. Is there something I
misunderstand, or are there other aspects I need to consider further?

>
> > +     if (skb_orig_data !=3D skb->data) {
> > +             skb->data =3D skb_orig_data;
> > +             skb->len =3D skb_orig_len;
> > +     }
> > +     if (unlikely(!vh))
> > +             return 0;
> > +
> > +     return ntohs(vh->h_vlan_TCI);
> > +}
> > +
>
> Only since I had to respond above: this is non-obvious enough to
> deserve a function comment. Something like the following?
>
> /* For SOCK_DGRAM, data starts at the network protocol, after any VLAN
>  * headers. sll_protocol must point to the network protocol. The
>  * (outer) VLAN TCI is still accessible as auxdata.
>  */
>
> > +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > +{
> > +     __be16 proto =3D skb->protocol;
> > +
> > +     if (unlikely(eth_type_vlan(proto))) {
> > +             u8 *skb_orig_data =3D skb->data;
> > +             int skb_orig_len =3D skb->len;
> > +
> > +             skb_push(skb, skb->data - skb_mac_header(skb));
> > +             proto =3D __vlan_get_protocol(skb, proto, NULL);
> > +             if (skb_orig_data !=3D skb->data) {
> > +                     skb->data =3D skb_orig_data;
> > +                     skb->len =3D skb_orig_len;
> > +             }
> > +     }
> > +
> > +     return proto;
> > +}
> > +
> >  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> >  {
> >       del_timer_sync(&pkc->retire_blk_timer);
> > @@ -1007,10 +1044,16 @@ static void prb_clear_rxhash(struct tpacket_kbd=
q_core *pkc,
> >  static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> >                       struct tpacket3_hdr *ppd)
> >  {
> > +     struct packet_sock *po =3D container_of(pkc, struct packet_sock, =
rx_ring.prb_bdqc);
> > +
> >       if (skb_vlan_tag_present(pkc->skb)) {
> >               ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> >               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
> >               ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> > +     } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && eth_type_=
vlan(pkc->skb->protocol))) {
> > +             ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb);
> > +             ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> > +             ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> >       } else {
> >               ppd->hv1.tp_vlan_tci =3D 0;
> >               ppd->hv1.tp_vlan_tpid =3D 0;
> > @@ -2428,6 +2471,10 @@ static int tpacket_rcv(struct sk_buff *skb, stru=
ct net_device *dev,
> >                       h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                       status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> > +             } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM && eth_=
type_vlan(skb->protocol))) {
> > +                     h.h2->tp_vlan_tci =3D vlan_get_tci(skb);
> > +                     h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                     status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> >               } else {
> >                       h.h2->tp_vlan_tci =3D 0;
> >                       h.h2->tp_vlan_tpid =3D 0;
> > @@ -2457,7 +2504,8 @@ static int tpacket_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> >       sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> >       sll->sll_family =3D AF_PACKET;
> >       sll->sll_hatype =3D dev->type;
> > -     sll->sll_protocol =3D skb->protocol;
> > +     sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > +             vlan_get_protocol_dgram(skb) : skb->protocol;
> >       sll->sll_pkttype =3D skb->pkt_type;
> >       if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> >               sll->sll_ifindex =3D orig_dev->ifindex;
> > @@ -3482,7 +3530,8 @@ static int packet_recvmsg(struct socket *sock, st=
ruct msghdr *msg, size_t len,
> >               /* Original length was stored in sockaddr_ll fields */
> >               origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> >               sll->sll_family =3D AF_PACKET;
> > -             sll->sll_protocol =3D skb->protocol;
> > +             sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) ?
> > +                     vlan_get_protocol_dgram(skb) : skb->protocol;
> >       }
> >
> >       sock_recv_cmsgs(msg, sk, skb);
> > @@ -3539,6 +3588,10 @@ static int packet_recvmsg(struct socket *sock, s=
truct msghdr *msg, size_t len,
> >                       aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                       aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > +             } else if (unlikely(sock->type =3D=3D SOCK_DGRAM && eth_t=
ype_vlan(skb->protocol))) {
> > +                     aux.tp_vlan_tci =3D vlan_get_tci(skb);
> > +                     aux.tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                     aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> >               } else {
> >                       aux.tp_vlan_tci =3D 0;
> >                       aux.tp_vlan_tpid =3D 0;
> > --
> > 2.43.0
> >
>
>

