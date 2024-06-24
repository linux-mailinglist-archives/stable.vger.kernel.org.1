Return-Path: <stable+bounces-54968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3309140A9
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 04:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A18283721
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 02:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37598BE8;
	Mon, 24 Jun 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lFnKVaxQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF352525E
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197337; cv=none; b=NDCwWXlmoswfXSSWaq2G/LxILwAGs+miki1oKIOTZajWYTz/QV2xBRAMuYncANbxcXgjLAuu3oN4M7hAPmdiPMkDvvDQpmCJpkVbxdwW3AX0n2zWtxjY8erz30k2izn0IMiPfpD0IbK8J5okUBqoorypmUTqsIz+Bav4XcLBl80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197337; c=relaxed/simple;
	bh=zoTYdl4aNtiwEnnz41lJFjxApfRkItt70xHJFg6hNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9CBJ59GMrua9kO7IaxN+M9k1O3Lsq13gTTYT04NN5rybSrTnxzjBaFRUt5cL4a+mGCr95dr4FoVgJDbvO/ZfbJlns5AyxQcpkDMrG+OQV7ZS9+WaHFp8PXahGefyweIVW9fCiM9woVaijDeFZkm2h3b9g0HgJkLKZkOB+WLOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lFnKVaxQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F39B33FE21
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 02:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719197325;
	bh=fc6Mz6o054+qkt6n7lp1tTsdpzCztqmqjvGsvLUE4nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=lFnKVaxQb3JaGEKDKA8dDIKvMeI1cFWSkoHLM9sIQ+hyr/zlrbQyQlE+1bPgpYAen
	 OOVBgsf+6oGKoyKyE8Idm7JU0FiV57hvlm7uHE6n+7C5EDFsU+oi0EN2ZlT7Ez1nO/
	 pTml2uDBXwhHTFhHOlNS3huGuzB5UxcTu2P1UPmlvqpD85Os/v5u5VUK7QydvBPIHS
	 +f6T4e444gyBzqrL5VBaEeVzZFd/Zz2dpoSgQQqUQLVJWpz582BYYSnWEVHqn9HiNG
	 eBgs3bQlYy8bkmuZKfL+XKufmPTMY7OF4F8+L+/oQfqJmYhGb7LIyngvwj0/4puBlZ
	 XrkIM1Dg2h2vQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6fe8b2bcc4so53670566b.0
        for <stable@vger.kernel.org>; Sun, 23 Jun 2024 19:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719197324; x=1719802124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc6Mz6o054+qkt6n7lp1tTsdpzCztqmqjvGsvLUE4nM=;
        b=PnsS1grVqnt3etXipCG+lxGx0fujR7vVE8fFn0B2nG6GWspS6KCUjt3B7YNxrLAEnC
         rwfXASBPQ3oh/WEGmhPEOIjM+jJsRmf/rIc8K9wNgOhLoRcAIrdUbcPgAi6ESnW0X1U6
         ZBL6xFHCBl+LwoHf4em44E/VUEz1Eh/3xBtfRK94UfCFydNZ7idKl86ZEQGLkPmJDB37
         HJlj86XghWp1sbWYWDetn0pxM/x5pMdCY6HVm2/3qp3NOysAk+v8FJh5Z5GEucu1AZ+O
         G3d4OrDUubCet9jMKKLw3db7pDKuJ1VQ0/MdbuZ00KSo8U3Hym88zkJN8Uk+LrLO3YZN
         mDVA==
X-Forwarded-Encrypted: i=1; AJvYcCXGQmSzAQeGynthg2EiDpbcpJVwNLogcqTbew5RzkUmlYYArEqznw41P+K9ocomfY+RUOkqfBzIDsmWY4tpdRYRGQ5dJXTh
X-Gm-Message-State: AOJu0YyHsCN9KuBaho8i7K4QCEAFnLbqsBCVLZolGv1G6KYB+quOAryy
	sLn+trRjI5BgZXu4LCcQIiprkk2HZpPfXO9hHmyHB/PAbqaq5JBcldX5awlgPrLzWiJkXnfDMfN
	nV0swA0Ho2yWXHSVAZ/XTt6foOEHqHTQWdar8wgcMxonuQk8p1/bFjMbF6x+ShNMQXuvIkIRYYX
	7cqn6ig+2Wsja97lIeIelMDOoaY8nwxk58yy6wJguKNO0C
