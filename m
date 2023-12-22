Return-Path: <stable+bounces-8298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCE81C3DC
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 05:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557D3285FA2
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13644211C;
	Fri, 22 Dec 2023 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNCGXFZF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875928F5
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703219595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dnfBu/fEgkmN9hsRGrX3Qh2OWxZhe8THfvYViPvNZA=;
	b=VNCGXFZFyZe3dz2Yzh3CYpBFLT+PTfzlgaW8f+PJ+kCqE5f8QtEYMVk09wfjcukL34wtsM
	LY72RkgqH6ln6Tdf9B2w2M5ePwna6t+Ht3E+KqAyfQ8cB9taKbxRU/5hmxNhCIxnPuj7IQ
	BJE7pKHaAxBaTB3c5ildvNxB90EnkVE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-m-59KMwyMRyEpfz0cru7QQ-1; Thu, 21 Dec 2023 23:33:13 -0500
X-MC-Unique: m-59KMwyMRyEpfz0cru7QQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d41d6055f6so1095295ad.0
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 20:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703219592; x=1703824392;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dnfBu/fEgkmN9hsRGrX3Qh2OWxZhe8THfvYViPvNZA=;
        b=eGMi/1qtbWCH/cDJdHEjFFozRZs27IxmW3X09bI6seOVPHHEb6/v4Qnauc+P3qL6J8
         ir0Zh/FbJPfxbYDwaSzPn31rUDnUldPi/698yTiFiVp1NIj/Wl7uF7wiCrm6bhTf8M0o
         NUc+2XKEJ1j3TlrrekwCMOwQQVVQbf8suDDoc3dtT88bwkzYxAeTgXoVz8HIsUHW8jqV
         DA+2WVnMigI9v1Uyf24tXjT/z8OJY+7C1G6UT+mx+XaxPgYKvy1FLjQ/oU5r4ANuwkle
         D5jJV7vh3RfeHQmyBNG1Mhebs3bS9XacEeX8GhSiPV48iDcNHIBTqS97Ex+fRpwGDS49
         VXXQ==
X-Gm-Message-State: AOJu0YwtOyJm8xju0+l5PKLEK3ZllIjOHj+I6bc5crmnj7RhvIfWgDRV
	IkV7IOSD6fiHankTE8zhR/3THMxWje7trh6vDCZCqGk6xEzklec2oo137UrCj4bd2QE50jacMOq
	U/jcOONFs0Hof1I+Pf2QLfUr7
X-Received: by 2002:a17:903:2602:b0:1d3:e573:20ec with SMTP id jd2-20020a170903260200b001d3e57320ecmr390703plb.90.1703219592226;
        Thu, 21 Dec 2023 20:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDVSGCaLDAAox1pQj6Gf9KxzIRJQl9Z4MY1pWe1L18FSa4/g4aAgyj/u/pm0pPnmWI+7vOLQ==
X-Received: by 2002:a17:903:2602:b0:1d3:e573:20ec with SMTP id jd2-20020a170903260200b001d3e57320ecmr390684plb.90.1703219591881;
        Thu, 21 Dec 2023 20:33:11 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001d3f79f61fdsm2445115pld.211.2023.12.21.20.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:33:11 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	xiao.w.wang@intel.com,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 1/4] riscv: mm: Fixup compat mode boot failure
