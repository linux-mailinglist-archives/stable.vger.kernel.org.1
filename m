Return-Path: <stable+bounces-59131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD392EACE
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7861F22B0C
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FE01667FA;
	Thu, 11 Jul 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuW7zRsI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F3158DA8;
	Thu, 11 Jul 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708443; cv=none; b=Km9XDe+1W77AVhqNk5QN+2GkR+oF5qArmF2YiZ7oUm3CrHhGRyqJAcBqJRtZaDkL61BZc2trCXac2c0pClhPWXupks1QCahUFypKhuUFM8WR5R1+2LCCV3TtA3TfATS1LBsu4Pxcy/XNoVBVPTr1PH6yNd22VzU/Ppf87LW8KUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708443; c=relaxed/simple;
	bh=0cOmxcRk0+/3AKFnowBw/+Y1brcE83Kk9E2BC4J0KHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBMV1xlcQPttlK+VRW0r4BYg8727fJk9JdB5n7ovH8Gv3u3ofTbd0OO0FeWIjSOmDzaaLz2dorXklqxW6PjnjwcOC3Nx7fJfpVcixL51nPQDpOpQmEEFKUnXLW3J9fAAcmVkXmHq8YWaJEC8KZrrFDvWoL3aAsZ0VNKPzXitoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuW7zRsI; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-810197638fcso313622241.1;
        Thu, 11 Jul 2024 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720708440; x=1721313240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM09hnKVB1kESbZILffmOawcWcc5pMVTZevNuy1bqkk=;
        b=BuW7zRsIkKzAvyb/JPNVcPGYjVA4iOo/+dLkH1OXEsSk/KyxSKWRgTRmd14tnl0139
         vjnt65xrFV/L463hGrdHH2XLR8PEca0MbZU95ZCpzGfMYg5CAaTuZUYLAedx5QPnU7Lj
         cOUtiy4c56EFmUDSVTMIJIf0Fo6xHc39lMMojKSKtluL1XqB/YZ+BLdoGLHQRAPpqoqf
         z4WQftKoKvl7vMOL3sJD6xSsorNvDcvk0mR35ul0i2/0b8SQykqr8mqbC75h/rJ6SzwJ
         EQVzLKVg9Rg6Mst5E71r+6R3gpZx7drND1AUP6YrKj8SLRa8hZBI3W27t15SrT+c7Q8X
         ilTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720708440; x=1721313240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM09hnKVB1kESbZILffmOawcWcc5pMVTZevNuy1bqkk=;
        b=Dru+3g7oxjUqg4XFe2mvul3L0jkUMSsu7Csrmmz5AE3X6Zo+Mn2wQaBFAEdwSwyklb
         LojOj3za+h6VC6Oc/5F896Xh7ovRq4WLLR5iZ0euFAIlerKOofAIOUVF2o7kaEmcXKnB
         dnXo6IsYa6w3XvkGkuWYfarnqYiTXlt4OQ0CrX6V0Ni7d8yL5k9Ua9fHpUB7scCSmdMj
         c3Lwd3Erz1LHrA6HAlaQSXZ85XiRZq1xWY39KVYwvxCHKavsE0QZ99Xc0aKRKPZk9T7c
         3vVUnxvSqoxWA5Og+F/cfvirK0SEfejvpGo6iyNyONgNUBL6ODKUhHS4fsW7tjllwC1b
         8a0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyK6XssFd+MohnM13hXWfr5LbJU9M3/bZb1kcvuahBK3xIBR+pJ7frZwQwoFMKOq3+8QjDXJI5jxJUs9nRkkkpms85XoAJGLGSBOwwMWzI06tUQqJIKc9fa5CiUOBaA2Oj1excLKabagCPqncpHwqzyT+r3pPKGFce2Lov
X-Gm-Message-State: AOJu0YwyVJPwczpwVmBpQKdP0TeakwIhai+F8zvF9KkVb4SSPictm/Y2
	OnTW/Ji/Luqnu8WeNGZZZuhYAnBmoSt1ey+NnOAu67MUCTH9xhgbdqmYdo/FldQhC2VT0OYx+IT
	3gGkJT8aDtfJkIKvNbDaG3vPO5e4=
