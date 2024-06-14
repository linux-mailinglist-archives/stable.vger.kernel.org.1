Return-Path: <stable+bounces-52175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260E9087AE
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9918A1C22363
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352C192B66;
	Fri, 14 Jun 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5ySND4h"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FB1922FE;
	Fri, 14 Jun 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358000; cv=none; b=iRhaCt/3v3ls+B0RGLrINcmmSl2Pcm+oxpdu5SRCY8gBKPFHXeYdBcR5oWFl0YDfzZaAIRnLJGP5P6DbMYdLERTExqMF88hX6mEdp9ZSGl5lRUH34QWMY7++Dhv3IQa93v8O7tDXd4v/HiRkD/ohy6DzgzXvdyOyR1ViXFOrVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358000; c=relaxed/simple;
	bh=OBDmvqK7bxGaEV1HPVMAHzuTJ6wumSXTRom7MffOMPg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ef60WBeK17dhBW8TL/O7fa2nY6YwfFumOxKSnaYeYrH41K1pRsSqDvXIz+ASaoknK7MGARF2hhsVHmNtJVrv9zKLZ6CcKKpWZhhSWFhOzheR3UgyHz3GAYwEaqUvRqgJHuGUa9+cZtg3C8sroOl4sHt7+GoAV1+q7kP6wrYyyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5ySND4h; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-797a7f9b552so124236185a.0;
        Fri, 14 Jun 2024 02:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718357998; x=1718962798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enmLRT2XQ6Zrwi5YAY8HYTitEXXxpPPAwekI9RufLrE=;
        b=K5ySND4hdALUFSWkrIPBute4ed6XENPOTaVSj2DnR9iheQJsu1FFnycoxDUuPXUMcO
         VUC+L0UNd4ZVpqP5Wzyi5llmFLJ+zVzIw043xT5NsSzIpyS3itxHNUHPYzuFbBSXl1kd
         wp06LBSFHnv2xLhJ6bgU+urPFdcPuhQCK4Jt60fBVl3ibhvGrdDd0ZJeBdH2ZKJvhrZT
         0BvXnMo5zQQg2pZ/0mAYBYwz0uLiynPy6fTf/lYQPwg8mks5zTT6FctPDBYiKF6YgL4q
         0h/3beTX6yCfV/MQwMCtBcNVh/3Sqb309aU71+vNfqm45dJAew/GL7vMJYvG2LA/m/77
         6rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357998; x=1718962798;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=enmLRT2XQ6Zrwi5YAY8HYTitEXXxpPPAwekI9RufLrE=;
        b=j1LcsmWwY+vQnLa9++KtVAyzX9+pxbWTEYCegXlu6mGZ5CQ9XC1RxHtAsEkl6g4e9s
         B1olbe7/khBXlq19SKEN0PvcJGGhWs/ge4ZbhPqmOrdf7Bi4ME7Bst1zgJ6poZxYdpbH
         IwE+adK8YuFZSNjniOR3MFa3pLIp7G1WbbzHrZ2v/jc21t3k9mFNWecGWGiY0I/vV28K
         13TKcJZ9o0R8AT5QZZiAwjJtu2Mhky9HUO6qDllY79LUp30t1R55jOZw/N0lRCJ67GJC
         P1skhYCXgRU8zoaW+xXvMsUwLpWCv2E80LRvNshSjyYJAKAUY5AB8SJ+UIrhapxiawKd
         BJbA==
X-Forwarded-Encrypted: i=1; AJvYcCXYDlHpTBGCPuz1Cuohj8cqwpBgCY60E4jZQKMwOaG1O16n+GWX+juGPE51QPUALH7GzH0VMKqU1dZHKhYAoEuxapUFsNKdsSR0MQtpcF9Lspvz5BuqglSYXajTiVlEEA80ZowQmr4HF89/SOkhyPlktlkw1dlMVyVx2vPq
X-Gm-Message-State: AOJu0YyB1rj2FH5hZPg6aWLVvByLJ5kkoJ51xg8K4vmJYdHtQQfeNOSY
	5g5XmfASoLF60scOmd+m5zdSYIyshDCNpa5Pn4qmNqGy13sJuGex
X-Google-Smtp-Source: AGHT+IHElPMGfp3Vvn5afdRo9WPrkfuaCNY+3dWID6CwG/6HS0wfTwQ/ZWK8VHM/0zcyrtgJ4en6Gg==
X-Received: by 2002:a05:620a:2481:b0:795:58cb:2c97 with SMTP id af79cd13be357-798d258de24mr210053485a.48.1718357997832;
        Fri, 14 Jun 2024 02:39:57 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc037eesm128409185a.72.2024.06.14.02.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:39:57 -0700 (PDT)
