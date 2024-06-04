Return-Path: <stable+bounces-47958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67CE8FBF44
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 00:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710FF281D3A
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 22:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69814C59C;
	Tue,  4 Jun 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOekrpHn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFD801;
	Tue,  4 Jun 2024 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541165; cv=none; b=noJnVOMm9iDsYqVKFIk66iuDAYNl6GsOjuRN0QCkIFD/D7o9bdYE9lPjzqQrm6nJ94sqc/SOw7vIcZehe3IWlHDMVRvZnVsco8+I7HRccIPnKhVdGaLpqrMpEyQwWVN1jGLJO1WfTVE1PkXuQgfUUexOAozD0NutqZ2dS5qubLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541165; c=relaxed/simple;
	bh=0j92OYN0ot6ykQ3RbGLDgHKUxmwp+JtNMv1RWWcbk/M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oFJRN2nkTi9LEZ9fwm2tP4qotGXDxAxGLO+EYlODtY+OYJrBpgpy/uftOC+VBIeLrUo84UYio5k4+fp8KkN61TJixw9wOung2ARB1abPJ6S/e9wLdg9/BZgbgeifmTKWA9hJl8+HJLTQBoX8iE/MY9x1izwkNaDa+K3Dwh+M5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOekrpHn; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a080a171dso47143087b3.0;
        Tue, 04 Jun 2024 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541162; x=1718145962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Jj8Pzqt23dEn0FrpFNMot6Gc2YRe5Kly/ELg/v/IE=;
        b=FOekrpHnJNL7oKuhz+5YGPohyXcD+RkKvA60kVOjSBdbnBdSsStpBr7NdWA7+68b5t
         IZtQMAR+26zSoppgyo/CYIGV2KxcuMMd6uWtcu98zp3wjtxykUYXu9Z4stzXbvw46W/4
         GbisMk/VUu2X7u5q2CjUouzg+U1f/a2Gi8uNZMf38TkLrKR8XOahmP5mmh49QKCYtNgy
         6iw1wCmL9pTCVengG8jnbT7q8/FmRqkJqf7o9VzXDZB2JhchWoHyHqFfS1QlnuutuE9l
         NkoZ5my3WKUZds14dduaxALFWRwjZdJQVzfdQM7NwZTowxxsutAaCv44YMI+3YUrC4Yu
         C34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541162; x=1718145962;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0Jj8Pzqt23dEn0FrpFNMot6Gc2YRe5Kly/ELg/v/IE=;
        b=tKhldOkCiOIz259Vk26EaTx+h068XRiDjQS6S8bHTRBQWh6JpaTcEWVGKEio7ICM8n
         PlvWQVkxC0UoW/2xH9juohfMmEKaA1sFiIZoEjHXZV0cRunz8v9X7ruE4hOMfWjXT6Zl
         V3SHK7lhOfPKT8SeoIW9K2/Hp6p+JPRYxh6IU9M7dgkplmrzdx47pSP+MlQH8jvyLKXW
         fgzJCa6DNkTtndjlOYyfGdOSJiPeDAucTrTxqvZSbXE9LJ3/eYV/jWrey3ILVvUin44+
         GcU+rlsmBjZhDaOqMJYTFfP1eIay3dBvnNtRaDCMpzFjRjrq4QFVHa9yLSWSxfvp0Apn
         cuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL//4g9BSTa0fQnUQ+oT5ALrJXhWIfZQED6CpgVr9ZRgtpo/hPgcMyhbJhgdkFMmNY0dJVqzfVr0gboqKP8wy4Q6E8/xOZz9ra2zzF5BoUEgpSXMruR720bwF7dDCBrhWakuGojuPbg1/HL8ZsB0d8gqmAxIAOEU/LYOZB
X-Gm-Message-State: AOJu0Yx7BOAdgvUxAhVMrl+YxT7JhQXLyvYEhLipXca2gjIPQnziE0Gc
	trzHScreGjDXbNi7J14uSwVvXN3huW80IL8ZZQlsQo7FVl2LtiH6
X-Google-Smtp-Source: AGHT+IHIXJN2Un+CobN++6lQfH0UMp9lpxmFKW7kjO/s3cRi4M+lO9D0ilFQrU0NkWsq6pKvkOEqow==
X-Received: by 2002:a81:c602:0:b0:627:c0ab:22b9 with SMTP id 00721157ae682-62cbb4dc6damr6947277b3.21.1717541162307;
        Tue, 04 Jun 2024 15:46:02 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6af5576960bsm29282156d6.3.2024.06.04.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:46:01 -0700 (PDT)
