Return-Path: <stable+bounces-54692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD990FDE9
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD96B20EBC
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 07:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289045C18;
	Thu, 20 Jun 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXimT1q3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9D21364;
	Thu, 20 Jun 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869010; cv=none; b=gND+RD18s/Afy9E5tsGhEb0JHdLtGLqQtILMztV+IAY2NWTZF9eNprDCuQiCyTXDSwxvBDmdfl7icDD/AviWQ3tRM/QIIU+rFd1O49gidXYxUkGQEKRO8sJ7E0Giv5LZ7878pP/Szp/EXhwhDZuEpAwlx3LcPSi8FrGKoOuYMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869010; c=relaxed/simple;
	bh=s9AjXeIifoforNVISNmsGvs5PP+oo9ZTmoi6WzOhXnQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q6P6OzevfY6ph/+GS5c3SBamp4C/pite57EaVA3x0Zumy2ulYo2pvaafu5vAX9mv3nYZ3av9hbnCBJfiAu/6av3b7iPEg+KPUzw+vXk0V0fv1MaX9raGD2NUDMYzum5pXcaQM1tUJaBjoS5SXRfyEB1ls0bTyaA0W9xkLZ108vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXimT1q3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b05c9db85fso3188886d6.2;
        Thu, 20 Jun 2024 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718869008; x=1719473808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf+VRT6SazC3kQF7aTsB0JpxS3zPU59t+oWQoFey/sU=;
        b=SXimT1q3eABRPVbo3hVy9Aq6Vx2vz380iqaqF6B8jksgllORAQYeEFx5VV3Wxzxw4q
         v42O27j37KVzkkE18ezJ9xHFjdKkkuRymrEDUc8BomavVlyWncWMN3QsswGoKLINR9w2
         7kYphL0ACBJzYkNMkUnERSC8gxmcfRGfFFFs6LSPnL/BoETvn+7GKAuAlOuVl5YYu+Lb
         0xFDGVA0dwkqi114FA2jqqfBcF+s+UmHUSPwJmZX062vsERBu8FxIyHWLEQBq7sNH02u
         Somp9IxesBMVr3CV2+km2eIGsc6CgR92hlviM5aGPqmX1MjnARJtIIdaGHRzt7nMSOLz
         4Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869008; x=1719473808;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qf+VRT6SazC3kQF7aTsB0JpxS3zPU59t+oWQoFey/sU=;
        b=rKeyLDms833Ksw4OkplsthdSkjqlvajJv7UuNemm6L3o9MHCsv22NhOel4ldPz1VYw
         Khod3HsZoKhCisdLr9qAAQ1BBfXxY6VF+yBGVBJCGdGOKPVZcNz3JQD68Mo/4wdmAnvK
         xRklDv0SQUoxhy62Nws1KML9fIIlm61igTmJCX5k1SLp0U9i/Wu/EC7jLGy+KFPXgJ38
         2RnhCuKRBQrxXY0VS7s4TnM8yWvTvcmTkfmWcBmQ2koeh5oCTDn4c9zPMyBSMl5mtY4g
         4lFz3PVcidI2GOl3DCS3T/79NNRRHNnFQ0no84wdc+5bmIQobNBDBsN47bI6IgXg80/M
         hsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBtvFzucl5iKckb+adxlWdOGZ+/IbL2S12n4B4q+kwrTy21pf0blyWcJU+vlznoGIDC2b+7xnb/aHfyY8C8X+lt1Hp4qCf9VYVDrjBMybpDaLODJ3/DPG/rzWWERgM1ulVRgukeNqqriSNWHyp/q01cliHlNxlQg7R9G7O
X-Gm-Message-State: AOJu0YznXow/5NxUUYqjks1A2DYIgCOblsV/+RAFq2IEU4kufZsz7Tzk
	mSxWnhbcvAexr3KQTZelZk3UwUgg80VqpQ+ixJzrYdqkiZs4SqCY