X-Google-Smtp-Source: AGHT+IG+32pOzsD1Wpd/m/yDdX5729UAhjArzwR66VTPZ3h+eIPc2EMF9lsGy46gmKbhU4yaab9TtAr8Zg0w00fRAds=
X-Received: by 2002:a05:6122:21ac:b0:4ef:52e2:6763 with SMTP id
 71dfb90a1353d-4f33f318833mr9932911e0c.13.1720708439701; Thu, 11 Jul 2024
 07:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617054514.127961-1-chengen.du@canonical.com>
 <ZnAdiDjI_unrELB8@nanopsycho.orion> <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>
 <ZnEmiIhs5K4ehcYH@nanopsycho.orion> <66715247c147c_23a4e7294a7@willemb.c.googlers.com.notmuch>
 <CAPza5qfQtPZ-UPF97CG+zEwoQunbzg8F8kX0Q1y5Fzt4Zoc=4w@mail.gmail.com>
 <6673dc0ee45dd_2a03042941e@willemb.c.googlers.com.notmuch>
 <CAPza5qfqoJeSe3=nEuMAhWygiu0+N3v2Qe1TPB1eywMEyfGLrw@mail.gmail.com>
 <66794d8c1d425_3637da294d8@willemb.c.googlers.com.notmuch> <CAPza5qeh+vDAv_Xe5Duz53GFDef2UNxSdPAbgivk=XmdVkJbMQ@mail.gmail.com>
In-Reply-To: <CAPza5qeh+vDAv_Xe5Duz53GFDef2UNxSdPAbgivk=XmdVkJbMQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 11 Jul 2024 10:33:23 -0400
Message-ID: <CAF=yD-+9m9MVTsmidD3wheBCWu6EZGmYEqB6a=jpY0GT74r6fA@mail.gmail.com>
Subject: Re: [PATCH v8] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Chengen Du <chengen.du@canonical.com>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:34=E2=80=AFPM Chengen Du <chengen.du@canonical.c=
om> wrote:
>
> On Mon, Jun 24, 2024 at 6:42=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Chengen Du wrote:
> > > On Thu, Jun 20, 2024 at 3:36=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Chengen Du wrote:
> > > > > On Tue, Jun 18, 2024 at 5:24=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jiri Pirko wrote:
> > > > > > > Mon, Jun 17, 2024 at 09:07:58PM CEST, willemdebruijn.kernel@g=
mail.com wrote:
> > > > > > > >Jiri Pirko wrote:
> > > > > > > >> Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical=
.com wrote:
> > > > > > > >> >The issue initially stems from libpcap. The ethertype wil=
l be overwritten
> > > > > > > >> >as the VLAN TPID if the network interface lacks hardware =
VLAN offloading.
> > > > > > > >> >In the outbound packet path, if hardware VLAN offloading =
is unavailable,
> > > > > > > >> >the VLAN tag is inserted into the payload but then cleare=
d from the sk_buff
> > > > > > > >> >struct. Consequently, this can lead to a false negative w=
hen checking for
> > > > > > > >> >the presence of a VLAN tag, causing the packet sniffing o=
utcome to lack
> > > > > > > >> >VLAN tag information (i.e., TCI-TPID). As a result, the p=
acket capturing
> > > > > > > >> >tool may be unable to parse packets as expected.
> > > > > > > >> >
> > > > > > > >> >The TCI-TPID is missing because the prb_fill_vlan_info() =
function does not
> > > > > > > >> >modify the tp_vlan_tci/tp_vlan_tpid values, as the inform=
ation is in the
> > > > > > > >> >payload and not in the sk_buff struct. The skb_vlan_tag_p=
resent() function
> > > > > > > >> >only checks vlan_all in the sk_buff struct. In cooked mod=
e, the L2 header
> > > > > > > >> >is stripped, preventing the packet capturing tool from de=
termining the
> > > > > > > >> >correct TCI-TPID value. Additionally, the protocol in SLL=
 is incorrect,
> > > > > > > >> >which means the packet capturing tool cannot parse the L3=
 header correctly.
