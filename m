Return-Path: <stable+bounces-8316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3DE81C69B
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 09:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D8A1C25144
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC62C8E7;
	Fri, 22 Dec 2023 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbvbpMaR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA321DA23
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703233691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zw3RHEplm+3wKRo41JY1pGYHPKanZ6Jye+Vpi6iDAho=;
	b=ZbvbpMaRlNvY1LtsBUAEdcET38uh+QfvxpMV8KryLm83PAFHDhm+GqCbuZ0uLFWVwVcT2Q
	5DtS85zmBUUcraN5AguT98AtWD9T2S9ryCfxqpwuayU8sraFNwli1nbNiREKEQ1yjzAAWN
	aFqgeGWqk3wtj5S+aS0fV4/1j49Is84=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Gp5-Lkt-O9OhM7DYUgM5_Q-1; Fri, 22 Dec 2023 03:28:09 -0500
X-MC-Unique: Gp5-Lkt-O9OhM7DYUgM5_Q-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6da6608ac3cso1947557a34.3
        for <stable@vger.kernel.org>; Fri, 22 Dec 2023 00:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703233688; x=1703838488;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw3RHEplm+3wKRo41JY1pGYHPKanZ6Jye+Vpi6iDAho=;
        b=ATyY1AsDcCGJMSeLBw8pYsENCEwL8zza/CrnVwgR4dQxRC+14Cctk2AfA9ii19X2Y6
         I4agHDE6NfYgojGscTicuVmfxMg7wNYyvu5T6R/SEhfdt1u7taRL+OQ9uM2rbc8pp9J3
         RdGPhTGQY4CxYbCpV9jIFOenGQFXA7OhCSM4ICK+VLS7K6KR5IENstqrUbHR4Mp/JDex
         F8alDTcCxVq5HWS5Txqx9r55OOOj02xRfimdP1xwAU+1Vx7Dv5sLjMmIe8OrroN9MhhU
         gyOyLQUrDWUOLMyCohXcKQKQZhi37t/DdjAwpB4V+FCAeCuJLYy89OBlmaK95Vcek+qh
         x70g==
X-Gm-Message-State: AOJu0YwXXEwa/7kIJgMYEhE2ZS0NEOX26ymUQB2CUPZDqadvaUUc+bvQ
	eTW9j4db3ix/aACmvs8U/y4OtxE+D1DvXer/W4nYgQGwg6AVzn2n3BAnRKozIBRryMKE66b0JN3
	2/uocSHTa0Q7dR8Z2VTQAgqST
X-Received: by 2002:a9d:6a19:0:b0:6d9:f4dd:190f with SMTP id g25-20020a9d6a19000000b006d9f4dd190fmr1214236otn.60.1703233688457;
        Fri, 22 Dec 2023 00:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo0yI0iJlF/BDgrjFZNiGJa7zRGJ+WeCVQE/5XG5PdcW5hwE/NS8oxdaiSqeh/JhKmViZiEw==
