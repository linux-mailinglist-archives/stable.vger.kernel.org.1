Return-Path: <stable+bounces-247161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNr8F8WdBWr4YwIAu9opvQ
	(envelope-from <stable+bounces-247161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:02:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E054012E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284CD3010B9C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55A1B4224;
	Thu, 14 May 2026 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCkoVfXV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383F26FDBF
	for <stable@vger.kernel.org>; Thu, 14 May 2026 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752878; cv=none; b=IfMNfrOmHtyloGwF+t8AL6j4pYQMa6/mYc875n+IUB7sOgoQeXJKiB5Wa4S+Bd9fS6e8s9o/x4iRInITNxRCQ5SIGGipKNAxrYI2PEzicFGHn3cUyAcojCPpcx3yFNjPFP+ye1ECUDOhPJvkNUpet2OkZ3Ve5zuQ6OmvSePLaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752878; c=relaxed/simple;
	bh=+cEb8sKW6+9qraXJdFaXavvqh0KSzrArqd7qpJBvKnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rr00XsA0NphQgRFSuKK8fx2Du8EFI0R96PYEclIpipLjVqb0ecH2oi/JbQ4FWMikzNRFYhHkKCQ4JDileiw1mIBITis72gz3506DxQNop/aYH1J+Y/OqpHeXSPD8QMbbBq7Q/MC4fceW9Abpvl04Zi0Wqki0LjmMhCKh9QU9oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCkoVfXV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso81704785e9.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778752876; x=1779357676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8w6xQoQW0qt8Zo29yNIyG0N7oGizsRoHt4bLIQ+cnk=;
        b=JCkoVfXVpIOxWllUVOEUdsLgbQhoaynrK3wUc5WfnD8EogC0/AMKzFhrOOrnjkKPWZ
         P6WB8Ej/hfAt/Ptnq+Df5fupyjVk9PumP29Wufv9jNBGCD2szRjlKN4oiC+FvAOy7OVP
         ujokPOczZ1Eme0Qmtp0FgQiy+RvW1Ri8uV53r2uXxIJHPsyNWmKHrn2RTWfot1eWmJzm
         V440Fz3NgX5QxOcAat44G9u7ucxOUzVCBfcHXTT7oZDxh5gCdGIwz0uI35R2FjyhoREf
         4OdpFWOyvMWTzc4/DB30C9C6YFE74uWpwYPL5+xFCoaRJoiVtTFfxMUARq9un4GJk6og
         lCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752876; x=1779357676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8w6xQoQW0qt8Zo29yNIyG0N7oGizsRoHt4bLIQ+cnk=;
        b=HsKKZjDEx+O0qBWulH4gjHJw6izZpAtvJK9s6DgY2W8FktWr06FXqTDkxGdrCZtMhz
         lJE2e0PWEWOCE6rRQvs8WAF7/FpsA7R0NQjasExGaXhQ0Z8FdqsZYMrbIj8A5dWonZ2c
         Croussn58SzwapgNWBASuR5IEa6S4mfZbyTUC6R/nfuTm6NdDTeMnCg7BCYlBdQw7Che
         pPBZ6SECh6NpMKdUJ8Co5uULZdne7t8T2a6W+9DhlcuRXWwUiYwRZLGB+Tuy6rK6myUx
         VHzORB05mGqkBjKomStRZM3PNC3nxZmUnPo+dqKpo6S1Rba0+HCXT1BAjVD6CkL2ipJH
         GVhw==
X-Gm-Message-State: AOJu0YyQiPOGNI/6rYB2YQ95cZbYOJ4e5lfgzIT8Z3JYlAlNZVp3ni5Q
	50IidBUDONh6w/Re78e1NotDvSwYcOFTJct8wstaPkkaVgNhTF8EDOF7
X-Gm-Gg: Acq92OEHoKzZZcdHwXlWvOsM4+ZkptVM+VMPdjbhLU1syTATEN0fdp2hkXREPhGN08V
	m3K91jckhv6+AJgEgcKM6y75xX6HYFjrsnC+3pCeJbFMapuItTZQ3Pz0b03/zKXf1Xrwfi1/H2T
	HErBFaYF+Wswseo9ppPITx3W7IMnGmLxwMXsfx8eEACnEZg/wI9SCcqjdJvyCF1cwiywcSQdJfl
	N0Sw00w9j+u0K9C2WeiRYXItnxa30aMYLIw7FhuxBVt2JluteI2CSw33JuguVipQ1hRjSrSKv0m
	HhBGTdEiF/LcDPhFppkJsG29xpZpRXNYVwJkgRv5Vxhs3Ddde66EdHF3MyJm7Yq/32OAcCSh3P0
	aSFo+DuYgm8dDtAp+1qRHaQtH2Sw8sI/Bjodr1TwT51hNHJh0Lw94R8j+MOFNIdVOlTa0O1tUVG
	AJhYTXdD3cM+m4kRVUkPi/pcm002NICwidFc1JPAvae/Rube7PkAPaeISuRwr1e4WvQCpCFkA=
X-Received: by 2002:a05:600c:c095:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48fe2474bc8mr2818425e9.6.1778752875639;
        Thu, 14 May 2026 03:01:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdafb6145sm20322885e9.1.2026.05.14.03.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:01:15 -0700 (PDT)
Date: Thu, 14 May 2026 11:01:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: stable@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 netdev@vger.kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH net v3] ice: fix packet corruption due to extraneous
 page flip
