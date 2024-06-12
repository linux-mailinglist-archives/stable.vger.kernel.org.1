Return-Path: <stable+bounces-50270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83809054C1
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D603282EE6
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB4017D8B1;
	Wed, 12 Jun 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqyNpVAD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17696171E70;
	Wed, 12 Jun 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201269; cv=none; b=kUV8KqUpRjQcWVs9EvdaR2U4VXmE84CdtWBDTxOAEI3b637v+kgDPaq2Nv3ftpxYGqzUwJ/Cmod48icI6IyB0HwtlOTiblj3wIxXPwpyGizLA/hlzQEO+QebLxLyMawmuDFZCefGhvUOQD2aWPdfRh42rzcWHZlZGhoZo6GMPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201269; c=relaxed/simple;
	bh=tvpQtmG9GKbEjMfOixraVd8c1QJ+lM5kAtNXcOuBzCk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uRF38zTHUmcfZHo0+f5+KILXkLppBDAvrTD7n2vWY2nxlj2c94J46FvWrtIuEmyxv+moHVro56BlNB7cxFuIEHTejeOIm9DgiweGY5DZLU3SqnOHWXt46X8OY8f5XIfZxPTs0PRtGthxD2h5Z0p7O0tnSvWU+yC1Jq23BpfEYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqyNpVAD; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7955af79812so243280585a.1;
        Wed, 12 Jun 2024 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201267; x=1718806067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce+3GfyZfs+4Onl09vCEctP6ADYwNAlHzNketWBX8Q4=;
        b=aqyNpVADpkq7T3UuxaWNV2iEYSZ11Yzqs1cTIJ8V+j4+YlM9hEM/7/ih9eMvudExg1
         gcOogAn6C3RCfsMYvWjJ+UAtKhpjqhSjl/2ARY9I7UMAEESQR4S3XyAyz/Zi9xQuO+zd
         +SRX4HY+eJUAwEG/kb/RpkgOASV4HoL3xTayqlzdVRP0du3/2Nk1mffngsEyeMgn5W1e
         u/LfcX1oo1SaUibrsk78L4Ipm525ioyMEWygX44cp9nlXmaMCF/H59en1Ur+QV8idgcP
         S4fOeK8Ktn8ch717lkkWPEv3/YhNvtIZ201PIXR987LTG4r2QtCA+AleO3GuyDjHoKzp
         8UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201267; x=1718806067;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ce+3GfyZfs+4Onl09vCEctP6ADYwNAlHzNketWBX8Q4=;
        b=EavZgEL2apF6CRfaFk3T9dzjKZJFjBHAjZ4vLkHXYrGxLlrpo83ANa9QHgNckjl8aC
         x4KizXErE9APS9T64GL5q1ISo84Jp2KOZGiji9bA7c80mFS+R/wQJR6mWU1RLrwtfMAW
         1KbjKt4mT/2yp8EgH+pjXsKPILJc3Kzv7fo4QScOqSOfceaIMHUkDsfO8lm15XId5W/9
         PJO4ktNV1hHXIxIJk6wQlt4c6Zab6bOOkiyfYDdSCgvi0yHOEizPbERX2nlhCBA2+dq5
         JIg1vS6T3yHFXlKex0pUG2UxKhvdVles0FdPNf/2tV1tzLK++ZPc22RE8YPyYmYm8PyJ
         DnXw==
X-Forwarded-Encrypted: i=1; AJvYcCUVCTA+iahQxBhsi0CMlWKDomspgRnZPtQPaBxoJtN3rL62n8RznK+ARPq1nujaqIgMME18SlwVsva531srKgjpg+sLsRyuf5qRpwSDgmZNEKp29ZK+SFLIK7LYvv0p7ZlAj+RlP07H3+Nk+zX+1ICOdbKkYK/KvrSrIVX0
X-Gm-Message-State: AOJu0Yy+WTCUNUnI6L6mvC2eME+0790g5CF4AogA+9F7j6uwaWvLxl0N
	1BRXoPfKwg7ER4fraaPWMPptE3ZTwJNpq/U+Wo+/0TEkgwmOUagM
X-Google-Smtp-Source: AGHT+IEqeAgUIbWDyqQ+TrjYtoU/ednpVRQgLeTNGOEt+KlWBWdCAh0RUplKMPnr0ax4ufbCrw+MDg==
X-Received: by 2002:a05:620a:46a9:b0:795:5958:7281 with SMTP id af79cd13be357-797f601b1a1mr232803085a.22.1718201266830;
        Wed, 12 Jun 2024 07:07:46 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954b9553c7sm461105385a.130.2024.06.12.07.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:07:46 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:07:45 -0400
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
Message-ID: <6669abb1ea6da_125bdf29449@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qe8KAjjZsZdTupXx27kvdPzhBNcDC=Nk5Xjc4O2obEAAA@mail.gmail.com>
References: <20240608025347.90680-1-chengen.du@canonical.com>
 <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
 <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
 <666789d3d9d2a_bf52c294e9@willemb.c.googlers.com.notmuch>
 <CAPza5qe8KAjjZsZdTupXx27kvdPzhBNcDC=Nk5Xjc4O2obEAAA@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
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

