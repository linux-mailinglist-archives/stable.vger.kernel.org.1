Return-Path: <stable+bounces-27558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EEE87A1E6
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 04:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBE9284E66
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229EDF67;
	Wed, 13 Mar 2024 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D6R7ZJ6o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF872F55
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300131; cv=none; b=Pk528Wu8FPfGNaFb2qRkgddsojln4hVRPVD5zSvx7iygqcaXnnZiR7EApt9/BPjI9GebrvAub11kufqKvRwzWznezi28lOR8pzpipMaMMNC7OSsf37SiRyeu1yvFsKuszz9BAPG5Ti2SRH3HDNvAd+zSpprH/6Xd++JBIlf2aAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300131; c=relaxed/simple;
	bh=WvRl61h3ByfZ0HysVdiQuStQNgkNDHIT84WHFO+RzTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN+8TqMSG9J+cVuUVgQOkMKbymg7jCJnl4biA9Hi2o9rVIyOkU36BSzTYyNT6rR49UOTZ+wViLAWn91TfuxsEpY34Pcy0kkDtiA+mko0WGmxpMxpnl2iTz6/YuFNfbHUp8D5rwsrXOe6NndIMJ8JBqVK4IM4Hp9+7mtMxxxfgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D6R7ZJ6o; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so2867245ad.1
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 20:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710300129; x=1710904929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrBUCaeV/dwaHFNXHKFwRp9ZoTbxAso4k6A0KIx30Kw=;
        b=D6R7ZJ6op4dtE0foDJ91RypEUmJoE0bdR1AqhxjgCYkAzKYMziC46vQUymW0Xi4XVL
         BkKH1bfxpfEe+liwrYMD17ZpDa3vrhXK6Wztk/0mp5sJkn78SWwz4DJ4Lg6LGA7OvUTo
         e9rdjNBCpTjebxkbD7PZlLV9KLR4qn5mttG8x/nPiz8ZtXAZmGI+qxA41+XErytX6QX6
         9NZIXgJChKuSmws6JgOYe6zT+eVH6cezV5ie6fzs/vhlcXG99cFSQ6wQT/WHvTNRWupl
         5nImAWuOc5s+86NBt9+TIbAM9djraCg13K9ir4ujbIzl0gIJ1e+DIWHNalaqds1o/Nbr
         wN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710300129; x=1710904929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrBUCaeV/dwaHFNXHKFwRp9ZoTbxAso4k6A0KIx30Kw=;
        b=cng7vLrNePci3E2sWGbqUrQ4WGHsYQ0xh8LE/Wu9r0Vi44qhQTlgMbmrGX47OHjYV7
         +QJVOcV07XBb2LirzwkQzJyIsyYnDMlII+DlwoLLG/Z0q6a+mwkfEHS+3iFCjLh5i9DP
         w2GBVaV9Z2UMwSKhQvfTvYQIUd/wIJGp4d8LBL8qkmUeSvSS9jWhDzRY9dQOQW53lLbz
         GgLTsHOs4HxK6kwV27E7hyMF6kuVtx/CO3uCSkJ8wlzU2SYzaZ3HC3twarvYtYYpSQYf
         QFZ2docaF0xUsc4+05EU8qIyieJVXY0vSzW/0R4RGxGjj30XaG1aufbXt3wRL3L0xDpk
         vaMA==
X-Forwarded-Encrypted: i=1; AJvYcCUVFcQRG6IuTFx15UuRrwdKieWt/Hdl3iced+DlOeJQjIBJ7TVrmbsQYGsS7jju4VLFlEe1fcYUabY5pmweBudFmO57vhz1
X-Gm-Message-State: AOJu0YwL5IfkEOxlwyTjHn0d6mVOvfy97mgFPeg4zYceqTzQ14W5Havp
	ktiM2MPOT35n7vOFtWJTr3wLHGpwgeVmyYRDmKz+Qqk5N8rmxpYp/JoyRAHGBMU=
X-Google-Smtp-Source: AGHT+IFKhNUh1ZNzl325ce9f/jj/4HvlL+NSmK1isj6lq+0XGv0m2rrdpwNhKz7ZPF9fQSmUeSmvTA==
X-Received: by 2002:a17:903:1c3:b0:1dd:8a51:7b49 with SMTP id e3-20020a17090301c300b001dd8a517b49mr2048372plh.15.1710300128657;
        Tue, 12 Mar 2024 20:22:08 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:733c:479a:4b7b:f77b])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902ed1500b001d9a42f6183sm7466890pld.45.2024.03.12.20.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:22:08 -0700 (PDT)
