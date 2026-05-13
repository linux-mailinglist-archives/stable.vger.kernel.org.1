Return-Path: <stable+bounces-246933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBUkCrOqBGoxMwIAu9opvQ
	(envelope-from <stable+bounces-246933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:45:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2360A537598
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D633300A59D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8E04C77D0;
	Wed, 13 May 2026 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ewR8W9/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCF478E5D
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689760; cv=none; b=jdleZ1W8TIG0HlrSNY/FlLHQ1zH3wLH6HiCMjJlqlMp6z/CFqCgrXig9Lwhe1BZ/k6nrrDtouHMFEOcfPn6kGb/QTl/7tLBIb8KKOjBzRdPRQD7DJwgBaV43H1iWLv3W8A/992yCfoMJXqKcAwZhiYjdD8VxPdFAGkXm+1gU1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689760; c=relaxed/simple;
	bh=7HfOKcYK4ju8sB2Adcy0gnbPOJmgaQdG7glxmghENQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdnnmZvKdn59aIGFCMxiEKD6q4s4yIW5VB3WiV2TfTXf+rwbYZcfiNYwT4FYV1ipSZxDLFQzOaHtmrraMAjy01dS3nFcIRQWG+XESs3p5v7vLsk8ZzlHDndZ7rKv3RcMlSIyLnCnmVwYpYdOOKdSh523OVzGg0Zz7HY569ADQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ewR8W9/j; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5FtOVnaoO8IXFmp5lDf5sDTst4cyyBiOa0tvjhoezPU=; t=1778689759; x=1779553759; 
	b=ewR8W9/jry2y1LekXQCRKZu3asS5muNTorVz2OL0aJi60CuQSAGrwVsEbo0bH7OUAiSgMEwTYD9
	2u2y2yQraQOtc8ZTa/AC4LUspgZDe04LNSsTpGIwtPHy60CLf8x30gUxA6/qnPCZkavbxAYACgA0N
	C9ArrHzqkOe9d1TR7FmEoAYDARZuDUwKCVGYxppzec/fTFCKCd/Z7EagT4Ay8rA5zHSOgKNARmEX0
	xY3W8R/MFTkYKRq9d2ws/xiQI0g5iRGLeaMD+qIZqqZKW53GJsy+3s76HOqvPNpLeiVa5rSBDGvTm
	nxr/U/slr47LG5GMpU3Q5E5QONCY3Zr5QnKQ==;
Received: from mail-yx1-f50.google.com ([74.125.224.50]:53615)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wNCST-0006sT-Ho
	for stable@vger.kernel.org; Wed, 13 May 2026 09:29:18 -0700
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-656d749109cso4248442d50.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 09:29:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywl9HJaZp2O7z0MaGsh7nDoBIhsjOJ4J3x8hkgKpdbkDfez2Twt
	CyD81UyXUtwioh2jX6Slina2ef1HhAUX0+GyGUQfeGfwuxlIUPCnAI88g5leo71kiKCpdsKKWs7
	rmVWWGqY9zJ/d7pzKLYPRQOFoNuvBiTE=
X-Received: by 2002:a05:690c:60c6:b0:7bd:5d03:dc1a with SMTP id
 00721157ae682-7c6a954fad6mr44092477b3.1.1778689756808; Wed, 13 May 2026
 09:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512181953.1689-1-ouster@cs.stanford.edu> <20260513100732.499e3f49@pumpkin>
In-Reply-To: <20260513100732.499e3f49@pumpkin>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 13 May 2026 09:28:40 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lm2yYOsEJarawjPo42XO3-WqkedBSuMJJbyx4NEOx-DSHJjl5-RqEAsvo
Message-ID: <CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
Subject: Re: [PATCH net v3] ice: fix packet corruption due to extraneous page flip
To: David Laight <david.laight.linux@gmail.com>
Cc: stable@vger.kernel.org, anthony.l.nguyen@intel.com, 
	intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com, 
	netdev@vger.kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 5d5bd4b8133540f30bea22ef470d169d
X-Rspamd-Queue-Id: 2360A537598
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246933-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.871];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,stanford.edu:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 2:07=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 12 May 2026 11:19:53 -0700
> John Ousterhout <ouster@cs.stanford.edu> wrote:
>
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
>
> How is this different from packet B (in the top half) being
> freed before packet A (in the bottom half)?

I'm not sure exactly what you're referring to here. Are you asking
about a situation where both halves of the page get filled with packet
data and then the second half to be filled is the first to be freed? I
believe that the ICE driver abandons a page if both halves are ever
occupied simultaneously; the page will be returned to the system once
both halves have dropped their references. Thus it doesn't matter
which half is freed first.

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
> > Cc: stable@vger.kernel.org # 6.12+
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
>
> Looks like you only need to calculate 'size' for the !ICE_XDP_CONSUMED pa=
th.
> You could also use the (likely cheaper) test for zero:
>                 if (!(rx_desc->wb.pkt_len & cpu_to_le16(ICE_RX_FLX_DESC_P=
KT_LEN_M))
>
> -- David
>
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
>

