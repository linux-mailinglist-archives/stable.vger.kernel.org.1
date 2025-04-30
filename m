Return-Path: <stable+bounces-139144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB2AA4A95
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB0F5A2B5F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115B254859;
	Wed, 30 Apr 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OVjzrAzX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201F1DF25A;
	Wed, 30 Apr 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014743; cv=none; b=DVgb04W31Q62MQegTDvgTMjgxzUyx8AWTAG37VeWm5QI66ZqHtl7YfxEr0OUJCwceVP8h2hYRJ6BS2y/HmILx/Vs1fYmzGuu8aUDmybIPnTo/dc5r8TZzUHv3hKh9xnQWzo4WyvnYqvIDPfnDc5hoW7jiGD77KyLNoxtCVE2LXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014743; c=relaxed/simple;
	bh=WgsIZBnKrOUXlHWyHteBatYQrkxyacAFYb8soNIONAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGZDvu1VWjjet5K+ds06b8sZ7bDQxpT8zAezQ6Mu3f1/c6Bhjj/ZLS4/q3fW+TQPl7AFUBnKRrh0kY4qj6/PP/o/Za08jzewrHW7PwLhIquwIE65mVoUIu0Nj/jldGZYzRUtXTj4yqFBiQsqI/UACho77zz26vlOa7hu3OnFfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVjzrAzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644ADC4CEE9;
	Wed, 30 Apr 2025 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746014743;
	bh=WgsIZBnKrOUXlHWyHteBatYQrkxyacAFYb8soNIONAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVjzrAzXTVvSHGWlOIPuVzuwrY02hbg+25DrO/iLoej4dIOMEL1IM8g+OZgwHbVf+
	 s9FC2tlPvpI0TWPWjhQkmoJxnFku+k/36BH60uT1vSHNDTGj9tf1LDXoD19X1r9YIj
	 PxT+vba369KabXRIGDRF9zZBt/3x7X8aDjoga/U8=
Date: Wed, 30 Apr 2025 09:19:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.hansen@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v5] x86/devmem: Remove duplicate range_is_allowed()
 definition
Message-ID: <2025043043-disinfect-cosigner-db50@gregkh>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
 <20250430024622.1134277-2-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430024622.1134277-2-dan.j.williams@intel.com>

On Tue, Apr 29, 2025 at 07:46:21PM -0700, Dan Williams wrote:
> 17 years ago, Venki suggested [1] "A future improvement would be to
> avoid the range_is_allowed duplication".
> 
> The only thing preventing a common implementation is that
> phys_mem_access_prot_allowed() expects the range check to exit
> immediately when PAT is disabled [2]. I.e. there is no cache conflict to
> manage in that case. This cleanup was noticed on the path to
> considering changing range_is_allowed() policy to blanket deny /dev/mem
> for private (confidential computing) memory.
> 
> Note, however that phys_mem_access_prot_allowed() has long since stopped
> being relevant for managing cache-type validation due to [3], and [4].
> 
> Commit 0124cecfc85a ("x86, PAT: disable /dev/mem mmap RAM with PAT") [1]
> Commit 9e41bff2708e ("x86: fix /dev/mem mmap breakage when PAT is disabled") [2]
> Commit 1886297ce0c8 ("x86/mm/pat: Fix BUG_ON() in mmap_mem() on QEMU/i386") [3]
> Commit 0c3c8a18361a ("x86, PAT: Remove duplicate memtype reserve in devmem mmap") [4]
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: "Naveen N Rao" <naveen@kernel.org>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/pat/memtype.c | 31 ++++---------------------------
>  drivers/char/mem.c        | 18 ------------------
>  include/linux/io.h        | 21 +++++++++++++++++++++
>  3 files changed, 25 insertions(+), 45 deletions(-)


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

