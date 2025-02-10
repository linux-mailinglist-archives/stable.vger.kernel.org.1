Return-Path: <stable+bounces-114683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6FA2F2FA
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22C2166D72
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086D2580D2;
	Mon, 10 Feb 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL/2g8ta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF11B960
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204225; cv=none; b=QUL0ZtwmZzsCJY5QIkuofy2RaCie9/zqTLJwX+AHhyjrqAVZ+WJdC2q1KpW49d2svvoG98yDO2VCEG53qbwYYkA/GDoV4pMX6jK/452lMpbXTgpwMCF4GCwPAaj+9Sik7MloQ4mch3w39yO1qYFS82t1dGG4ZEmrEKy7uikSZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204225; c=relaxed/simple;
	bh=ErKSwxLO50h+kSbz6XppUCkzQZr/MW2XaZANa/yMCtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzADqJimxcGWcnSWdTk4vWRUovGHbLocO2EZnqwTRDv/ptayCsB+zBqQWdv5UGIpn/egZMFmQ/sXGn6KQEyrPYlhMHXz072S9F6LJXTCIF6qqVqQDBHWbYSGC1u0NI3x7OJlFKfbqcBdEZXFmJgzAIQN1A9Uxx82N4EutfB9vI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL/2g8ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD192C4CED1;
	Mon, 10 Feb 2025 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739204225;
	bh=ErKSwxLO50h+kSbz6XppUCkzQZr/MW2XaZANa/yMCtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TL/2g8ta3sY5fyUilVWWgsIHHDlVT/P2Uh3SNh3v0jTa86qEFPoMWb95H/eG4FqUq
	 I43yjvvKLQi4I9ZEmsERBnHAxakT/I6ipauMfGbzINnyhFpHOqxIR3qoSAL6r2PK3L
	 RNrlR9NGmorxA+N7kLfCBTwRR2DcWLCnILqk2cQ+TigGhMPalJUg+JDxavGwjqEhe3
	 TP3KV2QMvADzQ1HzNFn5KQ24HsXlkj2sfcTD/kwJ8hxZ+eG1fyrZRTKYoeyuJ5uvaN
	 GCs+C5SlA0sontLmupDo2p0NtZgr3BrNh5mDSwEcmf8exN2WInnlcodvsHjQEdUdag
	 17/Xh6aZmLGOw==
Date: Mon, 10 Feb 2025 16:16:59 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 4/8] KVM: arm64: Remove VHE host restore of
 CPACR_EL1.SMEN
Message-ID: <20250210161658.GE7568@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-5-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-5-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 02:10:58PM +0000, Mark Rutland wrote:
> When KVM is in VHE mode, the host kernel tries to save and restore the
> configuration of CPACR_EL1.SMEN (i.e. CPTR_EL2.SMEN when HCR_EL2.E2H=1)
> across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
> configuration may be clobbered by hyp when running a vCPU. This logic
> has historically been broken, and is currently redundant.
> 
> This logic was originally introduced in commit:
> 
>   861262ab86270206 ("KVM: arm64: Handle SME host state when running guests")
> 
> At the time, the VHE hyp code would reset CPTR_EL2.SMEN to 0b00 when
> returning to the host, trapping host access to SME state. Unfortunately,
> this was unsafe as the host could take a softirq before calling
> kvm_arch_vcpu_put_fp(), and if a softirq handler were to use kernel mode
> NEON the resulting attempt to save the live FPSIMD/SVE/SME state would
> result in a fatal trap.
> 
> That issue was limited to VHE mode. For nVHE/hVHE modes, KVM always
> saved/restored the host kernel's CPACR_EL1 value, and configured
> CPTR_EL2.TSM to 0b0, ensuring that host usage of SME would not be
> trapped.
> 
> The issue above was incidentally fixed by commit:
> 
>   375110ab51dec5dc ("KVM: arm64: Fix resetting SME trap values on reset for (h)VHE")
> 
> That commit changed the VHE hyp code to configure CPTR_EL2.SMEN to 0b01
> when returning to the host, permitting host kernel usage of SME,
> avoiding the issue described above. At the time, this was not identified
> as a fix for commit 861262ab86270206.
> 
> Now that the host eagerly saves and unbinds its own FPSIMD/SVE/SME
> state, there's no need to save/restore the state of the EL0 SME trap.
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
>  arch/arm64/kvm/fpsimd.c           | 21 ---------------------
>  2 files changed, 22 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

