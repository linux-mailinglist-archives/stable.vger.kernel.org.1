Return-Path: <stable+bounces-204934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7DBCF5A45
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4ABD301F5E8
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF82DECDF;
	Mon,  5 Jan 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El51bi7+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F14285CA7;
	Mon,  5 Jan 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647746; cv=none; b=T6WQKqcaP29mLFhCrU3btpntRltCylKgghA2j1p+ECs2IXIzgHP5SIRw+an5uYIkenhrLAN/S3IEUZ4I/hldjJoh+gAyxx+YC0alU+wxa/MS5kaOvPvGpK/taCALKlODN6vObXFLRsSyx7NvWEgDfEeZ0Rpkw7+Og/QtRPmKaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647746; c=relaxed/simple;
	bh=IM2DuJa9reEiCLBZk8E9Dct8k60mL22ZGzV0MUiRdLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCwyxLTv7yG1YeTtcSLwgFevIy9/b6Xc9Hd/Ls4Jc2rQGCLzinXkQW+/Y6cEQJQAP1ZiAAx4bpunvi0QgVTnzjW7IrIVUPN7V1wXDKKpWjHDklGMqTskuHjmcdRzMQwKuZ0Zvfpd8m8y65oJnygPL/wCPZONesGTtYaoFGKjcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El51bi7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D92C116D0;
	Mon,  5 Jan 2026 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647746;
	bh=IM2DuJa9reEiCLBZk8E9Dct8k60mL22ZGzV0MUiRdLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=El51bi7+imH1giJ9Ep7MrHAH2+KZ4vdS0Xc4iaeVVVorQyVRxjbDjwfylCWGA24M2
	 pQWhRim60LLFJZimahW/BvYZ/panBYw3o1W99hKzDBSrDcVnvSNLADmXQ5ICCL5fIZ
	 IAoA67GeM65lzXWBH2OtCgbvCPvke7mGAUYM4e9wZsqy9BGJ7+WyhHa0FgdtTcE37s
	 RzK7G/zlLiGfFW/5pAT6jMcgu2T1jI610MpQZ3gjF2c/UBhzw4gB/xCQuQWfekMDYb
	 aIo5RrU3Ne8S5jJQJk+s9IVIQCrZTgDm9ULPpDbFgBN6QvnY+CkqJQ+oEWXmLv+V13
	 Z0rz2XAhrxriA==
Date: Mon, 5 Jan 2026 21:15:40 +0000
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, puranjay@kernel.org,
	usamaarif642@gmail.com, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix annotated branch unbootable kernel
Message-ID: <aVwp_BJx84gXHPlD@willie-the-truck>
References: <20251231-annotated-v1-1-9db1c0d03062@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-annotated-v1-1-9db1c0d03062@debian.org>

On Wed, Dec 31, 2025 at 04:44:05AM -0800, Breno Leitao wrote:
> The arm64 kernel doesn't boot with annotated branches
> (PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.
> 
> Bisecting it, I found that disabling branch profiling in arch/arm64/mm
> solved the problem. Narrowing down a bit further, I found that
> physaddr.c is the file that needs to have branch profiling disabled to
> get the machine to boot.
> 
> I suspect that it might invoke some ftrace helper very early in the boot
> process and ftrace is still not enabled(!?).
> 
> Disable branch profiling for physaddr.o to allow booting an arm64
> machine with CONFIG_PROFILE_ANNOTATED_BRANCHES and
> CONFIG_DEBUG_VIRTUAL together.
> 
> Cc: stable@vger.kernel.org
> Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Another approach is to disable profiling on all arch/arm64 code, similarly to
> x86, where DISABLE_BRANCH_PROFILING is called for all arch/x86 code. See
> commit 2cbb20b008dba ("tracing: Disable branch profiling in noinstr
> code").

Yes, let's start with arch/arm64/. We know that's safe and then if
somebody wants to make it finer-grained, it's on them to figure out a
way to do it without playing whack-a-mole.

Will