X-Google-Smtp-Source: AGHT+IGlnHfydSQrTHefkJi4nCTVMJHlmndeEQXK6JxIexRqCDc0hYSZaRF91pcVu3OQM0cbXkB+Mg==
X-Received: by 2002:a0c:f38e:0:b0:6b5:475:d1ad with SMTP id 6a1803df08f44-6b50475d33cmr43795706d6.34.1718869007651;
        Thu, 20 Jun 2024 00:36:47 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5033f8a0esm17154246d6.134.2024.06.20.00.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:36:47 -0700 (PDT)
Date: Thu, 20 Jun 2024 03:36:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kaber@trash.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <6673dc0ee45dd_2a03042941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qfQtPZ-UPF97CG+zEwoQunbzg8F8kX0Q1y5Fzt4Zoc=4w@mail.gmail.com>
References: <20240617054514.127961-1-chengen.du@canonical.com>
 <ZnAdiDjI_unrELB8@nanopsycho.orion>
 <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>
 <ZnEmiIhs5K4ehcYH@nanopsycho.orion>
 <66715247c147c_23a4e7294a7@willemb.c.googlers.com.notmuch>
 <CAPza5qfQtPZ-UPF97CG+zEwoQunbzg8F8kX0Q1y5Fzt4Zoc=4w@mail.gmail.com>
Subject: Re: [PATCH v8] af_packet: Handle outgoing VLAN packets without
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
> On Tue, Jun 18, 2024 at 5:24=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jiri Pirko wrote:
> > > Mon, Jun 17, 2024 at 09:07:58PM CEST, willemdebruijn.kernel@gmail.c=
om wrote:
> > > >Jiri Pirko wrote:
> > > >> Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical.com w=
rote:
> > > >> >The issue initially stems from libpcap. The ethertype will be o=
verwritten
> > > >> >as the VLAN TPID if the network interface lacks hardware VLAN o=
ffloading.
> > > >> >In the outbound packet path, if hardware VLAN offloading is una=
vailable,
> > > >> >the VLAN tag is inserted into the payload but then cleared from=
 the sk_buff
> > > >> >struct. Consequently, this can lead to a false negative when ch=
ecking for
> > > >> >the presence of a VLAN tag, causing the packet sniffing outcome=
 to lack
> > > >> >VLAN tag information (i.e., TCI-TPID). As a result, the packet =
capturing
> > > >> >tool may be unable to parse packets as expected.
> > > >> >
> > > >> >The TCI-TPID is missing because the prb_fill_vlan_info() functi=
on does not
> > > >> >modify the tp_vlan_tci/tp_vlan_tpid values, as the information =
is in the
> > > >> >payload and not in the sk_buff struct. The skb_vlan_tag_present=
() function
> > > >> >only checks vlan_all in the sk_buff struct. In cooked mode, the=
 L2 header
> > > >> >is stripped, preventing the packet capturing tool from determin=
ing the
> > > >> >correct TCI-TPID value. Additionally, the protocol in SLL is in=
correct,
> > > >> >which means the packet capturing tool cannot parse the L3 heade=
r correctly.
> > > >> >
> > > >> >Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > >> >Link: https://lore.kernel.org/netdev/20240520070348.26725-1-che=
ngen.du@canonical.com/T/#u
> > > >> >Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > > >> >Cc: stable@vger.kernel.org
> > > >> >Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > >> >---
> > > >> > net/packet/af_packet.c | 86 ++++++++++++++++++++++++++++++++++=
+++++++-
> > > >> > 1 file changed, 84 insertions(+), 2 deletions(-)
> > > >> >
> > > >> >diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > >> >index ea3ebc160e25..84e8884a77e3 100644
> > > >> >--- a/net/packet/af_packet.c
> > > >> >+++ b/net/packet/af_packet.c
> > > >> >@@ -538,6 +538,61 @@ static void *packet_current_frame(struct p=
acket_sock *po,
> > > >> >  return packet_lookup_frame(po, rb, rb->head, status);
> > > >> > }
> > > >> >
> > > >> >+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device=
 *dev)