Date: Tue, 12 Mar 2024 20:22:06 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix spurious errors from __get/put_kernel_nofault
Message-ID: <ZfEb3tCCcXjAfgbU@ghost>
References: <20240312022030.320789-1-samuel.holland@sifive.com>
 <ZfEVNbt9AMeVJS0k@ghost>
 <06ebe952-c872-4406-bcb9-00b0b892fb6c@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ebe952-c872-4406-bcb9-00b0b892fb6c@sifive.com>

On Tue, Mar 12, 2024 at 10:05:37PM -0500, Samuel Holland wrote:
> On 2024-03-12 9:53 PM, Charlie Jenkins wrote:
> > On Mon, Mar 11, 2024 at 07:19:13PM -0700, Samuel Holland wrote:
> >> These macros did not initialize __kr_err, so they could fail even if
> >> the access did not fault.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: d464118cdc41 ("riscv: implement __get_kernel_nofault and __put_user_nofault")
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >> ---
> >> Found while testing the unaligned access speed series[1]. The observed
> >> behavior was that with RISCV_EFFICIENT_UNALIGNED_ACCESS=y, the
> >> copy_from_kernel_nofault() in prepend_copy() failed every time when
> >> filling out /proc/self/mounts, so all of the mount points were "xxx".
> >>
> >> I'm surprised this hasn't been seen before. For reference, I'm compiling
> >> with clang 18.
> >>
> >> [1]: https://lore.kernel.org/linux-riscv/20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com/
> >>
> >>  arch/riscv/include/asm/uaccess.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> >> index ec0cab9fbddd..72ec1d9bd3f3 100644
> >> --- a/arch/riscv/include/asm/uaccess.h
> >> +++ b/arch/riscv/include/asm/uaccess.h
> >> @@ -319,7 +319,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
> >>  
> >>  #define __get_kernel_nofault(dst, src, type, err_label)			\
> >>  do {									\
> >> -	long __kr_err;							\
> >> +	long __kr_err = 0;						\
> >>  									\
> >>  	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
> >>  	if (unlikely(__kr_err))						\
> >> @@ -328,7 +328,7 @@ do {									\
> >>  
> >>  #define __put_kernel_nofault(dst, src, type, err_label)			\
> >>  do {									\
> >> -	long __kr_err;							\
> >> +	long __kr_err = 0;						\
> >>  									\
> >>  	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
> >>  	if (unlikely(__kr_err))						\
> >> -- 
> >> 2.43.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > 
> > I am not able to reproduce this using Clang 18 with
> > RISCV_EFFICIENT_UNALIGNED_ACCESS=y on 6.8. However I can see how this
> > could be an issue.
> > 
> > Going down the rabbit hold of macros here, I end up at
> > arch/riscv/include/asm/asm-extable.h where the register that hold 'err'
> > is written into the __ex_table section:
> > 
> > #define EX_DATA_REG(reg, gpr)						\
> > 	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
> > 
> > #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
> > 	__DEFINE_ASM_GPR_NUMS						\
> > 	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
> > 			  __stringify(EX_TYPE_UACCESS_ERR_ZERO),	\
> > 			  "("						\
> > 			    EX_DATA_REG(ERR, err) " | "			\
> > 			    EX_DATA_REG(ZERO, zero)			\
> > 			  ")")
> > 
> > I am wondering if setting this value to zero solves the problem by
> > hiding another issue. It seems like this shouldn't need to be
> > initialized to zero, however I am lost as to how this extable setup
> > works so perhaps this is the proper solution.
> 
> extable works by running the handler (selected by EX_TYPE_*) if some exception
> occurs while executing that instruction -- see the calls to fixup_exception() in
> fault.c and traps.c. If there is no exception, then the handler does not run,
> and the err register is not written by ex_handler_uaccess_err_zero().

Hmm okay I understand thank you for explaining that. It's interesting to
me that in __get_user_asm 'err' is set as a read/write variable even
though __get_user_asm doesn't write to it. However, it seems like
changing it to a write-only variable the compiler incorrectly optimizes
err, and the kernel fails to boot.

> 
> If you look at __get_user_asm(), you can see that the err register is not
> touched by the assembly code at all -- the only reference to %0 is in the
> extable entry. So if the macro that declares the error variable doesn't
> initialize it, nothing will.


Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Compare __get_user() and __put_user() which do initialize their error variable.
> 
> Regards,
> Samuel
> 

