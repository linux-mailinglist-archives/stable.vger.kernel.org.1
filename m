Return-Path: <stable+bounces-8296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35381C3D1
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 05:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855DC285E3C
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 04:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F088020FB;
	Fri, 22 Dec 2023 04:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rd3RhuE0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765F8F5A
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703219034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cnx8DhX5IecGWHmZB5Qoq5HltIXeldgLEw/ZWTgki2w=;
	b=Rd3RhuE0lhvRJJCj44lv0wXH9PXcDIFT95QvS67sZNtFVKg3kn8Cb6zE4POOLNwXqm7kBp
	QL5jknOX37vBY5m8enowLCZTctDa9vtXgytguauo+9nmToC8f7s1wcBoGIU5QcUngszqXG
	F+vzW3RMs+1eE5lPP91NANbfbyt5Tds=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-WqcG6FmGP9uJ3W4R9Vb4iA-1; Thu, 21 Dec 2023 23:23:52 -0500
X-MC-Unique: WqcG6FmGP9uJ3W4R9Vb4iA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28bc9e1f43eso1381228a91.0
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 20:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703219031; x=1703823831;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnx8DhX5IecGWHmZB5Qoq5HltIXeldgLEw/ZWTgki2w=;
        b=kNmOp64S4J+9vKCETFohf0LqLETqbm1skZEoGclkiOtd+jiCYO66NbRC9MTzeVJ6y0
         +ylZ9pPmSGCRK2RbfHbrOvbrZvWdrKsdFnRxaeMub96k/5j+bM4kqV306tPGmt2LaM1x
         pbiifYUzsnbv1FziYPNHnSXcTqnWsfO0pF7TJo016nePnT4Wac5vY2HBwYnVcmpYkVVo
         WNDmTvMFV8S5UsEe5YJ8x/i/PxhIHdK0cicBij0eCV+OSH7Ndp7WgMW3TLs6FAzIfMEu
         yO2s8+2vHG0QBNsmkcASP8uyTqqAmjA6JpCMlUucqD8Puxf4BeNiXRRd+y1+IoiqWK40
         gfIA==
X-Gm-Message-State: AOJu0YwZctfv7qvGeaLyeyZZqhlEjg/bGL7EQxITjyzDHA0LRmMLK73b
	9aT6pQj+5iHtxUyJWbYH3P+bnurHDBxgjVwxZ4QIxAqi3l1xBB3SkLiduSWWerfjkqg4AcW/5lm
	rUdSrJXaOhZS4CI/U0QhkaDvl
X-Received: by 2002:a17:903:41c9:b0:1d0:6ffd:9e06 with SMTP id u9-20020a17090341c900b001d06ffd9e06mr617804ple.88.1703219031133;
        Thu, 21 Dec 2023 20:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGPjTlXEJTe6N+AgEZwTc+WV8ng/X9Qz5/P34IiXFuimkgh7AxgOFC1oVCPdh5w/dkLxedfA==
