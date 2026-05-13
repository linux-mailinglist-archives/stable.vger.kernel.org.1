Return-Path: <stable+bounces-246929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aORnFCGsBGoxMwIAu9opvQ
	(envelope-from <stable+bounces-246929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:51:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D153771C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E40CB32E9ACB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626E36A35A;
	Wed, 13 May 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="INQU+0Fq"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546C28642B
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689153; cv=none; b=UOyCiPi22SlF+cZ/BRHFHkLGB4DtXGT/+qDglUHeVqZcX+xrHw6adDwqBD+o3WRTJWlpqr5m0cw0+ysqUfrXYzgcm9GoZDKKwrt6sbji1MXO28qf0nOA7smwogCHTLPefoTkU8szoigwj6MboY4bqzC1I6XCla2v3klbKuKh3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689153; c=relaxed/simple;
	bh=xk5gVzmTvuUhq51PH2Alyk32aLWXmLFwCkG3xGoe2Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeYKnp6pSHTm9N3SQsIoVwE4W+fuQJUzRNK49o5/iuOqNoDjZb52LpFtqqkwx05H+QyjLM7nAgDF5FqQSZ/UF7ocSKREt+t1NkRj+STKaguiqt0g39cwG1Bin/TudIJfb+fX6qBe/ttqfupgP0AI8+2xJA3N1Oj8rl70jpMmt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=INQU+0Fq; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gSymfgXXHEfqRIi3EKAZn1bLzeACwaVTipEgTXAoR5c=; t=1778689151; x=1779553151; 
	b=INQU+0FqJrrBhgI7B87lHUjP9tfzio7/sm7G9fWSFO5wW6rpIPM18kZoXOadt4svK5LE9U5nydm
	U+cuYhQmEofXhtr/BmvqZvr79rRj8v0GBJuRxB9poPLag9Z9djSQICIppcU8jEMdwlZf16I50E6rA
	RHDdvJwLdwP4dH/5QvQCI/c+NhfwhrbBCEjX+qfB5VUA/LiGxqyCPmc3iscnSXjMtR9DmHzYO7fBL
	eu1qprmsvp1K1DvJFXSfvAx4TJ+4ON586G44eAyalGiQ7t8rlYZCmv2mjkwSE9ULHWvsRhfJA1aeo
	nImh/SQSajt7e6vqtlyxr7Um3nhspeXF1t8g==;
Received: from mail-yx1-f49.google.com ([74.125.224.49]:44086)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wNCIg-0003s5-0d
	for stable@vger.kernel.org; Wed, 13 May 2026 09:19:11 -0700
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c364b893aso6987140d50.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 09:19:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw7rCZ9HZLjAbD4SiK33IhIo+ltxlIqyiBL3ILGScMd2kUWi6y1
	bMTGyrnAq5cSZK+t8PAumI8pVpcjotgIFBeYSN0DRV9OCRoXNNcay3bPu6hQu/XRMCVZyU3mfsF
	tIPAVgO7IZZVVbmVcquwKho2nimG64mI=
X-Received: by 2002:a05:690c:4990:b0:7b7:1753:1bd5 with SMTP id
 00721157ae682-7c6a944c95bmr41656947b3.7.1778689149298; Wed, 13 May 2026
 09:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512181228.1619-1-ouster@cs.stanford.edu> <2026051356-superman-synthesis-d983@gregkh>
In-Reply-To: <2026051356-superman-synthesis-d983@gregkh>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 13 May 2026 09:18:33 -0700
X-Gmail-Original-Message-ID: <CAGXJAmztHQCF59+h7wa-iYvm6CuJ-H4JFBQHqsYLYxjq8hFU=A@mail.gmail.com>
X-Gm-Features: AVHnY4ISIJkW5yOzJb4OU9OnwR3bXhHeQQc0zsrI-pm4zhzoOD7KvEH6GmwA6qU
Message-ID: <CAGXJAmztHQCF59+h7wa-iYvm6CuJ-H4JFBQHqsYLYxjq8hFU=A@mail.gmail.com>
Subject: Re: [PATCH net-next v3] ice: fix packet corruption due to extraneous
 page flip
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: ae8206b624f71ff41c2281f68712021f
X-Rspamd-Queue-Id: AB6D153771C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246929-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.239];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanford.edu:email,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, May 12, 2026 at 11:12:28AM -0700, John Ousterhout wrote:
> > Consider the following sequence of events:
> > * The bottom half of a buffer page is filled with data from
> >   packet A. The page has a net reference count (reference count
> >   - bias) of 1. The page is returned to the NIC, flipped to
> >   use the top half.
> > * Before the reference on the page is released, the NIC returns
> >   the page with no data in it ('size' is zero in ice_clean_rx_irq).
> >   In this case the bias does not get decremented. The page still
> >   has a net reference count of 1, so it gets returned to the NIC.
> >   However, ice_put_rx_mbuf flipped the page so that the bottom
> >   half is active.
> > * If the NIC stores another packet in the page before packet A
> >   has released its reference, the data in packet A will be
> >   overwritten with data from the new packet.
> > * Unfortunately zero-length buffers occur frequently: they seem
> >   to occur whenever a packet uses every available byte in a
> >   buffer, ending precisely at the end of the buffer. When this
> >   happens the NIC seems to generate an extra zero-length
> >   buffer.
> > The fix is for ice_put_rx_mbuf not to flip pages that have a
> > size of 0.
> >
> > This patch applies directly to longterm stable versions 6.18.27
> > and 6.12.86; it also seems relevant for 6.6.137 but would need
> > modifcations for that version. I have not examined earlier
> > versions.
> >
> > Unfortunately there is no upstream commit id for this patch because
> > the ICE driver has undergone a major revision (libeth refactor and
> > pagepool conversion) that eliminated the buggy code. Thus the
> > problem no longer exists in the main line.
> >
> > Cc: stable@vger.kernel.org # 6.6+
> > Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/et=
hernet/intel/ice/ice_txrx.c
> > index 51c459a3e722..081c7a7392b7 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -1215,6 +1215,13 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *=
rx_ring, struct xdp_buff *xdp,
> >               xdp_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frag=
s;
> >
> >       while (idx !=3D ntc) {
> > +             union ice_32b_rx_flex_desc *rx_desc;
> > +             unsigned int size;
> > +
> > +             rx_desc =3D ICE_RX_DESC(rx_ring, idx);
> > +             size =3D le16_to_cpu(rx_desc->wb.pkt_len) &
> > +                    ICE_RX_FLX_DESC_PKT_LEN_M;
> > +
> >               buf =3D &rx_ring->rx_buf[idx];
> >               if (++idx =3D=3D cnt)
> >                       idx =3D 0;
> > @@ -1224,10 +1231,20 @@ static void ice_put_rx_mbuf(struct ice_rx_ring =
*rx_ring, struct xdp_buff *xdp,
> >                * To do this, only adjust pagecnt_bias for fragments up =
to
> >                * the total remaining after the XDP program has run.
> >                */
> > -             if (verdict !=3D ICE_XDP_CONSUMED)
> > -                     ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> > -             else if (i++ <=3D xdp_frags)
> > +             if (verdict !=3D ICE_XDP_CONSUMED) {
> > +                     /* Don't "flip" the page if size is 0: in this ca=
se
> > +                      * the data in the current half will not be used =
so
> > +                      * it's OK to reuse that half. And, since the bia=
s
> > +                      * didn't get decremented for this half, the page=
 can
> > +                      * be returned to the NIC even if the other half =
is
> > +                      * still in use, so flipping the page could cause
> > +                      * live packet data to be overwritten.
> > +                      */
> > +                     if (size !=3D 0)
> > +                             ice_rx_buf_adjust_pg_offset(buf, xdp->fra=
me_sz);
> > +             } else if (i++ <=3D xdp_frags) {
> >                       buf->pagecnt_bias++;
> > +             }
> >
> >               ice_put_rx_buf(rx_ring, buf);
> >       }
> > --
> > 2.43.0
> >
> >
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

Apologies for this non-standard submission. I read the referenced page
before making my submission (and I have just read it again), but I
don't believe this submission can conform to any of the 3 recommended
formats. This is because there is not (and cannot be) an upstream
commit for this bug, since the buggy code has been removed. The patch
only applies to stable past releases (see the commit message).

Any advice you can provide on how to make this patch more conforming
would be most welcome.

-John-

