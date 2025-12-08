Return-Path: <stable+bounces-200319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CBCABF45
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 04:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FC8A300FFAE
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 03:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A6244667;
	Mon,  8 Dec 2025 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXIsVOFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1462309AA;
	Mon,  8 Dec 2025 03:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164182; cv=none; b=PjmXO8p66UBX8BRj4glQEAtQm1nqDNXe5WGqZrTQEfMaabYTObNukjsRQz/LTVmflSlUSS/kGdp+Sqak9B1mitB97Rb6RUaJV/njugTH2tCqMMOzmucNahVEzlGnvVLj3aWsU6+i/XSv4ITLGLSNf9cx0yqZGiXQAYU9OpC9C4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164182; c=relaxed/simple;
	bh=usuwjV9doJAiImUOLurUSUVXjSwAVyLVzVLbkxDip8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWYdJrEsLYsaqUFlGD9bmBSF7nX0AKO6h4Afldw8kl0GOkcl6QsRnrqXd//lSqR30oGEYDeDG2kzx0XCGg+zBiQOuoN9UjKtPii4zuIkIZvtdxp4Ok3VHw9K59PlTCJ2C/0LZiSJwJ0GuYskMeHX92PK8t/cq3aks29Yw8iTaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXIsVOFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE91C4CEFB;
	Mon,  8 Dec 2025 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765164181;
	bh=usuwjV9doJAiImUOLurUSUVXjSwAVyLVzVLbkxDip8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXIsVOFJv2yJ1FmMCkGe4DCCf4IurostL3xhPZEInRXSNMDYowUJItM5dhGo6Tyi6
	 hChxyOAKs0jJmtg3PYprQaoUZrL57c3NS31j0BYqxyI3vk9aig4ao0+QM84scYjuAT
	 xtHJgLEhICVFiycrM2dFG2KOVgHE0mPopUGIHcAGdE3B/L5DYbvaPgddNMlLxajgrD
	 12FVu+NuDXVrZqjiVKkiSjJTRIp0Ev3aGvgqDLcU6uK7ndV4ssNTaFRBKt6JfFps/5
	 VCPVMsl5XA7qpIsD//d8PahAFIzx7vsT6hF/7dhYg+pUDmtL2no5knqhE2HH0may8f
	 CpzK/n2i0mpmg==
Date: Sun, 7 Dec 2025 19:22:56 -0800
From: Nathan Chancellor <nathan@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, james.clark@linaro.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Patch "dma-mapping: Allow use of DMA_BIT_MASK(64) in global
 scope" has been added to the 6.17-stable tree
Message-ID: <20251208032256.GA1356249@ax162>
References: <20251208030749.190427-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208030749.190427-1-sashal@kernel.org>

On Sun, Dec 07, 2025 at 10:07:49PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope
> 
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      dma-mapping-allow-use-of-dma_bit_mask-64-in-global-s.patch
> and it can be found in the queue-6.17 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 51a1912d46ceb70602de50c167e440966b9836f1
> Author: James Clark <james.clark@linaro.org>
> Date:   Thu Oct 30 14:05:27 2025 +0000
> 
>     dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope
>     
>     [ Upstream commit a50f7456f853ec3a6f07cbe1d16ad8a8b2501320 ]

This change has a pending bug fix, consider waiting to apply this to the
stable trees.

  https://lore.kernel.org/20251207184756.97904-1-johannes.goede@oss.qualcomm.com/

Cheers,
Nathan

