Return-Path: <stable+bounces-223360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKubONT4qmlxZAEAu9opvQ
	(envelope-from <stable+bounces-223360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:55:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B62224537
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1CFE301D4FF
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74A3E9F76;
	Fri,  6 Mar 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4jy2GCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12B37BE8A;
	Fri,  6 Mar 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812492; cv=none; b=j/kI4XoSIZU9QaTPROeTRPWFS6LKf8gDR19qmM78TTqlW2VtDi5nXHGJ2VT2QlqKnparQRgpYS3OuSobXCPdCEfvXBMjuKV5SNqSp+KAdFTy6SiVPqujAby0DpztPriDa2F+eiqQ3GOXvFK0IOspgRb+1YwhjJq27IcmVfwUdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812492; c=relaxed/simple;
	bh=b6Q2vfwCcs0E5l+Cn9299eegQd0q/hpFvgEzI2+Enlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unnv0WjlGdzoCf6UMLsEMfSAb667p3h+zjZSjhzgW+zd3S9Qde7GbfzjCZXEKjUMzFWxWawPX/hQ3vK4bM45bVn/VFHh6hbH9tK5UtqMkZ/TP62HKishKBUbjrHwQxMkeTZDegaeBsYZR1lc1TIVMSXHFtafV1ocqgh0OnIrYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4jy2GCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40A3C4CEF7;
	Fri,  6 Mar 2026 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772812492;
	bh=b6Q2vfwCcs0E5l+Cn9299eegQd0q/hpFvgEzI2+Enlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4jy2GChNGU3tNV8OYElXie3aNzB0SXD7lh9yXZvKz1zVKHOB/ZWGp67yIFiNq5mf
	 Fhce69xc6aXopB0jXkIAQbwBRa6F49TXpg6qSElR3asH5LWu83AgIOZq/hvqaULwCj
	 cZ+4oqg1GlBG/VhklOHArgoo+k0eGGzK8/Jl5b+s/ZbLNUDdXNCs4oFiUxekgTu9mS
	 aGMwLC12+GsaxeKj6VbFiUsT5i5QQ7paFf32c2u2V8bWKhy5pxy1Mg82t6aW4jxZkO
	 nF0jWTWWJiJ1H0ndGgHFrEcgvRhnpQ2v7XVCVLCVMZESVe5wkWQjaDZaDrFmHeiwTq
	 riKeL5Mi5/Mng==
Date: Fri, 6 Mar 2026 17:54:41 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-efi@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/efi: defer freeing of boot services memory
Message-ID: <aar4wRh3TRm1m0HJ@kernel.org>
References: <20260225065555.2471844-1-rppt@kernel.org>
 <7e4f6a4b-fe41-482d-a4cd-5a059e1626e6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e4f6a4b-fe41-482d-a4cd-5a059e1626e6@app.fastmail.com>
X-Rspamd-Queue-Id: 21B62224537
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223360-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.922];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:11:12PM +0100, Ard Biesheuvel wrote:
> 
> On Wed, 25 Feb 2026, at 07:55, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > efi_free_boot_services() frees memory occupied by EFI_BOOT_SERVICES_CODE
> > and EFI_BOOT_SERVICES_DATA using memblock_free_late().
> >
> > There are two issue with that: memblock_free_late() should be used for
> > memory allocated with memblock_alloc() while the memory reserved with
> > memblock_reserve() should be freed with free_reserved_area().
> >
> > More acutely, with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> > efi_free_boot_services() is called before deferred initialization of the
> > memory map is complete.
> >
> > Benjamin Herrenschmidt reports that this causes a leak of ~140MB of
> > RAM on EC2 t3a.nano instances which only have 512MB or RAM.
> >
> 
> Putting a fixes tag referencing a patch that dates back to 2011 doesn't
> seem that useful here. Is this really an issue that goes all the way
> back? Or did a later change trigger the actual leak?

You are right, the leak was triggered later by addition of deferred
initialization of struct pages which is about 4.2 time.

So fixes tag is wrong indeed, but all the currently maintained stable
versions are affected.

-- 
Sincerely yours,
Mike.

