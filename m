Return-Path: <stable+bounces-215581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sXPMBjyLimk5LwAAu9opvQ
	(envelope-from <stable+bounces-215581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:34:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD26116020
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0054030056FC
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 01:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE06F2609DC;
	Tue, 10 Feb 2026 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2n4Qvnv3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62F2522A1
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770687287; cv=none; b=OYm9rTEIEv945zog92zseBmjgEWZ4Xw3viVtwIpBIfxAsHtrEQiryaBw5Zv6JgoQVvdbWn3q2OetyHsVdp3Tegv3EY/kqEK6FP00PzRaCxzUFdAZ6/SA4NhUc+OJLb7MwsTWD4MpxlgqXbXapMlM29l/sgH2AdCzNLE6nPY+Fj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770687287; c=relaxed/simple;
	bh=T/HCmpcNqFcFD7xZ86y+ZqO8jXnLnbpyYwBENPJl2eI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Cbxo/gY+6gPWfBT9J3h6gc4hgLfaMfrl1/c4+6hi+OV+j7dXn7A3LIcUrlf87DflBYlX3EKdPVXj2JBNC1x4jcwP+m+Bp5neey3NWfxPNfrUnUQ4WNQEWo7uUa13vUjl+g4B/VPmNFzMXS/KqEV2b6+LVrAPvxnlYlCznSvNdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2n4Qvnv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F5BC116C6;
	Tue, 10 Feb 2026 01:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1770687287;
	bh=T/HCmpcNqFcFD7xZ86y+ZqO8jXnLnbpyYwBENPJl2eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2n4Qvnv3dtojiMggwW254KgxnSn9CjO1dUWy3GOSer8V7sbAUuJUTPUZ4qine7txY
	 V0v6T4Ggpk2LSpnLqB0OWN7YCvMGMU4/BzUzjxpvxFWoZLP+xlzPqjvxQstWW9Gw/O
	 Yq/kTGRQ24+XqR4ouSD4ZmCR29P6yO2J3fgcgqNA=
Date: Mon, 9 Feb 2026 17:34:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jason Gunthorpe <jgg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Matthew Brost <matthew.brost@intel.com>, John
 Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-Id: <20260209173446.b76547c4028132f71de1b8eb@linux-foundation.org>
In-Reply-To: <89cb1d4744789702cd80dba8eb40dd50bf053b4e.camel@linux.intel.com>
References: <20260205111028.200506-1-thomas.hellstrom@linux.intel.com>
	<89cb1d4744789702cd80dba8eb40dd50bf053b4e.camel@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215581-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim,linux-foundation.org:email]
X-Rspamd-Queue-Id: 6DD26116020
X-Rspamd-Action: no action

On Mon, 09 Feb 2026 15:47:38 +0100 Thomas Hellstr=F6m <thomas.hellstrom@lin=
ux.intel.com> wrote:

> @Alistair, any chance of an R-B for the below version?

Yes please.

> @Andrew, will this go through the -mm tree or alternaltively an ack for
> merging through drm-xe-fixes?

Either works.  I'll grab a copy.  It you want to take this via drm then
I'll drop the mm.git copy once the drm tree's version appears in linux-next.

Acked-by: Andrew Morton <akpm@linux-foundation.org>

> > The lru_add_drain_all() function requires a short work-item

Pet peeve: s/the foo() function/foo()/g.  It's just as good!

> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4684,7 +4684,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > =A0				unlock_page(vmf->page);
> > =A0				put_page(vmf->page);
> > =A0			} else {
> > -				pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +				pte_unmap(vmf->pte);
> > +				softleaf_entry_wait_on_locked(entry, vmf->ptl);
> > =A0			}
> > =A0		} else if (softleaf_is_hwpoison(entry)) {
> > =A0			ret =3D VM_FAULT_HWPOISON;

So apart from the rename, this is the whole patch.  This got nicer!

