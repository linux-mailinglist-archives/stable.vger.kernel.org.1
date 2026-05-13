Return-Path: <stable+bounces-247035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFgkDuDjBGoNQQIAu9opvQ
	(envelope-from <stable+bounces-247035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 22:49:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9183453AAC4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 22:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18EBB30160CD
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD3379C3A;
	Wed, 13 May 2026 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDqtsTh9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2D379C40
	for <stable@vger.kernel.org>; Wed, 13 May 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705372; cv=none; b=SidzytVxjhfyc+Nab6BpAUsDXzOm0K8mbuX8JWkaohlxrxEVBuGOB5sBk5sWCX8r7/kWcJwyf5jBbfd7QUTMvTu7HUg1KG9/g9PFu+kzBmy2/I5cXB/XzQ8ey0ccQYyIiCStN21DlXAuBmSAs2rGQtItCoMGC49Gf+FiW4xZ+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705372; c=relaxed/simple;
	bh=vWDazQqAcKBnFf1dXtRdFaGVZplM0TcqpZ8RHyVdXCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGzaWmKwcjhc+xZJwKChMkOf5aQtRUl0oQ89j8NAgGVlTfdCMObC3dxZTNrDUcyHtXO/sjZEmBnZ9D9tH+9hRtLl3H3F4Yn0lekmSmE2xK/OLVm3CzmRJGt1gDo9GCaHmg79KHQ5Uj/ilOGr5nBEnLcErUpWORwe6RAnUVgm3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDqtsTh9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so66096785e9.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778705369; x=1779310169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EFeUCJZ+e7oYft3CAl+mqM5ysnAj3IowuzFODN/+G8=;
        b=qDqtsTh9b1blEETpVYLVgKyc3Q62sFFEhZqbvn+7IuNGy6YaUIOm1+xxPMcO6OhrPW
         O280hNEt/4DzDfQn4BzNWHwwchQ4Xl16JYK1jj1G8BDYIbpG+hK6CkxENFXD4q+HKQo8
         KSx6x1gosj3+C6GzWkKI7sHBss1xAuYgoSH+vFt5oGj1mcba5SCHVx+MOQCMYsSsm2VX
         nfZ0+FwKRBIvhjoUQ6F5iNru1RRszSKcXYjakxwfz2GneFbF4meA+bJYWHMWvy2xe0ui
         nDsiE9pSUL9f9KWJj7eikZaW3UioZTiMRTrV7qVYPsD+yAxpmH8oi+QkCg04/wETruP6
         Kt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778705369; x=1779310169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EFeUCJZ+e7oYft3CAl+mqM5ysnAj3IowuzFODN/+G8=;
        b=X0stL27+NThXssZXCo2Aw7Y4AeuEyydL8WBn/pxRBnSNSPjWkMhOm+zgEYoKjwg0pE
         srTK/UhquewNuaxUGesQMSsq3Msrdx91kyVTtuxZcKUcIY2cyvKOvjbXbf0YMAsQGoYn
         wD+ospu0DhgZdlNIywZbujnxywBszX3fG7fABXBBBt3EB3SCJBS6aosbh7UwINCyzMbk
         fknu0XMJTiveU7Fou3eH91mENWjsO22nOFd5lVD8vCsQfD8qJSzmefr0FNunj7QRGWg8
         WB9bnagf+/7K6rTWJsBKSJquxbWnYVgHSut50Ht9CCD4BHEpJQjHkc5ymIhlFGYCPWmW
         o8kA==
X-Gm-Message-State: AOJu0YxYycm1Oyq6f7t0Cm/0O48YIUUStkgTukfXXPS+KO1BZClrW0xl
	4gkm9mf9FbIt1CiCP4q7giu3PJ7K2BFpWdrNs/6iD00yiwR5Uwi9glYMCJa+sXb1
X-Gm-Gg: Acq92OHbJK6ORUvv5PDTYEkcGJNsRWOTVwis8H140w/oEeHKpJJj3jfvDGV2XEwQJEa
	4Z7gbUHoZufhLPzWI4ld04dGw1SlFGnji+IlHLhN0ihkq+O0oaXHEiKDSODkgn1TFb2aGlJEtbX
	TSu9VbeV20U3G9vf/BgC4EjteA3JaSjHa69T0zwMcgijHdMpYQjqCn1M+7y3I1DxqJyI2JbZsyL
	HkLJ0Z4crZ2gtYbu7yDvyoRrmvRswE5mmTR4OqSo+rToD+GTDdZquH0SrPNfe8rwb10kRLkHbiX
	gnZCyGdz/O8Cw1toVeWqXuT2EQT1t58bVMPer6Ti4CkAxdR+S+m9p6pPcv4+qVqH+iEbMdglYFo
	Lh1nhzY1eesw6v0dXbWK4oqhJXInAemVGFqswKrlXOXdIfbZwigF5QMGfiVXCPm7b03IwhdC7fW
	1nkk74x9qhfaklGgLR+68x4nI+gBXQhkjb7I1KU49/NPv4qJqQSfwCqRNZTZC1WX0G3mMLjN0=
X-Received: by 2002:a05:600c:3328:b0:48f:da34:ec4e with SMTP id 5b1f17b1804b1-48fda34edb0mr3327735e9.19.1778705369088;
        Wed, 13 May 2026 13:49:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm1476103f8f.16.2026.05.13.13.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:49:28 -0700 (PDT)
Date: Wed, 13 May 2026 21:49:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: stable@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 netdev@vger.kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH net v3] ice: fix packet corruption due to extraneous
 page flip
