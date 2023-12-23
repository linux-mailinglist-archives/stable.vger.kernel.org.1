Return-Path: <stable+bounces-8367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D681D1ED
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 04:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8231F23BAB
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE61368;
	Sat, 23 Dec 2023 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TGJrTWzc"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D271EC2
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb8f9cadabso366084b6e.1
        for <stable@vger.kernel.org>; Fri, 22 Dec 2023 19:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703302751; x=1703907551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwj8L7hiOAWlB8RKprTbYnCxIbCpgFGamvNe/uB4uQU=;
        b=TGJrTWzcYlaYtgwCVvS6ZXZWV2sovvpmjccxFqv/pHj90WQurTLDUETF1vUBpuSRG0
         BEIAUY8R1kOb3xgdf2UtU5YYBiP1FzPmqXDsLlkSoIO6n0ERcgUoV5WC+uN81qmnRvx9
         93zxleI7Qr03y+iiMUEFQUfVuKncMUbL5hdQHQ86Sn763r0gnUQKAmT4DTEVjGpSEYZ3
         FNqzXZRBdLav0Ym4it5rrHz+WSKWVpdxgqDNoN61A8+mQJoUA8M7r/TVzonwvvRqITnZ
         rpGbiB8Lm6KV0ULeyRPQp6h+v0Rt+N71fi5t3VgryR/mfiezbMrkgf8VUeNbY+8qvjBN
         Kacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703302751; x=1703907551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwj8L7hiOAWlB8RKprTbYnCxIbCpgFGamvNe/uB4uQU=;
        b=bsxhvu0o9KOgQ6VVeG1zcAftlMmSXY6AvNsMEpQt5elvGyb1YyfiY0rfnzKIl0aot7
         yeSd+4Ssn1CPg2XobbSwrcdKDisc8hQEj1G373YDn/7PNYpipEEJXS1IYiNy0h4MarU2
         nc40NqGY4StzMpQrAi4yCGhtBvt9J9EYvjL7LMfxSy9CkVNjGbhNjRqmpwPxRY8bzgb1
         IVAtJwzmIzcepaiZ4GNsvVQxNvzmoyRn+0wSYKcJaCXS748LXGwMaKyUvqtS0Px+rqkl
         /AaG7HYo3lenJU08QC6OMV4iZAT34ejZvWicFODkHMTxisla2lhGxlcnOtNR3U1BzhAg
         eP/w==
X-Gm-Message-State: AOJu0YyZRobr2bL9YNCEOKpBCpsS78zX2F8OFqNeAjdpJDkk4OvhWJeK
	SGLeZRIAVx64eFpf/gbPgXgsDBCf417y7A==
X-Google-Smtp-Source: AGHT+IGV7knx4f8lHnOC7V9FUkQIy8i9FV7aSDORB3Za7AEbrdfrH9pHxCNgo4060GBWclKCSX/g/g==
X-Received: by 2002:a05:6808:1441:b0:3b8:b607:13dd with SMTP id x1-20020a056808144100b003b8b60713ddmr1470549oiv.50.1703302751505;
        Fri, 22 Dec 2023 19:39:11 -0800 (PST)
Received: from ghost ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id de7-20020a05687075c700b00203af6ff47esm1235776oab.42.2023.12.22.19.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 19:39:11 -0800 (PST)
Date: Fri, 22 Dec 2023 19:39:07 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com,
	alexghiti@rivosinc.com, xiao.w.wang@intel.com, david@redhat.com,
	panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com,
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com,
	cleger@rivosinc.com, linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH V3 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Message-ID: <ZYZWW3373Zk1PRGq@ghost>
References: <20231222115703.2404036-1-guoren@kernel.org>
 <20231222115703.2404036-3-guoren@kernel.org>
 <ZYZLRNlEpVXECyq9@LeoBras>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYZLRNlEpVXECyq9@LeoBras>

On Fri, Dec 22, 2023 at 11:51:48PM -0300, Leonardo Bras wrote:
> On Fri, Dec 22, 2023 at 06:57:01AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > directly.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/processor.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index f19f861cda54..e1944ff0757a 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -16,7 +16,7 @@
> >  
> >  #ifdef CONFIG_64BIT
> >  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > -#define STACK_TOP_MAX		TASK_SIZE_64
> > +#define STACK_TOP_MAX		TASK_SIZE
> >  
> >  #define arch_get_mmap_end(addr, len, flags)			\
> >  ({								\
> > -- 
> > 2.40.1
> > 
> 
> 
> LGTM. 
> 
> FWIW:
> Reviewed-by: Leonardo Bras <leobras@redhat.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 