Date: Fri, 14 Jun 2024 05:39:56 -0400
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
Message-ID: <666c0feca4abf_17367e294e2@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qeDZonX5prLPOPQWjD2pNwzQHnhFkxCSkqC3ectWtPP3w@mail.gmail.com>
References: <20240608025347.90680-1-chengen.du@canonical.com>
 <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
 <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
 <666789d3d9d2a_bf52c294e9@willemb.c.googlers.com.notmuch>
 <CAPza5qe8KAjjZsZdTupXx27kvdPzhBNcDC=Nk5Xjc4O2obEAAA@mail.gmail.com>
 <6669abb1ea6da_125bdf29449@willemb.c.googlers.com.notmuch>
 <CAPza5qeDZonX5prLPOPQWjD2pNwzQHnhFkxCSkqC3ectWtPP3w@mail.gmail.com>
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

> Thank you for the suggestion.
> I have conducted further tests and found that the results are not as
> we expected.
> =

> I would like to explain my findings based on the following tests:
>     ip link add link ens18 ens18.24 type vlan proto 802.1ad id 24
>     ip link add link ens18.24 ens18.24.25 type vlan proto 802.1Q id 25
>     ifconfig ens18.24 1.0.24.1/24
>     ifconfig ens18.24.25 1.0.25.1/24
>     ping -n 1.0.25.3 > /dev/null 2>&1 &
>     tcpdump -nn -i any -y LINUX_SLL -Q out not tcp and not udp
> =

> I have added more logs and found the following results:
>     af_packet: tpacket_rcv: dev->name [ens18.24.25]
>     af_packet: tpacket_rcv: dev->name [ens18.24]
>     af_packet: vlan_get_tci: dev->name [ens18.24], min_header_len
> [14], hard_header_len [18]
>     af_packet: prb_fill_vlan_info: ppd->hv1.tp_vlan_tci [0],
> ppd->hv1.tp_vlan_tpid [8100]
>     af_packet: prb_fill_vlan_info: currect vlan_tci [19], tp_vlan_tpid =
[8100]
>     af_packet: tpacket_rcv: dev->name [ens18]
>     af_packet: vlan_get_tci: dev->name [ens18], min_header_len [14],
> hard_header_len [14]
>     af_packet: prb_fill_vlan_info: ppd->hv1.tp_vlan_tci [18],
> ppd->hv1.tp_vlan_tpid [88a8]
>     af_packet: prb_fill_vlan_info: currect vlan_tci [18], tp_vlan_tpid =
[88a8]
> =

> It seems that the min_header_len has been set even though the device
> is ens18.24.
> I will continue investigating this issue.
> Thank you for your ongoing assistance.

Thanks. Apparently min_header_len cannot be relied on for this. It is
not explicitly set in most drivers, including in the vlan driver.

Let's not make this series conditional on that.

The number of variable length link layer protocols is minimal, and
egregious errors are caught by skb_header_pointer. Just use
dev->hard_header_len as is, without the min_header_len check.

Btw, please remember not to top-post.
https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying

 =

> Best regards,
> Chengen Du
> =

> On Wed, Jun 12, 2024 at 10:07=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Chengen Du wrote:
> > > Hi Willem,
> > >
> > > On Tue, Jun 11, 2024 at 7:18=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Chengen Du wrote:
> > > > > Hi Willem,
> > > > >
> > > > > I'm sorry, but I would like to confirm the issue further.
> > > > >
> > > > > On Mon, Jun 10, 2024 at 4:19=E2=80=AFAM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Chengen Du wrote:
> > > > > > > The issue initially stems from libpcap. The ethertype will =
be overwritten
> > > > > > > as the VLAN TPID if the network interface lacks hardware VL=
AN offloading.
> > > > > > > In the outbound packet path, if hardware VLAN offloading is=
 unavailable,
> > > > > > > the VLAN tag is inserted into the payload but then cleared =
from the sk_buff
> > > > > > > struct. Consequently, this can lead to a false negative whe=
n checking for
> > > > > > > the presence of a VLAN tag, causing the packet sniffing out=
come to lack
> > > > > > > VLAN tag information (i.e., TCI-TPID). As a result, the pac=
ket capturing
> > > > > > > tool may be unable to parse packets as expected.
> > > > > > >
> > > > > > > The TCI-TPID is missing because the prb_fill_vlan_info() fu=
nction does not
> > > > > > > modify the tp_vlan_tci/tp_vlan_tpid values, as the informat=
ion is in the
> > > > > > > payload and not in the sk_buff struct. The skb_vlan_tag_pre=
sent() function
> > > > > > > only checks vlan_all in the sk_buff struct. In cooked mode,=
 the L2 header