X-Received: by 2002:a9d:6a19:0:b0:6d9:f4dd:190f with SMTP id g25-20020a9d6a19000000b006d9f4dd190fmr1214228otn.60.1703233688211;
        Fri, 22 Dec 2023 00:28:08 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id f29-20020a63555d000000b005c60ad6c4absm2756348pgm.4.2023.12.22.00.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:28:07 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	guoren@kernel.org,
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
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Fri, 22 Dec 2023 05:27:52 -0300
Message-ID: <ZYVIiGJHOfLrVOIC@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZYUhrTaXMqyRchyP@ghost>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org> <ZYUD4C1aXWt2oFJo@LeoBras> <ZYUK2zUHjYBL0zO7@ghost> <ZYUPQIJ070BYDzJJ@LeoBras> <ZYUhrTaXMqyRchyP@ghost>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 09:42:05PM -0800, Charlie Jenkins wrote:
> On Fri, Dec 22, 2023 at 01:23:29AM -0300, Leonardo Bras wrote:
> > On Thu, Dec 21, 2023 at 08:04:43PM -0800, Charlie Jenkins wrote:
> > > On Fri, Dec 22, 2023 at 12:34:56AM -0300, Leonardo Bras wrote:
> > > > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > 
> > > > > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > > > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > > > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > > > > directly.
> > > > 
> > > > ok
> > > > 
> > > > > 
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > ---
> > > > >  arch/riscv/include/asm/processor.h | 6 ++----
> > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > > > index f19f861cda54..1f538fc4448d 100644
> > > > > --- a/arch/riscv/include/asm/processor.h
> > > > > +++ b/arch/riscv/include/asm/processor.h
> > > > > @@ -16,15 +16,13 @@
> > > > >  
> > > > >  #ifdef CONFIG_64BIT
> > > > >  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > > > > -#define STACK_TOP_MAX		TASK_SIZE_64
> > > > > +#define STACK_TOP_MAX		TASK_SIZE
> > > > 
> > > > It means STACK_TOP_MAX will be in 64BIT:
> > > > - TASK_SIZE_32 if compat_mode=y
> > > > - TASK_SIZE_64 if compat_mode=n
> > > > 
> > > > Makes sense for me.
> > > > 
> > > > >  
> > > > >  #define arch_get_mmap_end(addr, len, flags)			\
> > > > >  ({								\
> > > > >  	unsigned long mmap_end;					\
> > > > >  	typeof(addr) _addr = (addr);				\
> > > > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > > > > -		mmap_end = STACK_TOP_MAX;			\
> > > > > -	else if ((_addr) >= VA_USER_SV57)			\
> > > > > +	if ((_addr) == 0 || (_addr) >= VA_USER_SV57)		\
> > > > >  		mmap_end = STACK_TOP_MAX;			\
> > > > >  	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > > > >  		mmap_end = VA_USER_SV48;			\
> > > > 
> > > > 
> > > > I don't think I got this change, or how it's connected to the commit msg.
> > > > 
> > > > Before:
> > > > - addr == 0, or addr > 2^57, or compat: mmap_end = STACK_TOP_MAX
> > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > - 0 < addr < 2^48 : mmap_end = 2^39
> > > > 
> > > > Now:
> > > > - addr == 0, or addr > 2^57: mmap_end = STACK_TOP_MAX
> > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > - 0 < addr < 2^48 : mmap_end = 2^39
> > > > 
> > > > IIUC compat mode addr will be < 2^32, so will always have mmap_end = 2^39 
> > > > if addr != 0. Is that desireable? 
> > > > (if not, above change is unneeded)
> > > 
> > > I agree, this change does not make sense for compat mode. Compat mode
> > > should never return an address that is greater than 2^32, but this
> > > change allows that.
> > > 
> > > > 
> > > > Also, unrelated to the change:
> > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > Is the above correct?
> > > > It looks like it should be 2^57 instead, and a new if clause for 
> > > > 2^32 < addr < 2^48 should have mmap_end = 2^48.
> > > 
> > > That is not the case. I documented this behavior and reasoning in
> > > Documentation/arch/riscv/vm-layout.rst in the "Userspace VAs" section.
> > > 
> > > I can reiterate here though. The hint address to mmap (defined here as
> > > "addr") is the maximum userspace address that mmap should provide. What
> > > you are describing is a minimum. The purpose of this change was to allow
> > > applications that are not compatible with a larger virtual address (such
> > > as applications like Java that use the upper bits of the VA to store
> > > data) to have a consistent way of specifying how many bits they would
> > > like to be left free in the VA. This requires to take the next lowest
> > > address space to guaruntee that all of the most-significant bits left
> > > clear in hint address do not end up populated in the virtual address
> > > returned by mmap.
> > > 
> > > - Charlie
> > 
> > Hello Charlie, thank you for helping me understand!
> > 
> > Ok, that does make sense now! The addr value hints "don't allocate > addr"
> > and thus:
> > 
> > - 0 < addr < 2^48 : mmap_end = 2^39
> > - 2^48 < addr < 2^57: mmap_end = 2^48
> > 
> > Ok, but then
> > - addr > 2^57: mmap_end = 2^57
> > right?
> > 
> > I mean, probably STACK_TOP_MAX in non-compat mode means 2^57 already, but 
> > having it explicitly like:
> > 
> >  else if ((_addr) >= VA_USER_SV57)                       \
> >          mmap_end = VA_USER_SV57;                        \
> > 
> > would not be better for a future full 64-bit addressing?
> > (since it's already on a different if clause)
> 
> I agree, that does make more sense.
> 
> > 
> > I could add comment on top of the macro with a short version on your addr 
> > hint description above. Would that be ok?
> 
> Sure :)

Sent, thanks!
Leo

> 
> - Charlie
> 
> > 
> > Thanks!
> > Leo
> > 
> > 
> > 
> > 
> > 
> > > 
> > > > 
> > > > Do I get it wrong?
> > > > 
> > > > (I will send an RFC 'fixing' the code the way I am whinking it should look 
> > > > like)
> > > > 
> > > > Thanks, 
> > > > Leo
> > > > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > > > -- 
> > > > > 2.40.1
> > > > > 
> > > > 
> > > 
> > 
> 


