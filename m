Return-Path: <stable+bounces-91855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A419C0BE8
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 17:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1705285136
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F67215F78;
	Thu,  7 Nov 2024 16:44:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E2215037;
	Thu,  7 Nov 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997890; cv=none; b=JIuyWqk1h6WffNRN1ZNEYRPiIcrC+oWzE2dMeXeW3ietglk5D9D+WVoPur6ryo04sgzc0uG/faJf4VCDf+Nbz0/Z0AoSb4Q75q14qG1nQNgCmYVm/A8b8eILy9CVv1WvQZnfJPvBnxj+Nca0cqfAFy40Z6qqUlOn3HPMvQZwO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997890; c=relaxed/simple;
	bh=SXx4QOIhA5/JJw4g2CZvTwpg/A4Tlu/908uCyS6i/4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZufAsE+KQDmpchgdVDIAs3BaZxICQtAlek0VnoesE0Q+OMgoWzC4WzFpNKP5GPQc/K0LXlAI+cJ9AEkS+wXaSHEN/cAuATEXEshfCPBiTwwPYZjT/yD2afJqWz8k5O57gyMtLVtkXIol4pBeux4CW4Uzk4tH3/k+Fr7HiNwq3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF8FA497;
	Thu,  7 Nov 2024 08:45:15 -0800 (PST)
Received: from [10.57.89.183] (unknown [10.57.89.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 030C93F528;
	Thu,  7 Nov 2024 08:44:44 -0800 (PST)
Message-ID: <422f3c5a-4c69-413f-af2a-f016124d3c91@arm.com>
Date: Thu, 7 Nov 2024 16:44:43 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Be stricter about IO mapping flags
To: Jann Horn <jannh@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241105-panthor-flush-page-fixes-v1-1-829aaf37db93@google.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241105-panthor-flush-page-fixes-v1-1-829aaf37db93@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2024 23:17, Jann Horn wrote:
> The current panthor_device_mmap_io() implementation has two issues:
> 
> 1. For mapping DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET,
>    panthor_device_mmap_io() bails if VM_WRITE is set, but does not clear
>    VM_MAYWRITE. That means userspace can use mprotect() to make the mapping
>    writable later on. This is a classic Linux driver gotcha.
>    I don't think this actually has any impact in practice:
>    When the GPU is powered, writes to the FLUSH_ID seem to be ignored; and
>    when the GPU is not powered, the dummy_latest_flush page provided by the
>    driver is deliberately designed to not do any flushes, so the only thing
>    writing to the dummy_latest_flush could achieve would be to make *more*
>    flushes happen.
> 
> 2. panthor_device_mmap_io() does not block MAP_PRIVATE mappings (which are
>    mappings without the VM_SHARED flag).
>    MAP_PRIVATE in combination with VM_MAYWRITE indicates that the VMA has
>    copy-on-write semantics, which for VM_PFNMAP are semi-supported but
>    fairly cursed.
>    In particular, in such a mapping, the driver can only install PTEs
>    during mmap() by calling remap_pfn_range() (because remap_pfn_range()
>    wants to **store the physical address of the mapped physical memory into
>    the vm_pgoff of the VMA**); installing PTEs later on with a fault
>    handler (as panthor does) is not supported in private mappings, and so
>    if you try to fault in such a mapping, vmf_insert_pfn_prot() splats when
>    it hits a BUG() check.
> 
> Fix it by clearing the VM_MAYWRITE flag (userspace writing to the FLUSH_ID
> doesn't make sense) and requiring VM_SHARED (copy-on-write semantics for
> the FLUSH_ID don't make sense).
> 
> Reproducers for both scenarios are in the notes of my patch on the mailing
> list; I tested that these bugs exist on a Rock 5B machine.
> 
> Note that I only compile-tested the patch, I haven't tested it; I don't
> have a working kernel build setup for the test machine yet. Please test it
> before applying it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
> Signed-off-by: Jann Horn <jannh@google.com>

Pushed to drm-misc-fixes.

Thanks,
Steve



