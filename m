Return-Path: <stable+bounces-27402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEB8789A0
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 21:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C45B1C20CD0
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC483ECC;
	Mon, 11 Mar 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="TkX9D18Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F013C0C
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189818; cv=none; b=LXAONggh+HSmQF807vqXCRsZEMxwJHaXClPfrYXfQ54FRm6cQG+KSmg8sF4KlarVYliFEuK7m3LXg0gJq6+qfxsxWliute+0YcMA42pyil5xewxQIwZOjavYtviT6xtf6kPjTIi7yZOdkVPpbyV8Us7p9LXu4dpzv1Sw8uI62u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189818; c=relaxed/simple;
	bh=ffFTjWUwjKJk2wn3H8xQs7+Dr4egWeva9itiCSg0Pds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcUmFmtrw6rv5pEqTk5JyU9CDfJoI8BJCQxs+aSDYw3rsjD6wcfME0rPZPCEDwcD/iV6H9Od5ERe7YgOzJ5lXJi/yvURYFXzzlnRnFdfUBkpzUIaQgClHvQU5mrOgRd2DFiVIxY+U+gQxiQD60tJRO2IQjcUKKV8JoORywuLyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=TkX9D18Q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e4b775e1d6so3320013a12.1
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1710189816; x=1710794616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSMbt8SBlxm6Ph+X2EK++FswYcdkJc9GASrRfqLnHIA=;
        b=TkX9D18QJLlFyRdRG30CYiVi6qpaNuz+kkgDiDd5J3jIyxyA3bbEF1OXna9WTZaHDx
         /05gGeyzBoKn/oc9Spg30J9EhNGPJwT5sfWfygeQdL1g4DOEoAadPPt4UtzS8vAwJSco
         XHRRKu5qD1ZQ4BHUHH7+RHuKAf+45hLNASjjAv7kNf1g4OM78xtxKfruVYG0//mpzh79
         0nV1qy4TM3wEt8LE8kEE3mSjsVBjfbgiWtXHUWEYz0O8YA2N70FbcGBu4KJr20dAGDkZ
         cR88Sa1BtTIMifmYXIjFpezhf9/ICASh/hPgl8P/STqfu2pf3W5OMUOMz4DHde7pzrxG
         qJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189816; x=1710794616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSMbt8SBlxm6Ph+X2EK++FswYcdkJc9GASrRfqLnHIA=;
        b=dBZ9lorIIA+KKY2VwXI2y/I5Gyjngl3LuA6uGvqc62NMg2VUMT1x5PrTgRYsPwpA+n
         f9FUk5DFd7LD4dII0pr31ouieOZNCXXpR1t4o+8YA7H5F9JEWxFcFWyuPICDy8M/WmOT
         bKSbQxFfRcSI0ra60KXRKSHw3rSP080SYUomAifZwK+HqaOMn+AJG8qoaCcqH69fmSRU
         hWJqNgK+RkIdC7Altvbhv7R5tG3vg4y71OGunfQA09j5CgNU/ZXqaINb9ll5q1qMzqzW
         nILV9qwt5azASgdgiJG8my/RGiVKSYW+jppzHoiFrFnFAl3Tfcb2J1h9U1Y8Ij6RiYSW
         eilg==
X-Forwarded-Encrypted: i=1; AJvYcCVOQhQ270DjWXmEn5pHeWPzMxZVZBkj6bab1kYlHfzf8oi22I6jKu/hpTs+0tQpQdYLRah0Qi31GE/U1+/LqTyvnVZhs8i/
X-Gm-Message-State: AOJu0YwLZIOAGzumjPXcohjzr8VF52w0rgD4RfNf3jSHd4w+HQtWus6n
	aL2U+0p6U+hGa6xy9Z7oaTsOi1O4CHcWZebbGb0epMxH/9s7GbFWapuJhg0vcr8=
X-Google-Smtp-Source: AGHT+IFI8S0cvDkzKsHH2FpOY4kyymcvH6/OLB/ZeoDIQrcOe7DhSL5TWGwsYWqI/wA3KH+4d8tiyA==
X-Received: by 2002:a17:90b:124b:b0:29b:a1de:32d9 with SMTP id gx11-20020a17090b124b00b0029ba1de32d9mr10720065pjb.18.1710189816372;
        Mon, 11 Mar 2024 13:43:36 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:500::7:5177])
        by smtp.gmail.com with ESMTPSA id cv8-20020a17090afd0800b0029bcf62e296sm4100584pjb.42.2024.03.11.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:43:36 -0700 (PDT)
Date: Mon, 11 Mar 2024 13:43:34 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH for 5.10-stable] x86/paravirt: Fix build due to
 __text_gen_insn() backport
Message-ID: <Ze9s9vIC9S-40kRO@telecaster>
References: <20240227131558.694096204@linuxfoundation.org>
 <20240227131601.488092151@linuxfoundation.org>
 <ZeYXvd1-rVkPGvvW@telecaster>
 <20240305112711.GAZecBj5TMaQDSz6Ym@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305112711.GAZecBj5TMaQDSz6Ym@fat_crate.local>

On Tue, Mar 05, 2024 at 12:27:11PM +0100, Borislav Petkov wrote:
> On Mon, Mar 04, 2024 at 10:49:33AM -0800, Omar Sandoval wrote:
> > v5.10.211 is failing to build with the attached .config with the
> > following error:
> 
> Ok, let's try this:
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> The Link tag has all the details but basically due to missing upstream
> commits, the header which contains __text_gen_insn() is not in the
> includes in paravirt.c, leading to:
> 
>   arch/x86/kernel/paravirt.c: In function 'paravirt_patch_call':
>   arch/x86/kernel/paravirt.c:65:9: error: implicit declaration of function '__text_gen_insn' \
>   [-Werror=implicit-function-declaration]
>    65 |         __text_gen_insn(insn_buff, CALL_INSN_OPCODE,
>       |         ^~~~~~~~~~~~~~~
> 
> Add the missing include.
> 
> Reported-by: Omar Sandoval <osandov@osandov.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/ZeYXvd1-rVkPGvvW@telecaster
> ---
>  arch/x86/kernel/paravirt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 5bea8d93883a..f0e4ad8595ca 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -31,6 +31,7 @@
>  #include <asm/special_insns.h>
>  #include <asm/tlb.h>
>  #include <asm/io_bitmap.h>
> +#include <asm/text-patching.h>
>  
>  /*
>   * nop stub, which must not clobber anything *including the stack* to
> -- 
> 2.43.0
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Tested-by: Omar Sandoval <osandov@osandov.com>

Thanks!

