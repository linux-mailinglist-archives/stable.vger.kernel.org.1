Return-Path: <stable+bounces-50123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB4902C67
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 01:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF363285056
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 23:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216A152782;
	Mon, 10 Jun 2024 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFomoEhJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34715219B;
	Mon, 10 Jun 2024 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061527; cv=none; b=D6P0qNE1NSdczcg+mJqUHPTty2uoB/yyZmFtg8qGLV7Fpw6+Js1hAH/42II4ijYJUQ/weqCdyyBeIP47qE1mTfvHljsY0ecxbfR0kdRHMuCdrwryEyi/wRpQKBfz0BxNhAdVlJS4hUMxe6n7KxKleKGAAt5X+wpfHzgupX1SHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061527; c=relaxed/simple;
	bh=rjTdHKpy4KIpkDow1PB/1VMECY8dd6bPkMlGvGUcKug=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L0CbTjFdz+x0PtELtER7U56+sE1WYGpb/HCCjfD3+fCnwaBR/j8zvBRsb76GKIEnQ7x6+SxvJPgUsrRS5IxPGAbKHpmWyO8Nlwi0zfhQqLPBYMzOWe5oFfb8QFKMwjQ+UC4lq55ANf6BU16YNqxVG44t4WoQ97vjIYxIwT/DJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFomoEhJ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80b8d45e6b7so684665241.3;
        Mon, 10 Jun 2024 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718061525; x=1718666325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpHB6EFgU/Pew3/eTX8AGPUmphuyA4goy7tWBK/JGg8=;
        b=RFomoEhJ8uzVg88ZK4v097AWM6r02ZkgpBZCtHe+unFh8fImVmgtkz1lHpFc283Lrn
         CFyg+h07IpNPqGHRbY/q/wt63sUkioBFS1x36mnmxF3jBs94M0LhDHq8Ij5qTwvxgu2/
         WN6ppNSJ6fQj7th63U/+E/t8fRd+GZGqIb/FNp5nRUo5y3AZasUGN+ew32rU91eArNcQ
         +GBRBpwwDcgxDla8DS2WW2z6PO3TafH08mTFteytdfcivC43CZWtNEBSXXox6o/W71LP
         T3dScCCn5X1WSHK21F404y5MZWYDH1wHsrMuiDyNkSU/zthThhyg29uB4Y7iKbWbC5N3
         dMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718061525; x=1718666325;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpHB6EFgU/Pew3/eTX8AGPUmphuyA4goy7tWBK/JGg8=;
        b=lD9RaeN+pZmBpfxqYuMBeNzdtyo7yXyW5wkIoY2oC5y1EpIUsrp3qSg9qiBAIPpFKP
         DQ+T0c21RdL8zD5EVG2LHHTr5oVoxBcvC5nENiQRMxwFJKas9Cy2Kru+99ceSeGd3o/f
         AYrYIlt3/s3UeYf8ZmDZWutEhwUXZTKpc9XWHRe81RLo2MJxGpeB8y0IUN5Kii1YPobf
         EOJWFDpLlNw5XxwlVh2Hypc5f/MG0MlNJsaRoJ+PMvCD+EZAVu/6s3hAW/9FOoZy46BK
         qjWk1cHNX9P9n1W40VAqohTeSb+QGmpeh+YImEeC3MlT8geb37ib3DgJ32fhJ6QkhDCz
         7CPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbt/cw/2f6TkGqfPh9O/92l762I0URectG+LhHDwqBfzLE+NtUFyM65Rq6abdh9tinv5CXVuUswAcy+3HRxRvmo3kRbCHtugZQOP7nx6Qj8jnChbLgNyJMhwoAXxmQUdknifHfIi7B8ERuQcfYXsYlziHdyFURG/3RSV4p
X-Gm-Message-State: AOJu0YyPr4gFFk/75YGXqdYLURl9K0jKVbAPD9RgAano19yARAo+DZh/
	RMUUG0T3CdLnW4io0Z1gVZCKCegKQa439ft6xuMAXMz0fuDkM1LA
X-Google-Smtp-Source: AGHT+IGQUPeKpDgPBnPgIHioUoIKBKuq2BPQe1+Z3hybaayCvOgodUE7MohCPPDFsQNL/qXioD4ggg==
X-Received: by 2002:a05:6102:9c7:b0:48c:374c:b30c with SMTP id ada2fe7eead31-48c374cb530mr8921118137.9.1718061525013;
        Mon, 10 Jun 2024 16:18:45 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795593165e7sm233737685a.65.2024.06.10.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 16:18:44 -0700 (PDT)
Date: Mon, 10 Jun 2024 19:18:43 -0400
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
Message-ID: <666789d3d9d2a_bf52c294e9@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
References: <20240608025347.90680-1-chengen.du@canonical.com>
 <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
 <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
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

> I'm sorry, but I would like to confirm the issue further.
> =

> On Mon, Jun 10, 2024 at 4:19=E2=80=AFAM Willem de Bruijn
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
> >
> > Overall, solid.
> >
> > > ---
> > >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++=
++--
> > >  1 file changed, 55 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > index ea3ebc160e25..8cffbe1f912d 100644
> > > --- a/net/packet/af_packet.c
> > > +++ b/net/packet/af_packet.c
> > > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packe=
t_sock *po,
> > >       return packet_lookup_frame(po, rb, rb->head, status);
> > >  }
> > >
> > > +static u16 vlan_get_tci(struct sk_buff *skb)
> > > +{
> > > +     struct vlan_hdr vhdr, *vh;
> > > +     u8 *skb_orig_data =3D skb->data;
> > > +     int skb_orig_len =3D skb->len;
> > > +
> > > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > > +     vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr)=
;
> >
> > Don't harcode Ethernet.
> >
> > According to documentation VLANs are used with other link layers.
> >
> > More importantly, in practice PF_PACKET allows inserting this
> > skb->protocol on any device.
> >
> > We don't use link layer specific constants anywhere in the packet
> > socket code for this reason. But instead dev->hard_header_len.
> >
> > One caveat there is variable length link layer headers, where
> > dev->min_header_len !=3D dev->hard_header_len. Will just have to fail=

> > on those.
> =

> Thank you for pointing out this error. I would like to confirm if I
> need to use dev->hard_header_len to get the correct header length and
> return zero if dev->min_header_len !=3D dev->hard_header_len to handle
> variable-length link layer headers. Is there something I
> misunderstand, or are there other aspects I need to consider further?

That's right.

The min_header_len !=3D hard_header_len check is annoying and may seem
pedantic. But it's the only way to trust that the next header starts
at hard_header_len.=

