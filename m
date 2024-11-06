Return-Path: <stable+bounces-91649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D19BEF3E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310DFB22B25
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05681F80C4;
	Wed,  6 Nov 2024 13:40:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6438F82
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900418; cv=none; b=L7IC50nmSLEG5vop7IUJgokKmPQQ+objvgJHWeWeHasjc+NyiRpxoV4jjZhK5TyuEuuv7C+BPjxxw7YuzyPZ8AogFP+fONB/FAg6dlBkrBQlhPvge9DVzggc3PEw6kdC/IEL4Xua1K/dcy3+BCsFIkk/9BHclJ/mTdHkmjdE0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900418; c=relaxed/simple;
	bh=A4gbR+RkOu9mDrb8WX7Cq6hfSKoxr2wHINr+gQIjYCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwj3kiZvFY0pB7dEGEK8+8TZZGdQr1NuBHe6aOabJ8jfK/TXOY7BjbLAB39bHD6weUuQ6cz1uK56duRudLTw2t0DApDflErAMPCJrbTtGfYuiFHRShAEuZUinKVAbF/4cyQlAsdCR2tGc6G3W+0yJifdZtIsM/zpD5zraY26VhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A6DbrZA029304;
	Wed, 6 Nov 2024 07:37:53 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A6Dbqdj029302;
	Wed, 6 Nov 2024 07:37:52 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 6 Nov 2024 07:37:52 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
Message-ID: <20241106133752.GG29862@gate.crashing.org>
References: <20241030-powerpc-vdso-drop-stackp-flags-clang-v1-1-d95e7376d29c@kernel.org> <884cf694-09c7-4082-a6b1-6de987025bf8@csgroup.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <884cf694-09c7-4082-a6b1-6de987025bf8@csgroup.eu>
User-Agent: Mutt/1.4.2.3i

Hi!

On Wed, Nov 06, 2024 at 09:55:58AM +0100, Christophe Leroy wrote:
> Le 30/10/2024 à 19:41, Nathan Chancellor a écrit :
> >Under certain conditions, the 64-bit '-mstack-protector-guard' flags may
> >end up in the 32-bit vDSO flags, resulting in build failures due to the
> >structure of clang's argument parsing of the stack protector options,
> >which validates the arguments of the stack protector guard flags
> >unconditionally in the frontend, choking on the 64-bit values when
> >targeting 32-bit:
> >
> >   clang: error: invalid value 'r13' in 'mstack-protector-guard-reg=', 
> >   expected one of: r2
> >   clang: error: invalid value 'r13' in 'mstack-protector-guard-reg=', 
> >   expected one of: r2
> >   make[3]: *** [arch/powerpc/kernel/vdso/Makefile:85: 
> >   arch/powerpc/kernel/vdso/vgettimeofday-32.o] Error 1
> >   make[3]: *** [arch/powerpc/kernel/vdso/Makefile:87: 
> >   arch/powerpc/kernel/vdso/vgetrandom-32.o] Error 1
> >
> >Remove these flags by adding them to the CC32FLAGSREMOVE variable, which
> >already handles situations similar to this. Additionally, reformat and
> >align a comment better for the expanding CONFIG_CC_IS_CLANG block.
> 
> Is the problem really exclusively for 32-bit VDSO on 64-bit kernel ?
> In any case, it is just wrong to have anything related to stack 
> protection in VDSO, for this reason we have the following in Makefile:
> 
> ccflags-y += $(call cc-option, -fno-stack-protector)
> 
> If it is not enough, should we have more complete ?

The -mstack-protector-guard-reg= doesn't do anything if you aren't
doing stack protection.  It allows any base register (so, r1..r31).
Setting it to any valid reg should be fine and not do anything harmful,
unless perhaps you *do* enable stack protector, then it better be the
expected stuff ;-)

Apparently clang does not implement it correctly?  This is just a clang
bug, please report it with them?

(r2 is the default for -m32, r13 is the default for -m64, it appears
that clang does not implement this option at all, it simply checks if
you set the default, and explodes if not).


Segher

