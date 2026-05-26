Return-Path: <stable+bounces-254451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMrPCnAgFmrLhwcAu9opvQ
	(envelope-from <stable+bounces-254451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 00:36:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D424F5DD39C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 00:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AC1D303BB8F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C8B3C819C;
	Tue, 26 May 2026 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Wdu74+dj"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7213C585C
	for <stable@vger.kernel.org>; Tue, 26 May 2026 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834980; cv=none; b=Jf8HyrR2hp6QRUSzR9FekRPor858uM0zuWP8+WNyS0UV6LjAfV3w9cBwnhkYvNfRfnWtwBw85/nAVh2OCA0zW4AYDhRivTkgLcwUqB5mWS6/NpFN6ncgaKfoAnX6v2NxbT85gKB4BoG39t0nVj5kvvYl3dl/owhw800Zw9eTzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834980; c=relaxed/simple;
	bh=qQGMf5Oja55h6Cw2oXwBePJIZxpj+DW+ZyPt7nOTD3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlqTD1t8cJRpgQvZLOfwDPLxlAk3gFozJrVoOtBZj0s7fBP51p9L5f3gsfn3SdQP1FUgdKuqqlovpYAAbt4MI6YON91ZueF5FNK6IWvXI22ispLaeHp+LA2j2qYIjf8Iup7acTosqEKTXovGhUgEDNRmcCnPKVOLbltjjmrdCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Wdu74+dj; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NJqWELah5fN6kC7HlpvsVp3NB/5DJZ/YkbrusZMNXr8=; t=1779834978; x=1780698978; 
	b=Wdu74+djM2wqYOJNutjl4obUDn74Gyo5iUXXss9ViM8Jx3f+h2DsiJsyYNgNOubvqCTs77e79sY
	y4tmF0LpEw7fJ5M6mJ8PviMzwVq248YFGJcZS015ARFaGTB4r1i7jrKlUc7YW2wituIJoo3Pvqc/N
	gq/wIswbI4b/CMA5Ki+4/Q0n4CuX9PgCBv/V5MJ2Pfu0bNYAmmBUXK2kEhdsobRCG4EwGAHbW8tif
	XT27BmMyDq2PqmYTFIf3liTDOWjB72MOpu9lOL/PFkazUh59eyjBUc8YPcTrMzobJawpPvvuQ0cO+
	uweMDdNTwaLiUmprgV7XUeBrKLAn25c6NeUg==;
Received: from mail-yw1-f176.google.com ([209.85.128.176]:50644)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wS062-00060t-Ce
	for stable@vger.kernel.org; Tue, 26 May 2026 15:17:59 -0700
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c58e6eb2c8so109926707b3.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 15:17:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+tA6QV+R0+9YqzRzAdWi3QJ0h8Ch2fhQd0m/xkCZhURoiDqoQ9mzleOOhev7Ei79ECHd0KxlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnwEdfMkpPaV3v0Zw4ytN8wS88f1TZ22yhjGxn8XIdkSjwHFS
	iddhfUPfYXRL+vKPl6P7XgXqx9wJ0xZtWl7n8w2fwgIVgyVdjkVJ0k95jXJspN/R+MHPsL/DpJb
	qQjWsOE4N13WZN29xxn2cS/l1hrf0JD0=
X-Received: by 2002:a05:690c:b05:b0:799:198d:8c78 with SMTP id
 00721157ae682-7d337dac2b7mr212869987b3.46.1779833877680; Tue, 26 May 2026
 15:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512181953.1689-1-ouster@cs.stanford.edu> <20260513100732.499e3f49@pumpkin>
 <CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
 <20260513214927.17a8dd45@pumpkin> <CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
 <20260514110112.12bdf5ff@pumpkin> <30dc284c-8cc0-4bae-b7b0-99d6d71a66e3@intel.com>
 <e1ce1387-ae6b-4b43-b5d8-a1141c4a4f1c@redhat.com>
In-Reply-To: <e1ce1387-ae6b-4b43-b5d8-a1141c4a4f1c@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 26 May 2026 15:17:20 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwa4OQJV1O+Zn8KYBH9wJEVrqefuJQ6NRjbBTmLqF4vwA@mail.gmail.com>
X-Gm-Features: AVHnY4InlTCmtsr01wWr_JUtpPbh3ksqqJ8UpLXEL8kdVSMNoGuSjEu4uz-pvUU
Message-ID: <CAGXJAmwa4OQJV1O+Zn8KYBH9wJEVrqefuJQ6NRjbBTmLqF4vwA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net v3] ice: fix packet corruption due
 to extraneous page flip
