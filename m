Return-Path: <stable+bounces-50124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22982902C6B
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AE8B21944
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E720152177;
	Mon, 10 Jun 2024 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVE73clS"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C618EAB;
	Mon, 10 Jun 2024 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061831; cv=none; b=MERI2+IYhmfJeTy3n1E+SrokB69aidWarNK+3XLeeivtWLEhAKG2tURYOPP2xab9nJG+/vBdXk3gS5m9ixCroD+hmGTpKEwOXsZ2dCVYj49IKzduO53z1xRxoFymFyNOW0Bi/RDlrTSxe1wragIst38m6YIvPIkhTfQgTNNk88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061831; c=relaxed/simple;
	bh=GL519/OeTsVEfPoHY170KKRiJkajWab9ytI9diRYgiw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g+i0Z9RtMiV+TosO/2sE5YfGk+80nCUGY2IAh8cl1pCTrZOi50dgI+pc4XFtSJ9s1KNh+gzaFlBr6ED518/ssNuwvj4jMrTo+Dss0gzHtCs0Mubcv6MuctLBp2aH1unsp5LCh3GqJmUUH/RxnvAJg01lB8q1TFUg8E1a/WNpFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVE73clS; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ad8243dba8so25008716d6.3;
        Mon, 10 Jun 2024 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718061829; x=1718666629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV5PVanzcpddAlRBQgJHZpxu5JR0+D1qul/h4jTI5Sk=;
        b=DVE73clSn0EdMByKbACpqs3LDazYnQMAUnLcBfJhVEQwI1fIpo+YVgG4acEVf3V+WR
         v6bE6T84hrs1AeQZDKvKk0t9FDKPSLQNWs+7tnHI0qoMTSQilgC+MK2Zpf+0xgvXzlQD
         vwyyq3A3mwRFJ2jKfx00enP7Q6xmyv5HRynuIIzEPX342IRv3hP2P0Uz2AsQKGjZcure
         1ySgwcScyA+2g8ZPK/8ej7Mp4xAqdzdojhM2A8jGJRvED5rIUGrTtwlI579/Wu+YStbj
         sEdihMizg7XCNpuF3xRd4aXnijA2lQ7yfac+elaJfypLLecFOee5eaZhYMmxx8sugOKH
         vlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718061829; x=1718666629;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lV5PVanzcpddAlRBQgJHZpxu5JR0+D1qul/h4jTI5Sk=;
        b=wK/E15xhvS9B1cfg33z3MAFBStsK5gbf5GSOszoEsJczhBbvQRnpaoFgfe3tFQZjmM
         h5MhRlPtiI7BCLCV5i4Z01JVMZkjfZAxHLdD7DQCUqdwbtgWOPCFDbAW1Xh63LWXRQuW
         kndk7WD8EiFX9yh3XO6gSSlJddqABGtFujmeAe/N330GvTRGe/tXDBix+urG2OdySgDe
         2bIlDF+0BoquiXjMGonFLx0ugCeS5WprP0IJJNfGVPdFv1YKurnHMFa/f22DbcJBOntE
         Ro8BqJIOTnMAUFeKBwzOibVn/saUY7bXsBZvnEytjAwrJ3yW1NVdVUpykq6T+bHVswV1
         r6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2T5Pv0/kabh+vrapWYPUJb1ESg9Z+HapIW0EFEBrqtuOYfl6AFP1Wt5fSzp+APo2J8/2W3R53i9/PIMVFubevpEkgko9HBy+WQ5upePXwDy5ECulzxmBlMAbyGTsoN3ul3mA7qafReid9Oz6M8a1LpqSAnTOhGDculPsD
X-Gm-Message-State: AOJu0YxxRnLa3x6Yr4iwPb3ktqDzDm9ooH+hKMYJeW3cXrCjuj3I9bhG
	CmBeTiG0ERfNUbdRsuPR8dRWcT7fq4gY33ah++BApPn1Nznuogs9
X-Google-Smtp-Source: AGHT+IGvkE0Hdy2WFEEHZ5FqvV9BKqDeyVqKkJko9HLGbHvkz4+NgzZnRHCDEmPWeQAdw+IWpCgV0A==
X-Received: by 2002:a05:6214:524a:b0:6b0:6b57:4c57 with SMTP id 6a1803df08f44-6b06b574fbbmr88520586d6.1.1718061828744;
        Mon, 10 Jun 2024 16:23:48 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b053b13054sm48731596d6.138.2024.06.10.16.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 16:23:48 -0700 (PDT)