> > > >> >+{
> > > >> >+ struct vlan_hdr vhdr, *vh;
> > > >> >+ u8 *skb_orig_data =3D skb->data;
> > > >> >+ int skb_orig_len =3D skb->len;
> > > >> >+ unsigned int header_len;
> > > >> >+
> > > >> >+ if (!dev)
> > > >> >+         return 0;
> > > >> >+
> > > >> >+ /* In the SOCK_DGRAM scenario, skb data starts at the network=

> > > >> >+  * protocol, which is after the VLAN headers. The outer VLAN
> > > >> >+  * header is at the hard_header_len offset in non-variable
> > > >> >+  * length link layer headers. If it's a VLAN device, the
> > > >> >+  * min_header_len should be used to exclude the VLAN header
> > > >> >+  * size.
> > > >> >+  */
> > > >> >+ if (dev->min_header_len =3D=3D dev->hard_header_len)
> > > >> >+         header_len =3D dev->hard_header_len;
> > > >> >+ else if (is_vlan_dev(dev))
> > > >> >+         header_len =3D dev->min_header_len;
> > > >> >+ else
> > > >> >+         return 0;
> > > >> >+
> > > >> >+ skb_push(skb, skb->data - skb_mac_header(skb));
> > > >> >+ vh =3D skb_header_pointer(skb, header_len, sizeof(vhdr), &vhd=
r);
> > > >> >+ if (skb_orig_data !=3D skb->data) {
> > > >> >+         skb->data =3D skb_orig_data;
> > > >> >+         skb->len =3D skb_orig_len;
> > > >> >+ }
> > > >> >+ if (unlikely(!vh))
> > > >> >+         return 0;
> > > >> >+
> > > >> >+ return ntohs(vh->h_vlan_TCI);
> > > >> >+}
> > > >> >+
> > > >> >+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > > >> >+{
> > > >> >+ __be16 proto =3D skb->protocol;
> > > >> >+
> > > >> >+ if (unlikely(eth_type_vlan(proto))) {
> > > >> >+         u8 *skb_orig_data =3D skb->data;
> > > >> >+         int skb_orig_len =3D skb->len;
> > > >> >+
> > > >> >+         skb_push(skb, skb->data - skb_mac_header(skb));
> > > >> >+         proto =3D __vlan_get_protocol(skb, proto, NULL);
> > > >> >+         if (skb_orig_data !=3D skb->data) {
> > > >> >+                 skb->data =3D skb_orig_data;
> > > >> >+                 skb->len =3D skb_orig_len;
> > > >> >+         }
> > > >> >+ }
> > > >> >+
> > > >> >+ return proto;
> > > >> >+}
> > > >> >+
> > > >> > static void prb_del_retire_blk_timer(struct tpacket_kbdq_core =
*pkc)
> > > >> > {
> > > >> >  del_timer_sync(&pkc->retire_blk_timer);
> > > >> >@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpa=
cket_kbdq_core *pkc,
> > > >> > static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> > > >> >                  struct tpacket3_hdr *ppd)
> > > >> > {
> > > >> >+ struct packet_sock *po =3D container_of(pkc, struct packet_so=
ck, rx_ring.prb_bdqc);
> > > >> >+
> > > >> >  if (skb_vlan_tag_present(pkc->skb)) {
> > > >> >          ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> > > >> >          ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto)=
;
> > > >> >          ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_V=
LAN_TPID_VALID;
> > > >> >+ } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && eth_t=
ype_vlan(pkc->skb->protocol))) {
> > > >> >+         ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb, pkc->=
skb->dev);
> > > >> >+         ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> > > >> >+         ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_V=
LAN_TPID_VALID;
> > > >> >  } else {
> > > >> >          ppd->hv1.tp_vlan_tci =3D 0;
> > > >> >          ppd->hv1.tp_vlan_tpid =3D 0;
> > > >> >@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *s=
kb, struct net_device *dev,
> > > >> >                  h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> > > >> >                  h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto)=
;
> > > >> >                  status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_=
VLAN_TPID_VALID;
> > > >> >+         } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM && =
eth_type_vlan(skb->protocol))) {
> > > >> >+                 h.h2->tp_vlan_tci =3D vlan_get_tci(skb, skb->=
dev);
> > > >> >+                 h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> > > >> >+                 status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_=
VLAN_TPID_VALID;
> > > >> >          } else {
> > > >> >                  h.h2->tp_vlan_tci =3D 0;
> > > >> >                  h.h2->tp_vlan_tpid =3D 0;
> > > >> >@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *sk=
b, struct net_device *dev,
> > > >> >  sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> > > >> >  sll->sll_family =3D AF_PACKET;
> > > >> >  sll->sll_hatype =3D dev->type;
> > > >> >- sll->sll_protocol =3D skb->protocol;
> > > >> >+ sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > > >> >+         vlan_get_protocol_dgram(skb) : skb->protocol;
> > > >> >  sll->sll_pkttype =3D skb->pkt_type;
> > > >> >  if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> > > >> >          sll->sll_ifindex =3D orig_dev->ifindex;
> > > >> >@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *=
sock, struct msghdr *msg, size_t len,
> > > >> >          /* Original length was stored in sockaddr_ll fields *=
/
> > > >> >          origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> > > >> >          sll->sll_family =3D AF_PACKET;
> > > >> >-         sll->sll_protocol =3D skb->protocol;
> > > >> >+         sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) =
?
> > > >> >+                 vlan_get_protocol_dgram(skb) : skb->protocol;=

> > > >> >  }
> > > >> >
> > > >> >  sock_recv_cmsgs(msg, sk, skb);
> > > >> >@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket =
*sock, struct msghdr *msg, size_t len,
> > > >> >                  aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> > > >> >                  aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> > > >> >                  aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_=
STATUS_VLAN_TPID_VALID;
> > > >> >+         } else if (unlikely(sock->type =3D=3D SOCK_DGRAM && e=
th_type_vlan(skb->protocol))) {
> > > >>
> > > >> I don't understand why this would be needed here. We spent quite=
 a bit
> > > >> of efford in the past to make sure vlan header is always strippe=
d.
> > > >> Could you fix that in tx path to fulfill the expectation?
> > > >
> > > >Doesn't that require NETIF_F_HW_VLAN_CTAG_TX?
> > > >
> > > >I also wondered whether we should just convert the skb for this ca=
se
> > > >with skb_vlan_untag, to avoid needing new PF_PACKET logic to handl=
e
> > > >unstripped tags in the packet socket code. But it seems equally
> > > >complex.
> > >
> > > Correct. skb_vlan_untag() as a preparation of skb before this funct=
ion
> > > is called is exactly what I was suggesting.
> >
> > It's not necessarily simpler, as that function expects skb->data to
> > point to the (outer) VLAN header.
> >
> > It will pull that one, but not any subsequent ones.
> >
> > SOCK_DGRAM expects skb->data to point to the network layer header.
> > And we only want to make this change for SOCK_DGRAM and if auxdata is=

> > requested.
> >
> > Not sure that it will be simpler. But worth a look at least.
> =

> Thank you for your suggestion.
> =

> I have analyzed the code and considered a feasible approach. We could
> call skb_vlan_untag() in packet_rcv before pushing skb into
> sk->sk_receive_queue. =


Only for SOCK_DGRAM.

And there is some user risk, as they will see different packets on
the same devices as before. A robust program should work for both
vlan stripped and unstripped, and the unstripped case is already
broken wrt sll_protocol returned, so I suppose this is acceptable.

> We would also need to determine if auxdata is
> required to maintain performance, which might cause the logic of
> judging PACKET_SOCK_AUXDATA to be spread across both the packet_rcv()
> and packet_recvmsg() functions.

You mean to only make the above change if SOCK_DGRAM and auxdata is
requested?

Btw, also tpacket_rcv, where auxdata is always returned.
 =

> The skb_vlan_untag() function handles VLANs in a more comprehensive
> way, but it seems to have a greater performance impact compared to our
> current approach.

I was afraid of that too. The skb_share_check is fine, as this also
exists in packet_rcv, before we would call skb_vlan_untag.

A bigger issue: this only pulls the outer tag. So we still need to
handle the vlan stacking case correctly manually.

> As I am not an expert in this domain, I might have overlooked some
> important aspects. I would appreciate it if you could share your
> thoughts on this decision.



