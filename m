Return-Path: <stable+bounces-254381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJNYM8u7FWrKYQcAu9opvQ
	(envelope-from <stable+bounces-254381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:27:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8425D8AFD
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1826318D028
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238838B14F;
	Tue, 26 May 2026 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkgd6dgM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747481DD9AC
	for <stable@vger.kernel.org>; Tue, 26 May 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808273; cv=none; b=b7s2ug0s48vfgFkKGef0usXE4gew+Dyi0BpxK35vp5IMA8Nj6Fa5DyuABJb575ONs3FwjEQJCeArXvAaCBPPjKdiokezKWewVW5Vn4IXxI+G6TOJDHQa02JSHYlGWW5dKPhJtnZ34UCVaFhe4cb1LH8C+ZV1qZXc1arNBL6zKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808273; c=relaxed/simple;
	bh=SCARi5umW3d5XBaEPSaPKKrqLS7JfeDlQS62zOijtSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkOn4ExGUuiQP5XGt6B36IqyZEhcDQ742DQrVXGETjneV94fumIZewcw7+cwWNyb33p00tH5UZ2VFuViPmZ+ZsdGqrf+JuGpnSzeXVrJLV9Mfz4FPcS/r/17VZqqGuPPHbY1cs8TrRHLTomfSLO+kVAy8d2jjxZaB3hBmPbPFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkgd6dgM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso41018575e9.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779808270; x=1780413070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz+rJovCHkSNlsFtO0WXxPTtCZGcHzWc5CByPRL4GyE=;
        b=Dkgd6dgM5GMVwV0t5O0FRCR1mVrjPouyCg/X9/eCkXVkadRPSJTyIJ0BuM6xbOv+F5
         1XpsypJn6A7VLC9+lMiZCwOJ2+S8wcGym0CR5+o1tcqb4QP5SsnnF5yFkSsHI8cqpCYH
         xXdqdnRf56SwdIpyS+CHd0G0zXpyzcco+kHwSvACxT3QqywH4TBupI/1z7oJbHSEbeem
         dyX/e5WR93ScGttIrIKmy5aFktSQ8Jm+wqfJPVCQl2noLveSkJ4M9ztNnOsYVNWuPAIA
         IdbKvl/XrR1z56gXw6AEj8wX88pVchoJhkwJ6PL1iyVaySZMwy6eNOmYVsZxZ0aSMuXU
         F3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808270; x=1780413070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gz+rJovCHkSNlsFtO0WXxPTtCZGcHzWc5CByPRL4GyE=;
        b=ikR3JFWj5TzHPbvnfpaGWPawaw3JoqX2qH+gYu1JYTJ9mH5JBMG3pXEOZBURl+u3KL
         rofwxnhZB3jN6PIDqV0LAXYMBBITI1PjG+10ftbPLKr4EDxhYDubNw/4GSNp49gjsUQP
         AUavMqEcvGb/b72V75935o3r82hKJd7a7lRScdYxAgoodK7W7mHAI2CZ3H1FcAmXOryF
         N48p4g9mebg4Sn+K7jy8gghIReQRUid7O1S5bhp7+UiWQnfwqKtqJ9Lp+wS1qrlxn9Yp
         w+ZIkBdjvsdYl7aqDtHYrI4SFLWPlIsCy7X+AARlN5kLnFzQ+Q0PwNOpo9WCW2tfu3OG
         mZFg==
X-Forwarded-Encrypted: i=1; AFNElJ8pfdb2OgBzZaqRfEOBosvFl4ikuvvcwhbLAED83FUNhfg+wMqxtCyMv2l8S4YdBzmvxJXEeZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eH0/G0NvDywK6cfNwlfPjPv2JUGGL/nDYHxHXGbPK64rdvVG
	+ALpWZkjXlBytSLnmwFrLoSqUiMSc+E6c/TJmBEtKuSRI+45rmYTmSb1
X-Gm-Gg: Acq92OEMQklEVwvAMpGFsn9VXvkHG/0oisrt5o2LUa5hU2jUwwpcO2gwPr3u8zHMivk
	FJUxc9rivAORvUJpTSEUmai9WfN1KkbF+NJmLfyYaPm2cqbwp1kJoBG3J4v40HZfI/wrgKSCvtl
	zZsciI9p+0JFDkYpCq65la3NKgPn+kUhWHAbluwBOpF3mqdicBay/rsCjTLH7T9DfTkTimJ/Tok
	YdC3/mF6p6C4Xpyh4kw8WoTscFbESqYmNfkq+I/KoBtYardPUQIpVD1DEizC/pdLEGGCPmC9j0i
	DCcMbAEx0/28HA08pMuOORSnkBn+rqOFDPx5TOCBCUMBvvGK/W3laXHlymaWtBtNKe7IRwSixTh
	xL+Fw9qxhlgf8L7EQGeet2r/HUh/faedW1K67QprwNuylecpe3Ja7DXu2NZ4i18l7wLlInjVmqK
	eoxuBposKOxbhIa+EkZcHIuWBBvSgEg0BC9jkR+acxOXVcRqwbKQlP03EKlV69al+Wlg4B9RXQl
	4s=
X-Received: by 2002:a05:600c:1553:b0:490:53b0:9e53 with SMTP id 5b1f17b1804b1-49053b0a086mr252276435e9.1.1779808269542;
        Tue, 26 May 2026 08:11:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490456274ebsm317708235e9.15.2026.05.26.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:11:09 -0700 (PDT)
Date: Tue, 26 May 2026 16:11:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Oros <poros@redhat.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, John Ousterhout
 <ouster@cs.stanford.edu>, stable@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v3] ice: fix packet corruption due
 to extraneous page flip
