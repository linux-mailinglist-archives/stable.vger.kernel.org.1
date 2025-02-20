Return-Path: <stable+bounces-118518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A9A3E627
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 21:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D567C422753
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A0214237;
	Thu, 20 Feb 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0nKIXOT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036251F666B;
	Thu, 20 Feb 2025 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084939; cv=none; b=Jv/Si8Y7SybhyMkwcJif4EuhwhCmFQ8KumpJhp2DywbMMZAHUUvsAkydeBtHPaqIqSmKVG80nyCQ42PwskxCaqGu9qNwwgzi0Srg3xpt+/3O3uHIzMM5Sg5eBgoO+g4Bb92sHxFatlcO4hR4haRQ2WnAU8uFtnCG3OORGhHqhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084939; c=relaxed/simple;
	bh=agg/F5eBMi3v2E6ZMkipYdxJuRDAbyiuMrwCutkSd7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH5BGRq9PeeSiXulUOT74OC7Bsg0B9ba5bIHyAMXVFJanOFbwbJPZ4dX25O56/Fxzp+0oqoC1zZAh826azGwscsRMXJn/ir/fsmMQ8SCdsuairL4/fOff7piOTJzwa4N2JSLrfrJAYg9kSHwuV74zbP3RtINwQutPeb5+muIOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0nKIXOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8D6C4CED1;
	Thu, 20 Feb 2025 20:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740084938;
	bh=agg/F5eBMi3v2E6ZMkipYdxJuRDAbyiuMrwCutkSd7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0nKIXOTN1IA2l/6aYpo0h87mwkdAani0hf24EqQFsG+wMCqST8Z+YbXFbMGahJ/M
	 ivdJI7JPMJPuAM7XkqUk8YlWzXIYRXKmFrwBSTumBqGfkU0U+gY1Olt25QbtWOcxkv
	 splvXS/sa6DdMgJ51uOd+w/eG64Bw5UzKjURyIp2cjTkyuVCnnr05/IpZQzfIk0Qxp
	 T5kJGjc0kgsBjAa8Mgf0Xdcg4/6fWSJMISDuvuqpixTHMFhnJiqdYKVoNCVu9+y+np
	 D3XVf7Tz0xwVjtOrDjBAyeSdcRaWyPzQOsapvcjKeRIhsdUdfqbQY/r53H9YuKzBZ2
	 3KX+lxb0Ru6jg==
Date: Thu, 20 Feb 2025 12:55:36 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] asm-generic/vmlinux.lds: Move .data.rel.ro input
 into .rodata segment
Message-ID: <20250220205536.ty7mpvhqmi43zgll@jpoimboe>
References: <20250219105542.2418786-4-ardb+git@google.com>
 <20250219105542.2418786-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219105542.2418786-5-ardb+git@google.com>

On Wed, Feb 19, 2025 at 11:55:44AM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>

BTW, I was copied on the cover letter but not the individual patches.

> When using -fPIE codegen, the compiler will emit const global objects
> (which are useless unless statically initialized) into .data.rel.ro
> rather than .rodata if the object contains fields that carry absolute
> addresses of other code or data objects. This permits the linker to
> annotate such regions as requiring read-write access only at load time,
> but not at execution time (in user space).

Hm, this sounds more like __ro_after_init, are we sure the kernel
doesn't need to write it early?

> This distinction does not matter for the kernel, but it does imply that
> const data will end up in writable memory if the .data.rel.ro sections
> are not treated in a special way.
> 
> So emit .data.rel.ro into the .rodata segment.

This is a bug fix, right?  Since the RO data wasn't actually RO?  That's
not clear in the title.

-- 
Josh

