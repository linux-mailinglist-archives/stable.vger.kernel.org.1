Return-Path: <stable+bounces-52055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70DE90743A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79B11C23A51
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5A145326;
	Thu, 13 Jun 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jFSc/htR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F24A07
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286484; cv=none; b=Ur/lU1UUqJlp0cQVNu4XCVWaDvLDKEI51Horpd4PFT0qxyl97/H2CrFkGkdnC37gI7iFvsORSR6va3Il/5VnPi9AxioCcfyIlOPmdgxDW+eXSuOGeyeSB08jPpXyJhGB1yCem2P9xMWdo9/WxC0adgfscZsbYR3Pi8tcpxQOmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286484; c=relaxed/simple;
	bh=/dQrRNNz2mPVszGNmHGCjfVyHSU68crTSQrnsrESOs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdqrdUPg9cTMp0C6FoA/shbamJwy7fRY3L7LoW6cjorW6BySLE1+ByzSWqEEY9iQgLUxogmS3+QyV9lH4E7OGePjp8X7jRQfFTbPUSuDI6rkvLzsy8gBitLVrVUeZS9urXn280Wu3MjNZH0EJipG1KX0/gAxjnohYjMv9RDlHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jFSc/htR; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B0873F0E4
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718286473;
	bh=MFqPztQitJYDktXqBkZ6NLUwtPUevbzJdNjmzYUffpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=jFSc/htREI/jOxDnpEPnaAtzd/BnNFwdRVTPxItva8fT7xvJuPol3DtrD90jGVaLy
	 oNRhqECFsP3YUicRxvUBiSlJWpJSrrxyoPiNkchutKzjOA3S8NP1DMYFxFoDex3zO8
	 FiFIkLsiU7poJ3sNA+pPKy8jryZTba91ThW/+X0P47ehOeD6LmIvhSztjqpeCNBU+v
	 uKfq1JKoM54lfvGFPeV27OVlMKSmt4QknbkxtuWMgZeMVqS1I8oGV7xP32xybdyM/G
	 rN4AcjSr6/tJW5vd0mUeh7wGAx/XXUz+lZRVdoxp27SnaDFi32WQ9Baj40h8XCD2j3
	 zLtFXtwaRHqKg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f0fee1f49so55689566b.0
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 06:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286472; x=1718891272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFqPztQitJYDktXqBkZ6NLUwtPUevbzJdNjmzYUffpg=;
        b=gs5Rye5qa6v1msZCW9RLKrHgv2UtePI1godGG60fwKjKU1aVDtxOnv7RcAcTULVhyy
         5ZW3tmfhuD20XJefFIXrZHIjY0Vgtbf/9Pm/Ovrh5zrXJTR28687wMYBKTyXfLImhWFA
         0RSxCRF7QOG12JF1yQ/eVJlCG6PFIJBiiD8jXLmGwdTrZroNSwhMrUx09zv7H7JatmTe
         cUjHTLURu2AffUEbSM8kFBX4H2Exd+nCtaHlmtPFQsFHAPYX1lnnVmDb2ypg5X91NYEp
         tn2qq/iyQdPbtjEHebQwpJSjXipf0xxx2TvV/0KZHhl6bh9mUEl1pzFOqHXLo8Jf1Aii
         lPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW38l/eLNjT7yiMmDggSukzSpXptsTms7zomw3xAGwkM2jiTs/956yaROBweGN3/rnicaAhDG0Af89sTKPbJDLZdd973i4i
X-Gm-Message-State: AOJu0YzxgFrz2W6kq/TpPQTAG8sPrAirx/uPTsrKVdbMrpCu96xfXC+7
	FMyb332u9mm1bMeVdk1XvHIX94pvIUAG3dd5JWfAOoj1x2Zr0QPNU6BXOAdV2ncCAuHETTbW/lZ
	ZYHF4a1RG0GppJBwK8W+QoOwAcLZKXO1WTY/GnRwx7x4Djav/aI2IljA6TUYd6WFqvxV07Z2Iwu
	M6njQecl+BEFawq3EifrDOu1la2zQbJufQcTXg1SW/sWsn