Message-ID: <20260526161108.645c47a1@pumpkin>
In-Reply-To: <e1ce1387-ae6b-4b43-b5d8-a1141c4a4f1c@redhat.com>
References: <20260512181953.1689-1-ouster@cs.stanford.edu>
	<20260513100732.499e3f49@pumpkin>
	<CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
	<20260513214927.17a8dd45@pumpkin>
	<CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
	<20260514110112.12bdf5ff@pumpkin>
	<30dc284c-8cc0-4bae-b7b0-99d6d71a66e3@intel.com>
	<e1ce1387-ae6b-4b43-b5d8-a1141c4a4f1c@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254381-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanford.edu:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D8425D8AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 14:47:42 +0200
Petr Oros <poros@redhat.com> wrote:

> On 5/14/26 18:43, Jacob Keller wrote:
> > On 5/14/2026 3:01 AM, David Laight wrote: =20
> >> On Wed, 13 May 2026 21:47:11 -0700
> >> John Ousterhout <ouster@cs.stanford.edu> wrote:
> >> =20
> >>> On Wed, May 13, 2026 at 1:49=E2=80=AFPM David Laight
> >>> <david.laight.linux@gmail.com> wrote: =20
> >>>> On Wed, 13 May 2026 09:28:40 -0700
> >>>> John Ousterhout <ouster@cs.stanford.edu> wrote:
> >>>>    =20
> >>>>> On Wed, May 13, 2026 at 2:07=E2=80=AFAM David Laight
> >>>>> <david.laight.linux@gmail.com> wrote: =20
> >>>>>> On Tue, 12 May 2026 11:19:53 -0700
> >>>>>> John Ousterhout <ouster@cs.stanford.edu> wrote:
> >>>>>>    =20
> >>>>>>> Consider the following sequence of events:
> >>>>>>> * The bottom half of a buffer page is filled with data from
> >>>>>>>    packet A. The page has a net reference count (reference count
> >>>>>>>    - bias) of 1. The page is returned to the NIC, flipped to
> >>>>>>>    use the top half.
> >>>>>>> * Before the reference on the page is released, the NIC returns
> >>>>>>>    the page with no data in it ('size' is zero in ice_clean_rx_ir=
q).
> >>>>>>>    In this case the bias does not get decremented. The page still
> >>>>>>>    has a net reference count of 1, so it gets returned to the NIC.
> >>>>>>>    However, ice_put_rx_mbuf flipped the page so that the bottom
> >>>>>>>    half is active.
> >>>>>>> * If the NIC stores another packet in the page before packet A
> >>>>>>>    has released its reference, the data in packet A will be
> >>>>>>>    overwritten with data from the new packet.
> >>>>>>> * Unfortunately zero-length buffers occur frequently: they seem
> >>>>>>>    to occur whenever a packet uses every available byte in a
> >>>>>>>    buffer, ending precisely at the end of the buffer. When this
> >>>>>>>    happens the NIC seems to generate an extra zero-length
> >>>>>>>    buffer.
> >>>>>>> The fix is for ice_put_rx_mbuf not to flip pages that have a
> >>>>>>> size of 0. =20
> >>>>>> How is this different from packet B (in the top half) being
> >>>>>> freed before packet A (in the bottom half)? =20
> >>>>> I'm not sure exactly what you're referring to here. Are you asking
> >>>>> about a situation where both halves of the page get filled with pac=
ket
> >>>>> data and then the second half to be filled is the first to be freed=
? I
> >>>>> believe that the ICE driver abandons a page if both halves are ever
> >>>>> occupied simultaneously; the page will be returned to the system on=
ce
> >>>>> both halves have dropped their references. Thus it doesn't matter
> >>>>> which half is freed first. =20
> >>>> That is what I was thinking, seems like the logic is over complicate=
d.
> >>>>
> >>>> If you need to put 4k pages into some kind of iommu rather than 2k b=
uffers
> >>>> (to contain 1536 byte ethernet packets) then I'd have thought you'd
> >>>> initially put both halves into adjacent tx ring entries.
> >>>> If a rx buffer is discarded (eg a zero length fragment or a CRC erro=
r,
> >>>> or even 'copy break' for short packets) then, as an optimisation,
> >>>> you could reuse the buffer for another receive.
> >>>> The same could be done if the page is freed by an application.
> >>>>
> >>>> However it sounds like it doesn't use the 2nd half until the first
> >>>> completes - otherwise you'd never 'flip' to make the other half
> >>>> active.
> >>>>
> >>>> Thinks...
> >>>> By only putting half of each 4k 'page' into the rx ring the code
> >>>> will usually save (expensive) iommu setup in the (probably) normal
> >>>> case where the buffers are freed 'reasonably quickly'.
> >>>> But that really requires a 'free/with_nic/busy' state for each half
> >>>> rather then trying to guess from a reference count.
> >>>>
> >>>> But if the low-level code is recycling the rx buffer (for any reason)
> >>>> it wants to use the same buffer.
> >>>>
> >>>> The ethernet driver I wrote (a long time ago, early 90s) allocated
> >>>> 64k as 128 512byte buffers and did an aligned word-sized copy of
> >>>> every receive frame - most frames were in contiguous memory.
> >>>> The simplicity of it made up for the cost of the copy, especially
> >>>> since that was an iommu system. =20
> >>> I'm not here to defend the logic (and it has been replaced with
> >>> something that is probably simpler and more efficient); I'm just
> >>> suggesting a bug fix for the stable releases that still have this
> >>> logic. =20
> > Right. We definitely want a fix for the possible data corruption in
> > stable. Ideally one as simple as possible.
> > =20
> >> You've forced me to look at all of the function :-)
> >> I've noticed a few things:
> >> - If ice_add_xdp_frag() fails (because there are too many fragments)
> >>    then the rest of the fragments are left in the tx ring (instead
> >>    of being discarded) - so are likely to be treated as a full packet
> >>    later on.
> >> - Frames with status errors (crc, framing etc) are discarded after
> >>    the skb is built - surely that should happen before the xdp 'progra=
m'
> >>    is called.
> >> - If the remote system send a very very long frame (traditionally the =
PHY's
> >>    'jabber detect' didn't always work) you can end up with all of the =
rx
> >>    ring being full of a single partial packet.
> >>
> >> I think you need to avoid calling ice_add_xdp_frag() when 'size =3D=3D=
 0'.
> >> Then in ice_put_rx_mbuf() unconditionally call ice_put_rx_buf() for
> >> zero length fragments.
> >> The comment would be 'zero length fragments can always be reused'.
> >> =20
> > That seems correct.
> > =20
> >> The zero length fragments almost certainly exist because the mac hardw=
are
> >> advances the the new buffer expecting more data - but only gets the
> >> 4 byte CRC. So the zero length buffer contains the receive status.
> >> =20
> > That matches my understanding. =20
> Hi John,
>=20
> I have been looking at the same area in the pre-page-pool ice code and
> I want to ask whether you observed memory growth during your Homa runs
> that exposed the corruption, because in my testing the same bias mismatch
> also produces a slow page leak that your v3 does not close.
>=20
> Short version of the leak path, in the PASS (!CONSUMED) branch:
>=20
>  =C2=A0 1. ice_get_rx_buf(size=3D0) does pagecnt_bias-- unconditionally
>  =C2=A0 =C2=A0 =C2=A0(added by commit ef68094cb09e ("ice: Fix kernel pani=
c due to page
>  =C2=A0 =C2=A0 =C2=A0refcount underflow") as the fix for the matching pan=
ic).
>  =C2=A0 2. ice_add_xdp_frag() then returns 0 for size=3D=3D0, so that pag=
e is
>  =C2=A0 =C2=A0 =C2=A0never attached to the xdp_buff/SKB. Nobody downstrea=
m will ever
>  =C2=A0 =C2=A0 =C2=A0call put_page() to balance the pagecnt_bias-- from s=
tep 1.
>  =C2=A0 3. Your v3 in ice_put_rx_mbuf() correctly skips the page flip for
>  =C2=A0 =C2=A0 =C2=A0size=3D=3D0, which closes the corruption window. But=
 it does not
>  =C2=A0 =C2=A0 =C2=A0restore pagecnt_bias for that zero size buffer, so t=
he page is
>  =C2=A0 =C2=A0 =C2=A0handed back to ice_reuse_rx_page() with a permanent =
deficit of 1.
>  =C2=A0 4. On the next reuse of that page with size > 0, pagecnt_bias dro=
ps
>  =C2=A0 =C2=A0 =C2=A0again. ice_can_reuse_rx_page() now sees pgcnt - bias=
 =3D=3D 2 and
>  =C2=A0 =C2=A0 =C2=A0drains via __page_frag_cache_drain(page, pagecnt_bia=
s). Because
>  =C2=A0 =C2=A0 =C2=A0pagecnt_bias is one too low, the drain undershoots b=
y 1: page
>  =C2=A0 =C2=A0 =C2=A0refcount stays at 2 instead of 1.
>  =C2=A0 5. The SKB eventually releases its reference (refcount -> 1), but
>  =C2=A0 =C2=A0 =C2=A0nothing ever brings it to 0. The page is leaked.
>  =C2=A0 =C2=A0 =C2=A0ice_alloc_rx_bufs() just allocates a fresh page to f=
ill the slot.
>=20
> At the zero size frequency you mentioned (thousands per second), this
> adds up to roughly MB/s of leaked page cache, which Jaroslav Pulchart
> originally reported against 6.13.y on NUMA nodes and which motivated
> the libeth/page_pool conversion in mainline. So in stable trees the
> leak side of this bug is still live.
>=20
> Two questions:
>=20
>  =C2=A0 - Did you monitor RSS / page allocator stats over the duration of
>  =C2=A0 =C2=A0 your Homa runs? If you did and did not see growth, I would=
 like
>  =C2=A0 =C2=A0 to understand what is different about your setup, because =
by my
>  =C2=A0 =C2=A0 reading of the code the leak should fire whenever both hal=
ves of
>  =C2=A0 =C2=A0 a page end up in SKBs simultaneously and one of them carri=
ed a
>  =C2=A0 =C2=A0 zero size descriptor along the way.
>=20
>  =C2=A0 - If your focus was specifically the corruption, would you be open
>  =C2=A0 =C2=A0 to extending v3 (or replacing it) with a fix that also res=
tores
>  =C2=A0 =C2=A0 pagecnt_bias for the size=3D=3D0 case? The minimal extensi=
on is one
>  =C2=A0 =C2=A0 extra branch in ice_put_rx_mbuf:
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (verdict !=3D ICE_XDP_CONSUMED && size !=
=3D 0)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ice_rx_buf_adjus=
t_pg_offset(buf, xdp->frame_sz);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf->pagecnt_bia=
s++;
>=20
>  =C2=A0 =C2=A0 which restores bias on every path where the page is not ac=
tually
>  =C2=A0 =C2=A0 going out to an SKB. (I have a slightly different variant =
that
>  =C2=A0 =C2=A0 tracks has_data in struct ice_rx_buf to also handle the br=
oken
>  =C2=A0 =C2=A0 positional 'i <=3D xdp_frags' counter in the CONSUMED path=
, where
>  =C2=A0 =C2=A0 zero size descriptors in the middle of a frame steal bias+=
+ slots
>  =C2=A0 =C2=A0 from real fragments. Happy to share it if useful.)

By thought was:

I think you need to avoid calling ice_add_xdp_frag() when 'size =3D=3D 0'.
Then in ice_put_rx_mbuf() unconditionally call ice_put_rx_buf() for
zero length fragments (regardless of verdict).
The comment would be 'zero length fragments can always be reused'.

I think that path always reuses the same half of the page without
going near the 'bias' code paths (which I didn't manage to grok).
It is the same path that is used for frames with bad CRC (ignoring
the broken paths when xdp is enabled).

-- David

>=20
> Regards,
> Petr
>=20
>=20