Date: Fri, 22 Dec 2023 01:32:56 -0300
Message-ID: <ZYUReEZWcZVv1kxP@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZYUHg3kIMYdNSOSr@ghost>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-2-guoren@kernel.org> <ZYTriK9hjOFQou9Z@LeoBras> <CAJF2gTT=EQzsuYMHr3FLb82Gi325PqWMEOAzfc6fg=go+gKP_g@mail.gmail.com> <ZYUHg3kIMYdNSOSr@ghost>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 07:50:27PM -0800, Charlie Jenkins wrote:
> On Fri, Dec 22, 2023 at 10:57:16AM +0800, Guo Ren wrote:
> > On Fri, Dec 22, 2023 at 9:51 AM Leonardo Bras <leobras@redhat.com> wrote:
> > >
> > > Hello Guo Ren,
> > >
> > > On Thu, Dec 21, 2023 at 10:46:58AM -0500, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > In COMPAT mode, the STACK_TOP is 0x80000000, but the TASK_SIZE is
> > > > 0x7fff000. When the user stack is upon 0x7fff000, it will cause a user
> > > > segment fault. Sometimes, it would cause boot failure when the whole
> > > > rootfs is rv32.
> > >
> > > Checking if I get the scenario:
> > >
> > > In pgtable.h:
> > > #ifdef CONFIG_64BIT
> > > #define TASK_SIZE_64    (PGDIR_SIZE * PTRS_PER_PGD / 2)
> > > #define TASK_SIZE_MIN   (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > >
> > > #ifdef CONFIG_COMPAT
> > > #define TASK_SIZE_32    (_AC(0x80000000, UL) - PAGE_SIZE)
> > > #define TASK_SIZE       (test_thread_flag(TIF_32BIT) ? \
> > >                          TASK_SIZE_32 : TASK_SIZE_64)
> > > #else
> > > [...]
> > >
> > > Meaning CONFIG_COMPAT is only available in CONFIG_64BIT, and TASK_SIZE in
> > > compat mode is either TASK_SIZE_32 or TASK_SIZE_64 depending on the thread_flag.
> > >
> > > from processor.h:
> > > #ifdef CONFIG_64BIT
> > > #define DEFAULT_MAP_WINDOW      (UL(1) << (MMAP_VA_BITS - 1))
> > > #define STACK_TOP_MAX           TASK_SIZE_64
> > > [...]
> > > #define STACK_TOP               DEFAULT_MAP_WINDOW
> > >
> > >
> > > where:
> > > #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
> > > with MMAP_VA_BITS_64 being either 48 or 37.
> > >
> > > In compat mode,
> > > STACK_TOP = 1 << (32 - 1)       -> 0x80000000
> > > TASK_SIZE = 0x8000000 - 4k      -> 0x7ffff000
> > >
> > > IIUC, your suggestion is to make TASK_SIZE = STACK_TOP in compat mode only.
> > Yes, it causes the problem, which causes the boot to fail.
> 
> I think what Leonardo is getting at is that it is odd that it would
> cause boot issues if TASK_SIZE is not equal STACK_TOP. This seems
> indicative of a different problem. While this may fix the issue, it
> should be valid for TASK_SIZE to be less than STACK_TOP.
> 
> - Charlie
> 

That is also a good point, but I am not that acquainted to this to 
actually propose this. 

I was thinking more on these questions:
Is TASK_SIZE and STACK_TOP related somehow?
If so, would not be better to describe one in terms of the other, like
#define TASK_SIZE (STACK_TOP - PAGE_SIZE)

Or the other way around.

I mean, if they have any relation it would be much easier to represent them 
that way, and it would avoid having two magical numbers.

Thanks!
Leo

> > 
> > >
> > > Then why not:
> > > #ifdef CONFIG_COMPAT
> > > #define TASK_SIZE_32    STACK_TOP
> > Yes, it's the solution that I think at first. But I didn't find any
> > problem with 0x7ffff000 ~ 0x80000000, and then I removed this gap to
> > unify it with Sv39 and Sv48.
> > 
> > >
> > > With some comments explaining why there is no need to reserve a PAGE_SIZE
> > > in the TASK_SIZE_32.
> > At first, I wanted to put a invalid page between the user & kernel
> > space, but it seems useless.
> > 
> > >
> > > Does that make sense?
> > >
> > > Thanks!
> > > Leo
> > >
> > > >
> > > > Freeing unused kernel image (initmem) memory: 2236K
> > > > Run /sbin/init as init process
> > > > Starting init: /sbin/init exists but couldn't execute it (error -14)
> > > > Run /etc/init as init process
> > > > ...
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/pgtable.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > > > index ab00235b018f..74ffb2178f54 100644
> > > > --- a/arch/riscv/include/asm/pgtable.h
> > > > +++ b/arch/riscv/include/asm/pgtable.h
> > > > @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> > > >  #define TASK_SIZE_MIN        (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > > >
> > > >  #ifdef CONFIG_COMPAT
> > > > -#define TASK_SIZE_32 (_AC(0x80000000, UL) - PAGE_SIZE)
> > > > +#define TASK_SIZE_32 (_AC(0x80000000, UL))
> > >
> > >
> > >
> > >
> > > >  #define TASK_SIZE    (test_thread_flag(TIF_32BIT) ? \
> > > >                        TASK_SIZE_32 : TASK_SIZE_64)
> > > >  #else
> > > > --
> > > > 2.40.1
> > > >
> > >
> > 
> > 
> > -- 
> > Best Regards
> >  Guo Ren
> 


