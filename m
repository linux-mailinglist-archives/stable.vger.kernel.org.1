Return-Path: <stable+bounces-118610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38891A3F8F6
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FF87A5044
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A8C1DB933;
	Fri, 21 Feb 2025 15:37:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34081DB12D
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152221; cv=none; b=DFbdX6pCHOwEhddsa2Mijzi41wEE8nH1PpnpWj7iZQvC/HvtGr1DLepVk9f0tdn4gG4lKFuXv2wrlKTLZrhkmc5EZvfgrsh0IFUCSyB0GTau+SNxJZzvObw3dM9KKLKRdLTYmTIKxkX+9Im1d3W262f5xDQUq2cLBeYseydwf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152221; c=relaxed/simple;
	bh=T+5RuTBa27fbuXoAOJzz5Dy+7UTUdhzMblI4nDgZ0XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aotvqmOqheXWmHx2/5A7aPlWsjpNSij21hPVma/qpwKc2PAo5JLfDGrCGUEPBlqi3yMCEOCxD+G8aBkGPFkKxw/YRD131YdeggbLVuGuM9ckYDZOe90s3F4FGf4tqowaV/yax1o85aVN2+jfi7rZO68nKMNU7oMtar9w/3ChPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923C1C4CEE2;
	Fri, 21 Feb 2025 15:37:00 +0000 (UTC)
Date: Fri, 21 Feb 2025 15:36:58 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, yang@os.amperecomputing.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH stable 5.10.y-6.12.y] arm64: mte: Do not allow PROT_MTE
 on MAP_HUGETLB user mappings
Message-ID: <Z7idmpkLyNWgMkb3@arm.com>
References: <20250220155801.1731061-1-catalin.marinas@arm.com>
 <2025022102-scabbed-jinx-5f61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022102-scabbed-jinx-5f61@gregkh>

On Fri, Feb 21, 2025 at 04:17:09PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 20, 2025 at 03:58:01PM +0000, Catalin Marinas wrote:
> > PROT_MTE (memory tagging extensions) is not supported on all user mmap()
> > types for various reasons (memory attributes, backing storage, CoW
> > handling). The arm64 arch_validate_flags() function checks whether the
> > VM_MTE_ALLOWED flag has been set for a vma during mmap(), usually by
> > arch_calc_vm_flag_bits().
> > 
> > Linux prior to 6.13 does not support PROT_MTE hugetlb mappings. This was
> > added by commit 25c17c4b55de ("hugetlb: arm64: add mte support").
> > However, earlier kernels inadvertently set VM_MTE_ALLOWED on
> > (MAP_ANONYMOUS | MAP_HUGETLB) mappings by only checking for
> > MAP_ANONYMOUS.
> > 
> > Explicitly check MAP_HUGETLB in arch_calc_vm_flag_bits() and avoid
> > setting VM_MTE_ALLOWED for such mappings.
> > 
> > Fixes: 9f3419315f3c ("arm64: mte: Add PROT_MTE support to mmap() and mprotect()")
> > Cc: <stable@vger.kernel.org> # 5.10.x-6.12.x
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > 
> > Hi Greg,
> > 
> > This patch applies cleanly on top of the stable-rc/linux-6.12.y to
> > 5.10.y LTS, so I'm only sending it once. It's not for 6.13 onwards since
> > those kernels support hugetlbfs with MTE.
> 
> Now queued up, thanks.

Thanks Greg.

-- 
Catalin