Message-ID: <20260514110112.12bdf5ff@pumpkin>
In-Reply-To: <CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
References: <20260512181953.1689-1-ouster@cs.stanford.edu>
	<20260513100732.499e3f49@pumpkin>
	<CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
	<20260513214927.17a8dd45@pumpkin>
	<CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 057E054012E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247161-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanford.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 21:47:11 -0700
John Ousterhout <ouster@cs.stanford.edu> wrote:

> On Wed, May 13, 2026 at 1:49=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Wed, 13 May 2026 09:28:40 -0700
> > John Ousterhout <ouster@cs.stanford.edu> wrote:
> > =20
> > > On Wed, May 13, 2026 at 2:07=E2=80=AFAM David Laight
> > > <david.laight.linux@gmail.com> wrote: =20
> > > >
> > > > On Tue, 12 May 2026 11:19:53 -0700
> > > > John Ousterhout <ouster@cs.stanford.edu> wrote:
> > > > =20
> > > > > Consider the following sequence of events:
> > > > > * The bottom half of a buffer page is filled with data from
> > > > >   packet A. The page has a net reference count (reference count
> > > > >   - bias) of 1. The page is returned to the NIC, flipped to
> > > > >   use the top half.
> > > > > * Before the reference on the page is released, the NIC returns
> > > > >   the page with no data in it ('size' is zero in ice_clean_rx_irq=
).
> > > > >   In this case the bias does not get decremented. The page still
> > > > >   has a net reference count of 1, so it gets returned to the NIC.
> > > > >   However, ice_put_rx_mbuf flipped the page so that the bottom
> > > > >   half is active.
> > > > > * If the NIC stores another packet in the page before packet A
> > > > >   has released its reference, the data in packet A will be
> > > > >   overwritten with data from the new packet.
> > > > > * Unfortunately zero-length buffers occur frequently: they seem
> > > > >   to occur whenever a packet uses every available byte in a
> > > > >   buffer, ending precisely at the end of the buffer. When this
> > > > >   happens the NIC seems to generate an extra zero-length
> > > > >   buffer.
> > > > > The fix is for ice_put_rx_mbuf not to flip pages that have a
> > > > > size of 0. =20
> > > >
> > > > How is this different from packet B (in the top half) being
> > > > freed before packet A (in the bottom half)? =20
> > >
> > > I'm not sure exactly what you're referring to here. Are you asking
> > > about a situation where both halves of the page get filled with packet
> > > data and then the second half to be filled is the first to be freed? I
> > > believe that the ICE driver abandons a page if both halves are ever
> > > occupied simultaneously; the page will be returned to the system once
> > > both halves have dropped their references. Thus it doesn't matter
> > > which half is freed first. =20
> >
> > That is what I was thinking, seems like the logic is over complicated.
> >
> > If you need to put 4k pages into some kind of iommu rather than 2k buff=
ers
> > (to contain 1536 byte ethernet packets) then I'd have thought you'd
> > initially put both halves into adjacent tx ring entries.
> > If a rx buffer is discarded (eg a zero length fragment or a CRC error,
> > or even 'copy break' for short packets) then, as an optimisation,
> > you could reuse the buffer for another receive.
> > The same could be done if the page is freed by an application.
> >
> > However it sounds like it doesn't use the 2nd half until the first
> > completes - otherwise you'd never 'flip' to make the other half
> > active.
> >
> > Thinks...
> > By only putting half of each 4k 'page' into the rx ring the code
> > will usually save (expensive) iommu setup in the (probably) normal
> > case where the buffers are freed 'reasonably quickly'.
> > But that really requires a 'free/with_nic/busy' state for each half
> > rather then trying to guess from a reference count.
> >
> > But if the low-level code is recycling the rx buffer (for any reason)
> > it wants to use the same buffer.
> >
> > The ethernet driver I wrote (a long time ago, early 90s) allocated
> > 64k as 128 512byte buffers and did an aligned word-sized copy of
> > every receive frame - most frames were in contiguous memory.
> > The simplicity of it made up for the cost of the copy, especially
> > since that was an iommu system. =20
>=20
> I'm not here to defend the logic (and it has been replaced with
> something that is probably simpler and more efficient); I'm just
> suggesting a bug fix for the stable releases that still have this
> logic.

You've forced me to look at all of the function :-)
I've noticed a few things:
- If ice_add_xdp_frag() fails (because there are too many fragments)
  then the rest of the fragments are left in the tx ring (instead
  of being discarded) - so are likely to be treated as a full packet
  later on.
- Frames with status errors (crc, framing etc) are discarded after
  the skb is built - surely that should happen before the xdp 'program'
  is called.
- If the remote system send a very very long frame (traditionally the PHY's
  'jabber detect' didn't always work) you can end up with all of the rx
  ring being full of a single partial packet.

I think you need to avoid calling ice_add_xdp_frag() when 'size =3D=3D 0'.
Then in ice_put_rx_mbuf() unconditionally call ice_put_rx_buf() for
zero length fragments.
The comment would be 'zero length fragments can always be reused'.

The zero length fragments almost certainly exist because the mac hardware
advances the the new buffer expecting more data - but only gets the=20
4 byte CRC. So the zero length buffer contains the receive status.

-- David

>=20
> -John-


