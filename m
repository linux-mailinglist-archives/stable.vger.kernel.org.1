Return-Path: <stable+bounces-118606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09FA3F83C
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21DF189356A
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1720102C;
	Fri, 21 Feb 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OP2KNIjc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A312FF69
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151032; cv=none; b=YDiMNMbwbLHoRLWUs4sAPBteIqR+qtz8RiBxvDXDUApzqvZ6zCG8g5b6eKr2RiGf19tDMx47nDDTxwZWb2j1fuh1dGv+8t6pkjbBMXLI429ZapeowGj8lfuhaybWhtPtaJY8bKTyge9w+4KiOAV7+fkMlpXjuPyrzIZzyjB71QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151032; c=relaxed/simple;
	bh=VNtxx84Vg7YdMS8F2lDOk/xU1uYuqz0hjgy0kzS273w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUIPSROOxScd8KmS2TTUELlvoTub3UsMzgzGhT0+FzM+eFqezIlo+5oYxwbve3JW6eisi/gNb7SSnoStJLYggbXuvBxBSh75qBo67H/Ift+UXtgY6KagXKkgyMW1A/g/K8FBs4kzXlnnBz1/CbsTb6VO4PI7/PAqydYTehrLHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OP2KNIjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C592C4CEEA;
	Fri, 21 Feb 2025 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740151031;
	bh=VNtxx84Vg7YdMS8F2lDOk/xU1uYuqz0hjgy0kzS273w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OP2KNIjcHI3pyTLGy8hh4q3Nk9ujEPZa419E73qU1EMf4s/57bU58qJidKk5QKjsV
	 C6McYj00n8s1G+Vchks5RaYCT+N/8GldjodhC6mthCDH1zLJ5OS/SQAZ5AgIhbJyY1
	 X7vxQ1OrX9EQf/HVJXi7oOdxYn1lMCGDyeXuyook=
Date: Fri, 21 Feb 2025 16:17:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: stable@vger.kernel.org, yang@os.amperecomputing.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH stable 5.10.y-6.12.y] arm64: mte: Do not allow PROT_MTE
 on MAP_HUGETLB user mappings
Message-ID: <2025022102-scabbed-jinx-5f61@gregkh>
References: <20250220155801.1731061-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220155801.1731061-1-catalin.marinas@arm.com>

On Thu, Feb 20, 2025 at 03:58:01PM +0000, Catalin Marinas wrote:
> PROT_MTE (memory tagging extensions) is not supported on all user mmap()
> types for various reasons (memory attributes, backing storage, CoW
> handling). The arm64 arch_validate_flags() function checks whether the
> VM_MTE_ALLOWED flag has been set for a vma during mmap(), usually by
> arch_calc_vm_flag_bits().
> 
> Linux prior to 6.13 does not support PROT_MTE hugetlb mappings. This was
> added by commit 25c17c4b55de ("hugetlb: arm64: add mte support").
> However, earlier kernels inadvertently set VM_MTE_ALLOWED on
> (MAP_ANONYMOUS | MAP_HUGETLB) mappings by only checking for
> MAP_ANONYMOUS.
> 
> Explicitly check MAP_HUGETLB in arch_calc_vm_flag_bits() and avoid
> setting VM_MTE_ALLOWED for such mappings.
> 
> Fixes: 9f3419315f3c ("arm64: mte: Add PROT_MTE support to mmap() and mprotect()")
> Cc: <stable@vger.kernel.org> # 5.10.x-6.12.x
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> Hi Greg,
> 
> This patch applies cleanly on top of the stable-rc/linux-6.12.y to
> 5.10.y LTS, so I'm only sending it once. It's not for 6.13 onwards since
> those kernels support hugetlbfs with MTE.

Now queued up,t hanks.

greg k-h

