Return-Path: <stable+bounces-147962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53431AC6A41
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09413B99F9
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3002857D2;
	Wed, 28 May 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olyCyipN"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FD2459EA;
	Wed, 28 May 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438560; cv=none; b=LgbghBUxbifSN4X5xMBQyYwKNgYYq4a44CXiapqxdQcQvUlrbOQ/mt9K7kpRdhj5qmbagwSpSYv3E/NSgwEnHcJOYkVhV1obfsJTP1FOHvFMWnsBh6O4H0oDaiPomTOujFzlztyDwZ7PUZiGtNOTTLJOygx2Buu+FNRuw70tvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438560; c=relaxed/simple;
	bh=4Pn5+IaraLwfB51pd3e88aEPpbE+Xpl78G5c8jBouU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHylBcd0YOKReQAuRbqgKDc273u0stNHCMsGXm16lu1HMUkYiKiZuqQMOqyhcIhmkIjzmdielYlQmy+JbYQWBoCkoXe5uFIKd3znp1/d5YD5QvD1O6PyQkng5Q7ULFkV6i0LrtOU5PcvZNmvs0C6h+Djj7LNXVwaIQ0yozeropI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=olyCyipN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EKajYrvbUK7K9eBj0BAcVo9PVCzIMkEs/jt3hskWVO0=; b=olyCyipNVyN0DI1Kq+4tOKvnyO
	GlVT+ibtDB4n4Emex6vrP2lhgZaTRQGDL1Yg+x+otaG+Pvcwrj/m+g+lI7G/FzyfvF5nTZBTXlDra
	wWFwjz5etn3iUWbLyZLSxpmZ8CFOAAmCx7MDmXDeZjCh/DUGpvIkNEPaCOQd1zYqEuVnWCyydm7Wz
	QemXA26cgxJF3RLRoKgR9q9FOAfdYsu/s9d3KmRAO4QjqPDCOnXx/Lts7JxoemlalYqJolw0QWsjp
	EWm1gzPRGFO9wW/knkhvImSIuEYVRoMcwqF21JkBPZSEUuy2/31KZtVAyJ//4wxYh9IuJaUF1+jlM
	/4ulWODw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKGjp-0000000Dfve-48jJ;
	Wed, 28 May 2025 13:22:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 09B7F300263; Wed, 28 May 2025 15:22:32 +0200 (CEST)
Date: Wed, 28 May 2025 15:22:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Message-ID: <20250528132231.GB39944@noisy.programming.kicks-ass.net>
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
 <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
 <044f0048-95bb-4822-978e-a23528f3891f@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <044f0048-95bb-4822-978e-a23528f3891f@suse.com>

On Wed, May 28, 2025 at 03:19:24PM +0200, J=FCrgen Gro=DF wrote:
> On 28.05.25 15:10, Peter Zijlstra wrote:
> > On Wed, May 28, 2025 at 02:35:57PM +0200, Juergen Gross wrote:
> > > When allocating memory pages for kernel ITS thunks, make them read-on=
ly
> > > after having written the last thunk.
> > >=20
> > > This will be needed when X86_FEATURE_PSE isn't available, as the thunk
> > > memory will have PAGE_KERNEL_EXEC protection, which is including the
> > > write permission.
> > >=20
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 5185e7f9f3bd ("x86/module: enable ROX caches for module text o=
n 64 bit")
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > ---
> > >   arch/x86/kernel/alternative.c | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > >=20
> > > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternat=
ive.c
> > > index ecfe7b497cad..bd974a0ac88a 100644
> > > --- a/arch/x86/kernel/alternative.c
> > > +++ b/arch/x86/kernel/alternative.c
> > > @@ -217,6 +217,15 @@ static void *its_alloc(void)
> > >   	return no_free_ptr(page);
> > >   }
> > > +static void its_set_kernel_ro(void *addr)
> > > +{
> > > +#ifdef CONFIG_MODULES
> > > +	if (its_mod)
> > > +		return;
> > > +#endif
> > > +	execmem_restore_rox(addr, PAGE_SIZE);
> > > +}
> > > +
> > >   static void *its_allocate_thunk(int reg)
> > >   {
> > >   	int size =3D 3 + (reg / 8);
> > > @@ -234,6 +243,8 @@ static void *its_allocate_thunk(int reg)
> > >   #endif
> > >   	if (!its_page || (its_offset + size - 1) >=3D PAGE_SIZE) {
> > > +		if (its_page)
> > > +			its_set_kernel_ro(its_page);
> > >   		its_page =3D its_alloc();
> > >   		if (!its_page) {
> > >   			pr_err("ITS page allocation failed\n");
> > > @@ -2338,6 +2349,11 @@ void __init alternative_instructions(void)
> > >   	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
> > >   	apply_returns(__return_sites, __return_sites_end);
> > > +	/* Make potential last thunk page read-only. */
> > > +	if (its_page)
> > > +		its_set_kernel_ro(its_page);
> > > +	its_page =3D NULL;
> > > +
> > >   	/*
> > >   	 * Adjust all CALL instructions to point to func()-10, including
> > >   	 * those in .altinstr_replacement.
> >=20
> > No, this is all sorts of wrong. Execmem API should ensure this.
>=20
> You are aware that this patch is basically mirroring the work which is
> already done for modules in alternative.c?

I am having trouble parsing that -- where does alternative.c do this to
modules?