Date: Tue, 04 Jun 2024 18:46:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kaber@trash.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <665f9929a1195_2bf7de294d0@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qeVMqpvjwMeBdAfvp=MFxxJv9xS4JfJ9rig9-rNVdKTjA@mail.gmail.com>
References: <20240604054823.20649-1-chengen.du@canonical.com>
 <CAPza5qeVMqpvjwMeBdAfvp=MFxxJv9xS4JfJ9rig9-rNVdKTjA@mail.gmail.com>
Subject: Re: [PATCH v5] af_packet: Handle outgoing VLAN packets without
 hardware offloading
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chengen Du wrote:
> Hi Willem,
> =

> Thank you for your comments on patch v4.
> I have made some modifications and would like to discuss some of your
> suggestions in detail.

Thanks for the revision. It addresses many of my comments. =

> =

> =

> On Tue, Jun 4, 2024 at 1:50=E2=80=AFPM Chengen Du <chengen.du@canonical=
.com> wrote:
> >
> > The issue initially stems from libpcap. The ethertype will be overwri=
tten
> > as the VLAN TPID if the network interface lacks hardware VLAN offload=
ing.
> > In the outbound packet path, if hardware VLAN offloading is unavailab=
le,
> > the VLAN tag is inserted into the payload but then cleared from the s=
k_buff
> > struct. Consequently, this can lead to a false negative when checking=
 for
> > the presence of a VLAN tag, causing the packet sniffing outcome to la=
ck
> > VLAN tag information (i.e., TCI-TPID). As a result, the packet captur=
ing
> > tool may be unable to parse packets as expected.
> >
> > The TCI-TPID is missing because the prb_fill_vlan_info() function doe=
s not
> > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in =
the
> > payload and not in the sk_buff struct. The skb_vlan_tag_present() fun=
ction
> > only checks vlan_all in the sk_buff struct. In cooked mode, the L2 he=
ader
> > is stripped, preventing the packet capturing tool from determining th=
e
> > correct TCI-TPID value. Additionally, the protocol in SLL is incorrec=
t,
> > which means the packet capturing tool cannot parse the L3 header corr=
ectly.
> >
> > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.d=
u@canonical.com/T/#u
> > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > ---
> >  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++=
--
> >  1 file changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index ea3ebc160e25..53d51ac87ac6 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -538,6 +538,52 @@ static void *packet_current_frame(struct packet_=
sock *po,
> >         return packet_lookup_frame(po, rb, rb->head, status);
> >  }
> >
> > +static u16 vlan_get_tci(struct sk_buff *skb)
> > +{
> > +       unsigned int vlan_depth =3D skb->mac_len;
> > +       struct vlan_hdr vhdr, *vh;
> > +       u8 *skb_head =3D skb->data;
> > +       int skb_len =3D skb->len;
> > +
> > +       if (vlan_depth) {
> > +               if (WARN_ON(vlan_depth < VLAN_HLEN))
> > +                       return 0;
> > +               vlan_depth -=3D VLAN_HLEN;
> > +       } else {
> > +               vlan_depth =3D ETH_HLEN;
> > +       }
> > +
> > +       skb_push(skb, skb->data - skb_mac_header(skb));
> > +       vh =3D skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhd=
r);
> > +       if (skb_head !=3D skb->data) {
> > +               skb->data =3D skb_head;
> > +               skb->len =3D skb_len;
> > +       }
> > +       if (unlikely(!vh))
> > +               return 0;
> > +
> > +       return ntohs(vh->h_vlan_TCI);
> > +}
> =

> As you mentioned, we need the outermost VLAN tag to fit the protocol
> we referenced in tp_vlan_tpid.
> In if_vlan.h, __vlan_get_protocol() only provides the protocol and may
> affect other usage scenarios if we modify it to also provide TCI.
> =

> There is a similar function called __vlan_get_tag(), which also aims
> to extract TCI from the L2 header, but it doesn't check the header
> size as __vlan_get_protocol() does.
> To prevent affecting other usage scenarios, I introduced a new
> function to achieve our purpose.

__vlan_get_protocol exists to parse through possibly multiple VLAG
tags to the inner non-VLAN protocol.