X-Received: by 2002:a17:907:cc94:b0:a6f:6126:18aa with SMTP id a640c23a62f3a-a7165477dc4mr214349366b.67.1719197324330;
        Sun, 23 Jun 2024 19:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnMVSO2ffYxvzDDihPd9K9ZFOnzwdpRe4ZUKCU+gJPmAkx7aXVRbzBax/Mnl5GGzzGAk4HZweGTKdJNQ5hvaY=
X-Received: by 2002:a17:907:cc94:b0:a6f:6126:18aa with SMTP id
 a640c23a62f3a-a7165477dc4mr214348566b.67.1719197323795; Sun, 23 Jun 2024
 19:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617054514.127961-1-chengen.du@canonical.com>
 <ZnAdiDjI_unrELB8@nanopsycho.orion> <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>
 <ZnEmiIhs5K4ehcYH@nanopsycho.orion> <66715247c147c_23a4e7294a7@willemb.c.googlers.com.notmuch>
 <CAPza5qfQtPZ-UPF97CG+zEwoQunbzg8F8kX0Q1y5Fzt4Zoc=4w@mail.gmail.com> <6673dc0ee45dd_2a03042941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <6673dc0ee45dd_2a03042941e@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Mon, 24 Jun 2024 10:48:32 +0800
Message-ID: <CAPza5qfqoJeSe3=nEuMAhWygiu0+N3v2Qe1TPB1eywMEyfGLrw@mail.gmail.com>
Subject: Re: [PATCH v8] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 3:36=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > On Tue, Jun 18, 2024 at 5:24=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jiri Pirko wrote:
> > > > Mon, Jun 17, 2024 at 09:07:58PM CEST, willemdebruijn.kernel@gmail.c=
om wrote:
> > > > >Jiri Pirko wrote:
> > > > >> Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical.com w=
rote:
> > > > >> >The issue initially stems from libpcap. The ethertype will be o=
verwritten
> > > > >> >as the VLAN TPID if the network interface lacks hardware VLAN o=
ffloading.
> > > > >> >In the outbound packet path, if hardware VLAN offloading is una=
vailable,
> > > > >> >the VLAN tag is inserted into the payload but then cleared from=
 the sk_buff
> > > > >> >struct. Consequently, this can lead to a false negative when ch=
ecking for
> > > > >> >the presence of a VLAN tag, causing the packet sniffing outcome=
 to lack
> > > > >> >VLAN tag information (i.e., TCI-TPID). As a result, the packet =
capturing
> > > > >> >tool may be unable to parse packets as expected.
> > > > >> >
> > > > >> >The TCI-TPID is missing because the prb_fill_vlan_info() functi=
on does not
> > > > >> >modify the tp_vlan_tci/tp_vlan_tpid values, as the information =
is in the
> > > > >> >payload and not in the sk_buff struct. The skb_vlan_tag_present=
() function
> > > > >> >only checks vlan_all in the sk_buff struct. In cooked mode, the=
 L2 header
> > > > >> >is stripped, preventing the packet capturing tool from determin=
ing the
> > > > >> >correct TCI-TPID value. Additionally, the protocol in SLL is in=
correct,
> > > > >> >which means the packet capturing tool cannot parse the L3 heade=
r correctly.
> > > > >> >
> > > > >> >Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > > >> >Link: https://lore.kernel.org/netdev/20240520070348.26725-1-che=
ngen.du@canonical.com/T/#u
> > > > >> >Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > > > >> >Cc: stable@vger.kernel.org
> > > > >> >Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > > >> >---
> > > > >> > net/packet/af_packet.c | 86 ++++++++++++++++++++++++++++++++++=
+++++++-
> > > > >> > 1 file changed, 84 insertions(+), 2 deletions(-)
> > > > >> >
> > > > >> >diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > >> >index ea3ebc160e25..84e8884a77e3 100644
> > > > >> >--- a/net/packet/af_packet.c
> > > > >> >+++ b/net/packet/af_packet.c
> > > > >> >@@ -538,6 +538,61 @@ static void *packet_current_frame(struct p=
acket_sock *po,
> > > > >> >  return packet_lookup_frame(po, rb, rb->head, status);
> > > > >> > }
> > > > >> >
> > > > >> >+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device=
 *dev)