X-Received: by 2002:a17:907:6d08:b0:a6f:489b:ff50 with SMTP id a640c23a62f3a-a6f489c0235mr351318366b.52.1718286472669;
        Thu, 13 Jun 2024 06:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUf9nn+WvUhr3fbrsGnbcPHzbl5rRrZzF8VptZiPY/Dy3NlH0XspoK4Nz2ghUOr3OMFIcX2V6Pq7yY5UMQG2k=
X-Received: by 2002:a17:907:6d08:b0:a6f:489b:ff50 with SMTP id
 a640c23a62f3a-a6f489c0235mr351316366b.52.1718286472251; Thu, 13 Jun 2024
 06:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608025347.90680-1-chengen.du@canonical.com>
 <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch> <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
 <666789d3d9d2a_bf52c294e9@willemb.c.googlers.com.notmuch> <CAPza5qe8KAjjZsZdTupXx27kvdPzhBNcDC=Nk5Xjc4O2obEAAA@mail.gmail.com>
 <6669abb1ea6da_125bdf29449@willemb.c.googlers.com.notmuch>
In-Reply-To: <6669abb1ea6da_125bdf29449@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Thu, 13 Jun 2024 21:47:41 +0800
Message-ID: <CAPza5qeDZonX5prLPOPQWjD2pNwzQHnhFkxCSkqC3ectWtPP3w@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

Thank you for the suggestion.
I have conducted further tests and found that the results are not as
we expected.

I would like to explain my findings based on the following tests:
    ip link add link ens18 ens18.24 type vlan proto 802.1ad id 24
    ip link add link ens18.24 ens18.24.25 type vlan proto 802.1Q id 25
    ifconfig ens18.24 1.0.24.1/24
    ifconfig ens18.24.25 1.0.25.1/24
    ping -n 1.0.25.3 > /dev/null 2>&1 &
    tcpdump -nn -i any -y LINUX_SLL -Q out not tcp and not udp

I have added more logs and found the following results:
    af_packet: tpacket_rcv: dev->name [ens18.24.25]
    af_packet: tpacket_rcv: dev->name [ens18.24]
    af_packet: vlan_get_tci: dev->name [ens18.24], min_header_len
[14], hard_header_len [18]
    af_packet: prb_fill_vlan_info: ppd->hv1.tp_vlan_tci [0],
ppd->hv1.tp_vlan_tpid [8100]
    af_packet: prb_fill_vlan_info: currect vlan_tci [19], tp_vlan_tpid [810=
0]
    af_packet: tpacket_rcv: dev->name [ens18]
    af_packet: vlan_get_tci: dev->name [ens18], min_header_len [14],
hard_header_len [14]
    af_packet: prb_fill_vlan_info: ppd->hv1.tp_vlan_tci [18],
ppd->hv1.tp_vlan_tpid [88a8]
    af_packet: prb_fill_vlan_info: currect vlan_tci [18], tp_vlan_tpid [88a=
8]

It seems that the min_header_len has been set even though the device
is ens18.24.
I will continue investigating this issue.
Thank you for your ongoing assistance.

Best regards,
Chengen Du

On Wed, Jun 12, 2024 at 10:07=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > Hi Willem,
> >
> > On Tue, Jun 11, 2024 at 7:18=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Chengen Du wrote:
> > > > Hi Willem,
> > > >
> > > > I'm sorry, but I would like to confirm the issue further.
> > > >
> > > > On Mon, Jun 10, 2024 at 4:19=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Chengen Du wrote:
> > > > > > The issue initially stems from libpcap. The ethertype will be o=
verwritten
> > > > > > as the VLAN TPID if the network interface lacks hardware VLAN o=
ffloading.
> > > > > > In the outbound packet path, if hardware VLAN offloading is una=
vailable,
> > > > > > the VLAN tag is inserted into the payload but then cleared from=
 the sk_buff
> > > > > > struct. Consequently, this can lead to a false negative when ch=
ecking for
> > > > > > the presence of a VLAN tag, causing the packet sniffing outcome=
 to lack
> > > > > > VLAN tag information (i.e., TCI-TPID). As a result, the packet =
capturing
> > > > > > tool may be unable to parse packets as expected.
> > > > > >
> > > > > > The TCI-TPID is missing because the prb_fill_vlan_info() functi=
on does not
> > > > > > modify the tp_vlan_tci/tp_vlan_tpid values, as the information =
is in the
> > > > > > payload and not in the sk_buff struct. The skb_vlan_tag_present=
() function
> > > > > > only checks vlan_all in the sk_buff struct. In cooked mode, the=
 L2 header
