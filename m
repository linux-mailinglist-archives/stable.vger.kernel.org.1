Return-Path: <stable+bounces-197978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DBBC98B20
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 19:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FFB3A25AA
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 18:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A8333452;
	Mon,  1 Dec 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NZRhtdf8"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6E331211;
	Mon,  1 Dec 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613193; cv=none; b=pcxBT9Ml/fRkEoW5ttMl1jrtT9bShL3s5N+YxhFiYHr22EXy9hBTa+2RamUaWAkRzr8Kg+Omd5S1uzh0pRCSncGhmNI/qAIu5wVjH8SWZcqeehsBTH2+LKK2Yj/gipq5Z6mUzwgatmvcPPK6I8eD+K/rP4zm2shcNw9EONo+k5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613193; c=relaxed/simple;
	bh=C6dIkzgWuN6EImWVi9Zmuvxi/2rf42KnOHj0IUYuFuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghfo9URZJDtyKTCtfVTQEZYrlUiBAO8kNKKpTTBCFJrJ/2OUOs+4MyXGiPbrCU194LPSPXIV8iScCWnGA2PjCcIQS8KhNKTz0SvQK7HFFeikQoJm1h5UJKCgRs+DIRxIeqfI3o44bwn/3oyOuzWA+jc/1fm2gOW4g/B77E2Cgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NZRhtdf8 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B51040E01A5;
	Mon,  1 Dec 2025 18:19:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H2gZ1m0bTXMR; Mon,  1 Dec 2025 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764613179; bh=4DcHPWiiSKpGRCFQVRmvaJzipjwrM5wefbrGJC3lGdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZRhtdf8D9Ve3n8Cx3Xlj7WAEWfsxdGGabvw9dycQQc58L8/nhT18s2eKURuMexe6
	 Ln8IY13PuSh4l8drinpcZ8GDUPWMQCGFiubKdBZOarggKZtZ/KYtZK+s8jYzh8GyE1
	 X6CAEU3tCl9dyeIVOKelNP7Ar8ltxchkY2zBr/bbqCKkRf/jlqSxOHKKYsUy2UiouH
	 HtjwU+W8quB+qVRDaG9B9N+acPYsELGinGMSJEV1qav36x0TRBZk3gCj178RRDWE75
	 EDIlzmO03EjdgEkLCc1meSDe61R+mPSQhGh5IRWETu5BX7xvOOE7lZrMMP2M9ySwVm
	 Yw6SV24Cn/sqa5tW9VbuYTiq/jEe0CQ9lllg8bhXHWllZivVmMhoUvlNbguRSM0qfY
	 uTju667OGbviolpJQtU699FZle6+izsQRWC2r+vbf5bdjcYtBfkiqmsltdThVNVL7z
	 Lv+pcsZe+wAuDiNzrAZoJxD+97xHKbhKa4gWSVksarDwkTlcnvbJ7XiK7m1V/Vgkvg
	 aiqH9C0LPgGhIwdiMbUJh44kYsoFtySGDPpG1uaULs958zzzeKwvTjcnBlLL+1V67X
	 W3QaynSLvBr9JX7n4aQOacsIDSeJWnlCPgYGqIv4BzCzFEwWjnQox0F/Mo9vKLFRtG
	 bBp2zzeSXWqKOdSlhWjLrhHk=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 498BF40E022E;
	Mon,  1 Dec 2025 18:19:17 +0000 (UTC)
Date: Mon, 1 Dec 2025 19:19:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: henry.willard@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Jiri Bohac <jbohac@suse.cz>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Jonathan McDowell <noodles@fb.com>, linux-kernel@vger.kernel.org,
	yifei.l.liu@oracle.com, stable@vger.kernel.org,
	Paul Webb <paul.x.webb@oracle.com>
Subject: Re: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
Message-ID: <20251201181909.GCaS3cHcsBjmYblRHG@fat_crate.local>
References: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
 <20251201092020.88628d787ac7e66dd3c31a15@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251201092020.88628d787ac7e66dd3c31a15@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 09:20:20AM -0800, Andrew Morton wrote:
> On Wed, 12 Nov 2025 11:30:02 -0800 Harshit Mogalapalli <harshit.m.mogal=
apalli@oracle.com> wrote:
>=20
> > When the second-stage kernel is booted via kexec with a limiting comm=
and
> > line such as "mem=3D<size>", the physical range that contains the car=
ried
> > over IMA measurement list may fall outside the truncated RAM leading =
to
> > a kernel panic.
> >=20
> >     BUG: unable to handle page fault for address: ffff97793ff47000
> >     RIP: ima_restore_measurement_list+0xdc/0x45a
> >     #PF: error_code(0x0000) =E2=80=93 not-present page
> >=20
> > Other architectures already validate the range with page_is_ram(), as
> > done in commit: cbf9c4b9617b ("of: check previous kernel's
> > ima-kexec-buffer against memory bounds") do a similar check on x86.

Then why isn't there a ima_validate_range() function there which everyone
calls instead of the same check being replicated everywhere?

> > Cc: stable@vger.kernel.org
> > Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on=
 kexec")
>=20
> That was via the x86 tree so I assume the x86 team (Boris?) will be
> processing this patch.

Yeah, it is on my to-deal-with-after-the-merge-window pile.

But since you've forced my hand... :-P

> I'll put it into mm.git's mm-hotfixes branch for now, to get a bit of
> testing and to generally track its progress.
>=20
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -439,9 +439,23 @@ int __init ima_free_kexec_buffer(void)
> > =20
> >  int __init ima_get_kexec_buffer(void **addr, size_t *size)
> >  {
> > +	unsigned long start_pfn, end_pfn;
> > +
> >  	if (!ima_kexec_buffer_size)
> >  		return -ENOENT;
> > =20
> > +	/*
> > +	 * Calculate the PFNs for the buffer and ensure
> > +	 * they are with in addressable memory.
>=20
> "within" ;)
>=20
> > +	 */
> > +	start_pfn =3D PFN_DOWN(ima_kexec_buffer_phys);
> > +	end_pfn =3D PFN_DOWN(ima_kexec_buffer_phys + ima_kexec_buffer_size =
- 1);
> > +	if (!pfn_range_is_mapped(start_pfn, end_pfn)) {
> > +		pr_warn("IMA buffer at 0x%llx, size =3D 0x%zx beyond memory\n",

This error message needs to be made a lot more user-friendly.

And pls do a generic helper as suggested above which ima code calls.

And by looking at the diff, there are two ima_get_kexec_buffer() function=
s in
the tree which could use some unification too ontop.

Right?

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

