Return-Path: <stable+bounces-139523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327B2AA7C64
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 00:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE5D4652CB
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2D221554;
	Fri,  2 May 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPQJe9/T"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0783214236
	for <stable@vger.kernel.org>; Fri,  2 May 2025 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746225990; cv=none; b=sOgPemJ/MMQogL6MHt8eOBGlV/WWFsqhcJ45tW/lGwGP27HN+xw9m6zS/TkFXZbMdFn9EfrzyxFFqd1KYbjxQvtih7xt0nNSuCI49gA0p/rC7B6CA4nH1YCU5uU9wncedYutTwnTxE1WPvOkGxI/WP2WskMnJYWG50+JEj6Uh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746225990; c=relaxed/simple;
	bh=MohwM7fVbor2Vyoh5g3MSChXrAJLw55GPUSBDMuPcGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJbSz99Alhevh4dgp24XDh8AjHROlhP+W9TzgNtb7YeCgNZ3RgBVPIrJBL6Rw2GMw9L56e0Tfh7Px+PsKrDhH74nLXpG2CPE9LN5nq/1Xg9lX1ZOxvGWAr833o8tAl2TAx1ZSbWHhGAaRFtwtvTGC6CT8jFZBUDZ0mHkeVbKPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPQJe9/T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746225987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBpwNFNUcKXm2mDG6MpS+gQbwBietEpngWQL4+w2ZxM=;
	b=cPQJe9/TUrmikpWWlpkltHo2p2v8CcbYIm3hcCGIHz48tXGlrYOjdfBoYYDr39UmVNZay7
	0R0bIEAz0KxdapcMe55QFvIUK8TaHgJXgP90S8UsX+v5+NFMwB9X14/lmcyyl3sUUaPG4c
	WGNtBPe8dcBeeSrDV7XEBt9yZ5fe4VA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Afe_K3h7OjqjRGKuRlF7Dw-1; Fri, 02 May 2025 18:46:24 -0400
X-MC-Unique: Afe_K3h7OjqjRGKuRlF7Dw-1
X-Mimecast-MFC-AGG-ID: Afe_K3h7OjqjRGKuRlF7Dw_1746225984
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47699e92ab0so52731551cf.0
        for <stable@vger.kernel.org>; Fri, 02 May 2025 15:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746225984; x=1746830784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBpwNFNUcKXm2mDG6MpS+gQbwBietEpngWQL4+w2ZxM=;
        b=ilEBfUyvrLEBtmZasbsQmJVMkRX9cnoq1B1NlRigMPk4JqNVkOV2frDssbvafAEsm9
         IYecX/kN9fxFf9sAnvx3HbpPJw7raqR9LfBLJOgo9VIAWgIJ4uoYg8M+t/b+yB1gJGoi
         XqrCI2KQdhxvTduoDMx7Vij7u23z4w0TIAgSc0BC9xubJb4NZaebauncFOoFyObpneWU
         LzblEtPgj3rwSrZBfzrRuctlEk/1IzBMreWUWWo/NQKCGjmTIbBgYW9cJPnRA5a1wkxM
         TCBiPksweGeBsWKcMoCdbTO9lObtzNhBRKI/nzBN1T6fKDOi2/usJgb0f3om/QhWogdQ
         lqIA==
X-Forwarded-Encrypted: i=1; AJvYcCXnzFcxUFfJP/pYav1LexuwghZo3VNbdQ6vHb+fI12Cbz/4ppIBMCnQnvFPYN5lOAg2+93XMpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8gRt4cXLcH6/0Icfz1Z1iGWNuYi+zQEany5MG/Y/GSBmY1exV
	2qafhl3JJoZ1AfHjDV++dGN6C/BSt+y5so0w7g/N+0H53OIETJnHO+fmCLjW+yS/YjpnoQLwZ4F
	w3vTE7ZrFucOhI82OV9601oOi/CXYNypgULVePxQOZcr9Mv0+3EJ0HQ==
X-Gm-Gg: ASbGncvvWSctZkEAN0YrQsVn4Ms3wpuJ2CPAHNhpZF8Zwr6F1drdpd6EIKEeYFL1V3B
	PJ5wV7VM1yGC15o1hmM/GxO1S28rUw6Dyh1GFgQPpGYxe9uk7YTX1t8oqbkzw+/l2UP0RXwpH3u
	vV2evGV47g4KXry19l7oumD6Gu0x/L0nir5z572HeSZkii3sqqjNdAiEFoNsCemHzFJBee3sqzl
	EmJ3D/9TY8Qor3eY8gsiHAaReTCTQKtOI5MJEFluWgJZtA9phKNWN1CMpsIzcBoQOV96NXGTeMn
	j/U=
X-Received: by 2002:a05:622a:5908:b0:47a:e63b:ec60 with SMTP id d75a77b69052e-48c31c182d3mr79854241cf.27.1746225984214;
        Fri, 02 May 2025 15:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUFR3XpnaIDy4pwFEqipRCtx1dBpoUtjuA3Eh3W7Ph6JfUfxzzQ94OxMVeRO2kYgTbY3OQoA==
X-Received: by 2002:a05:622a:5908:b0:47a:e63b:ec60 with SMTP id d75a77b69052e-48c31c182d3mr79854051cf.27.1746225983976;
        Fri, 02 May 2025 15:46:23 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48b966d7907sm24561601cf.30.2025.05.02.15.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 15:46:23 -0700 (PDT)
Date: Fri, 2 May 2025 18:46:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adolfo <adolfotregosa@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Align huge faults to order
Message-ID: <aBVLPAJVbyIrFjLS@x1.local>
References: <20250502224035.3183451-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250502224035.3183451-1-alex.williamson@redhat.com>

On Fri, May 02, 2025 at 04:40:31PM -0600, Alex Williamson wrote:
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

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


