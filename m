Return-Path: <stable+bounces-83219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A84F996C6F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B412AB220C3
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525041990CD;
	Wed,  9 Oct 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XxG1D3iI"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7DBCA5B;
	Wed,  9 Oct 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481354; cv=none; b=H5xBBFAf1st2MxtkvgPHX1sthkk1QxrxCLZFnk1HF5iN27yigvM63D930i87S2JrOsVPbuEJZb0j5khgboKSkueUUWkVB8vLIRSdPQ+MeduJz459jeQYwuxb4FfCoC/D7S7B6DjyBonKN2AnIvZPLxoDIAR7UEZ5jHnGj036Dzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481354; c=relaxed/simple;
	bh=fx0Mp8rbRWNM2WhXz9q3fVJkUUyUBrTj15kEVqt07po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeQYS/XmAnDOwWjl/aYEBJh7Jbyd0XWQOEjoHnn3yOD2Buz4y64oEpCqQpshdiz/Ls7CtNrZ4WDK85pF7XGcn3jsJJboVdS6kVpBFOz3vsv31QM50ws6lqVQvRsP8/IlaIwJa8/WZzFcpL4MaQbXzwCXGB88xH8wHij/8Wx0/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XxG1D3iI reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 28F9540E021E;
	Wed,  9 Oct 2024 13:42:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LiEmuf-hL5hq; Wed,  9 Oct 2024 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728481343; bh=Q5rU6AZIyEerx2G9HImeh6tXvj76r3VtsfVrSX9a8OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxG1D3iIBKNCeWbyu8zK+3+dMIP3DRw9EQB8IahcEtSTtxLQFxeGW0C8R+5aCBZOo
	 9wtxVZL2BDa1qrD8MRnOhO5IOIDztXDGzSGZtO+EWx1TNPkBHu7OYKocNV96RJIWHk
	 qk2Vb6DM6NUYE5wKoU+452taOLoqjJrBaEaY90WAZKmQgVrPYYA14oOBSsbn8A1LYb
	 JNH1NTkmkbVRcz/3FGCph3MA+4LK0fov/WXNlVBBG2Tu0emEgVJ+YOihJT4o+OI/pz
	 RsobMFp2E5fOaly4X+jv+rFz/m5BXYuc/8aSo8ZEnORcM+hXurMZ5gLE+pQqMVP0nc
	 bx0WTHk4deNEYSGygekX239jVPuy7rFgRwpmpPSLwC7ss5YHKI7VtR7gk82yx8Wk9J
	 4GFWW8OIHD+z3vI9+Xjw4+k6C1YRPfdY5BV+No6qymYvzbzuZKYosrBLlPhdiTMN4U
	 zMoeuMddobH4DypO9CBMz//FTSIIyLcJT7ed0pOqxTAmEU0NtDGMhbM2Ua4blzCtwk
	 PZjvB7lW3cJHcjkMWhGPaSgo/5PX30Hf89DZfOnd6phvw60NjBk4RgljFuVMGZeKh8
	 qTj2G/vXN4c74dOJr0Xr4RAD1SIK0u31z3569AVcpsS4B9ylQ+Me9wcnHHc9SoNnfG
	 mtfQNNitzZs4iBBVgF7X86kA=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FA5540E0163;
	Wed,  9 Oct 2024 13:42:11 +0000 (UTC)
Date: Wed, 9 Oct 2024 15:42:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Robert Gill <rtgill82@gmail.com>,
	stable@vger.kernel.org, #@tip-bot2.tec.linutronix.de,
	5.10+@tip-bot2.tec.linutronix.de,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/bugs: Use code segment selector for VERW
 operand
Message-ID: <20241009134205.GJZwaILf_bDcWuht-k@fat_crate.local>
References: <172842753652.1442.15253433006014560776.tip-bot2@tip-bot2>
 <20241009061102.GBZwYediMceBEfSEFo@fat_crate.local>
 <20241009073437.GG17263@noisy.programming.kicks-ass.net>
 <20241009093257.GDZwZNyfIjw0lTZJqL@fat_crate.local>
 <efa42b69-13ba-40ed-99e2-431220d7dcb3@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efa42b69-13ba-40ed-99e2-431220d7dcb3@citrix.com>
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:24:19AM +0100, Andrew Cooper wrote:
> I'll bite.=C2=A0 Why do you think this form is is better?

Smaller, shorter ifdeffery block. An example speaks more than 1000 words:

arch/x86/include/asm/asm.h

> You've now got VERW_ARG leaking across the whole kernel, and a layer of
> obfuscatio^W indirection in CLEAR_CPU_BUFFERS.

We have that all around the kernel anyway.

> Admittedly, when I wrote this fragment as a suggestion[1], the 32bit
> comment was in the main comment because there really is no need for it
> to be separate.
>=20
> But abstracting away VERW_ARG like this hampers legibility/clarity,
> rather than improving it IMO.

I guess we see it differently.

I don't care all that much to continue this - I'll just say that having t=
he
CLEAR_CPU_BUFFERS macro text simpler and putting the argument complexity
abstracted away in macros reads better to me.

Oh well.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

