Return-Path: <stable+bounces-245324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBlxLg5NAmpaqQEAu9opvQ
	(envelope-from <stable+bounces-245324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 23:41:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44426516676
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 23:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C9DE3044A6F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E504D98F6;
	Mon, 11 May 2026 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b="bbeDXEiq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB44D90D0
	for <stable@vger.kernel.org>; Mon, 11 May 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535664; cv=pass; b=YWRU0ZpKFSry980riFwu5CTFa+0XzK+EkbgIR8O9Pqih+uFky+v3GDxk/J0FI9ne9swsp1BUCqJXM+leT7XO5VEpV1pGTYzWNBBnZAgg8HI2GIv86pQEjSi8yN+FFVGJa+dRxACC+qI45ivp2cu+oU3lCIfrDh5vk+yeF51t340=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535664; c=relaxed/simple;
	bh=lJB7fD+0kZedYjEQATwAZeKYQRfTKZQy5z9HB8/efo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAthhN2QZ1akTyBHABZAXMoxLM/LFx9fQJU8xkfWRumBvF0YJwvkPnI96rfYE0EuStA2c1LLqi3WmKqa+DMIWSqoacHN7JfQaXTb2tTmO/EfaJSqEjEypHIS2X18sPUg/TvWrekcBKRBDS8ylfq96S6MTyey/GxkyeP2M5LlTK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com; spf=pass smtp.mailfrom=amlalabs.com; dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b=bbeDXEiq; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlalabs.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso4442475e87.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 14:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778535661; cv=none;
        d=google.com; s=arc-20240605;
        b=SYFMyGj3H9fRvopF9UtfHNw/2dKlqnd3BPsgC+bnVReYpLRi/yplYnt99o+4YilUI7
         iKQ6eP28Detm0hGNuvvOtrOqzDaJhXP5l8TMoL5uSyLwiJEH5PvCDjbaVOAvxXHOo+E9
         AULXBlRypmBA+lWOT4jnk+uhUieOXCbiWAfbgWJ7qytbR635eAtqUvJ+KNcfVlzqr6uQ
         CKWDckXpgH1/+qNlSk8qLLkGG5fEy5iONRNrDChQnLwm2gw2q4RBZiY0t0jriXc7S59D
         qDNKUjJn5cyfEE+LGsDpuJAUU/bfH1SoyVpz5IUXg/HY1aznoWD3H0Ha8FVtIKCD6r1C
         pTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nXGS2COif/6iKudvleqhAUyTu2yl4tq3AvaH+a188Uc=;
        fh=Y4/ADlIjQoq85Sk/UleUKAVCpRj1S7KvbxVWaHc+bEs=;
        b=aqlh3d6jw6OKc0uV7FdN8qLmwEf3aqIaD5xPlDmHTZWE7Wy5CaNLASL4DOkAQbfQvU
         URtAKLnHWlNQOEWBiH2GZeFDv0YRTcS1Fg3fN9s9lGERia+JEHxOOxXB8D9OB0INPHmu
         ls5q8sKdZ3OPNvOCa6Pb00dMXT57QGiNjP2+vVW607MWs8anO/TPBslszXpObf/e/sR8
         mprcQC41rgOHpgKCOwGr3YHcfl/z1imXm0G/F4YSOKsutFRUZrKhMqcwRBzFsHiv9olm
         2xvop+yjE+DhXp024X+6hJaJPCSAWA+E6nZxvevoLK/nI5ZpIF+Vqt6i9Rc3SABI4qUZ
         5saQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amlalabs-com.20251104.gappssmtp.com; s=20251104; t=1778535661; x=1779140461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXGS2COif/6iKudvleqhAUyTu2yl4tq3AvaH+a188Uc=;
        b=bbeDXEiqpgCqQJGd97RlznsW78jwumAm0D2BKDVL40U6q7DyONTcSZo8/Q1xHnYHS4
         m4eqe9NuUgNH0QEI03OtW3utB/pfFP+2946Zo9b67X1XIZDfUi9fe7hzI0yqt7IIDTdW
         cHXsbFYX4HHMGLOOQBYXZk09Bfb8wd0PnAyuj18GDRChfb8RCKM+gpknA4nd6GA2KprX
         wvPVmMMysntHRYVIXaBcmvNDfuhzUAUJr4cCCtRNiJ30zCUGNy29CFGWxUx1m0BJLmvL
         wQTAuTMnQ1o6MuN1MmLOTDG60ol2f8n2pqubIwat993JXzcHbL7YNaf/3RIAo421NM1S
         O3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535661; x=1779140461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXGS2COif/6iKudvleqhAUyTu2yl4tq3AvaH+a188Uc=;
        b=qAEMRS88MtciqpfEpyjRNx+adhkGzJDOBOgaFkwvgjB3OeuxjSaoeviuOvL37IxAt2
         5pQ60yKpLup4hRQl0tcdCnyaKjIQQSfU9mG1Mom6t7ss7QtVDjrXYnyq6+68yaUPWeMz
         zku+/Y1YP16f103fuo5MivYjCtofk958jJHKg7VI7Q8qSpi0l0zALrUbhvITWPHW7O/S
         RYXl8BtELfMLC9Ch6tEK7TKt3AGNIy8TpIoeSUwXCEHqHpl3qhVqnBFXzvKvdD/8Z8+k
         mGSdoLavQQhvdgDamYkxX9nTie/54Ph7IIJBFXHBfDnFRnYg6zkowL5YK/RIr5hU1gJM
         MUaA==
X-Forwarded-Encrypted: i=1; AFNElJ8ushUWfNm++/1gXwVjwh8G3H+KXAqWIMU+gOTCFH54kDBQSwno2CYWOZVL9boRjX/um2gyYsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGojaRIvyVLhklNLbOtVTaED2uYKa4W1qWdrmWaxPlzuo9rM4
	D3aZKvmAv28cIZXeGCViJ40BuR9Jha1jBsgBcs6K19eoJwXmNgObC9GvskuHA9RkQuA6wK5d8Up
	DHBjG/dD0vHBVbd6kqVetLJLDlQQd66w2JibZmczuFU0=
X-Gm-Gg: Acq92OGY7M2J8RivcEzxIZHNgaB/FM9lO/z3/+i1HCBBl0+0ixHGMpnmIS6uNDrmdW9
	dLHGmB1gjxca+hGYGuruQzZY5Ikr2zLdL//DZePqfBvzbbxva0i6vypUz9hSJuwLaB02tkMC6d/
	tJE8g1WQnMcgiPBSYVRjAWsYcfoapGkRVd4+3WzfWyZWLubsDBwKCzRYiUI+170cXaeDtpVNY68
	cNMbZTwSL1nYc9TO8NzENVoV4oftX4LT9LGrkJqpCBsCa1DlmCgkpVNts/0bvZc//THrUyvVH+a
	vg7h8eWOnjzs7zLzmeJA9bH9lnTc7EWIM6BeUg==
X-Received: by 2002:a05:6512:acf:b0:5a3:eb4b:37a7 with SMTP id
 2adb3069b0e04-5a8b6c9c525mr2973242e87.6.1778535660345; Mon, 11 May 2026
 14:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501233933.2614302-1-souvik@amlalabs.com> <a708a295-9d80-4538-9d12-53c12820f9ed@kernel.org>
 <af4SR5-QwUCAClR8@nvdebian.thelocal>
In-Reply-To: <af4SR5-QwUCAClR8@nvdebian.thelocal>
From: Souvik Banerjee <souvik@amlalabs.com>
Date: Mon, 11 May 2026 14:40:48 -0700
X-Gm-Features: AVHnY4IWwwENmh7P5b_KrrZMmOGLtrgr6q2JnnDVvjY__BAFZLDH8ZYDhGP0lUc
Message-ID: <CANCY+o6T8eSnkw_mETH=kd9JDxp9tguHWnaU7L6Bp-sJMpniSw@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: check for empty/zero entries before calling pfn_to_page()
To: Alistair Popple <apopple@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, dan.j.williams@intel.com, willy@infradead.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 44426516676
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amlalabs-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[amlalabs.com];
	TAGGED_FROM(0.00)[bounces-245324-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amlalabs-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[souvik@amlalabs.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amlalabs.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,amlalabs-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Thanks for the review, will send a v2 with this feedback.


Souvik Banerjee


On Fri, May 8, 2026 at 9:44=E2=80=AFAM Alistair Popple <apopple@nvidia.com>=
 wrote:
>
> On 2026-05-08 at 19:15 +1000, "David Hildenbrand (Arm)" <david@kernel.org=
> wrote...
> > On 5/2/26 01:39, Souvik Banerjee wrote:
> > > Commit 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
> > > added zero/empty-entry early returns to dax_associate_entry() and
> > > dax_disassociate_entry(), but placed them *after* the
> > > `struct folio *folio =3D dax_to_folio(entry);` line.  dax_to_folio()
> > > expands to page_folio(pfn_to_page(dax_to_pfn(entry))), and page_folio=
()
> > > performs READ_ONCE(page->compound_head) -- a real dereference of the
> > > struct page pointer derived from a bogus PFN extracted from the
> > > empty/zero XA value.
> > >
> > > On systems where vmemmap covers all of RAM that dereference reads
> > > garbage and is harmless: the early return then discards the result.
> > > On virtio-pmem with altmap (vmemmap stored inside the device), only
> > > the real device PFN range is mapped, so the dereference triggers a
> > > kernel paging fault from the truncate / invalidate path and from the
> > > PMD-downgrade branch of dax_iomap_pte_fault when an entry is being
> > > freed:
> > >
> > >   Unable to handle kernel paging request at
> > >   virtual address ffff_fdff_bf00_0008 (vmemmap region)
> > >   Call trace:
> > >    dax_disassociate_entry.isra.0+0x20/0x50
> > >    dax_iomap_pte_fault
> > >    dax_iomap_fault
> > >    erofs_dax_fault
> > >
> > > Close the residual gap by moving the dax_to_folio() call after the
> > > zero/empty guard in dax_disassociate_entry().  Apply the same
> > > treatment to dax_busy_page(), which has the identical pattern but
> > > was not touched by the prior fix.
> > >
> > > Fixes: 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
> > > Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
> > > Cc: stable@vger.kernel.org # v6.15+
> > > Cc: Alistair Popple <apopple@nvidia.com>
>
> Thanks for fixing this.
>
> > > Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
> > > ---
> > >  fs/dax.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index 6d175cd47a99..6878473265bb 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -505,21 +505,23 @@ static void dax_associate_entry(void *entry, st=
ruct address_space *mapping,
> > >  static void dax_disassociate_entry(void *entry, struct address_space=
 *mapping,
> > >                             bool trunc)
> > >  {
> > > -   struct folio *folio =3D dax_to_folio(entry);
> > > +   struct folio *folio;
> > >
> > >     if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
> > >             return;
> > >
> > > +   folio =3D dax_to_folio(entry);
> > >     dax_folio_put(folio);
> > >  }
> > >
> > >  static struct page *dax_busy_page(void *entry)
> > >  {
> > > -   struct folio *folio =3D dax_to_folio(entry);
> > > +   struct folio *folio;
> > >
> > >     if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
> > >             return NULL;
> > >
> > > +   folio =3D dax_to_folio(entry);
> > >     if (folio_ref_count(folio) - folio_mapcount(folio))
> > >             return &folio->page;
> > >     else
> >
> > Makes perfect sense to me.
> >
> >
> > What about the usage in dax_associate_entry()?
>
> Pretty sure the issue exists there as well given this code path implies w=
e could
> pass zero/empty entries there as well:
>
>         if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entr=
y)) {
>                 void *old;
>
>                 dax_disassociate_entry(entry, mapping, false);
>                 dax_associate_entry(new_entry, mapping, vmf->vma,
>                                         vmf->address, shared);
>
>  - Alistair
>
> > --
> > Cheers,
> >
> > David