> > > > > > > >> >
> > > > > > > >> >Link: https://github.com/the-tcpdump-group/libpcap/issues=
/1105
> > > > > > > >> >Link: https://lore.kernel.org/netdev/20240520070348.26725=
-1-chengen.du@canonical.com/T/#u
> > > > > > > >> >Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspa=
ce")
> > > > > > > >> >Cc: stable@vger.kernel.org
> > > > > > > >> >Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > > > > > >> >---
> > > > > > > >> > net/packet/af_packet.c | 86 ++++++++++++++++++++++++++++=
+++++++++++++-
> > > > > > > >> > 1 file changed, 84 insertions(+), 2 deletions(-)
> > > > > > > >> >
> > > > > > > >> >diff --git a/net/packet/af_packet.c b/net/packet/af_packe=
t.c
> > > > > > > >> >index ea3ebc160e25..84e8884a77e3 100644
> > > > > > > >> >--- a/net/packet/af_packet.c
> > > > > > > >> >+++ b/net/packet/af_packet.c
> > > > > > > >> >@@ -538,6 +538,61 @@ static void *packet_current_frame(st=
ruct packet_sock *po,
> > > > > > > >> >  return packet_lookup_frame(po, rb, rb->head, status);
> > > > > > > >> > }
> > > > > > > >> >
> > > > > > > >> >+static u16 vlan_get_tci(struct sk_buff *skb, struct net_=
device *dev)
> > > > > > > >> >+{
> > > > > > > >> >+ struct vlan_hdr vhdr, *vh;
> > > > > > > >> >+ u8 *skb_orig_data =3D skb->data;
> > > > > > > >> >+ int skb_orig_len =3D skb->len;
> > > > > > > >> >+ unsigned int header_len;
> > > > > > > >> >+
> > > > > > > >> >+ if (!dev)
> > > > > > > >> >+         return 0;
> > > > > > > >> >+
> > > > > > > >> >+ /* In the SOCK_DGRAM scenario, skb data starts at the n=
etwork
> > > > > > > >> >+  * protocol, which is after the VLAN headers. The outer=
 VLAN
> > > > > > > >> >+  * header is at the hard_header_len offset in non-varia=
ble
> > > > > > > >> >+  * length link layer headers. If it's a VLAN device, th=
e
> > > > > > > >> >+  * min_header_len should be used to exclude the VLAN he=
ader
> > > > > > > >> >+  * size.
> > > > > > > >> >+  */
> > > > > > > >> >+ if (dev->min_header_len =3D=3D dev->hard_header_len)
> > > > > > > >> >+         header_len =3D dev->hard_header_len;
> > > > > > > >> >+ else if (is_vlan_dev(dev))
> > > > > > > >> >+         header_len =3D dev->min_header_len;
> > > > > > > >> >+ else
> > > > > > > >> >+         return 0;
> > > > > > > >> >+
> > > > > > > >> >+ skb_push(skb, skb->data - skb_mac_header(skb));
> > > > > > > >> >+ vh =3D skb_header_pointer(skb, header_len, sizeof(vhdr)=
, &vhdr);
> > > > > > > >> >+ if (skb_orig_data !=3D skb->data) {
> > > > > > > >> >+         skb->data =3D skb_orig_data;
> > > > > > > >> >+         skb->len =3D skb_orig_len;
> > > > > > > >> >+ }
> > > > > > > >> >+ if (unlikely(!vh))
> > > > > > > >> >+         return 0;
> > > > > > > >> >+
> > > > > > > >> >+ return ntohs(vh->h_vlan_TCI);
> > > > > > > >> >+}
> > > > > > > >> >+
> > > > > > > >> >+static __be16 vlan_get_protocol_dgram(struct sk_buff *sk=
b)
> > > > > > > >> >+{
> > > > > > > >> >+ __be16 proto =3D skb->protocol;
> > > > > > > >> >+
> > > > > > > >> >+ if (unlikely(eth_type_vlan(proto))) {
> > > > > > > >> >+         u8 *skb_orig_data =3D skb->data;
> > > > > > > >> >+         int skb_orig_len =3D skb->len;
> > > > > > > >> >+
> > > > > > > >> >+         skb_push(skb, skb->data - skb_mac_header(skb));
> > > > > > > >> >+         proto =3D __vlan_get_protocol(skb, proto, NULL)=
;
> > > > > > > >> >+         if (skb_orig_data !=3D skb->data) {
> > > > > > > >> >+                 skb->data =3D skb_orig_data;
> > > > > > > >> >+                 skb->len =3D skb_orig_len;
> > > > > > > >> >+         }
> > > > > > > >> >+ }
> > > > > > > >> >+
> > > > > > > >> >+ return proto;
> > > > > > > >> >+}
> > > > > > > >> >+
> > > > > > > >> > static void prb_del_retire_blk_timer(struct tpacket_kbdq=
_core *pkc)
> > > > > > > >> > {
> > > > > > > >> >  del_timer_sync(&pkc->retire_blk_timer);
> > > > > > > >> >@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(stru=
ct tpacket_kbdq_core *pkc,
> > > > > > > >> > static void prb_fill_vlan_info(struct tpacket_kbdq_core =
*pkc,
> > > > > > > >> >                  struct tpacket3_hdr *ppd)
> > > > > > > >> > {
> > > > > > > >> >+ struct packet_sock *po =3D container_of(pkc, struct pac=
ket_sock, rx_ring.prb_bdqc);
> > > > > > > >> >+
> > > > > > > >> >  if (skb_vlan_tag_present(pkc->skb)) {
> > > > > > > >> >          ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->=
skb);
> > > > > > > >> >          ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_=
proto);
> > > > > > > >> >          ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_ST=
ATUS_VLAN_TPID_VALID;
> > > > > > > >> >+ } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM &&=
 eth_type_vlan(pkc->skb->protocol))) {
> > > > > > > >> >+         ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb,=
 pkc->skb->dev);
