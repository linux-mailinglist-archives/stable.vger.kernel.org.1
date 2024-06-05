Return-Path: <stable+bounces-48244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30398FD66B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 21:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640DB286B7D
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 19:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0F14E2F6;
	Wed,  5 Jun 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehq1ABJw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F014A082;
	Wed,  5 Jun 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615484; cv=none; b=DkJdbzKVaLFkOdN+4G4Pa7p+bcrFOkMAfeTih8bmwjqrj2ad3hKkTzo3NH7Vk+bYi1FKwyxUbwAp6el/ZmJ6I5BZSY/yK56E8NFk9G7I0rmPqccE1rv+FoVWMRGf2wUQQHhXW6U3c9IA8ndY+Sjaizua+Km5AXm20dbu73t4EFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615484; c=relaxed/simple;
	bh=XoiBwK78jmFXZQzlPFjr3KzsMFjDyRNd5EPyxRAUYMQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=X4XEjNlFH6qmyYe40dTso4NJG3dxaQAEAzw3EGMHFgT2Link6Loxfd4sW0Ktt61P5gphWLBzusXlyvOaaj4rNUcRreLs+VnifT+s2vOZW9MCKbbFz2cb9Njtoexpg3TVI7tAec05LX2h6fXOW6Z8qLo94MutAktdgm1use7KLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehq1ABJw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79523244ccfso12818485a.0;
        Wed, 05 Jun 2024 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717615481; x=1718220281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASBZvLM58bf16B0KyrwZKf+HmsxQ7reizaV2L9QBjg4=;
        b=Ehq1ABJwBZRhsKzkfK/tfOxmehT2yS+xrX3ukPj8OeCM0lPlWE+lerl/ej1s+m+Kco
         7T5Dybyy/3ywk6C6aeZ46ChBnvcLeFQlvGn1yTvN6VgP8cFx6zufg0f9ov/pcQ+FvEKr
         x0ale6fZL/SmCA+Jqz6R7GM5SU6ybdRenf0OGTHDKRA/A6GjWngTcUzGElOYGjGthCEE
         2ax6k6x5jcXF5oe6xgIx6HTPs8b4t1QOkn0kFy/MYI6qnEFqqAEmUr2CkFIRr91teWF+
         ZPHtDlc1d/8qwCR4LcHLPFB1nV57axEvMLOFT0umJYylhh+Bhe3xET230KKn+6gc51na
         vS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717615481; x=1718220281;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ASBZvLM58bf16B0KyrwZKf+HmsxQ7reizaV2L9QBjg4=;
        b=SLJAnAAWKPsJ4YataMDyCC06a1JCtrsOQ1gIh26flUjfEiGMXo6sUzj6mZxwbfcxl9
         TMHvz1hrAakJ9MaVrE9S+Zp2g44BiEY70LkoPJzbzGAv8AzZzt50tKadefqZFoVgqbV6
         n6Ds7f+bBWNhNW7S42sMbUe78E2U7k95xW1V5oGESRcX31cZLWhBozTEzS7BBXLOj51F
         PY4Qe8osix05aFtf4hmf8lTkjgfGJbXyaBqZvfqO+Qq06AEQNWq/ze7vsE9kfUPFYcPu
         LjXG/zUvFtqcldNBWZB0Gi/geKl1rXQAs+FPehwPJcrBSIGEQtYKQBgWBXtbj+XRf5bs
         bLng==
X-Forwarded-Encrypted: i=1; AJvYcCWKW0BXhVmlwWmLih1K2je9H+EW/LknRCOluzKZjiufv4xGoToop2y+egIHs7HNTiScfgClY1h9m7AYsiIckDh+w9/LvB6YY694SX1CDZYZz41MfQLIlQ0TBCNFViUfR5Y+6BzhRFVscqYaH32m4jQmq5hGJz/t7hhUDMxk
X-Gm-Message-State: AOJu0YyN3tbl8cRS3Ikxou1XLpWMFPFulTjsztxFN1c3eZspxhAurltR
	wb7QFK24GVcg4GhlMp3ulnf/jW9HDQbF6Sely6+8rhe7HM9wKFms
X-Google-Smtp-Source: AGHT+IEFTCRNTuHsa3tQ48rWIIV3BH8TfeMukY0QeC0iwMcyI+BK8Zpp7rEJoB3zij/+aSyXy8keRw==
X-Received: by 2002:a05:620a:4045:b0:794:fea9:cbb7 with SMTP id af79cd13be357-7952f16e1c9mr100882885a.33.1717615481487;
        Wed, 05 Jun 2024 12:24:41 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2f1215fsm467044285a.41.2024.06.05.12.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:24:40 -0700 (PDT)
Date: Wed, 05 Jun 2024 15:24:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kaber@trash.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <6660bb77cdfc6_3581cb29471@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qctPn_yrFQrO_2NHXpz-kf1qTwxk_APn2t5VU30sY=-MQ@mail.gmail.com>
References: <20240604054823.20649-1-chengen.du@canonical.com>
 <665f9bccaa91c_2bf7de294f4@willemb.c.googlers.com.notmuch>
 <CAPza5qctPn_yrFQrO_2NHXpz-kf1qTwxk_APn2t5VU30sY=-MQ@mail.gmail.com>
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

