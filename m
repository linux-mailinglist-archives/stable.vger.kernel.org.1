Return-Path: <stable+bounces-141861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F088AACEB3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3607A991E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EF71DD525;
	Tue,  6 May 2025 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PK4gsorZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4F481B6
	for <stable@vger.kernel.org>; Tue,  6 May 2025 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746562358; cv=none; b=dUyYHQaNGIYUHlAs9D5hgRxFlz+BkF0/2PyK3+iv2cP5J0Kf7fCXXtGQwfIOYTwAIHsdXPHIzOw86fxnRZhB1m0IhPvu1bWt0dQFNlF1J7NHAgN2r6ccU6DwG/CQTIK4eTDXh2ETmh/pype/Vd8hnincyue7z8gN9GmTVm6OAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746562358; c=relaxed/simple;
	bh=LYEJl+eYUpmTRCpsYGZDOEgiUCSxsf5QIuyINK/GMAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcUBoxZQi67qh7gs5f5usSH8c7FN1nnwe3acw0w5xMfwJAMQgFp2zADOLoewunbWDYyhumdoGlIyXh5xiq5nu2pITBQljutYfCs275FV/vxnNBBnhuDvJMu+3x3Hq6lk3VfX8D/2HFEaWNVm1TtS5BpX2N20GZ6S+aTLmdHkHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PK4gsorZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746562355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OeWb7vihmTpzLUB+AGhUaTYkPYqbMEgGJsN2qWU3xk=;
	b=PK4gsorZZkOXOgDaBgZ7DafTdpiezq6paysJZfcrcbVQCHTf1N1Qg4vqXPgiea9gTPMiKi
	EOL0+yFBrzxN0xKhmW4eT3mOrkaMPvNZmoJVjunwltehy/7Tp6qz4cGAzn2pidoxTYOAR0
	e5CGPVAKaZzDtYjuSbzHAa/h3pxCylA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-MG2U0xSDMmeKPDu7sljUYA-1; Tue, 06 May 2025 16:12:34 -0400
X-MC-Unique: MG2U0xSDMmeKPDu7sljUYA-1
X-Mimecast-MFC-AGG-ID: MG2U0xSDMmeKPDu7sljUYA_1746562354
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3da71e9fc6cso974705ab.2
        for <stable@vger.kernel.org>; Tue, 06 May 2025 13:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746562353; x=1747167153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OeWb7vihmTpzLUB+AGhUaTYkPYqbMEgGJsN2qWU3xk=;
        b=RGqBhpHp1UVSVJGqf8unlNmZqVn7fnsRIa6qJ24BIgf3N9xvPBRqM0IUg9fqDGv1bL
         gSuLAxKAwuCOnEWYyzccYjuxpi4rFMeA3OSfXpnaqXZjQm2or7MyKqKB5rHDhUMCEjyw
         TS1Pjxw4nBBb2iBGoFHqHBTRWI/IbljCUuTRoNBNA5akaghSoVMr6Hi0hxBAEa6Q11O+
         pQ+MdSOJ1X4R/f2Vq/t6R5z0WLbb4JJDky8pOR1XS1/xKALOyGkjP0zvdToo1dyiHliF
         E5uDML2j85YWMoW+49npwnXon+xKohHKvxm/oRfeNUQd5MvwaUdq0mLTdMSw4Ifjswhj
         NFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8EwKzXZcP9pzZkw5BvpBXoLABurYSCk0oF/p5z1qtTzatncfbB/j7KgoAcABj6MnkOCipLrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx38o1VfSaAmoyDKrFoFJUJeKPOEv4hpJ4xjM2G1et9I8u5J5U
	kcu5Mmr6j2g1qgNXnTMymCcFCrG2MtslURyqaNnYjRp6bx7PsvwXNPE2Wr8P8VhBCZoKxbr0JZb
	c14dOw7kasPzA75r5WZPZXGPMU5sdeIr5yC/4++zR92OZooWfPuoQtOThIdVI+Q==
X-Gm-Gg: ASbGncv55QvTM/meC1aZt2L5LbdYKo2lNW+cgOaHzCV2q1ihNXxHKOdNLqlLKrN5ZZy
	4qFLxJvsmJ6pfrR/NZ2K0qvAXCiDplZuPwWTS/SC7mlD+3uFGbmduhcsm76Ank7vQ3JBRhEUmjk
	J2h6hwbiMsdCHP/6+3qxnifxhX+Vhb7jn5TGa1DaMrYJ4tswrsPiK3fIHhRT9VWecuHr8nLp+01
	ZCHoUOXUoM1f7g9rgAugNqG2aiQfC+VlPm0yDIJjOLFX2VPdkgC/kTPzN6DCDWVaxKIUEbVTSFa
	Zbuu9OICs5xyK0M=
