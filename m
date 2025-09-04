Return-Path: <stable+bounces-177732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C426B43DB4
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A25A2397
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D32EFD81;
	Thu,  4 Sep 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="CxpSSWPx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E72D3737
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993839; cv=none; b=eZX0QXYAE9LN00LBtITRXpjSsFU83IQBklZYMpqhTatliUvwUsReTCWz6b42NuAaeGo1rfRvTWQUTBlxsIUM6OV6Xml/C4I3VLHURasHGoJe1XciKGPMs9un4AiAMGjkFriWUisZjNVADclP11bv3VzV2oWUfZm21mzzCFmSkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993839; c=relaxed/simple;
	bh=mo4sgaKZOpF6fcEiPQVuRCY4Rqd4Fs1IcnZ2aA6pidk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtwMzWq9VdoJL5sYW7x06gnbP6car2OvUVbjkyy5+HiC1dgUKvHb4q4MdBS03gxSglnSu8hfVq58rdiSw8pKv7hsTCx9brLigulUsFfsnucpgaf6wGk2akCKiET5pFIFtv1e4ffu7DAaehlTwTlq1ozkhSevC5ydagY/Be8QfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=CxpSSWPx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458272c00so12988575ad.3
        for <stable@vger.kernel.org>; Thu, 04 Sep 2025 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756993836; x=1757598636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlQ4Sx6+JNm7Anzsg6uLNnjJoKTjxwqCeqz7s3XShYk=;
        b=CxpSSWPxAv8JfOr+XK17IrZ1utzByIiXkB365Q4ObD8u6mIa/RIn4YiRzQU+8HNTsT
         cC+d1DWqnyNLDwTjXzE5RSnRGFOS9diJfB8ZIXhxX2IWa7ok5sa4YFLh+Eikz3L4NSEd
         I2tgy0dI+nWobzzJVvIa8EC7uM7E+kG0Mi8vNuf5FShYTwJgkYcb8LEwvapKbefDZS0O
         ategc6kVxuewKCN2qvnQRDJXuBNhrCaWdTO7rxdHiBgKAJCIkBXrlLPRZcMHhscP1fJ5
         ErvHFOgkToZBkEnhsneQ+UCoIP+m10vzGnpYVNJjVox23+XfvhiDrK+zsOeCqW31GT9m
         qOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993836; x=1757598636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlQ4Sx6+JNm7Anzsg6uLNnjJoKTjxwqCeqz7s3XShYk=;
        b=vIRepjqN/PbUOeUcZEAFUiFqKfnTN0h5QA+MpCosMzgL+xEZYWoa+exKLDRArILIxv
         ly6q8JtHQ9UuoYb84Hw++ww3kB8asCGEqzL6IMYNqH0K/xw2upHyMCWhWOqEs5jtLzgT
         AMk1Na4hQHQMS/kd4z+pWYIuFQmwncyQMyOmoKeKz5qXSAyVJgdsoIDoCggGsGdITprZ
         gIzeNMOmoaPbn/Xez7/Z+Z4gPoRX1xY6+ROUE+h6u9S7ECobPlgBkcbRhN3W5YhPm+TY
         hlL7SbWrcnSvoadZRTbMv+Te06B7I0cGyZ5Bt9mYA2XOCBg1FhYmEXATc+4efJ8R6H6K
         9L6w==
X-Forwarded-Encrypted: i=1; AJvYcCWrGsXzu17iJ6C0g0rYAHG76TrghflbAG2mCWyy/t+6kieednFTaqo/LPGCwDUb6lBKyIh1jeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6yBVg6/haBUpKvOtindypQb+EJ/6uNulltMC8dSJV6YesDzt
	bCGAUYh/vKuvcFrsgeD4f3N7yEX2acqPlz+9SAw0eal3CPcYZsQa/mU8AtDU33KV4MQ=
X-Gm-Gg: ASbGnctfM6TnLXimqZBd+p3a+DKfgaHMIjGbVV5h7fLN0MtON418cygeGppx5BEYzip
	APi9B/N66sl7RHEF+hvC8+1otrbFXBeRgTUea7F4WKaLjKsfQTlIYN7nrB4XYgpA64eYtYg+GWs
	YGEWg9rgq/kQko6iXKgNearrqdDGuKGhJyJkQO1+OBlGcPTveifvyLN+m2WGzOYCt/o/DCmojTx
	6xGXJ7/FhK/QnAWfE3Tg9srI8LAbioZXRAo2agm8s3n2yd+m9qSb6H/53Lfkp8ILr/0kWKreIT6
	+sgabmt0M1CLf1L2ufwhTqwmypM9jt4x1m+PAnaN2noRwEaQ9tr7gID4Lazw9VCMhOskpuXOrgX
	dYFsHOtPOgeTc64KY/RzbBqMu2FMZvNNP7hZL2vNmtqU9GPmk/t8JqCsQxsLtB9jewi8=
X-Google-Smtp-Source: AGHT+IE++qNRXBiBncRgnIXQY1GziFXTwGi/APCNRK270AtfnhaMl41kWTSkHeIknkyFSIhHul9yOw==
X-Received: by 2002:a17:903:37cf:b0:246:9a2c:7ecd with SMTP id d9443c01a7336-24944a9afe6mr259693895ad.29.1756993836464;
        Thu, 04 Sep 2025 06:50:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9952bccasm44979405ad.105.2025.09.04.06.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:50:35 -0700 (PDT)
Message-ID: <49bdcd0c-18ef-42ec-a71d-497bc6d6414d@rivosinc.com>
Date: Thu, 4 Sep 2025 15:50:24 +0200
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
 Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
 <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/09/2025 20:53, Alexandre Ghiti wrote:
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
> ---
>  arch/riscv/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 22e3f52a763d1c0350e8185225e4c99aac3fc549..551e7490737effb2c238e6a4db50293ece7c9df9 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -209,7 +209,7 @@ do {									\
>  		err = 0;						\
>  		break;							\
>  __gu_failed:								\
> -		x = 0;							\
> +		x = (__typeof__(x))0;					\
>  		err = -EFAULT;						\
>  } while (0)
>  
> 

Hi Alex,

I applied that and checked that the sparse warnings were fixed as well,
looks good to me.

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

