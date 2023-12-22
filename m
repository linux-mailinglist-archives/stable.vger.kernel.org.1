Return-Path: <stable+bounces-8287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B8081C2E3
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 02:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42761F24101
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 01:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F090A53;
	Fri, 22 Dec 2023 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDrvzrFi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16253A50
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703209887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nN/8wghPJhB2Oh8gNGg0tlhxxcx+OK+Kvi1mD9v1Gs8=;
	b=EDrvzrFi2h35zWLk4LR0dOBZM6wwKUPPMJt5RuL7dMke5op8nJu7l1Rq3zPgIrEMYBkmID
	NsCYgZhTPml/+7zptttwNob9frPit0giHn/JlA1tGXcq8eBWdxEaQs5xXcpBIAp6DglODx
	AZWir9ByP5we2JjcmS1O0awUWyqpOfA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-5rHx5aGmPwy-PMlIsW4_aw-1; Thu, 21 Dec 2023 20:51:25 -0500
X-MC-Unique: 5rHx5aGmPwy-PMlIsW4_aw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d32b4a8ea0so14570365ad.3
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 17:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703209884; x=1703814684;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nN/8wghPJhB2Oh8gNGg0tlhxxcx+OK+Kvi1mD9v1Gs8=;
        b=apm73SI4IcBQlie0n1j89cc8OqdKTzZOu6CJWMyL6j/AX4fSpq66BU1eOsiiCqNmAS
         46c54KI5aCFGM7T+KORJUocJBl+/jmNi3CgT2cQ9pevjYJGFrEFh8XMGNiVIbC3WizJx
         wLjugF3it0+ciAAjSPsSSO48ZhW3HaMAxrZuy4TCeBEmkgQrq2vUwywRkKADQ8+3UKbX
         J68cfqw+3awd7T7A39eKQkBkhFX5ZRF8p/r7aXJuf7QVURI7QfInx5oB8z9M2qPVMiQ1
         YWsuBVDPGBmUaOFk1tKRuNyCVtl50i2HklZ51BskB89Icerhm9cGNRQTWkH3SPUDJ8RE
         jo8Q==
X-Gm-Message-State: AOJu0YwtvL1A1F6kKcr92NMmX56VTQU+PS+wZUpvake38xMCzNWQeAMW
	v//wHm+J+6p4wfXdDfwi0w/KJKDsXlNrSfoha3+g1RLij9SpAlEZTU1RoSBVLEwL0nTRto1mA3d
	GMZD522tBumym1mH1VSXSNeGH
X-Received: by 2002:a17:903:1c9:b0:1d3:bc88:59af with SMTP id e9-20020a17090301c900b001d3bc8859afmr583106plh.136.1703209883996;
        Thu, 21 Dec 2023 17:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqK9sjO3boko2Euac1Jio1zRfdmiG73LJTSADdDmxStfdygllQ8qRIUhBvzNbygwsIwnluxA==
X-Received: by 2002:a17:903:1c9:b0:1d3:bc88:59af with SMTP id e9-20020a17090301c900b001d3bc8859afmr583099plh.136.1703209883697;
        Thu, 21 Dec 2023 17:51:23 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b001d3ebfb2006sm2285019plh.203.2023.12.21.17.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:51:22 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: guoren@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
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
Date: Thu, 21 Dec 2023 22:51:04 -0300
Message-ID: <ZYTriK9hjOFQou9Z@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221154702.2267684-2-guoren@kernel.org>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-2-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Guo Ren,

On Thu, Dec 21, 2023 at 10:46:58AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> In COMPAT mode, the STACK_TOP is 0x80000000, but the TASK_SIZE is
> 0x7fff000. When the user stack is upon 0x7fff000, it will cause a user
> segment fault. Sometimes, it would cause boot failure when the whole
> rootfs is rv32.

Checking if I get the scenario:

In pgtable.h:
#ifdef CONFIG_64BIT
#define TASK_SIZE_64    (PGDIR_SIZE * PTRS_PER_PGD / 2)
#define TASK_SIZE_MIN   (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)

#ifdef CONFIG_COMPAT
#define TASK_SIZE_32    (_AC(0x80000000, UL) - PAGE_SIZE)
#define TASK_SIZE       (test_thread_flag(TIF_32BIT) ? \
                         TASK_SIZE_32 : TASK_SIZE_64)
#else
[...]

Meaning CONFIG_COMPAT is only available in CONFIG_64BIT, and TASK_SIZE in 
compat mode is either TASK_SIZE_32 or TASK_SIZE_64 depending on the thread_flag.

from processor.h:
#ifdef CONFIG_64BIT
#define DEFAULT_MAP_WINDOW      (UL(1) << (MMAP_VA_BITS - 1))
#define STACK_TOP_MAX           TASK_SIZE_64
[...]
#define STACK_TOP               DEFAULT_MAP_WINDOW


where:
#define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
with MMAP_VA_BITS_64 being either 48 or 37.

In compat mode,
STACK_TOP = 1 << (32 - 1) 	-> 0x80000000
TASK_SIZE = 0x8000000 - 4k 	-> 0x7ffff000

IIUC, your suggestion is to make TASK_SIZE = STACK_TOP in compat mode only.

Then why not:
#ifdef CONFIG_COMPAT
#define TASK_SIZE_32    STACK_TOP

With some comments explaining why there is no need to reserve a PAGE_SIZE 
in the TASK_SIZE_32.

Does that make sense?

Thanks!
Leo

> 
> Freeing unused kernel image (initmem) memory: 2236K
> Run /sbin/init as init process
> Starting init: /sbin/init exists but couldn't execute it (error -14)
> Run /etc/init as init process
> ...
> 
> Cc: stable@vger.kernel.org
> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index ab00235b018f..74ffb2178f54 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
>  
>  #ifdef CONFIG_COMPAT
> -#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
> +#define TASK_SIZE_32	(_AC(0x80000000, UL))




>  #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
>  			 TASK_SIZE_32 : TASK_SIZE_64)
>  #else
> -- 
> 2.40.1
> 