Since you only want the outer VLAN tag, you can use skb_header_pointer
directly. No need for vlan_depth.

Similar to what __vlan_get_tag does, but with safe access as it is not
guaranteed that the data beyond the link layer lies in skb linear.

> Additionally, the starting point of skb->data differs in SOCK_RAW and
> SOCK_DGRAM cases.
> I accounted for this by using skb_push to ensure that skb->data starts
> from the L2 header.
> =

> Would you recommend modifying __vlan_get_tag() to add the size check
> logic instead?
> If so, we would also need to consider how to integrate the size check
> logic into both __vlan_get_protocol() and __vlan_get_tag().

No, let's not touch those.
> =

> > +
> > +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > +{
> > +       __be16 proto =3D skb->protocol;
> > +
> > +       if (unlikely(eth_type_vlan(proto))) {
> > +               u8 *skb_head =3D skb->data;
> > +               int skb_len =3D skb->len;
> > +
> > +               skb_push(skb, skb->data - skb_mac_header(skb));
> > +               proto =3D __vlan_get_protocol(skb, proto, NULL);
> > +               if (skb_head !=3D skb->data) {
> > +                       skb->data =3D skb_head;
> > +                       skb->len =3D skb_len;
> > +               }
> > +       }
> > +
> > +       return proto;
> > +}
> > +
> >  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> >  {
> >         del_timer_sync(&pkc->retire_blk_timer);
> > @@ -1011,6 +1057,10 @@ static void prb_fill_vlan_info(struct tpacket_=
kbdq_core *pkc,
> >                 ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> >                 ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto)=
;
> >                 ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_V=
LAN_TPID_VALID;
> > +       } else if (unlikely(eth_type_vlan(pkc->skb->protocol))) {
> > +               ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb);
> > +               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> > +               ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_V=
LAN_TPID_VALID;
> >         } else {
> >                 ppd->hv1.tp_vlan_tci =3D 0;
> >                 ppd->hv1.tp_vlan_tpid =3D 0;
> > @@ -2428,6 +2478,10 @@ static int tpacket_rcv(struct sk_buff *skb, st=
ruct net_device *dev,
> >                         h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                         h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto)=
;
> >                         status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_=
VLAN_TPID_VALID;
> > +               } else if (unlikely(eth_type_vlan(skb->protocol))) {
> > +                       h.h2->tp_vlan_tci =3D vlan_get_tci(skb);
> > +                       h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                       status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_=
VLAN_TPID_VALID;
> >                 } else {
> >                         h.h2->tp_vlan_tci =3D 0;
> >                         h.h2->tp_vlan_tpid =3D 0;
> > @@ -2457,7 +2511,8 @@ static int tpacket_rcv(struct sk_buff *skb, str=
uct net_device *dev,
> >         sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> >         sll->sll_family =3D AF_PACKET;
> >         sll->sll_hatype =3D dev->type;
> > -       sll->sll_protocol =3D skb->protocol;
> > +       sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > +               vlan_get_protocol_dgram(skb) : skb->protocol;
> >         sll->sll_pkttype =3D skb->pkt_type;
> >         if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> >                 sll->sll_ifindex =3D orig_dev->ifindex;
> > @@ -3482,7 +3537,8 @@ static int packet_recvmsg(struct socket *sock, =
struct msghdr *msg, size_t len,
> >                 /* Original length was stored in sockaddr_ll fields *=
/
> >                 origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> >                 sll->sll_family =3D AF_PACKET;
> > -               sll->sll_protocol =3D skb->protocol;
> > +               sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) =
?
> > +                       vlan_get_protocol_dgram(skb) : skb->protocol;=

> >         }
> >
> >         sock_recv_cmsgs(msg, sk, skb);
> > @@ -3539,6 +3595,10 @@ static int packet_recvmsg(struct socket *sock,=
 struct msghdr *msg, size_t len,
> >                         aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                         aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                         aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_=
STATUS_VLAN_TPID_VALID;
> > +               } else if (unlikely(eth_type_vlan(skb->protocol))) {
> > +                       aux.tp_vlan_tci =3D vlan_get_tci(skb);
> > +                       aux.tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                       aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_=
STATUS_VLAN_TPID_VALID;
> >                 } else {
> >                         aux.tp_vlan_tci =3D 0;
> >                         aux.tp_vlan_tpid =3D 0;
> > --
> > 2.43.0
> >



