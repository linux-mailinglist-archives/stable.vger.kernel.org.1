Return-Path: <stable+bounces-8362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E395381D149
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 03:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684EC1F236A2
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 02:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4EBA21;
	Sat, 23 Dec 2023 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilADpyK4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D182EA3
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703299925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FsXvda8piHC8mKVnVEUK8EOJKqYtl+i/XG7XRDw0vA=;
	b=ilADpyK4sTdhqSyLGlSHrGKZPdo0xD8sSTaUbRDOusRdSvr7JV2+3s6KGTETZ6C5eTkc+Q
	lmGHHjBihGA7M9jR8q+8uLuc4Iafb/411JTcqm+3EIveyIqoWKv89XPBP5fFFcNv3oma5c
	rhzKKGpUt90S2rcJwjGx0kV4zKlormc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-I9ZIZmXrMSWgNW1_4uGDFg-1; Fri, 22 Dec 2023 21:52:04 -0500
X-MC-Unique: I9ZIZmXrMSWgNW1_4uGDFg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d94252c6bcso1288634b3a.3
        for <stable@vger.kernel.org>; Fri, 22 Dec 2023 18:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703299923; x=1703904723;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FsXvda8piHC8mKVnVEUK8EOJKqYtl+i/XG7XRDw0vA=;
        b=ZZmThcnUYOqWdwkZH+f0t+rc5Q/BBwFWl6uaWjAJQL8QY9qJnHf65TrKEZDyMv9VPK
         gSzgaEViuDB11wNq/+FWiKHgOW5QasJic1NUjr8vzdzI2SmdxEkh54WULaXIeBGr5f6C
         TvTJ+mVeJYvewAzrioPObF5VJupq2Np6CMFNFi6hC2/SHKXLYCT5TVW527EV/n9k9EZZ
         6Sr0YSwOwG+J3u6NF4VjVqyeia9rcbE20QN2LUhFN8up+GOdLBXZLbog1khTDCNL8i+3
         xdOJm2nqWx6+cpAcuLHs9T30s3d8W7xR3k0FzZ8KEG8NsT7bQHtAznE3ZyVw1XtE2uBs
         siuQ==
X-Gm-Message-State: AOJu0Yx6HtuFYbXQVZR6dU9ZGdVRJnx47dbdisA8WZwain7MXN4Z5zR8
	4+jrYiY8KlGNfAHpm/9QbLlrv6soTFI+FT6p72wCMlq8jxtvaYzb0OriRk7oIKaDzHCuddVPOjm
	xG7HBOUXgmOmWItMDho4cC2Ae
X-Received: by 2002:a05:6a21:78a0:b0:195:3e62:29b0 with SMTP id bf32-20020a056a2178a000b001953e6229b0mr977578pzc.81.1703299923028;
        Fri, 22 Dec 2023 18:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6xlks/80GQ9vCPW4KsUSOdHlvisDMKZyHP//fnCHq7v50UmfEp6S/CaJroh718uKlIh90zA==
X-Received: by 2002:a05:6a21:78a0:b0:195:3e62:29b0 with SMTP id bf32-20020a056a2178a000b001953e6229b0mr977563pzc.81.1703299922697;
        Fri, 22 Dec 2023 18:52:02 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ed:60ec:45a7:dfa:5e5:9eed])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001d398876f5esm4131410plb.121.2023.12.22.18.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:52:02 -0800 (PST)
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
Subject: Re: [PATCH V3 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Fri, 22 Dec 2023 23:51:48 -0300
Message-ID: <ZYZLRNlEpVXECyq9@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222115703.2404036-3-guoren@kernel.org>
References: <20231222115703.2404036-1-guoren@kernel.org> <20231222115703.2404036-3-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 06:57:01AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> directly.
> 
> Cc: stable@vger.kernel.org
> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/processor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index f19f861cda54..e1944ff0757a 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -16,7 +16,7 @@
>  
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> -#define STACK_TOP_MAX		TASK_SIZE_64
> +#define STACK_TOP_MAX		TASK_SIZE
>  
>  #define arch_get_mmap_end(addr, len, flags)			\
>  ({								\
> -- 
> 2.40.1
> 


LGTM. 

FWIW:
Reviewed-by: Leonardo Bras <leobras@redhat.com>