> On Tue, Jun 11, 2024 at 7:18=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Chengen Du wrote:
> > > Hi Willem,
> > >
> > > I'm sorry, but I would like to confirm the issue further.
> > >
> > > On Mon, Jun 10, 2024 at 4:19=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Chengen Du wrote:
> > > > > The issue initially stems from libpcap. The ethertype will be o=
verwritten
> > > > > as the VLAN TPID if the network interface lacks hardware VLAN o=
ffloading.
> > > > > In the outbound packet path, if hardware VLAN offloading is una=
vailable,
> > > > > the VLAN tag is inserted into the payload but then cleared from=
 the sk_buff
> > > > > struct. Consequently, this can lead to a false negative when ch=
ecking for
> > > > > the presence of a VLAN tag, causing the packet sniffing outcome=
 to lack
> > > > > VLAN tag information (i.e., TCI-TPID). As a result, the packet =
capturing
> > > > > tool may be unable to parse packets as expected.
> > > > >
> > > > > The TCI-TPID is missing because the prb_fill_vlan_info() functi=
on does not
> > > > > modify the tp_vlan_tci/tp_vlan_tpid values, as the information =
is in the
> > > > > payload and not in the sk_buff struct. The skb_vlan_tag_present=
() function
> > > > > only checks vlan_all in the sk_buff struct. In cooked mode, the=
 L2 header
> > > > > is stripped, preventing the packet capturing tool from determin=
ing the
> > > > > correct TCI-TPID value. Additionally, the protocol in SLL is in=
correct,
> > > > > which means the packet capturing tool cannot parse the L3 heade=
r correctly.
> > > > >
> > > > > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > > > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-che=
ngen.du@canonical.com/T/#u
> > > > > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > >
> > > > Overall, solid.
> > > >
> > > > > ---
> > > > >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++=
++++++--
> > > > >  1 file changed, 55 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > > index ea3ebc160e25..8cffbe1f912d 100644
> > > > > --- a/net/packet/af_packet.c
> > > > > +++ b/net/packet/af_packet.c
> > > > > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct p=
acket_sock *po,
> > > > >       return packet_lookup_frame(po, rb, rb->head, status);
> > > > >  }
> > > > >
> > > > > +static u16 vlan_get_tci(struct sk_buff *skb)
> > > > > +{
> > > > > +     struct vlan_hdr vhdr, *vh;
> > > > > +     u8 *skb_orig_data =3D skb->data;
> > > > > +     int skb_orig_len =3D skb->len;
> > > > > +
> > > > > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > > > > +     vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &v=
hdr);
> > > >
> > > > Don't harcode Ethernet.
> > > >
> > > > According to documentation VLANs are used with other link layers.=

> > > >
> > > > More importantly, in practice PF_PACKET allows inserting this
> > > > skb->protocol on any device.
> > > >
> > > > We don't use link layer specific constants anywhere in the packet=

> > > > socket code for this reason. But instead dev->hard_header_len.
> > > >
> > > > One caveat there is variable length link layer headers, where
> > > > dev->min_header_len !=3D dev->hard_header_len. Will just have to =
fail
> > > > on those.
> > >
> > > Thank you for pointing out this error. I would like to confirm if I=

> > > need to use dev->hard_header_len to get the correct header length a=
nd
> > > return zero if dev->min_header_len !=3D dev->hard_header_len to han=
dle
> > > variable-length link layer headers. Is there something I
> > > misunderstand, or are there other aspects I need to consider furthe=
r?
> >
> > That's right.
> >
> > The min_header_len !=3D hard_header_len check is annoying and may see=
m
> > pedantic. But it's the only way to trust that the next header starts
> > at hard_header_len.
> =

> Thank you for your advice.
> I have implemented the modification, but I found that the
> (min_header_len !=3D hard_header_len) check results in unexpected
> behavior in the following test scenario:
>     ip link add link ens18 ens18.24 type vlan proto 802.1ad id 24
>     ip link add link ens18.24 ens18.24.25 type vlan proto 802.1Q id 25
>     ifconfig ens18.24 1.0.24.1/24
>     ifconfig ens18.24.25 1.0.25.1/24
>     ping -n 1.0.25.3 > /dev/null 2>&1 &
>     tcpdump -nn -i any -y LINUX_SLL -Q out not tcp and not udp
> =

> While receiving a packet from ens18.24.25 (802.1Q), the min_header_len
> and hard_header_len are 14 and 18, respectively.
> This check results in the TCI being 0 instead of 25.
> Should we skip this check to display the correct value, or is there
> another check that can achieve the same purpose?

Interesting. Glad you found this.

Makes sense, as VLAN devices have

    vlandev->hard_header_len =3D dev->hard_header_len + VLAN_HLEN;

Does

    if (min_header_len && min_header_len !=3D hard_header_len)

resolve it?

Few devices actually set min_header_len. Initially, only Ethernet in
ether_setup() and loopback. It was introduced for validation in
dev_validate_header, and a min_header_len of 0 just skips some basic
validation.

As long as VLAN devices do not initialize min_header_len (e.g., by
inheriting it from the physical device and incorrectly setting it to
ETH_HLEN), then this should be fine.