> My apologies, but I still have some questions I would like to discuss w=
ith you.
> =

> On Wed, Jun 5, 2024 at 6:57=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Chengen Du wrote:
> > > The issue initially stems from libpcap. The ethertype will be overw=
ritten
> > > as the VLAN TPID if the network interface lacks hardware VLAN offlo=
ading.
> > > In the outbound packet path, if hardware VLAN offloading is unavail=
able,
> > > the VLAN tag is inserted into the payload but then cleared from the=
 sk_buff
> > > struct. Consequently, this can lead to a false negative when checki=
ng for
> > > the presence of a VLAN tag, causing the packet sniffing outcome to =
lack
> > > VLAN tag information (i.e., TCI-TPID). As a result, the packet capt=
uring
> > > tool may be unable to parse packets as expected.
> > >
> > > The TCI-TPID is missing because the prb_fill_vlan_info() function d=
oes not
> > > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is i=
n the
> > > payload and not in the sk_buff struct. The skb_vlan_tag_present() f=
unction
> > > only checks vlan_all in the sk_buff struct. In cooked mode, the L2 =
header
> > > is stripped, preventing the packet capturing tool from determining =
the
> > > correct TCI-TPID value. Additionally, the protocol in SLL is incorr=
ect,
> > > which means the packet capturing tool cannot parse the L3 header co=
rrectly.
> > >
> > > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen=
.du@canonical.com/T/#u
> > > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > ---
> > >  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++=
++--
> > >  1 file changed, 62 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > index ea3ebc160e25..53d51ac87ac6 100644
> > > --- a/net/packet/af_packet.c
> > > +++ b/net/packet/af_packet.c
> > > @@ -538,6 +538,52 @@ static void *packet_current_frame(struct packe=
t_sock *po,
> > >       return packet_lookup_frame(po, rb, rb->head, status);
> > >  }
> > >
> > > +static u16 vlan_get_tci(struct sk_buff *skb)
> > > +{
> > > +     unsigned int vlan_depth =3D skb->mac_len;
> > > +     struct vlan_hdr vhdr, *vh;
> > > +     u8 *skb_head =3D skb->data;
> > > +     int skb_len =3D skb->len;
> > > +
> > > +     if (vlan_depth) {
> > > +             if (WARN_ON(vlan_depth < VLAN_HLEN))
> > > +                     return 0;
> > > +             vlan_depth -=3D VLAN_HLEN;
> > > +     } else {
> > > +             vlan_depth =3D ETH_HLEN;
> > > +     }
> > > +
> > > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > > +     vh =3D skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhd=
r);
> > > +     if (skb_head !=3D skb->data) {
> > > +             skb->data =3D skb_head;
> > > +             skb->len =3D skb_len;
> > > +     }
> > > +     if (unlikely(!vh))
> > > +             return 0;
> > > +
> > > +     return ntohs(vh->h_vlan_TCI);
> >
> > As stated in the conversation: no need for the vlan_depth code.
> >
> > skb->data is either at the link layer header or immediately beyond it=

> > (i.e., at the outer vlan tag).
> =

> I'm confused about this part and feel there may be some
> misunderstanding on my end. From what I understand, skb->data will be
> at different positions depending on the scenario. For example, in
> tpacket_rcv(), in SOCK_RAW, it will be at the link layer header, but
> for SOCK_DGRAM with PACKET_OUTGOING, it will be at the network layer
> header.

Right, but that is a binary option. Either at L2 or right after.

skb_header_pointer(skb, skb_mac_offset(skb) - ETH_VLEN, ...) will do.
> =

> Given this situation, it seems necessary to adjust skb->data to point
> to the link layer header and then seek the VLAN tag based on the MAC
> length, rather than parsing directly from the skb->data head. Could
> you please clarify this in more detail?
> =

> >
> > > +}
> > > +
> > > +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > > +{
> > > +     __be16 proto =3D skb->protocol;
> > > +
> > > +     if (unlikely(eth_type_vlan(proto))) {
> > > +             u8 *skb_head =3D skb->data;
> >
> > Since skb->head is a different thing from skb->data, please call this=

> > orig_data or so.
> > > +             int skb_len =3D skb->len;
> > > +
> > > +             skb_push(skb, skb->data - skb_mac_header(skb));
> > > +             proto =3D __vlan_get_protocol(skb, proto, NULL);
> > > +             if (skb_head !=3D skb->data) {
> > > +                     skb->data =3D skb_head;
> > > +                     skb->len =3D skb_len;
> > > +             }
> > > +     }
> >
> > I don't see a way around this temporary skb->data mangling, so +1
> > unless someone else suggests a cleaner way.
> >
> > On second thought, one option:
> >
> > This adds some parsing overhead in the datapath. SOCK_RAW does not
> > need it, as it can see the whole VLAN tag. Perhaps limit the new
> > branches to SOCK_DGRAM cases? Then the above can also be simplified.
> =

> I considered this approach before, but it would result in different
> metadata for SOCK_DGRAM and SOCK_RAW scenarios. This difference makes
> me hesitate because it might be better to provide consistent metadata
> to describe the same packet, regardless of the receiver's approach.
> These are just my thoughts and I'm open to further discussion.

See Alexandre's response and my follow-up.=

