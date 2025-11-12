Return-Path: <stable+bounces-194571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23AC50AD3
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 07:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B09034EA206
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 06:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22482DC33B;
	Wed, 12 Nov 2025 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZStueS/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA5262FF6
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927751; cv=none; b=ozPfvRXD7ys9jydaoK0Huj/MldDPGI+xe3W24NiaZhDh1hTorG6jdfLcnPax1pOzrRPzjtn6r27hLNWXEyj81imPRZvNqefkx5Ms63lmqRG24QDq9G2u7+VATN+mFp1FMCloIQN2JI9f7auBwetZkpar+Inei8nS07LclkvfLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927751; c=relaxed/simple;
	bh=/x4XZIRoMLNhyu0rYcHubu3u5VIXlH9V8B33W9iRICc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=qcHkGr1wyfTc7RyoLZTNpNOtcr44yug7tqAdj+2ue/62CRTQdZeIFYIbxzCieXzVNeVv1wFUwMgUiaqzMGojSfHr/WalkyDFioRxExy5LB9o41aNYB1elUQvbSFd6HbhJmaWwuvUvbrGTdInx4zyUl10ErMQmbB8OcHfJIODa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZStueS/4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29808a9a96aso4514875ad.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762927747; x=1763532547; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vf+V3xa9EgGUbHOlQxF1xdJJTU0DRTndVUemiyXUeyI=;
        b=ZStueS/4trU8f6sSvf0LHZO/9mt+nOLXLu/UldJSpb0skHlV2NCwhyMNjEhT9Mx6bg
         JZphKb90/LWOdsCdLL6a1oscPuVO3PfuBiNxJJuRSDCknrvaqcqai47qBKBtt1SyoSSa
         9Yzv52CUEFx8g3CYcYF/4LS/DHQunNAuGYKyF8qgunax8RBNUVFUwxYf2vhsVIGOWSKm
         rgIq5bG8u63J3/x3Rz23s5ACQ4OOABHU4/sZs7bIYZ6tdJOTRrAeNC8KfhHeCcNPZqgz
         3/75OIN0SPOk4olRElfFQHrCJhTPjyQ6uy/eSWOig6pDdsWvkwbOEZ7fmPfQbHX1F++8
         /SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762927747; x=1763532547;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf+V3xa9EgGUbHOlQxF1xdJJTU0DRTndVUemiyXUeyI=;
        b=hzzGt5vRkDNuKNN7XlBSTKiSX+5utneXyGCtoEhxxoC2ViOc8rev46LlHUzaqQZ5pG
         VH8x864dPabuLkTSSIExWX4ZBeqSPeEZEGGxMLwA7P9Mj2GQh8SGXL5SJllUQlG7YF7A
         rm7Lb8zS8KZatco1j75Xx8hz2A0EzkeWMO37lfWHVy1j1CFMmi/3E+6OqQh9MEO5oA9e
         OH9maRcIIaU92G7WOkXEq27Zlde/W3LCagagfu9uCptjGDGB7elL4pR95dQk60WYpNoD
         c2I1X0aNmj5FSlNIBUGzjM9z3lCjiC893tbXjt5W2VMw3I+2IRE7zNXkWIJgJylFvyWN
         T2xg==
X-Forwarded-Encrypted: i=1; AJvYcCVIUhTEjyayXVA4LNtFO0bQwQ9J1zgt3ie9VZW5yFBCGdLxbISK9Pfhs6lFGwD1+6kPCNadMIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfsmKJCUIIYCWFTancfnSNEGWuUgvoEY3WJtTCS3lLF2FGGsN
	TLVRoCH57QJgq0m2ItM+gPuw0jZrjguYKPUv1WwgU0z7Qgh1adlXOX51
