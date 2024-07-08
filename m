Return-Path: <stable+bounces-58250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD20492A9AF
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 21:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775D11F22700
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 19:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A514BFB4;
	Mon,  8 Jul 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YzW+5sAM"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87683148833;
	Mon,  8 Jul 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466246; cv=none; b=UxSGw6uWQeg1JMEbt1AHVBidSZ53KhrJd1jHVGuwcPt/FP9w2vS0n6NINeerrvY/fjlUFj5CoF3ea1U+Fdjf/timpNaAYPHqmBHjm3szQfc6J28EmyX91TOcMBrNEFRC9cKMEO42wChWeDeBXp5+lXNt0r2FCvdS3oGbRkDqkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466246; c=relaxed/simple;
	bh=jfjaeLNh4I5mGiVYqVP5eL/KmwkIqLSdjDlPg+iogdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klo7DkdyoPkurpUZC+6CmrtLugvtZMEuU3ioLYMn+mXpE9Bj0srZl0075gcyB1+4Nit/hnht9OUOTgfw38itptTIp8/quIn6sbODFdEoXZ39+MeUjYMm0f57Qi6Oak6IyUXeXq0IzKv2BDBRu6sWi9JwCxlrxLfNO8hBgByp/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YzW+5sAM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CBAA40E019D;
	Mon,  8 Jul 2024 19:17:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n4K8qAoRIsLN; Mon,  8 Jul 2024 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720466238; bh=0e5ovUUtXQgTZyUAr4S3+sI3n7TZtAlcadWL7hRqI1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzW+5sAMamOZiL8yNdR/hQFmbo22zTgrAXM8OsmEA/zNrujp4f9zcy+mnU6dLBV/V
	 SGjEZZN9THps7N+qw0Lk2JHPyeD2q9ndRC+7ggi4kR32mtGHqc1bojdX0paV2VdX4E
	 xCWfOm1E9t4DkFkKcuKhENagRTD5twr+SGCvL/wen874TkZUQBqjelhd4zpL0mIVOU
	 Wln0zQWgrmqswHtsFKNuctmBfpY8SUcDtmHREo5+Cwb30A5vXoa61DRTggnWEzeP+x
	 vBwTzAFfELbbhEPpIz5zNGbm0gSJOW6JN90q4pTKvqEMKBuhvEw0F6h9fSwf9Hi3Y6
	 7ikmJbMGoljdYdfEGmWL2J9HOMfvc7MSYJ8XyBBcePnWbT9YSb12Go6vnOFeyu7vXi
	 nFRoJLLjAhy9ZOYgWhJTsrjwHsEAdNO8BGg4xkAsjkciaxNIcRNDacRIw3ftTzpVWl
	 1tMBqNV+d+uSyLxqipxOWe6TyLLJJuNpSj2+aCn7Xp2MJJDn8ZWW+ojHRhjcCSy0RA
	 Rl/BivVYVQASwkdPbU38bE6xkLyD2mHExybZF2a6ajLqEFl8Hkg8JyYo6Xk3uvfADy
	 O7fIaPisUoZ5A2YH5IjScRUIsm7L1Mj8udaPuraQVSjFp1bTPaEsGCRlLp1o8WKe3l
	 vJHDYjwTC1Vbd1Ay9XUXtp+8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 454FA40E0192;
	Mon,  8 Jul 2024 19:17:04 +0000 (UTC)
Date: Mon, 8 Jul 2024 21:17:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"open list:X86 TRUST DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kai Huang <kai.huang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Message-ID: <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
References: <20240708183946.3991-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708183946.3991-1-decui@microsoft.com>

On Mon, Jul 08, 2024 at 06:39:45PM +0000, Dexuan Cui wrote:
> When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> allocates buffers using vzalloc(), and needs to share the buffers with the
> host OS by calling set_memory_decrypted(), which is not working for
> vmalloc() yet. Add the support by handling the pages one by one.

"Add support..." and the patch is cc:stable?

This looks like it is fixing something and considering how you're rushing
this, I'd let this cook for a whole round and queue it after 6.11-rc1. So that
it gets tested properly.

> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

When were you able to collect all those tags on a newly submitted patch?

Do you even know what the meaning of those tags is or you just slap them
willy-nilly, just for fun?

> Cc: stable@vger.kernel.org

Why?

Fixes: what?

From reading this, it seems to me you need to brush up on

https://kernel.org/doc/html/latest/process/submitting-patches.html

while waiting.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

