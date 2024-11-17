Return-Path: <stable+bounces-93675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7EE9D03C6
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F88BB26A94
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 12:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74131AAE30;
	Sun, 17 Nov 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jddM0Hic"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F31AA1C7
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846336; cv=none; b=J+IfhDPMYiYwXkWzqrCtklzup/Nw3+AYdTsjwJ/p8ng0ZesGMEjD9OfCEvR6NaaFqm+mf75ulRzeV4MB/ljpyjm94mULk7ydL/f9jfLktJKLjDJJ8a1mt3UywQXm5h2+RtRNqo7kuh0UcIH93opQLhXtF11zsdE00Ol96db7xkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846336; c=relaxed/simple;
	bh=METi0w/NkMiw5z6lkH1cPvSH9klozqF92hNWDoxsVuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EwJwwtj1GNykrsfGF0hhrPSINqaWhBTFS1UZQsaofmXQU5BZcGT70Ena5IBKsiTtWhXF7KImN9D2xj+IjbpW9/xmBkidPGqsrMrvz3/OQE6f9+DFNnV25H0Or7D+OL7zWloiHwWDpGyVfhMZAx2bjsCeSkG1l+7r/dHyemXrP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=jddM0Hic; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846332;
	bh=ivoElLl6v01dXn3j88D2JzVuA8zDCUIbPPKgg72fH4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jddM0HicZ6glVWTVoexDcRGDtEPZfSdXC7PSUXrPxmgesfCZ2mwmnvfWGKtSBOGVE
	 iXieeSBAr/q0k6Bz1u6q7Sl+d815QqpV9yXMhzWX4UlRIVOF51A3kQHz44ZAfFWhC6
	 866nTk/LG/jkUUfdGNTEZbPe3tgAYV4aLpqY5YvZA2vyDy3xhK1AOkL1xpYhe998dx
	 hi5LceFRxk8yPcizRFgj9lgIMC9zNr8Jlc47ExTwxayHgrCHKVLsvYPWymHw6djMqk
	 /Zqc9VP5nVkoBikYSzX6kfE4pqaTZczuq+VWIoMn/vEEI+B3PP9V1nt0SeTZZ7kfoX
	 oZjVswpgJPv/A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj76vXHz4xfV;
	Sun, 17 Nov 2024 23:25:31 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor <nathan@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20241030-powerpc-vdso-drop-stackp-flags-clang-v1-1-d95e7376d29c@kernel.org>
References: <20241030-powerpc-vdso-drop-stackp-flags-clang-v1-1-d95e7376d29c@kernel.org>
Subject: Re: [PATCH] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
Message-Id: <173184539742.890800.7357374459961481947.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 11:41:37 -0700, Nathan Chancellor wrote:
> Under certain conditions, the 64-bit '-mstack-protector-guard' flags may
> end up in the 32-bit vDSO flags, resulting in build failures due to the
> structure of clang's argument parsing of the stack protector options,
> which validates the arguments of the stack protector guard flags
> unconditionally in the frontend, choking on the 64-bit values when
> targeting 32-bit:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
      https://git.kernel.org/powerpc/c/d677ce521334d8f1f327cafc8b1b7854b0833158

cheers