> > > > > > > >> >+         ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->proto=
col);
> > > > > > > >> >+         ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_ST=
ATUS_VLAN_TPID_VALID;
> > > > > > > >> >  } else {
> > > > > > > >> >          ppd->hv1.tp_vlan_tci =3D 0;
> > > > > > > >> >          ppd->hv1.tp_vlan_tpid =3D 0;
> > > > > > > >> >@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_b=
uff *skb, struct net_device *dev,
> > > > > > > >> >                  h.h2->tp_vlan_tci =3D skb_vlan_tag_get(=
skb);
> > > > > > > >> >                  h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_=
proto);
> > > > > > > >> >                  status |=3D TP_STATUS_VLAN_VALID | TP_S=
TATUS_VLAN_TPID_VALID;
> > > > > > > >> >+         } else if (unlikely(sk->sk_type =3D=3D SOCK_DGR=
AM && eth_type_vlan(skb->protocol))) {
> > > > > > > >> >+                 h.h2->tp_vlan_tci =3D vlan_get_tci(skb,=
 skb->dev);
> > > > > > > >> >+                 h.h2->tp_vlan_tpid =3D ntohs(skb->proto=
col);
> > > > > > > >> >+                 status |=3D TP_STATUS_VLAN_VALID | TP_S=
TATUS_VLAN_TPID_VALID;
> > > > > > > >> >          } else {
> > > > > > > >> >                  h.h2->tp_vlan_tci =3D 0;
> > > > > > > >> >                  h.h2->tp_vlan_tpid =3D 0;
> > > > > > > >> >@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_bu=
ff *skb, struct net_device *dev,
> > > > > > > >> >  sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr)=
;
> > > > > > > >> >  sll->sll_family =3D AF_PACKET;
> > > > > > > >> >  sll->sll_hatype =3D dev->type;
> > > > > > > >> >- sll->sll_protocol =3D skb->protocol;
> > > > > > > >> >+ sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > > > > > > >> >+         vlan_get_protocol_dgram(skb) : skb->protocol;
> > > > > > > >> >  sll->sll_pkttype =3D skb->pkt_type;
> > > > > > > >> >  if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV))=
)
> > > > > > > >> >          sll->sll_ifindex =3D orig_dev->ifindex;
> > > > > > > >> >@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct so=
cket *sock, struct msghdr *msg, size_t len,
> > > > > > > >> >          /* Original length was stored in sockaddr_ll fi=
elds */
> > > > > > > >> >          origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> > > > > > > >> >          sll->sll_family =3D AF_PACKET;
> > > > > > > >> >-         sll->sll_protocol =3D skb->protocol;
> > > > > > > >> >+         sll->sll_protocol =3D (sock->type =3D=3D SOCK_D=
GRAM) ?
> > > > > > > >> >+                 vlan_get_protocol_dgram(skb) : skb->pro=
tocol;
> > > > > > > >> >  }
> > > > > > > >> >
> > > > > > > >> >  sock_recv_cmsgs(msg, sk, skb);
> > > > > > > >> >@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct s=
ocket *sock, struct msghdr *msg, size_t len,
> > > > > > > >> >                  aux.tp_vlan_tci =3D skb_vlan_tag_get(sk=
b);
> > > > > > > >> >                  aux.tp_vlan_tpid =3D ntohs(skb->vlan_pr=
oto);
> > > > > > > >> >                  aux.tp_status |=3D TP_STATUS_VLAN_VALID=
 | TP_STATUS_VLAN_TPID_VALID;
