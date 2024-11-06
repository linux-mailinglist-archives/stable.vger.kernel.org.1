Return-Path: <stable+bounces-90108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF199BE582
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A37281BFD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6B1DED52;
	Wed,  6 Nov 2024 11:27:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8B1DE4ED;
	Wed,  6 Nov 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892467; cv=none; b=RcYnJbsl2QcZP+kBzZF3Lxnq2NaiNzfl7LouNTBvJAYbnzxELkUEXB+FYH2Phoo0UU9v0UJ2IjZ34KLb5OsNPP1yUMpiHMGPXHDalyx9sCRqXOAj5eaoIITsu1nN6Na9ilYD3ubH0PLF+NR2ZbSvBvbMiyQ0vw8XN3U6ZMzurUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892467; c=relaxed/simple;
	bh=Z2v9o+k2bPx4B1kpWHk2LtaHD6klOShgAlCNkXRU8xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dn36ofQOxwqPQbrhOf1NLQOFRx5v0xPgDpmb8GSKqoQ8nkePXvoVx9LhtwfkonYCoQkBw0nAC+X6UvpMGE7AUjhY0Yd1qrmkF7hBeaOx8v6r6EypuWjg6pG+l/X/3QCRani7M1GJx/8ElZwL7gwgrwO7tJqBHF9tdhxWDUAL5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F3551063;
	Wed,  6 Nov 2024 03:28:14 -0800 (PST)
Received: from [10.57.91.71] (unknown [10.57.91.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 230B03F6A8;
	Wed,  6 Nov 2024 03:27:43 -0800 (PST)
Message-ID: <41c73be0-8d9a-4d81-bc51-933ec0bbcbc5@arm.com>
Date: Wed, 6 Nov 2024 11:27:42 +0000
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

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve


