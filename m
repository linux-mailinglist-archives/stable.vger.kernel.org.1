Return-Path: <stable+bounces-205080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B0FCF84AF
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 13:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C615301E98C
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890BD2DA76B;
	Tue,  6 Jan 2026 12:21:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E98256D;
	Tue,  6 Jan 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702118; cv=none; b=gvpcR6IEJRGS8fYB2x5HdboEcJERgbQWpxbg/fdLYL4Hl2eteOOF3dCa8iy0qb2BqJdht6nj7A1QaX0qhoVqOE32pQfX/LAjmiCJ8Cqnu9iA1Cma5Bcv8Yc1gLxUOv69mTt24HhfqLMhJvB9JbXhJUrcytcKeAK30K3XIkBsNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702118; c=relaxed/simple;
	bh=fZ3Cgw90ck/IzpfwCFpJA4Z/WCoX9MwTjBm8U4VL+kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV6AHzRJEKR00KCQEkY1xPO5w5r7RAk2C7jB+HA1coqTkZ3gABL/VaGJ8SYD0Ch1URqWoBXHjLFOYW73fHfLkOSbyDdYcvW/2h0ZvaiGrWP2F4Y6BguIST6E41Aqsen2D26OngoAgM/xDsH2ywp7UeOZSW8uTJwNbKW+7vBcgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55397497;
	Tue,  6 Jan 2026 04:21:49 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC46D3F5A1;
	Tue,  6 Jan 2026 04:21:53 -0800 (PST)
Date: Tue, 6 Jan 2026 12:21:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Laura Abbott <labbott@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com,
	puranjay@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>

On Tue, Jan 06, 2026 at 02:16:35AM -0800, Breno Leitao wrote:
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
> Rather than playing whack-a-mole with individual files, disable branch
> profiling for the entire arch/arm64 tree, similar to what x86 already
> does in arch/x86/Kbuild.
> 
> Cc: stable@vger.kernel.org
> Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Breno Leitao <leitao@debian.org>

I don't think ec6d06efb0bac is to blame here, and CONFIG_DEBUG_VIRTUAL
is unsound in a number of places, so I'd prefer to remove that Fixes tag
and backport this for all stable trees.

Regardless, I'm in favour of disabling CONFIG_DEBUG_VIRTUAL widely, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> Changes in v2:
> - Expand the scope to arch/arm64 instead of just physaddr.c
> - Link to v1: https://lore.kernel.org/all/20251231-annotated-v1-1-9db1c0d03062@debian.org/
> ---
>  arch/arm64/Kbuild | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
> index 5bfbf7d79c99..d876bc0e5421 100644
> --- a/arch/arm64/Kbuild
> +++ b/arch/arm64/Kbuild
> @@ -1,4 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +# Branch profiling isn't noinstr-safe
> +subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
> +
>  obj-y			+= kernel/ mm/ net/
>  obj-$(CONFIG_KVM)	+= kvm/
>  obj-$(CONFIG_XEN)	+= xen/
> 
> ---
> base-commit: c8ebd433459bcbf068682b09544e830acd7ed222
> change-id: 20251231-annotated-75de3f33cd7b
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