> > > > > > > >> >+         } else if (unlikely(sock->type =3D=3D SOCK_DGRA=
M && eth_type_vlan(skb->protocol))) {
> > > > > > > >>
> > > > > > > >> I don't understand why this would be needed here. We spent=
 quite a bit
> > > > > > > >> of efford in the past to make sure vlan header is always s=
tripped.
> > > > > > > >> Could you fix that in tx path to fulfill the expectation?
> > > > > > > >
> > > > > > > >Doesn't that require NETIF_F_HW_VLAN_CTAG_TX?
> > > > > > > >
> > > > > > > >I also wondered whether we should just convert the skb for t=
his case
> > > > > > > >with skb_vlan_untag, to avoid needing new PF_PACKET logic to=
 handle
> > > > > > > >unstripped tags in the packet socket code. But it seems equa=
lly
> > > > > > > >complex.
> > > > > > >
> > > > > > > Correct. skb_vlan_untag() as a preparation of skb before this=
 function
> > > > > > > is called is exactly what I was suggesting.
> > > > > >
> > > > > > It's not necessarily simpler, as that function expects skb->dat=
a to
> > > > > > point to the (outer) VLAN header.
> > > > > >
> > > > > > It will pull that one, but not any subsequent ones.
> > > > > >
> > > > > > SOCK_DGRAM expects skb->data to point to the network layer head=
er.
> > > > > > And we only want to make this change for SOCK_DGRAM and if auxd=
ata is
> > > > > > requested.
> > > > > >
> > > > > > Not sure that it will be simpler. But worth a look at least.
> > > > >
> > > > > Thank you for your suggestion.
> > > > >
> > > > > I have analyzed the code and considered a feasible approach. We c=
ould
> > > > > call skb_vlan_untag() in packet_rcv before pushing skb into
> > > > > sk->sk_receive_queue.
> > > >
> > > > Only for SOCK_DGRAM.
> > > >
> > > > And there is some user risk, as they will see different packets on
> > > > the same devices as before. A robust program should work for both
> > > > vlan stripped and unstripped, and the unstripped case is already
> > > > broken wrt sll_protocol returned, so I suppose this is acceptable.
> > > >
> > > > > We would also need to determine if auxdata is
> > > > > required to maintain performance, which might cause the logic of
> > > > > judging PACKET_SOCK_AUXDATA to be spread across both the packet_r=
cv()
> > > > > and packet_recvmsg() functions.
> > > >
> > > > You mean to only make the above change if SOCK_DGRAM and auxdata is
> > > > requested?
> > >
> > > Yes, we can constrain the performance overhead to specific scenarios =
this way.
> > >
> > > >
> > > > Btw, also tpacket_rcv, where auxdata is always returned.
> > > >
> > > > > The skb_vlan_untag() function handles VLANs in a more comprehensi=
ve
> > > > > way, but it seems to have a greater performance impact compared t=
o our
> > > > > current approach.
> > > >
> > > > I was afraid of that too. The skb_share_check is fine, as this also
> > > > exists in packet_rcv, before we would call skb_vlan_untag.
> > > >
> > > > A bigger issue: this only pulls the outer tag. So we still need to
> > > > handle the vlan stacking case correctly manually.
> > >
> > > It seems we are on the same page. The need to manually handle VLAN
> > > stacking is a significant concern. Since the code is in the critical
> > > path, we must carefully manage the performance overhead. Given that
> > > the current method is more efficient than calling skb_vlan_untag(), I
> > > propose retaining the patch as is. Please let me know if there are an=
y
> > > other concerns.
> >
> > I agree.
>
> I apologize for any inconvenience. May I ask when this patch will be
> merged? Or is there anything I need to do to help the patch proceed?

Please rebase and resubmit.

For details, see also
https://kernel.org/doc/html/latest/process/maintainer-netdev.html#patch-sta=
tus

