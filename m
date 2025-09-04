Return-Path: <stable+bounces-177688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7542B42E4A
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 02:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B87D1C22771
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C31B4223;
	Thu,  4 Sep 2025 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="W8hd2uEd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E01A83FB
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946068; cv=none; b=d1jC4iTYeMeZXnF0SsQdBTw47JuclZQSOHasAYzRSt176JM+SUcl6FM18pKLc3W87dUAUfeEwIMcJVMRgZmY9HM52nhf7/8E1wwg+Kwu2A8/OLWsYjoYsAeBQk0cxSewC+TbvOiJ9caWwwvXKNlGvvOpkPXpy54TstcSy4KXB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946068; c=relaxed/simple;
	bh=g3TLz2gSRW1IlQ6fi2Xj28A7/PuM3Ybbs4o2E8dYe2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko1AAUcmU0Nlfm8rJburIP8DXjhXpdk59fNK7rRCPIjaYHS00+srgZYABWYbAhFDmJINA+A1AU3JukpN9UH3aRmyeRvXh6po5/g/JMAxZZDf6XVlBgs/DBGIGyxKwiX/Ny1awP6Eqv2K9QyZqZjrV3vJRdrLYghJlYEKd6NfkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=W8hd2uEd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323266d6f57so485857a91.0
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 17:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1756946064; x=1757550864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLTUD5tAnhy3ZTN7uw5PbelnC7/OP8Jv6iyZLCIi7Hs=;
        b=W8hd2uEdqbWsNAccfEe/lMPrTEWalB3z5UrCGHFlYFhcVPfIc2xIy+Ja8NAqvzUsyx
         GDT5iRivzxqnVOYGrj5PJPKC40+yNeDwbbHxFwDIa0Lq2UBKOJXoLZ9uD9knMLCj1Wsu
         PzO3fkGd6UK5GeiwA/tO2Qi5okHxqhmdWMmbfkMLo6rH21qY/Ar2GCQvIbKmdzAmAtmS
         z6PMU6sTlinGAy2SJOgxIe2vkcwLPB5yHdKLqwYIfixKlNosHYldcwLDf5g/7UC0ZLgf
         nnyq5CA6VLiSC4csem7xBHGYg/IdITabqte0IWfW1VXnXEqV/f9WdfES72EyCHg+ZJv1
         4DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946064; x=1757550864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLTUD5tAnhy3ZTN7uw5PbelnC7/OP8Jv6iyZLCIi7Hs=;
        b=SIpafCoIbM4aZf67NshD/Rxb/KMtVpLrwxZ4/pnreDV/m0b9KMUGevFl6WwEzEOw+u
         gqXMFk5Xigx9/0DEKEC7mZVHtqKcjFEt+WM3PtJFL7ggULGAC+sPUSsL4EHSRHi9y2SV
         /2Nn9yEcracUr4Ijx3x1Nxhkz+2HiokpfQxFOoycbkLXnY89RLXxdiUFuwMiVumqhVDJ
         zYsd6dtYesiGzRUYuJt1vlxlswf24QUn1f6vUlgJtqCZxE5s+Ign9fu+aBFZm9Ohvqb9
         g/iu3/TGU092xNpvjVq7VQXE1Pik/HudNyJzspV5FVFHbf2Rb7M3hERU6wuEV4wKEzf3
         pK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+PFGU38/RsUsH99L3rh0MNmHewQuZyXznSDDrWPPe8cDqROR+HQIsrD+MScS+DQrojvEW+dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZ2R0YP7K6wzyp6c/iuLg/NyhN/H8e5xit6MZ2swVBVZsfTJE
	hHfLdokmaDFY65OQFUgVegay6h48en4DllMMMhW/dKAfkgwFEmN3aPLiKiTR1iZBZw==
X-Gm-Gg: ASbGncv8JT00aF3O6LsPqGWLASwK+ct11LDCz+HUdtnm5KMJFVZlZKfU7XM5xCs/2RW
	dKs8k3DffdWwiNOTeKnYXYGRcKjjShTAqaS7VQViRYFN6H6BrHEW5kcfCZPKBKuCyPQwLxMZs5G
	V70ZPuD07Td1NuAu/ZVsbGQ/hcEJngWjCKkGDvVU/jtsXtEkmFP7UlV8utTrlQs/YhXdYX0qX5S
	r/F/i3EtIEhQITzKUYEoAMQ2ysKGqmCj47p8y2BEi80xXSsBubeMBJu2n2mjmgobUnkkEgl5Qa4
	G3DkUZWS5jn/6Phax+vj6COuxCzAXDTF9WHmyBZ+ouygMucT3hcc8VJhC6joS4jhF2MTBAnixNo
	pw14uF+qY5dfKElhZEm5P0AV7n6ItJZUOy2TiblLGvitRVQ26yg9NmA==
X-Google-Smtp-Source: AGHT+IFZIGiF6FH1F1iBzUKNv9BF9Pzhn7yHPb40iqlLiXlzirACFZ3W/rhu2h8VU7pS2JXdY2M8tA==
X-Received: by 2002:a17:90b:394a:b0:32b:8edb:12ce with SMTP id 98e67ed59e1d1-32b8edb1412mr1878452a91.15.1756946064198;
        Wed, 03 Sep 2025 17:34:24 -0700 (PDT)
Received: from [192.168.50.200] ([202.172.96.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4e5684da06sm12474425a12.17.2025.09.03.17.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 17:34:23 -0700 (PDT)
Message-ID: <be993fd5-cbfb-4517-b9dd-0607281d03bc@tenstorrent.com>
Date: Thu, 4 Sep 2025 10:34:17 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: Fix sparse warning in __get_user_error()
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
 <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

These two are on me. Sorry.

Thanks for fixing them Alexandre.

On 4/9/2025 4:53 am, Alexandre Ghiti wrote:
> We used to assign 0 to x without an appropriate cast which results in
> sparse complaining when x is a pointer:
> 
>>> block/ioctl.c:72:39: sparse: sparse: Using plain integer as NULL pointer
> 
> So fix this by casting 0 to the correct type of x.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508062321.gHv4kvuY-lkp@intel.com/
> Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>

> ---
>   arch/riscv/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 22e3f52a763d1c0350e8185225e4c99aac3fc549..551e7490737effb2c238e6a4db50293ece7c9df9 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -209,7 +209,7 @@ do {									\
>   		err = 0;						\
>   		break;							\
>   __gu_failed:								\
> -		x = 0;							\
> +		x = (__typeof__(x))0;					\
>   		err = -EFAULT;						\
>   } while (0)
>   
> 