> > > > > > > is stripped, preventing the packet capturing tool from dete=
rmining the
> > > > > > > correct TCI-TPID value. Additionally, the protocol in SLL i=
s incorrect,
> > > > > > > which means the packet capturing tool cannot parse the L3 h=
eader correctly.
> > > > > > >
> > > > > > > Link: https://github.com/the-tcpdump-group/libpcap/issues/1=
105
> > > > > > > Link: https://lore.kernel.org/netdev/20240520070348.26725-1=
-chengen.du@canonical.com/T/#u
> > > > > > > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace=
")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > > > >
> > > > > > Overall, solid.
> > > > > >
> > > > > > > ---
> > > > > > >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++=
++++++++++--
> > > > > > >  1 file changed, 55 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.=
c
> > > > > > > index ea3ebc160e25..8cffbe1f912d 100644
> > > > > > > --- a/net/packet/af_packet.c
> > > > > > > +++ b/net/packet/af_packet.c
> > > > > > > @@ -538,6 +538,43 @@ static void *packet_current_frame(stru=
ct packet_sock *po,
> > > > > > >       return packet_lookup_frame(po, rb, rb->head, status);=

> > > > > > >  }
> > > > > > >
> > > > > > > +static u16 vlan_get_tci(struct sk_buff *skb)
> > > > > > > +{
> > > > > > > +     struct vlan_hdr vhdr, *vh;
> > > > > > > +     u8 *skb_orig_data =3D skb->data;
> > > > > > > +     int skb_orig_len =3D skb->len;
> > > > > > > +
> > > > > > > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > > > > > > +     vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr)=
, &vhdr);
> > > > > >
> > > > > > Don't harcode Ethernet.
> > > > > >
> > > > > > According to documentation VLANs are used with other link lay=
ers.
> > > > > >
> > > > > > More importantly, in practice PF_PACKET allows inserting this=

> > > > > > skb->protocol on any device.
> > > > > >
> > > > > > We don't use link layer specific constants anywhere in the pa=
cket
> > > > > > socket code for this reason. But instead dev->hard_header_len=
.
> > > > > >
> > > > > > One caveat there is variable length link layer headers, where=

> > > > > > dev->min_header_len !=3D dev->hard_header_len. Will just have=
 to fail
> > > > > > on those.
> > > > >
> > > > > Thank you for pointing out this error. I would like to confirm =
if I
> > > > > need to use dev->hard_header_len to get the correct header leng=
th and
> > > > > return zero if dev->min_header_len !=3D dev->hard_header_len to=
 handle
> > > > > variable-length link layer headers. Is there something I
> > > > > misunderstand, or are there other aspects I need to consider fu=
rther?
> > > >
> > > > That's right.
> > > >
> > > > The min_header_len !=3D hard_header_len check is annoying and may=
 seem
> > > > pedantic. But it's the only way to trust that the next header sta=
rts
> > > > at hard_header_len.
> > >
> > > Thank you for your advice.
> > > I have implemented the modification, but I found that the
> > > (min_header_len !=3D hard_header_len) check results in unexpected
> > > behavior in the following test scenario:
> > >     ip link add link ens18 ens18.24 type vlan proto 802.1ad id 24
> > >     ip link add link ens18.24 ens18.24.25 type vlan proto 802.1Q id=
 25
> > >     ifconfig ens18.24 1.0.24.1/24
> > >     ifconfig ens18.24.25 1.0.25.1/24
> > >     ping -n 1.0.25.3 > /dev/null 2>&1 &
> > >     tcpdump -nn -i any -y LINUX_SLL -Q out not tcp and not udp
> > >
> > > While receiving a packet from ens18.24.25 (802.1Q), the min_header_=
len
> > > and hard_header_len are 14 and 18, respectively.
> > > This check results in the TCI being 0 instead of 25.
> > > Should we skip this check to display the correct value, or is there=

> > > another check that can achieve the same purpose?
> >
> > Interesting. Glad you found this.
> >
> > Makes sense, as VLAN devices have
> >
> >     vlandev->hard_header_len =3D dev->hard_header_len + VLAN_HLEN;
> >
> > Does
> >
> >     if (min_header_len && min_header_len !=3D hard_header_len)
> >
> > resolve it?
> >
> > Few devices actually set min_header_len. Initially, only Ethernet in
> > ether_setup() and loopback. It was introduced for validation in
> > dev_validate_header, and a min_header_len of 0 just skips some basic
> > validation.
> >
> > As long as VLAN devices do not initialize min_header_len (e.g., by
> > inheriting it from the physical device and incorrectly setting it to
> > ETH_HLEN), then this should be fine.
> >