> > > > >> >+{
> > > > >> >+ struct vlan_hdr vhdr, *vh;
> > > > >> >+ u8 *skb_orig_data =3D skb->data;
> > > > >> >+ int skb_orig_len =3D skb->len;
> > > > >> >+ unsigned int header_len;
> > > > >> >+
> > > > >> >+ if (!dev)
> > > > >> >+         return 0;
> > > > >> >+
> > > > >> >+ /* In the SOCK_DGRAM scenario, skb data starts at the network
> > > > >> >+  * protocol, which is after the VLAN headers. The outer VLAN
> > > > >> >+  * header is at the hard_header_len offset in non-variable
> > > > >> >+  * length link layer headers. If it's a VLAN device, the
> > > > >> >+  * min_header_len should be used to exclude the VLAN header
> > > > >> >+  * size.
> > > > >> >+  */
> > > > >> >+ if (dev->min_header_len =3D=3D dev->hard_header_len)
> > > > >> >+         header_len =3D dev->hard_header_len;
> > > > >> >+ else if (is_vlan_dev(dev))
> > > > >> >+         header_len =3D dev->min_header_len;
> > > > >> >+ else
> > > > >> >+         return 0;
> > > > >> >+
> > > > >> >+ skb_push(skb, skb->data - skb_mac_header(skb));
> > > > >> >+ vh =3D skb_header_pointer(skb, header_len, sizeof(vhdr), &vhd=
r);
> > > > >> >+ if (skb_orig_data !=3D skb->data) {
> > > > >> >+         skb->data =3D skb_orig_data;
> > > > >> >+         skb->len =3D skb_orig_len;
> > > > >> >+ }
> > > > >> >+ if (unlikely(!vh))
> > > > >> >+         return 0;
> > > > >> >+
> > > > >> >+ return ntohs(vh->h_vlan_TCI);
> > > > >> >+}
> > > > >> >+
> > > > >> >+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > > > >> >+{
> > > > >> >+ __be16 proto =3D skb->protocol;
> > > > >> >+
> > > > >> >+ if (unlikely(eth_type_vlan(proto))) {
> > > > >> >+         u8 *skb_orig_data =3D skb->data;
> > > > >> >+         int skb_orig_len =3D skb->len;
> > > > >> >+
> > > > >> >+         skb_push(skb, skb->data - skb_mac_header(skb));
> > > > >> >+         proto =3D __vlan_get_protocol(skb, proto, NULL);
> > > > >> >+         if (skb_orig_data !=3D skb->data) {
> > > > >> >+                 skb->data =3D skb_orig_data;
> > > > >> >+                 skb->len =3D skb_orig_len;
> > > > >> >+         }
> > > > >> >+ }
> > > > >> >+
> > > > >> >+ return proto;
> > > > >> >+}
> > > > >> >+
> > > > >> > static void prb_del_retire_blk_timer(struct tpacket_kbdq_core =
*pkc)
> > > > >> > {
> > > > >> >  del_timer_sync(&pkc->retire_blk_timer);
> > > > >> >@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpa=
cket_kbdq_core *pkc,
> > > > >> > static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> > > > >> >                  struct tpacket3_hdr *ppd)
> > > > >> > {
> > > > >> >+ struct packet_sock *po =3D container_of(pkc, struct packet_so=
ck, rx_ring.prb_bdqc);
> > > > >> >+
> > > > >> >  if (skb_vlan_tag_present(pkc->skb)) {
> > > > >> >          ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> > > > >> >          ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto)=
;
> > > > >> >          ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_V=
LAN_TPID_VALID;
> > > > >> >+ } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && eth_t=
ype_vlan(pkc->skb->protocol))) {
> > > > >> >+         ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb, pkc->=
skb->dev);
> > > > >> >+         ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> > > > >> >+         ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_V=
LAN_TPID_VALID;
> > > > >> >  } else {
> > > > >> >          ppd->hv1.tp_vlan_tci =3D 0;
> > > > >> >          ppd->hv1.tp_vlan_tpid =3D 0;
> > > > >> >@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *s=
kb, struct net_device *dev,
> > > > >> >                  h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> > > > >> >                  h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto)=
;
> > > > >> >                  status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_=
VLAN_TPID_VALID;
> > > > >> >+         } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM && =
eth_type_vlan(skb->protocol))) {
> > > > >> >+                 h.h2->tp_vlan_tci =3D vlan_get_tci(skb, skb->=
dev);
> > > > >> >+                 h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> > > > >> >+                 status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_=
VLAN_TPID_VALID;
> > > > >> >          } else {
> > > > >> >                  h.h2->tp_vlan_tci =3D 0;
> > > > >> >                  h.h2->tp_vlan_tpid =3D 0;
> > > > >> >@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *sk=
b, struct net_device *dev,
> > > > >> >  sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> > > > >> >  sll->sll_family =3D AF_PACKET;
> > > > >> >  sll->sll_hatype =3D dev->type;
> > > > >> >- sll->sll_protocol =3D skb->protocol;
> > > > >> >+ sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > > > >> >+         vlan_get_protocol_dgram(skb) : skb->protocol;
> > > > >> >  sll->sll_pkttype =3D skb->pkt_type;
> > > > >> >  if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> > > > >> >          sll->sll_ifindex =3D orig_dev->ifindex;
> > > > >> >@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *=
sock, struct msghdr *msg, size_t len,
> > > > >> >          /* Original length was stored in sockaddr_ll fields *=
/
> > > > >> >          origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> > > > >> >          sll->sll_family =3D AF_PACKET;
> > > > >> >-         sll->sll_protocol =3D skb->protocol;
> > > > >> >+         sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) =
?
> > > > >> >+                 vlan_get_protocol_dgram(skb) : skb->protocol;
> > > > >> >  }
> > > > >> >
> > > > >> >  sock_recv_cmsgs(msg, sk, skb);
> > > > >> >@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket =
*sock, struct msghdr *msg, size_t len,
> > > > >> >                  aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> > > > >> >                  aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> > > > >> >                  aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_=
STATUS_VLAN_TPID_VALID;
> > > > >> >+         } else if (unlikely(sock->type =3D=3D SOCK_DGRAM && e=
th_type_vlan(skb->protocol))) {
> > > > >>
> > > > >> I don't understand why this would be needed here. We spent quite=
 a bit
> > > > >> of efford in the past to make sure vlan header is always strippe=
d.
> > > > >> Could you fix that in tx path to fulfill the expectation?
> > > > >
> > > > >Doesn't that require NETIF_F_HW_VLAN_CTAG_TX?
> > > > >
> > > > >I also wondered whether we should just convert the skb for this ca=
se
> > > > >with skb_vlan_untag, to avoid needing new PF_PACKET logic to handl=
e
> > > > >unstripped tags in the packet socket code. But it seems equally
> > > > >complex.
> > > >
> > > > Correct. skb_vlan_untag() as a preparation of skb before this funct=
ion
> > > > is called is exactly what I was suggesting.
> > >
> > > It's not necessarily simpler, as that function expects skb->data to
> > > point to the (outer) VLAN header.
> > >
> > > It will pull that one, but not any subsequent ones.
> > >
> > > SOCK_DGRAM expects skb->data to point to the network layer header.
> > > And we only want to make this change for SOCK_DGRAM and if auxdata is
> > > requested.
> > >
> > > Not sure that it will be simpler. But worth a look at least.
> >
> > Thank you for your suggestion.
> >
> > I have analyzed the code and considered a feasible approach. We could
> > call skb_vlan_untag() in packet_rcv before pushing skb into
> > sk->sk_receive_queue.
>
> Only for SOCK_DGRAM.
>
> And there is some user risk, as they will see different packets on
> the same devices as before. A robust program should work for both
> vlan stripped and unstripped, and the unstripped case is already
> broken wrt sll_protocol returned, so I suppose this is acceptable.
>
> > We would also need to determine if auxdata is
> > required to maintain performance, which might cause the logic of
> > judging PACKET_SOCK_AUXDATA to be spread across both the packet_rcv()
> > and packet_recvmsg() functions.
>
> You mean to only make the above change if SOCK_DGRAM and auxdata is
> requested?

Yes, we can constrain the performance overhead to specific scenarios this w=
ay.

>
> Btw, also tpacket_rcv, where auxdata is always returned.
>
> > The skb_vlan_untag() function handles VLANs in a more comprehensive
> > way, but it seems to have a greater performance impact compared to our
> > current approach.
>
> I was afraid of that too. The skb_share_check is fine, as this also
> exists in packet_rcv, before we would call skb_vlan_untag.
>
> A bigger issue: this only pulls the outer tag. So we still need to
> handle the vlan stacking case correctly manually.

It seems we are on the same page. The need to manually handle VLAN
stacking is a significant concern. Since the code is in the critical
path, we must carefully manage the performance overhead. Given that
the current method is more efficient than calling skb_vlan_untag(), I
propose retaining the patch as is. Please let me know if there are any
other concerns.

>
> > As I am not an expert in this domain, I might have overlooked some
> > important aspects. I would appreciate it if you could share your
> > thoughts on this decision.
>
>