X-Gm-Gg: ASbGncuLP7NonAFh8d5QGlxUvBWuU1ERTvsKQorKNXKesYeEVaZdDmdUERZdKc0w+rb
	shTUBf6eMPvJr6IHMF40w2RXfKsacSgPQWch2uzeav4UNOhQJjzN2Wxc9D3KC6EuC9C+m5elL39
	VYH5Po0JOT7R1xeii+bfuuzlLXR2bt+pjyqk0C2fSwc5FhdoHYmfKCcMX0AlQ8U+5YF7x8ENZZF
	v8zHJXdLui6X2fa9k2sp5rleBkDPNDGVThrgRvLW0/4VfZ+DjDEts3GD4+QOFpT4J2D2w8C4vYA
	F0yVuKPPMfSlEsdTI9BCT8DYpHcElXbyjLOPJTljB3qIr6xeAFzvRtXxGWP+FVW6T7NcaCdJlMU
	Owu5OC3V2tLpdHst1sOifbRYrLcOZ3LN3n2MAfW8ZlLkzZY3D81kW1hShuvda0JwEXER4xro=
X-Google-Smtp-Source: AGHT+IEohiT6l/U6Q6cSeQX1Sd4BBaq0PAFAEVh2j8GuYXQZDYJogJ/Y0Dgu8WSYVH4jJhCDgr7O2w==
X-Received: by 2002:a17:902:e804:b0:296:1beb:6776 with SMTP id d9443c01a7336-2984edf314amr25324145ad.58.1762927747094;
        Tue, 11 Nov 2025 22:09:07 -0800 (PST)
Received: from dw-tp ([49.207.219.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbd8cd0sm18094405ad.4.2025.11.11.22.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:09:06 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nadav Amit <nadav.amit@gmail.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org, Dave Vasilevsky <dave@vasilevsky.ca>
Subject: Re: [PATCH v2] powerpc, mm: Fix mprotect on book3s 32-bit
In-Reply-To: <20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca>
Date: Wed, 12 Nov 2025 11:03:52 +0530
Message-ID: <87ikff95mn.ritesh.list@gmail.com>
References: <20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Dave Vasilevsky <dave@vasilevsky.ca> writes:

> On 32-bit book3s with hash-MMUs, tlb_flush() was a no-op. This was
> unnoticed because all uses until recently were for unmaps, and thus
> handled by __tlb_remove_tlb_entry().
>
> After commit 4a18419f71cd ("mm/mprotect: use mmu_gather") in kernel 5.19,
> tlb_gather_mmu() started being used for mprotect as well. This caused
> mprotect to simply not work on these machines:
>
>   int *ptr = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
>                   MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>   *ptr = 1; // force HPTE to be created
>   mprotect(ptr, 4096, PROT_READ);
>   *ptr = 2; // should segfault, but succeeds
>
> Fixed by making tlb_flush() actually flush TLB pages. This finally
> agrees with the behaviour of boot3s64's tlb_flush().
>
> Fixes: 4a18419f71cd ("mm/mprotect: use mmu_gather")
> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Flush entire TLB if full mm is requested.
> - Link to v1: https://lore.kernel.org/r/20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca
> ---
>  arch/powerpc/include/asm/book3s/32/tlbflush.h | 8 ++++++--
>  arch/powerpc/mm/book3s32/tlb.c                | 9 +++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
> index e43534da5207aa3b0cb3c07b78e29b833c141f3f..b8c587ad2ea954f179246a57d6e86e45e91dcfdc 100644
> --- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
> +++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
> @@ -11,6 +11,7 @@
>  void hash__flush_tlb_mm(struct mm_struct *mm);
>  void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>  void hash__flush_range(struct mm_struct *mm, unsigned long start, unsigned long end);
> +void hash__flush_gather(struct mmu_gather *tlb);

Maybe I would have preferred the following naming convention for hash
specific tlb_flush w.r.t mmu_gather, which is also similar to what
book3s64 uses ;)

- hash__tlb_flush() 

But no strong objection on this either. BTW - I did run your test
program in Qemu and I was able to reproduce the problem, and this patch
fixes it.

The change overall looks good to me. So, please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