To: Petr Oros <poros@redhat.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, David Laight <david.laight.linux@gmail.com>, 
	stable@vger.kernel.org, anthony.l.nguyen@intel.com, 
	intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: f381877c06e33db9b8e2eda11595152b
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org,lists.osuosl.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	TAGGED_FROM(0.00)[bounces-254451-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.812];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,stanford.edu:email]
X-Rspamd-Queue-Id: D424F5DD39C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 5:47=E2=80=AFAM Petr Oros <poros@redhat.com> wrote:
>
>
> On 5/14/26 18:43, Jacob Keller wrote:
> > On 5/14/2026 3:01 AM, David Laight wrote:
> >> On Wed, 13 May 2026 21:47:11 -0700
> >> John Ousterhout <ouster@cs.stanford.edu> wrote:
> >>
> >>> On Wed, May 13, 2026 at 1:49=E2=80=AFPM David Laight
> >>> <david.laight.linux@gmail.com> wrote:
> >>>> On Wed, 13 May 2026 09:28:40 -0700
> >>>> John Ousterhout <ouster@cs.stanford.edu> wrote:
> >>>>
> >>>>> On Wed, May 13, 2026 at 2:07=E2=80=AFAM David Laight
> >>>>> <david.laight.linux@gmail.com> wrote:
> >>>>>> On Tue, 12 May 2026 11:19:53 -0700
> >>>>>> John Ousterhout <ouster@cs.stanford.edu> wrote:
> >>>>>>
> >>>>>>> Consider the following sequence of events:
> >>>>>>> * The bottom half of a buffer page is filled with data from
> >>>>>>>    packet A. The page has a net reference count (reference count
> >>>>>>>    - bias) of 1. The page is returned to the NIC, flipped to
> >>>>>>>    use the top half.
> >>>>>>> * Before the reference on the page is released, the NIC returns
> >>>>>>>    the page with no data in it ('size' is zero in ice_clean_rx_ir=
q).
> >>>>>>>    In this case the bias does not get decremented. The page still
> >>>>>>>    has a net reference count of 1, so it gets returned to the NIC=
.
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
> >>>>>>> size of 0.
> >>>>>> How is this different from packet B (in the top half) being
> >>>>>> freed before packet A (in the bottom half)?
> >>>>> I'm not sure exactly what you're referring to here. Are you asking
> >>>>> about a situation where both halves of the page get filled with pac=
ket
> >>>>> data and then the second half to be filled is the first to be freed=
? I
> >>>>> believe that the ICE driver abandons a page if both halves are ever
> >>>>> occupied simultaneously; the page will be returned to the system on=
ce
> >>>>> both halves have dropped their references. Thus it doesn't matter
> >>>>> which half is freed first.
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
> >>>> But if the low-level code is recycling the rx buffer (for any reason=
)
> >>>> it wants to use the same buffer.
> >>>>
> >>>> The ethernet driver I wrote (a long time ago, early 90s) allocated
> >>>> 64k as 128 512byte buffers and did an aligned word-sized copy of
> >>>> every receive frame - most frames were in contiguous memory.
> >>>> The simplicity of it made up for the cost of the copy, especially
> >>>> since that was an iommu system.
> >>> I'm not here to defend the logic (and it has been replaced with
> >>> something that is probably simpler and more efficient); I'm just
> >>> suggesting a bug fix for the stable releases that still have this
> >>> logic.
> > Right. We definitely want a fix for the possible data corruption in
> > stable. Ideally one as simple as possible.
> >
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
> >>
> > That seems correct.
> >
> >> The zero length fragments almost certainly exist because the mac hardw=
are
> >> advances the the new buffer expecting more data - but only gets the
> >> 4 byte CRC. So the zero length buffer contains the receive status.
> >>
> > That matches my understanding.
> Hi John,
>
> I have been looking at the same area in the pre-page-pool ice code and
> I want to ask whether you observed memory growth during your Homa runs
> that exposed the corruption, because in my testing the same bias mismatch
> also produces a slow page leak that your v3 does not close.
>
> Short version of the leak path, in the PASS (!CONSUMED) branch:
>
>    1. ice_get_rx_buf(size=3D0) does pagecnt_bias-- unconditionally
>       (added by commit ef68094cb09e ("ice: Fix kernel panic due to page
>       refcount underflow") as the fix for the matching panic).
>    2. ice_add_xdp_frag() then returns 0 for size=3D=3D0, so that page is
>       never attached to the xdp_buff/SKB. Nobody downstream will ever
>       call put_page() to balance the pagecnt_bias-- from step 1.
>    3. Your v3 in ice_put_rx_mbuf() correctly skips the page flip for
>       size=3D=3D0, which closes the corruption window. But it does not
>       restore pagecnt_bias for that zero size buffer, so the page is
>       handed back to ice_reuse_rx_page() with a permanent deficit of 1.
>    4. On the next reuse of that page with size > 0, pagecnt_bias drops
>       again. ice_can_reuse_rx_page() now sees pgcnt - bias =3D=3D 2 and
>       drains via __page_frag_cache_drain(page, pagecnt_bias). Because
>       pagecnt_bias is one too low, the drain undershoots by 1: page
>       refcount stays at 2 instead of 1.
>    5. The SKB eventually releases its reference (refcount -> 1), but
>       nothing ever brings it to 0. The page is leaked.
>       ice_alloc_rx_bufs() just allocates a fresh page to fill the slot.
>
> At the zero size frequency you mentioned (thousands per second), this
> adds up to roughly MB/s of leaked page cache, which Jaroslav Pulchart
> originally reported against 6.13.y on NUMA nodes and which motivated
> the libeth/page_pool conversion in mainline. So in stable trees the
> leak side of this bug is still live.
>
> Two questions:
>
>    - Did you monitor RSS / page allocator stats over the duration of
>      your Homa runs? If you did and did not see growth, I would like
>      to understand what is different about your setup, because by my
>      reading of the code the leak should fire whenever both halves of
>      a page end up in SKBs simultaneously and one of them carried a
>      zero size descriptor along the way.

I have not monitored the page allocator stats. I'm not sure I know the
best way to do this; I tried slabtop but it didn't seem to show
significant growth in memory usage.

>    - If your focus was specifically the corruption, would you be open
>      to extending v3 (or replacing it) with a fix that also restores
>      pagecnt_bias for the size=3D=3D0 case? The minimal extension is one
>      extra branch in ice_put_rx_mbuf:
>
>          if (verdict !=3D ICE_XDP_CONSUMED && size !=3D 0)
>                  ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
>          else
>                  buf->pagecnt_bias++;
>
>      which restores bias on every path where the page is not actually
>      going out to an SKB. (I have a slightly different variant that
>      tracks has_data in struct ice_rx_buf to also handle the broken
>      positional 'i <=3D xdp_frags' counter in the CONSUMED path, where
>      zero size descriptors in the middle of a frame steal bias++ slots
>      from real fragments. Happy to share it if useful.)

My understanding of the ice driver is extremely limited. You may be
right about the proposed fix, but I don't currently know enough to get
comfortable with it. I think it might be better to separate your
change into a different patch, which can be shepherded by people with
appropriate understanding.

-John-