X-Received: by 2002:a17:903:41c9:b0:1d0:6ffd:9e06 with SMTP id u9-20020a17090341c900b001d06ffd9e06mr617788ple.88.1703219030811;
        Thu, 21 Dec 2023 20:23:50 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001d1d5fb96f9sm2497743pli.27.2023.12.21.20.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:23:50 -0800 (PST)
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
Date: Fri, 22 Dec 2023 01:23:29 -0300
Message-ID: <ZYUPQIJ070BYDzJJ@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZYUK2zUHjYBL0zO7@ghost>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org> <ZYUD4C1aXWt2oFJo@LeoBras> <ZYUK2zUHjYBL0zO7@ghost>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 08:04:43PM -0800, Charlie Jenkins wrote:
> On Fri, Dec 22, 2023 at 12:34:56AM -0300, Leonardo Bras wrote:
> > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > > 
> > > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > > directly.
> > 
> > ok
> > 
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/processor.h | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > index f19f861cda54..1f538fc4448d 100644
> > > --- a/arch/riscv/include/asm/processor.h
> > > +++ b/arch/riscv/include/asm/processor.h
> > > @@ -16,15 +16,13 @@
> > >  
> > >  #ifdef CONFIG_64BIT
> > >  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > > -#define STACK_TOP_MAX		TASK_SIZE_64
> > > +#define STACK_TOP_MAX		TASK_SIZE
> > 
> > It means STACK_TOP_MAX will be in 64BIT:
> > - TASK_SIZE_32 if compat_mode=y
> > - TASK_SIZE_64 if compat_mode=n
> > 
> > Makes sense for me.
> > 
> > >  
> > >  #define arch_get_mmap_end(addr, len, flags)			\
> > >  ({								\
> > >  	unsigned long mmap_end;					\
> > >  	typeof(addr) _addr = (addr);				\
> > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > > -		mmap_end = STACK_TOP_MAX;			\
> > > -	else if ((_addr) >= VA_USER_SV57)			\
> > > +	if ((_addr) == 0 || (_addr) >= VA_USER_SV57)		\
> > >  		mmap_end = STACK_TOP_MAX;			\
> > >  	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > >  		mmap_end = VA_USER_SV48;			\
> > 
> > 
> > I don't think I got this change, or how it's connected to the commit msg.
> > 
> > Before:
> > - addr == 0, or addr > 2^57, or compat: mmap_end = STACK_TOP_MAX
> > - 2^48 < addr < 2^57: mmap_end = 2^48
> > - 0 < addr < 2^48 : mmap_end = 2^39
> > 
> > Now:
> > - addr == 0, or addr > 2^57: mmap_end = STACK_TOP_MAX
> > - 2^48 < addr < 2^57: mmap_end = 2^48
> > - 0 < addr < 2^48 : mmap_end = 2^39
> > 
> > IIUC compat mode addr will be < 2^32, so will always have mmap_end = 2^39 
> > if addr != 0. Is that desireable? 
> > (if not, above change is unneeded)
> 
> I agree, this change does not make sense for compat mode. Compat mode
> should never return an address that is greater than 2^32, but this
> change allows that.
> 
> > 
> > Also, unrelated to the change:
> > - 2^48 < addr < 2^57: mmap_end = 2^48
> > Is the above correct?
> > It looks like it should be 2^57 instead, and a new if clause for 
> > 2^32 < addr < 2^48 should have mmap_end = 2^48.
> 
> That is not the case. I documented this behavior and reasoning in
> Documentation/arch/riscv/vm-layout.rst in the "Userspace VAs" section.
> 
> I can reiterate here though. The hint address to mmap (defined here as
> "addr") is the maximum userspace address that mmap should provide. What
> you are describing is a minimum. The purpose of this change was to allow
> applications that are not compatible with a larger virtual address (such
> as applications like Java that use the upper bits of the VA to store
> data) to have a consistent way of specifying how many bits they would
> like to be left free in the VA. This requires to take the next lowest
> address space to guaruntee that all of the most-significant bits left
> clear in hint address do not end up populated in the virtual address
> returned by mmap.
> 
> - Charlie

Hello Charlie, thank you for helping me understand!

Ok, that does make sense now! The addr value hints "don't allocate > addr"
and thus:

- 0 < addr < 2^48 : mmap_end = 2^39
- 2^48 < addr < 2^57: mmap_end = 2^48

Ok, but then
- addr > 2^57: mmap_end = 2^57
right?

I mean, probably STACK_TOP_MAX in non-compat mode means 2^57 already, but 
having it explicitly like:

 else if ((_addr) >= VA_USER_SV57)                       \
         mmap_end = VA_USER_SV57;                        \

would not be better for a future full 64-bit addressing?
(since it's already on a different if clause)

I could add comment on top of the macro with a short version on your addr 
hint description above. Would that be ok?

Thanks!
Leo





> 
> > 
> > Do I get it wrong?
> > 
> > (I will send an RFC 'fixing' the code the way I am whinking it should look 
> > like)
> > 
> > Thanks, 
> > Leo
> > 
> > 
> > 
> > 
> > 
> > > -- 
> > > 2.40.1
> > > 
> > 
> 