Message-ID: <20260513214927.17a8dd45@pumpkin>
In-Reply-To: <CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
References: <20260512181953.1689-1-ouster@cs.stanford.edu>
	<20260513100732.499e3f49@pumpkin>
	<CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9183453AAC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247035-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 09:28:40 -0700
John Ousterhout <ouster@cs.stanford.edu> wrote:

> On Wed, May 13, 2026 at 2:07=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 12 May 2026 11:19:53 -0700
> > John Ousterhout <ouster@cs.stanford.edu> wrote:
> > =20
> > > Consider the following sequence of events:
> > > * The bottom half of a buffer page is filled with data from
> > >   packet A. The page has a net reference count (reference count
> > >   - bias) of 1. The page is returned to the NIC, flipped to
> > >   use the top half.
> > > * Before the reference on the page is released, the NIC returns
> > >   the page with no data in it ('size' is zero in ice_clean_rx_irq).
> > >   In this case the bias does not get decremented. The page still
> > >   has a net reference count of 1, so it gets returned to the NIC.
> > >   However, ice_put_rx_mbuf flipped the page so that the bottom
> > >   half is active.
> > > * If the NIC stores another packet in the page before packet A
> > >   has released its reference, the data in packet A will be
> > >   overwritten with data from the new packet.
> > > * Unfortunately zero-length buffers occur frequently: they seem
> > >   to occur whenever a packet uses every available byte in a
> > >   buffer, ending precisely at the end of the buffer. When this
> > >   happens the NIC seems to generate an extra zero-length
> > >   buffer.
> > > The fix is for ice_put_rx_mbuf not to flip pages that have a
> > > size of 0. =20
> >
> > How is this different from packet B (in the top half) being
> > freed before packet A (in the bottom half)? =20
>=20
> I'm not sure exactly what you're referring to here. Are you asking
> about a situation where both halves of the page get filled with packet
> data and then the second half to be filled is the first to be freed? I
> believe that the ICE driver abandons a page if both halves are ever
> occupied simultaneously; the page will be returned to the system once
> both halves have dropped their references. Thus it doesn't matter
> which half is freed first.

That is what I was thinking, seems like the logic is over complicated.

If you need to put 4k pages into some kind of iommu rather than 2k buffers
(to contain 1536 byte ethernet packets) then I'd have thought you'd
initially put both halves into adjacent tx ring entries.
If a rx buffer is discarded (eg a zero length fragment or a CRC error,
or even 'copy break' for short packets) then, as an optimisation,
you could reuse the buffer for another receive.
The same could be done if the page is freed by an application.

However it sounds like it doesn't use the 2nd half until the first
completes - otherwise you'd never 'flip' to make the other half
active.

Thinks...
By only putting half of each 4k 'page' into the rx ring the code
will usually save (expensive) iommu setup in the (probably) normal
case where the buffers are freed 'reasonably quickly'.
But that really requires a 'free/with_nic/busy' state for each half
rather then trying to guess from a reference count.

But if the low-level code is recycling the rx buffer (for any reason)
it wants to use the same buffer.

The ethernet driver I wrote (a long time ago, early 90s) allocated
64k as 128 512byte buffers and did an aligned word-sized copy of
every receive frame - most frames were in contiguous memory.
The simplicity of it made up for the cost of the copy, especially
since that was an iommu system.=20

-- David