> > > > > > is stripped, preventing the packet capturing tool from determin=
ing the
> > > > > > correct TCI-TPID value. Additionally, the protocol in SLL is in=
correct,
> > > > > > which means the packet capturing tool cannot parse the L3 heade=
r correctly.
> > > > > >
> > > > > > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > > > > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-che=
ngen.du@canonical.com/T/#u
> > > > > > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > > >
> > > > > Overall, solid.
> > > > >
> > > > > > ---
> > > > > >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++=
++++++--
> > > > > >  1 file changed, 55 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > > > index ea3ebc160e25..8cffbe1f912d 100644
> > > > > > --- a/net/packet/af_packet.c
> > > > > > +++ b/net/packet/af_packet.c
> > > > > > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct p=
acket_sock *po,
> > > > > >       return packet_lookup_frame(po, rb, rb->head, status);
> > > > > >  }
> > > > > >
> > > > > > +static u16 vlan_get_tci(struct sk_buff *skb)
> > > > > > +{
> > > > > > +     struct vlan_hdr vhdr, *vh;
> > > > > > +     u8 *skb_orig_data =3D skb->data;
> > > > > > +     int skb_orig_len =3D skb->len;
> > > > > > +
> > > > > > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > > > > > +     vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &v=
hdr);
> > > > >
> > > > > Don't harcode Ethernet.
> > > > >
> > > > > According to documentation VLANs are used with other link layers.
> > > > >
> > > > > More importantly, in practice PF_PACKET allows inserting this
> > > > > skb->protocol on any device.
> > > > >
> > > > > We don't use link layer specific constants anywhere in the packet
> > > > > socket code for this reason. But instead dev->hard_header_len.
> > > > >
> > > > > One caveat there is variable length link layer headers, where
> > > > > dev->min_header_len !=3D dev->hard_header_len. Will just have to =
fail
> > > > > on those.
> > > >
> > > > Thank you for pointing out this error. I would like to confirm if I
> > > > need to use dev->hard_header_len to get the correct header length a=
nd
> > > > return zero if dev->min_header_len !=3D dev->hard_header_len to han=
dle
> > > > variable-length link layer headers. Is there something I
> > > > misunderstand, or are there other aspects I need to consider furthe=
r?
> > >
> > > That's right.
> > >
> > > The min_header_len !=3D hard_header_len check is annoying and may see=
m
> > > pedantic. But it's the only way to trust that the next header starts
> > > at hard_header_len.
> >
> > Thank you for your advice.
> > I have implemented the modification, but I found that the
> > (min_header_len !=3D hard_header_len) check results in unexpected
> > behavior in the following test scenario:
> >     ip link add link ens18 ens18.24 type vlan proto 802.1ad id 24
> >     ip link add link ens18.24 ens18.24.25 type vlan proto 802.1Q id 25
> >     ifconfig ens18.24 1.0.24.1/24
> >     ifconfig ens18.24.25 1.0.25.1/24
> >     ping -n 1.0.25.3 > /dev/null 2>&1 &
> >     tcpdump -nn -i any -y LINUX_SLL -Q out not tcp and not udp
> >
> > While receiving a packet from ens18.24.25 (802.1Q), the min_header_len
> > and hard_header_len are 14 and 18, respectively.
> > This check results in the TCI being 0 instead of 25.
> > Should we skip this check to display the correct value, or is there
> > another check that can achieve the same purpose?
>
> Interesting. Glad you found this.
>
> Makes sense, as VLAN devices have
>
>     vlandev->hard_header_len =3D dev->hard_header_len + VLAN_HLEN;
>
> Does
>
>     if (min_header_len && min_header_len !=3D hard_header_len)
>
> resolve it?
>
> Few devices actually set min_header_len. Initially, only Ethernet in
> ether_setup() and loopback. It was introduced for validation in
> dev_validate_header, and a min_header_len of 0 just skips some basic
> validation.
>
> As long as VLAN devices do not initialize min_header_len (e.g., by
> inheriting it from the physical device and incorrectly setting it to
> ETH_HLEN), then this should be fine.
>