X-Received: by 2002:a05:6e02:1529:b0:3d9:4351:835 with SMTP id e9e14a558f8ab-3da738ee196mr1606585ab.2.1746562352681;
        Tue, 06 May 2025 13:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlR56swiWjxyIPd0BY//7vLXfu+WAj3Tx8jfGlO9u3SFBkhujBWi5NmgFxUf7KdAL57JORjg==
X-Received: by 2002:a05:6e02:1529:b0:3d9:4351:835 with SMTP id e9e14a558f8ab-3da738ee196mr1606505ab.2.1746562352330;
        Tue, 06 May 2025 13:12:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a940fedsm2286920173.66.2025.05.06.13.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 13:12:31 -0700 (PDT)
Date: Tue, 6 May 2025 14:12:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Adolfo
 <adolfotregosa@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Align huge faults to order
Message-ID: <20250506141229.363a7462.alex.williamson@redhat.com>
In-Reply-To: <20250502224035.3183451-1-alex.williamson@redhat.com>
References: <20250502224035.3183451-1-alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 May 2025 16:40:31 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> The vfio-pci huge_fault handler doesn't make any attempt to insert a
> mapping containing the faulting address, it only inserts mappings if the
> faulting address and resulting pfn are aligned.  This works in a lot of
> cases, particularly in conjunction with QEMU where DMA mappings linearly
> fault the mmap.  However, there are configurations where we don't get
> that linear faulting and pages are faulted on-demand.
> 
> The scenario reported in the bug below is such a case, where the physical
> address width of the CPU is greater than that of the IOMMU, resulting in a
> VM where guest firmware has mapped device MMIO beyond the address width of
> the IOMMU.  In this configuration, the MMIO is faulted on demand and
> tracing indicates that occasionally the faults generate a VM_FAULT_OOM.
> Given the use case, this results in a "error: kvm run failed Bad address",
> killing the VM.
> 
> The host is not under memory pressure in this test, therefore it's
> suspected that VM_FAULT_OOM is actually the result of a NULL return from
> __pte_offset_map_lock() in the get_locked_pte() path from insert_pfn().
> This suggests a potential race inserting a pte concurrent to a pmd, and
> maybe indicates some deficiency in the mm layer properly handling such a
> case.
> 
> Nevertheless, Peter noted the inconsistency of vfio-pci's huge_fault
> handler where our mapping granularity depends on the alignment of the
> faulting address relative to the order rather than aligning the faulting
> address to the order to more consistently insert huge mappings.  This
> change not only uses the page tables more consistently and efficiently, but
> as any fault to an aligned page results in the same mapping, the race
> condition suspected in the VM_FAULT_OOM is avoided.
> 
> Reported-by: Adolfo <adolfotregosa@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220057
> Fixes: 09dfc8a5f2ce ("vfio/pci: Fallback huge faults for unaligned pfn")
> Cc: stable@vger.kernel.org
> Tested-by: Adolfo <adolfotregosa@gmail.com>
> Co-developed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 35f9046af315..6328c3a05bcd 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1646,14 +1646,14 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct vfio_pci_core_device *vdev = vma->vm_private_data;
> -	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
> +	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
> +	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
> +	unsigned long pfn = vma_to_pfn(vma) + pgoff;
>  	vm_fault_t ret = VM_FAULT_SIGBUS;
>  
> -	pfn = vma_to_pfn(vma) + pgoff;
> -
> -	if (order && (pfn & ((1 << order) - 1) ||
> -		      vmf->address & ((PAGE_SIZE << order) - 1) ||
> -		      vmf->address + (PAGE_SIZE << order) > vma->vm_end)) {
> +	if (order && (addr < vma->vm_start ||
> +		      addr + (PAGE_SIZE << order) > vma->vm_end ||
> +		      pfn & ((1 << order) - 1))) {
>  		ret = VM_FAULT_FALLBACK;
>  		goto out;
>  	}

Applied to vfio for-linus branch for v6.15.  Added Peter as a Sign-off
to be compatible with the Co-developed tag, in agreement with Peter.
Modified the bz Link: to Closes: for checkpatch.  Thanks,

Alex


