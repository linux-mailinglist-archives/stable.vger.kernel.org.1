Return-Path: <stable+bounces-183600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27483BC4EBD
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7C093521B5
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B842749D3;
	Wed,  8 Oct 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqQieQZR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB232727E5
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927479; cv=none; b=mHISW3qevq9fzu6sxyJOp32dv6SHf8Q0495COw7Pl5IfVF3rK5DNsOB5ZWAD6joC6aYNVkuFmbJmPZh8R4t4NmJZf716XDwZf1/Uyymlt+IZcB4qrZL6zOfjPwxzo86psedklIb5XTwbwJeHBrGksDvu1K8BEDQiCEN48+qKn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927479; c=relaxed/simple;
	bh=N31ilv74oly5MwZpmaMuwEenXmb62MTdPxYq3RqSmIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfTPJqmz0KnxLCRLGZVWNMCS+SMUVh2vV2C3y1hy6jnm3sc3oQRKJBJB45qje5Nb45eCIf0mlBIfUwFK66/5KzxfvQz9iXLKD+yMeg3dnnF5c3hwlwMhIbLf44nQ2zkX4g3myU096duFzmLmyvSkLvkkA2NIahbxqMKseaUHQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqQieQZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C7AC113D0
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759927479;
	bh=N31ilv74oly5MwZpmaMuwEenXmb62MTdPxYq3RqSmIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aqQieQZR3vwxlStqo6iOnZZELag0xnqfCqNBsbDX3546Y4eKN3ZTJ1grDd7Gp2MKt
	 LuRzdtmFmH5PCT6bSeA3wb3Yhyu/LZ1CUlZmGxT9tlAFPhtehcNOx+LeyBY54+UV8g
	 zRYRGt2eTGJNopitgAcobC87SgArwTUUtVdrfd10dPmT1XMOaUabpFmXyp0dTdahUH
	 M/WStRHaNOHBHXO2R/m1VRe4LBLMElhSSAO+J0Y2NQFuuJaRByy+j7qZdcXy2gMHuc
	 F0/nGHKc+HnovDn3Gi3VervfYb9rN6yd6xvuH7Wfr3k3Qy6qaV0e8YqR86LY6Its9N
	 //Dc23NlkmS/w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57a960fe78fso8338485e87.2
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 05:44:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCfOrhp1DpvQTfLyWwT+k3kIoWfYbs3OJVW1OCeOn8YMF75/A+59GrPnpJQJNEPjEkOsrMg3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMJj8XTLaC79oScyrFMQGvp4mmc6MctBQUBW7atTwxtlf/EXb
	6XleMHej7U7SGrSZXg290K4PwMY+OY/xT+kVJcs7FRPAgxL7Np6WaAb2PGj+CCaIJIDmjvvDpV1
	tNi76HItqq9ycxnhcSGye4iema6nnuns=
X-Google-Smtp-Source: AGHT+IFb/9iVZyCeacRA4eV5KNX9g58E3Jlitn31uEFl4qngdAtE1ZMjpaLTq+Y+xAVeNotQ9Yk5di84F5oEAA9lL/Y=
X-Received: by 2002:a05:6512:138e:b0:579:f4b3:bd2d with SMTP id
 2adb3069b0e04-5906de92179mr905583e87.57.1759927477667; Wed, 08 Oct 2025
 05:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com> <20251001210201.838686-23-ardb+git@google.com>
 <94214ee4-3eec-4151-a5a7-9d5e030fbca3@sirena.org.uk>
In-Reply-To: <94214ee4-3eec-4151-a5a7-9d5e030fbca3@sirena.org.uk>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 8 Oct 2025 05:44:25 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEfw4RnY4wg6JBz01Hoa7r2amdJnj-eD-Kt0D+r6kAEtA@mail.gmail.com>
X-Gm-Features: AS18NWAvgP-PCFNPrGtZ5EtJZD86tidAj6ogMQQ_6DyA-DVZJAXzTHykQTP7Ti8
Message-ID: <CAMj1kXEfw4RnY4wg6JBz01Hoa7r2amdJnj-eD-Kt0D+r6kAEtA@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] arm64: Revert support for generic kernel mode FPU
To: Mark Brown <broonie@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, linux@armlinux.org.uk, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 09:23, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Oct 01, 2025 at 11:02:03PM +0200, Ard Biesheuvel wrote:
>
> > However, dropping that flag allows the compiler to use FPU and SIMD
> > registers in other ways too, and for this reason, arm64 only permits
> > doing so in strictly controlled contexts, i.e., isolated compilation
> > units that get called from inside a kernel_neon_begin() and
> > kernel_neon_end() pair.
>
> > The users of the generic kernel mode FPU API lack such strict checks,
> > and this may result in userland FP/SIMD state to get corrupted, given
> > that touching FP/SIMD registers outside of a kernel_neon_begin/end pair
> > does not fault, but silently operates on the userland state without
> > preserving it.
>
> Oh dear, that's nasty - I didn't see the patch when it was going in:
>

Actually, there is a check, it just wasn't wired up correctly by the
amdgpu driver, due to the fact that it wraps kernel_fpu_begin()/end()
calls into its own API, which are therefore always made from a
compilation unit where it is supported.

The trick is to #include <linux/fpu.h> into the definition of their
own wrapper API, so that using /that/ from FP/SIMD code also triggers
a build error.

So I'll drop this patch.

