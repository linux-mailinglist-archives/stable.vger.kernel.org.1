Return-Path: <stable+bounces-118479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28199A3E102
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99417A8A62
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40B20B812;
	Thu, 20 Feb 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o7ldMznp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982020487F
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069546; cv=none; b=QTxYLC8nFlsLVMF41y6HAUhPsIUYZ7gnfWtcSTr9izbRsnXqgZ9zUrM2A3kJ/gv5ioVb5zBQDydnOYtmuzd2FsGva+oSrqy+UGkterckZcCYTKx/AvDRn6n+LE1YHfAF43LyYbaWf3x4fRn4DuvM7p1GJIhJNWH4mu7C226fU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069546; c=relaxed/simple;
	bh=+/hLHzsl3KWd3MX8t+C1gUkYV8W/2ef/3T7qqFADfXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzFtw/lhlKsVkMK/sBNyTd45JaKfoMbPrx+MKYcD4eHgxgCZz/ghMX3jw1jYR0IoX8JXt+K/zXhrMvR4WoINy7V/4f2vjBgXr/tdhwz1vs27zg9NB0QSs44hkWIQP6alwJd+d7UILfnWWqnXnbdk3rpOk2PQGXww3GexQ4lqXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o7ldMznp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D61AC4CED1;
	Thu, 20 Feb 2025 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740069545;
	bh=+/hLHzsl3KWd3MX8t+C1gUkYV8W/2ef/3T7qqFADfXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7ldMznpQqRefCBSpZpbPCouwjlXt6hJUac3qswIQeCPtRXdgaaBYK+zvn9wz+veS
	 btr+ItnfB8ErDZ7+bRJQTVowo5bBlhMj5G9RS9n6Zx4XniYtoxgjAqHnyZ01B5vozF
	 pHti8ahaybOm/XNFW4u9HSFmA3hkcsPSGWMta3Vw=
Date: Thu, 20 Feb 2025 17:39:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: stable@vger.kernel.org, yang@os.amperecomputing.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH stable 5.10.y-6.12.y] arm64: mte: Do not allow PROT_MTE
 on MAP_HUGETLB user mappings
Message-ID: <2025022050-gopher-sizable-8657@gregkh>
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

Thanks for this, I'll queue it up after the next round of releases.

greg k-h

