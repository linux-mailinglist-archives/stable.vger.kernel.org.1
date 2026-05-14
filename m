Return-Path: <stable+bounces-247105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO7QHgJUBWpPVAIAu9opvQ
	(envelope-from <stable+bounces-247105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:48:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE2353DC0E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC813031020
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086E2F2914;
	Thu, 14 May 2026 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="tJYo5xlc"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411827B50F
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734077; cv=none; b=jQGBZi3JWiK47J8VuX1HiyZL3AspDYn1w3wGazHbk68vQxIqySm2et5piqFWIeSv8Dop1kMxJY5XrVwhrv5ih5av15WvZW8jqHNUwEMvDcn+1bjo/aerYub/xke9N9l6inBEuAVr1O9EfoGXCrcq6eroQIak5w2If77azqeS6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734077; c=relaxed/simple;
	bh=5BxZ5ztoiVpQIfiHlmIE3177HomQSnDfB2tqISVkGKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4pw/s9z3PItqBnFQvHc1JbHqkVG9ExDykuA2dHhkublB5prAkLYU/Vdhh9uBSgsBAet7Jwd9NC6fJbw0qbJEYEWBsh8xlcgNBjRRkkD6N/eJmhQ2Qckt7zMQqqIrsG/RRZGI1NPjBwkB3kIilJik2Lc378aBbyZZ5WmvYd7144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=tJYo5xlc; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3AyOL3ppd8xGJZ2KNy9mC12UjWrON94Yu0GePueZeeM=; t=1778734076; x=1779598076; 
	b=tJYo5xlcM4FNeKq+x+Rkr5c7bK5AmUVaJrcIJDQwptBLmSCLCSibWMgSfnLtOvNjmg+ierQHzlJ
	B1QKFIUDHtFYR1LgJGJNuYKHH+xjJ7tMwXNppvCBNz1p7rKA+nYj3nbeLSjcak6VldSqZD9Xzzjy+
	FrgVJXsvLk2ITmYfHQAU+XD+xfLZ+7BuBnmMmK9FK2iWeCcqKpRxn0mjKduuep6zBGlOjDIF/nuus
	hzCocI8l5ADawdrQcKmA40FVe8DImjlM7PZhSy6Ym09N9Mi2B6ybrFk3kHacxhRlWA50ETkYDDys2
	Ei3QvzgLMu+Jml5eRDj1yutOiNZNVBWDbNDw==;
Received: from mail-yx1-f52.google.com ([74.125.224.52]:57674)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wNNz9-0002tF-Cw
	for stable@vger.kernel.org; Wed, 13 May 2026 21:47:49 -0700
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651c5d525f6so9124313d50.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 21:47:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyv/baO71XHOBqB4ui3gSKPC7wmKDeBWGXF6tZO0S1iEqdyonGn
	VXwH/yx+Zfk+T746IbJkiGGFHUpff9xAD9Pu0WnkDESilsr4KdlBWcR4Lyroc9pfGC/RcvpqAIX
	ZU1xouOJXANnZdftwTCsNRNLKACWDRuY=
X-Received: by 2002:a05:690c:c117:b0:7bd:ac4d:bf5b with SMTP id
 00721157ae682-7c6dc7c118fmr52576797b3.44.1778734066710; Wed, 13 May 2026
 21:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512181953.1689-1-ouster@cs.stanford.edu> <20260513100732.499e3f49@pumpkin>
 <CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com> <20260513214927.17a8dd45@pumpkin>
In-Reply-To: <20260513214927.17a8dd45@pumpkin>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 13 May 2026 21:47:11 -0700
X-Gmail-Original-Message-ID: <CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
X-Gm-Features: AVHnY4I7VDZMqDYm3BEU1IYOkcNt_oCLDdDfb41-kNLISPv5uzgLWbSydLqU5ug
Message-ID: <CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
Subject: Re: [PATCH net v3] ice: fix packet corruption due to extraneous page flip
To: David Laight <david.laight.linux@gmail.com>
Cc: stable@vger.kernel.org, anthony.l.nguyen@intel.com, 
	intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com, 
	netdev@vger.kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: ae7d61d5ad21aa0d569d6b6c8168eb46
X-Rspamd-Queue-Id: DEE2353DC0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247105-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.916];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,stanford.edu:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 1:49=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 13 May 2026 09:28:40 -0700
> John Ousterhout <ouster@cs.stanford.edu> wrote:
>
> > On Wed, May 13, 2026 at 2:07=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 12 May 2026 11:19:53 -0700
> > > John Ousterhout <ouster@cs.stanford.edu> wrote:
> > >
> > > > Consider the following sequence of events:
> > > > * The bottom half of a buffer page is filled with data from
> > > >   packet A. The page has a net reference count (reference count
> > > >   - bias) of 1. The page is returned to the NIC, flipped to
> > > >   use the top half.
> > > > * Before the reference on the page is released, the NIC returns
> > > >   the page with no data in it ('size' is zero in ice_clean_rx_irq).
> > > >   In this case the bias does not get decremented. The page still
> > > >   has a net reference count of 1, so it gets returned to the NIC.
> > > >   However, ice_put_rx_mbuf flipped the page so that the bottom
> > > >   half is active.
> > > > * If the NIC stores another packet in the page before packet A
> > > >   has released its reference, the data in packet A will be
> > > >   overwritten with data from the new packet.
> > > > * Unfortunately zero-length buffers occur frequently: they seem
> > > >   to occur whenever a packet uses every available byte in a
> > > >   buffer, ending precisely at the end of the buffer. When this
> > > >   happens the NIC seems to generate an extra zero-length
> > > >   buffer.
> > > > The fix is for ice_put_rx_mbuf not to flip pages that have a
> > > > size of 0.
> > >
> > > How is this different from packet B (in the top half) being
> > > freed before packet A (in the bottom half)?
> >
> > I'm not sure exactly what you're referring to here. Are you asking
> > about a situation where both halves of the page get filled with packet
> > data and then the second half to be filled is the first to be freed? I
> > believe that the ICE driver abandons a page if both halves are ever
> > occupied simultaneously; the page will be returned to the system once
> > both halves have dropped their references. Thus it doesn't matter
> > which half is freed first.
>
> That is what I was thinking, seems like the logic is over complicated.
>
> If you need to put 4k pages into some kind of iommu rather than 2k buffer=
s
> (to contain 1536 byte ethernet packets) then I'd have thought you'd
> initially put both halves into adjacent tx ring entries.
> If a rx buffer is discarded (eg a zero length fragment or a CRC error,
> or even 'copy break' for short packets) then, as an optimisation,
> you could reuse the buffer for another receive.
> The same could be done if the page is freed by an application.
>
> However it sounds like it doesn't use the 2nd half until the first
> completes - otherwise you'd never 'flip' to make the other half
> active.
>
> Thinks...
> By only putting half of each 4k 'page' into the rx ring the code
> will usually save (expensive) iommu setup in the (probably) normal
> case where the buffers are freed 'reasonably quickly'.
> But that really requires a 'free/with_nic/busy' state for each half
> rather then trying to guess from a reference count.
>
> But if the low-level code is recycling the rx buffer (for any reason)
> it wants to use the same buffer.
>
> The ethernet driver I wrote (a long time ago, early 90s) allocated
> 64k as 128 512byte buffers and did an aligned word-sized copy of
> every receive frame - most frames were in contiguous memory.
> The simplicity of it made up for the cost of the copy, especially
> since that was an iommu system.

I'm not here to defend the logic (and it has been replaced with
something that is probably simpler and more efficient); I'm just
suggesting a bug fix for the stable releases that still have this
logic.

-John-

