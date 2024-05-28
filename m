Return-Path: <stable+bounces-47573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0478D1ED1
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698191F238C7
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7AD16FF37;
	Tue, 28 May 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdFutYW5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978AD16FF5A;
	Tue, 28 May 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906587; cv=none; b=BnBSBjhLpwqU9E/AMRE5RkNAtj4zdrQNcA54KIeITwNqJ5GEAZlOtiZIPdZcOape2k1vgVau/FkARDoa/ABbYxAqP/TDzTNdyD1/c/hLDnIH+iwVuaiGpbC79ica3LCJx4gi/qsVbVuPzcz4zmvjAFRS3kpUG8Wzh8QmlSqKh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906587; c=relaxed/simple;
	bh=ka61hrwWyt80vXDLIqj6xF9p6ZdwzYeaYhuB6NPdZV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1aSHpO7MNfMUeflQoafZIs2Vs/K7aeJTWT6+MGDpI/erg750ZdVKiR1HhLGI1Jqep+SSDEBf1k476IBZAJnGZS4nLF93TDEhOnVNB87J4pTyYjkKokOgpZISnzPK6WFylo3FO4FwjWYE8na/ttF4585zXG2DRATOADsrCCK/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdFutYW5; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8052b43d328so130769241.0;
        Tue, 28 May 2024 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906584; x=1717511384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg8y460Xa+j7cx+obTE0cFpPu6S6+u6FQc2pe05Mc/I=;
        b=FdFutYW5p6K+1vWWZTWEGs+7tad2TzPDGqfaX093Y33VT6GRJ9Ts3is96zhD5uzuhB
         QCjGkrjBZUhHmpv7YO7yzzRNdesNKTCAscFj8RmdSwZ/r73Fm1sUJnujJNP2Xeshf9hc
         c0T6vyWU8fZu7lOTDcobq+jli/yJZYH54/qXqEzn/F9HcTcVNtmHPiOuyAdJ5ORWSJSq
         6YJrT52okV3nF2nKlC5Hlyh2uAofpDKkYf78PzJE9hB1lJW2jwklBv5blNEzQrXRCI2a
         7MywhOXKYl5ILeYDnRJ+cNx4+xXOdqGS0pF+kDP9yFdRu3cdjbnM7Th6eivLBjeYo4x2
         9AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906584; x=1717511384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg8y460Xa+j7cx+obTE0cFpPu6S6+u6FQc2pe05Mc/I=;
        b=tRAvhw1lCgy6AREdna0/Lm+4rmvBr4GxBgrxZo0SCcmK5zIXezIXHoUlCpjDC+WpJT
         slJQTAdGV+W0wiC2a0Ar8VlW2tFxpShhjSd3tBKYVu4KU6Q7LWijm3XZLhj35b3ITVdS
         YWini1YyyS2+QxDwD6b2bCBRXQEVjNOUX89Livda4SbJIQKBeS1RptegnkSDu9MeEU6Z
         gMw9S469kmZ9N0saCVSchW7vYvdPiE7mw8fs7aoG5vHuTL4Y9sw5+RwyalUUawQjGiFU
         Qk7sraE7R0vzlKIY6+CZIVpjGmVFSiXIUGIEqDyyA48JX9+kf+kmpchHdvAXJx9WAY+e
         rnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAUaFNmnisOCwhpjtDJpN1wTaEoxU08PYNvD04tUwQq34AnmqRoBItbb7Zef+8fe6CwFEhuxy0JmQIjhtkS///LEwXcPDUd0l2MmrnO/6jC3xCWILEH797VE5gEsyprOAvdf6orZ5dX7K++qEYoWcP0pYnM/tiwEdk6m1G
X-Gm-Message-State: AOJu0YyFKtLSwqD69YlmOGd1FhpDs9jzwRBiwDrjYcBtHUDZqj6/pifR
	qGU74oeykABZWUx4z3FLXIoliqqtJ0AZ5YYHhcd0nMBE8fHu+WxSPr0TECZYGf3++6R0w82KnWh
	aN0dVargg2tK7SosnR/KjqU7hQ8A=