Date: Mon, 10 Jun 2024 19:23:48 -0400
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
Message-ID: <66678b0413c20_bf52c2946d@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qfcXSQNxz2kNVWHqYBGgnFLDa-Ey5b9y5OenZndo2a0Og@mail.gmail.com>
References: <20240608025347.90680-1-chengen.du@canonical.com>
 <CAPza5qfuNhDbhV9mau9RE=cNKMwGtJcx4pmjkoHNwpfysnw5yw@mail.gmail.com>
 <66660ec3f3e22_8dbbb294ed@willemb.c.googlers.com.notmuch>
 <CAPza5qfcXSQNxz2kNVWHqYBGgnFLDa-Ey5b9y5OenZndo2a0Og@mail.gmail.com>
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

> On Mon, Jun 10, 2024 at 4:21=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Chengen Du wrote:
> > > Hi,
> > >
> > > I would like to provide some additional explanations about the patc=
h.
> > >
> > >
> > > On Sat, Jun 8, 2024 at 10:54=E2=80=AFAM Chengen Du <chengen.du@cano=
nical.com> wrote:
> > > >
> > > > The issue initially stems from libpcap. The ethertype will be ove=
rwritten
> > > > as the VLAN TPID if the network interface lacks hardware VLAN off=
loading.
> > > > In the outbound packet path, if hardware VLAN offloading is unava=
ilable,
> > > > the VLAN tag is inserted into the payload but then cleared from t=
he sk_buff
> > > > struct. Consequently, this can lead to a false negative when chec=
king for
> > > > the presence of a VLAN tag, causing the packet sniffing outcome t=
o lack
> > > > VLAN tag information (i.e., TCI-TPID). As a result, the packet ca=
pturing
> > > > tool may be unable to parse packets as expected.
> > > >
> > > > The TCI-TPID is missing because the prb_fill_vlan_info() function=
 does not
> > > > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is=
 in the
> > > > payload and not in the sk_buff struct. The skb_vlan_tag_present()=
 function
> > > > only checks vlan_all in the sk_buff struct. In cooked mode, the L=
2 header
> > > > is stripped, preventing the packet capturing tool from determinin=
g the
> > > > correct TCI-TPID value. Additionally, the protocol in SLL is inco=
rrect,
> > > > which means the packet capturing tool cannot parse the L3 header =
correctly.
> > > >
> > > > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-cheng=
en.du@canonical.com/T/#u
> > > > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > > ---
> > > >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++=
++++--
> > > >  1 file changed, 55 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > index ea3ebc160e25..8cffbe1f912d 100644
> > > > --- a/net/packet/af_packet.c
> > > > +++ b/net/packet/af_packet.c
> > > > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct pac=
ket_sock *po,
> > > >         return packet_lookup_frame(po, rb, rb->head, status);
> > > >  }
> > > >
> > > > +static u16 vlan_get_tci(struct sk_buff *skb)
> > > > +{
> > > > +       struct vlan_hdr vhdr, *vh;
> > > > +       u8 *skb_orig_data =3D skb->data;
> > > > +       int skb_orig_len =3D skb->len;
> > > > +
> > > > +       skb_push(skb, skb->data - skb_mac_header(skb));
> > > > +       vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &v=
hdr);
> > > > +       if (skb_orig_data !=3D skb->data) {
> > > > +               skb->data =3D skb_orig_data;
> > > > +               skb->len =3D skb_orig_len;
> > > > +       }
> > >
> > >
> > > The reason for not directly using skb_header_pointer(skb,
> > > skb_mac_header(skb) + ETH_HLEN, ...) to get the VLAN header is due =
to
> > > the check logic in skb_header_pointer. In the SOCK_DGRAM and
> > > PACKET_OUTGOING scenarios, the offset can be a negative number, whi=
ch
> > > causes the check logic (i.e., likely(hlen - offset >=3D len)) in
> > > __skb_header_pointer() to not work as expected.
> >
> > The calculation is still correct?
> >
> > I think that this is not the first situation where negative offsets
> > can be given to skb_header_pointer.
> =

> The check will pass even if the offset is negative, but I believe this
> may not be the right approach. In my humble opinion, the expected
> check should be similar to the skb_push check, which ensures that
> after moving forward by the offset bytes, skb->data remains larger
> than or equal to skb->head to avoid accessing out-of-bound data. It
> might be worth considering adding a check in __skb_header_pointer to
> handle negative offsets, as this seems logical. However, this change
> could impact a wider range of code. Please correct me if I am
> mistaken.

Your current approach is fine too.

A negative offset greater than skb_headroom would certainly be a
problem. But in these cases where skb->mac_header is known to be
correct, the offset skb_mac_offset() against skb->data must be
within bounds, even if it may be negative.


