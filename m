Return-Path: <stable+bounces-97251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FDF9E277D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199BDBC23C7
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357381F75BC;
	Tue,  3 Dec 2024 15:32:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F00F1F75BD;
	Tue,  3 Dec 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239949; cv=none; b=Rk/wTLOB3QebPZQtP7mN22qsCQRehvBJhlbD9NqdLoF/iHd8P6lJ19xjtcBuNR5U5dIvaBFxiovPNdrXWUUc4W3QRwNTsHeK22pAChmnIvOZT7HPfwXEVy+jQJx/ma/X3+tGP73eAlK7fo9JZyqBn79deEZ2atBDZWnkolJpUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239949; c=relaxed/simple;
	bh=Gu+nl35448vAkGNYug2TUYI8gJBL+zCPISsT0TEt9eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elvDllwH+KJQqRUULRa3oj5d0nhtB1mjOY8lnB0V2G1hXRD0BKvqbmp0wbZmPj9buk71izu/2AHAC3zWv14cd4o4s5OGhwqo4BeRLC8Oe6haR2Xv5B6XGv2PKVji2CTes7kAX4MPU7FNGVSD9jYZKS8DwNjtkKWS+N4OO4Ls/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0213AFEC;
	Tue,  3 Dec 2024 07:32:54 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE9793F71E;
	Tue,  3 Dec 2024 07:32:24 -0800 (PST)
Date: Tue, 3 Dec 2024 15:32:22 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64/sme: Flush foreign register state in
 do_sme_acc()
Message-ID: <Z08khk6Mg6+T6VV9@e133380.arm.com>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-1-d853479d1b77@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-arm64-sme-reenable-v1-1-d853479d1b77@kernel.org>

On Tue, Dec 03, 2024 at 12:45:53PM +0000, Mark Brown wrote:
> When do_sme_acc() runs with foreign FP state it does not do any updates of
> the task structure, relying on the next return to userspace to reload the
> register state appropriately, but leaves the task's last loaded CPU
> untouched. This means that if the task returns to userspace on the last
> CPU it ran on then the checks in fpsimd_bind_task_to_cpu() will incorrectly
> determine that the register state on the CPU is current and suppress reload
> of the floating point register state before returning to userspace. This
> will result in spurious warnings due to SME access traps occuring for the
> task after TIF_SME is set.
> 
> Call fpsimd_flush_task_state() to invalidate the last loaded CPU
> recorded in the task, forcing detection of the task as foreign.
> 
> Fixes: 8bd7f91c03d8 ("arm64/sme: Implement traps and syscall handling for SME")
> Reported-by: Mark Rutlamd <mark.rutland@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kernel/fpsimd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 8c4c1a2186cc510a7826d15ec36225857c07ed71..eca0b6a2fc6fa25d8c850a5b9e109b4d58809f54 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1460,6 +1460,8 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
>  		sme_set_vq(vq_minus_one);
>  
>  		fpsimd_bind_task_to_cpu();
> +	} else {
> +		fpsimd_flush_task_state(current);

TIF_FOREIGN_FPSTATE is (or was) a cache of the task<->CPU binding that
you're clobbering here.

So, this fpsimd_flush_task_state() should have no effect unless
TIF_FOREIGN_FPSTATE is already wrong?  I'm wondering if the apparent
need for this means that there is an undiagnosed bug elsewhere.

(My understanding is based on FPSIMD/SVE; I'm less familiar with the
SME changes, so I may be missing something important here.)

[...]

Cheers
---Dave

