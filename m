Return-Path: <stable+bounces-114682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D414A2F2EB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013141889E30
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D8B2580D3;
	Mon, 10 Feb 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug3dLP8m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1F2580CC
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204100; cv=none; b=lo8HDqR/9MJFCjT7NlRsA3cV1U9rzQiWpkAHOu4a8WDiqkSQXuKc+Db8Nd5fzVV7TixcEeg8otjJM0/CcxdFdDg6xZsBtaZGSGTLs8Xd1PZp4m6mZlYPGpLgIHX0ewyzncNc9+L7iwVfSKVr2tFMMYFg8hYlPTJbZDapPMCpIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204100; c=relaxed/simple;
	bh=cYJKkYg6JWieggFljG8oREQ6zBfLbDJc0fdZqFCC5NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIJ9yx9vZejChh5J4rkFI864Jd/Ah2GOwJkA7y+ZP6hTyXc9HKzkLhxsYrYw8HkL5vNgb3IlxA4Rrbr8uZsLjvrxfIlDVBinw6X3NBdrE6tbv7fFYw6busYN3PyVhfjOtkrjmcWKQ5Xg/ULQlOqGhWX6x9zQ8P65bycX2EYUGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug3dLP8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E4CC4CEE5;
	Mon, 10 Feb 2025 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739204100;
	bh=cYJKkYg6JWieggFljG8oREQ6zBfLbDJc0fdZqFCC5NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ug3dLP8midRAMLXGpFLUPpRbJ4ymdgaeaim0RBgk4tUCzwHF46qCZmwCXVksvc583
	 fiIxYfVWB1PJuFrG9pd69Yfc3luMcm2a1LmhyxxxoekUosgCpxwAEiQxiZVpEAvU6O
	 3Vre5YNYouuWoeUtji2+hrAdbYDbh8H6KhUPg8iUgGNBbszR3KPJKzAPHWaca8wrdl
	 Ca47WRoxISGUgMsFDtxQfM/t+DtbKQfHt2JpSDZTsGrUL+dxJJP6Sjo/clkFI4y2Dg
	 CcYU603vedkauBtC9vYyaexQIgPWyeQvSXNEnX3E2G5zf54qmoTbxvVCQ/U4xuXi0n
	 LmbWX4KeF4wZQ==
Date: Mon, 10 Feb 2025 16:14:54 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 3/8] KVM: arm64: Remove VHE host restore of
 CPACR_EL1.ZEN
Message-ID: <20250210161453.GD7568@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-4-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-4-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 02:10:57PM +0000, Mark Rutland wrote:
> When KVM is in VHE mode, the host kernel tries to save and restore the
> configuration of CPACR_EL1.ZEN (i.e. CPTR_EL2.ZEN when HCR_EL2.E2H=1)
> across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
> configuration may be clobbered by hyp when running a vCPU. This logic is
> currently redundant.
> 
> The VHE hyp code unconditionally configures CPTR_EL2.ZEN to 0b01 when
> returning to the host, permitting host kernel usage of SVE.
> 
> Now that the host eagerly saves and unbinds its own FPSIMD/SVE/SME
> state, there's no need to save/restore the state of the EL0 SVE trap.
> The kernel can safely save/restore state without trapping, as described
> above, and will restore userspace state (including trap controls) before
> returning to userspace.
> 
> Remove the redundant logic.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h |  1 -
>  arch/arm64/kvm/fpsimd.c           | 16 ----------------
>  2 files changed, 17 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

