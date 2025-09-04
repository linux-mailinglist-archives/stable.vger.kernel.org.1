Return-Path: <stable+bounces-177689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16437B42E53
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 02:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBFE5603BF
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184719309C;
	Thu,  4 Sep 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Y4yJ6Xky"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108415E5DC
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946577; cv=none; b=UzxAtwHk5Me39JGMP/I18fF+/Se1oGB8FpJd6QnAHjFo4p+vs6/yOv8jJGqxkcLrf7EZsloURoPnYIe13RDHtzw3l5gEJEoawDiDNWbiuWgvnN3jEkTVwdcW1XToAOPUg5sH0/sB77nTturMNciu6qb4JqU8Ji/mQNAKk9tWRio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946577; c=relaxed/simple;
	bh=r9UQXonNNNzyBETC4b9TWEJirsTqEPpHNaR8afKeQKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PA/QBbvRGIK+iZ0qUNA8Ldnw/1sNBWZxtjLhC9pbxjldxFtfBQKVxq/WzjJ64Fy3iQ9kMpuGJGv4Wrnh9wSkE32zRMUl+K3nh+qVDrZBkoILLI6pWnQVhjrjAPxtxF3GO2oM96ykHaDZg7Os2JA6kgpulJl0d70bd9X+fbVSIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Y4yJ6Xky; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244582738b5so4214755ad.3
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1756946576; x=1757551376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRKp6Q/nB96pBMeqsdUtO6CB8seNwZ89Vp0VznvbBKw=;
        b=Y4yJ6XkywYZGmPAUPxNlZvyc30IewVvhCmmHhPnaLmsbmYvTJi/7Y9lR+WhHIaH2hF
         d4hXbP/rsbSEWNqfrPrdHJCzSj4dZz+rDTxMW4w4IV5em83awLIZce6L0ymBZAcRlc34
         QB5wNHk4339qhny40ilCp0lc2rl3Cp2lCRkZO3PB+0xANvF/no/EXSXPIZy2/KiPmws8
         L8NskxrvRczBTQ8QobhL2BmmoPLpK0l8eRQwsQ3+Py1qmBxlyUHxXFDl1Ttuhm8swKjb
         GKYH+dH4WE6kQgsqZsnM77n8Zfy5/eCe+gzrWpj5Ac/rK0gUphKQl4BP/LaoMgyScDsn
         pRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946576; x=1757551376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRKp6Q/nB96pBMeqsdUtO6CB8seNwZ89Vp0VznvbBKw=;
        b=L7SmHybZMz9XrmKcIe3UScW0hP6CWuAN+Zwb3U4GPKXVHfqs+6rvOuKQnoJlhNtX6N
         oxtIB0kWgKc+NJy+Yv7ZLlLGGpZs+BhtyIDwVx+meRKtJxgUUnATz9Iaeft0AmXPHjmC
         apBfYO7SAgh1Fxv9hQK/uNg0AjQaTP7hapOzxlxCa0nrdq5zlK1pN2JxILVQ/p8+xihv
         CblVA20wJzbsnIXSz8I2U5QD4AD2CIsJM8Gc2ZqTVuynII5bip6QCikwRWnNJeIL7NQV
         6mLjDiMfVIieSXAeI6BXOUrPX6zARgE2gq9znqA1AXOZjuT38hTopuslZwyTGM7YOwKI
         fZmw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ge7ihxWKnsGq7B4u0ndDIvOaauo6nY8HZ6Tu4n7L/4unSOWAYCeu7fHKZm+WGuowWpF50oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6fvkHU4OzV1hNdG3Ua3RkJxb1mWdmD3vZkviUHNX6ltCMaKZ
	Aopyh3qIdEWrO4YhE3r8EBfrbTxhtrTHNVVBnDIap2zvEpgv38gaSL/RPc0pU+J2Iw==
X-Gm-Gg: ASbGncvbW3BwJV6fezhTHB23vCuAd2Qa1YZCLhnTF9JHVd+s5TEJBbhdUMHwZImu4Kn
	64cShKGKwr0npZ9iCC7keleZkAQo2OiMYGZaYe9UdZ6gSVWB7wOQxbGxGUPOLzDmLqGXRFFqeqr
	m9N3l1SN3EOUDNFTzO5TimxKIIa36fZaNKTngnde7IFMyL+sIlJ/MZLZYXKPvtDC+7hHPNdL17t
	/OhPh92gfC1ShH7J+VpU7gaaguE51kQHDYt5WldJv9J6Y7/skHt1TA5RRxmSbUg7z+sFkfXb6an
	zZrWsyeAo7v2FSBjgiP0X53JGfRM7/QAiRxyEbZzkiR2sMSWVImRht8Ccfj/Q0zhWubwGY2cCsU
	/mNj4DFSmE/YhxSAWGu3rMjjqK91ZzSsqbINlGI6azCC55Fn/1afQPw==
X-Google-Smtp-Source: AGHT+IEchyLbqCG1IttpCNZB5tDBBfo2NCjV8oSKclrFTZ9oZqLEP1Wpq2MwEz6HMGThU9nnXWM2cA==
X-Received: by 2002:a17:903:3847:b0:248:e3fb:4dc8 with SMTP id d9443c01a7336-24944aa2905mr245867995ad.39.1756946575545;
        Wed, 03 Sep 2025 17:42:55 -0700 (PDT)
Received: from [192.168.50.200] ([202.172.96.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ca41746casm24333915ad.48.2025.09.03.17.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 17:42:55 -0700 (PDT)
Message-ID: <2fb511b8-4841-40e1-a364-e52dad51e300@tenstorrent.com>
Date: Thu, 4 Sep 2025 10:42:49 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: Fix sparse warning about different address
 spaces
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
 <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/2025 4:53 am, Alexandre Ghiti wrote:
> We did not propagate the __user attribute of the pointers in
> __get_kernel_nofault() and __put_kernel_nofault(), which results in
> sparse complaining:
> 
>>> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
>     mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
>     mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *
> 
> So fix this by correctly casting those pointers.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>

> ---
>   arch/riscv/include/asm/uaccess.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 551e7490737effb2c238e6a4db50293ece7c9df9..f5f4f7f85543f2a635b18e4bd1c6202b20e3b239 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -438,10 +438,10 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>   }
>   
>   #define __get_kernel_nofault(dst, src, type, err_label)			\
> -	__get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)
> +	__get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
>   
>   #define __put_kernel_nofault(dst, src, type, err_label)			\
> -	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
> +	__put_user_nocheck(*((type *)(src)), (__force __user type *)(dst), err_label)
>   
>   static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
>   {
> 