X-Google-Smtp-Source: AGHT+IE1iPcTI3pn+5wr1fZSALkFdHBU+jz0yKwG86On+gFfOzSfsdcWJsSjZYld6caHgt28iKAiaIMEpj6Eo7JGKbc=
X-Received: by 2002:a05:6122:7c8:b0:4de:847a:3647 with SMTP id
 71dfb90a1353d-4e4f02cac8bmr12828252e0c.11.1716906584536; Tue, 28 May 2024
 07:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527074456.9310-1-chengen.du@canonical.com>
 <66549c368764b_268e8229462@willemb.c.googlers.com.notmuch> <CAPza5qe-H6piY6ED7StLOiviiMbWq1rnMpKR_dZu1sehwhji2w@mail.gmail.com>
In-Reply-To: <CAPza5qe-H6piY6ED7StLOiviiMbWq1rnMpKR_dZu1sehwhji2w@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 28 May 2024 10:29:07 -0400
Message-ID: <CAF=yD-J8UV+KD7fUQ-eSJWvHrhqezMs81zXX=VeVgdHR8ZZ7ag@mail.gmail.com>
Subject: Re: [PATCH v3] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Chengen Du <chengen.du@canonical.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, loke.chetan@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 11:40=E2=80=AFPM Chengen Du <chengen.du@canonical.c=
om> wrote:
>
> Hi Willem,
>
> Thank you for your suggestions on the patch.
> However, there are some parts I am not familiar with, and I would appreci=
ate more detailed information from your side.

Please respond with plain-text email. This message did not make it to
the list. Also no top posting.

https://docs.kernel.org/process/submitting-patches.html
https://subspace.kernel.org/etiquette.html

> > > @@ -2457,7 +2465,8 @@ static int tpacket_rcv(struct sk_buff *skb, str=
uct net_device *dev,
> > >       sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> > >       sll->sll_family =3D AF_PACKET;
> > >       sll->sll_hatype =3D dev->type;
> > > -     sll->sll_protocol =3D skb->protocol;
> > > +     sll->sll_protocol =3D (skb->protocol =3D=3D htons(ETH_P_8021Q))=
 ?
> > > +             vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->pro=
tocol;
> >
> > In SOCK_RAW mode, the VLAN tag will be present, so should be returned.
>
> Based on libpcap's handling, the SLL may not be used in SOCK_RAW mode.

The kernel fills in the sockaddr_ll fields in tpacket_rcv for both
SOCK_RAW and SOCK_DGRAM. Libpcap already can use both SOCK_RAW and
SOCK_DGRAM. And constructs the sll2_header pseudo header that tcpdump
sees itself, in pcap_handle_packet_mmap.

> Do you recommend evaluating the mode and maintaining the original logic i=
n SOCK_RAW mode,
> or should we use the same logic for both SOCK_DGRAM and SOCK_RAW modes?

I suggest keeping as is for SOCK_RAW, as returning data that starts at
a VLAN header together with skb->protocol of ETH_P_IPV6 would be just
as confusing as the inverse that we do today on SOCK_DGRAM.

> >
> > I'm concerned about returning a different value between SOCK_RAW and
> > SOCK_DGRAM. But don't immediately see a better option. And for
> > SOCK_DGRAM this approach is indistinguishable from the result on a
> > device with hardware offload, so is acceptable.
> >
> > This test for ETH_P_8021Q ignores the QinQ stacked VLAN case. When
> > fixing VLAN encap, both variants should be addressed at the same time.
> > Note that ETH_P_8021AD is included in the eth_type_vlan test you call
> > above.
>
> In patch 1, the eth_type_vlan() function is used to determine if we need =
to set the sll_protocol to the VLAN-encapsulated protocol, which includes b=
oth ETH_P_8021Q and ETH_P_8021AD.
> You mentioned previously that we might want the true network protocol ins=
tead of the inner VLAN tag in the QinQ case (which means 802.1ad?).
> I believe I may have misunderstood your point.

I mean that if SOCK_DGRAM strips all VLAN headers to return the data
from the start of the true network header, then skb->protocol should
return that network protocol.

With vlan stacking, your patch currently returns ETH_P_8021Q.

See the packet formats in
https://en.wikipedia.org/wiki/IEEE_802.1ad#Frame_format if you're
confused about how stacking works.

> Could you please confirm if both ETH_P_8021Q and ETH_P_8021AD should use =
the VLAN-encapsulated protocol when VLAN hardware offloading is unavailable=
?
> Or are there other aspects that this judgment does not handle correctly?

