Return-Path: <stable+bounces-155127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B5AE1A45
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C4B3B6507
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E72F28A1C5;
	Fri, 20 Jun 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uMbZLKc7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4525E83C
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420347; cv=none; b=eRsfE1KlGfPmAINgzQu72muNVbOmzPuvLipz/O5cKSR9C9XiWefJ8R7wa8yVfWVRDV59vf5ble4z19KXe5GfG/E9CMD5IdO6l6meWCcFdEIlqblAKdagjn+BLK9TpnIjwbo+X4a+nJV2JomdyrJcksZ+lgJZ1TMU1uMZrn/LxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420347; c=relaxed/simple;
	bh=4Sx9MiZEkzQTOqPTHOV0KIKZIeQYY9r1ZxN2d4/+8+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QG9bv3lSw/SdlRP2DB/ltl52jyfxYKH3lmwkBnx40daHO4c6ldCqvo8YT3Ed0M9rz1s+faTCohYREg7vM4saKMpoIcIAd5SWYvDjqN3Vyeobk7OJqiOy/ZMfAM+WrrpfhRGEkS5KqCzcI3YvlqjW7yLg9tVrH9a9QE2sKp7pvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uMbZLKc7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso1160732b3a.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1750420343; x=1751025143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNPD3caLacQ3mJRAHDqinnGbqP8uVwxmMugF1g1Heu8=;
        b=uMbZLKc7fo2/8hMrmPZu91Szyi40BLIQsiVWoGBloHcEOueEJTa/uwv4LbCY63CcyU
         n7j6nBLCUu3KPa4UFkaBIuyqdGzYzq6Ci0aIEUBOf6p9fo4hb1/9RCCENlIDT4WkXMVV
         T4KIopk+FLVLLP6fLjRvlylhhM0cj+HIha45LZX0Mpv4YYf2yp+z4uBRdmQl//kVOjPk
         hscYKZ1+Bqarnb4XBQraAznVIFLzfcUtbx4NZ6rT/Yd7YQUq+AWkOxEe0QdNOa/xmEo7
         Ew6cmk8Cs8jZ8tG1i9t9D+sh8J6TtWvk4FCw6vZQGHa9zGCYB6SXVJZ/ylgYmYD85VE0
         S0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750420343; x=1751025143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNPD3caLacQ3mJRAHDqinnGbqP8uVwxmMugF1g1Heu8=;
        b=Kh4SVWS+92Yb5AlRHBu/OuMim71NnoWlxXqhSGN4xL5NgYPuN9m1FJtz+BkmvGHRY2
         L0RBBpnNaqNSLpgVYAYLAd2autN69vAfjT1Cc6iPMa/DmdkfQ3DCzyPv8ecE5VM2E4kM
         ruFDSAszSIUmFmOg9Zqghsk6ZLAB3UFIkgMgptr7L2dYT3q8CEHU6U+H9KuEDvGoLmWB
         BGyalL3SfZsgakNX2dfkzCZ5ROWp+pgAy+Divh4pykDFYLCbIm1QcNViWIVQnYwtH8bm
         BWWZbhKcK91n3lv4OH/sHg4uZKr0VqcHw1ZulIQbRf/SZHuba/gefNs2JwrUQ6G6P6Ja
         sfUA==
X-Gm-Message-State: AOJu0YyhduogMQbOgxZCsde8qdZ9kmyZWmk6duBbx3mSNwYQVpxw7eQm
	pILA5w14+W9jURjSqpZCMrUHctBKudPG2jHHbeNHcXaTyhbXW/rc9anz3F6oU7hLJSU=
X-Gm-Gg: ASbGncv50XEOSbcEN4tS/KFSsNa3aUN+qVQ8b+7KzvoHFRnDLqXavgmvm2eOij9gdRS
	Nhn9Xbzb1YUwMrQtMSfIxGuwGciN1Cj4wnRCIAeba414sfeQBllhDNzF37GUNaqTwweaYzq36tY
	7DYR9N2/hhZtkNtuqLxUVctRLoDMfZo+9CZl+PD7RUGGHWeXykNQTEG52oNXZ5AkYvGH/jU4jz0
	ovk6qCgkPRqwcsDqYo3krFIR930ZToM3DZcZbAA/eVzEpc4NQU7oh8TZFog80WUeJhDL6vHcvo3
	qrtrfFpvk+ank8b1IJ0JpL4A9peUggn+M3wVUjU2BHpVW5YBAcXWxLmp/Hwm+iHSYAv52CNueHM
	tIK+zkcdmmGmIDMhL9gGvsPJecX7wTjUAVVelryG1Lw==
X-Google-Smtp-Source: AGHT+IH+A11YxuprorYt1GU54KdKygUhbJ+NrGRjacRyjJFPFXl2ZTZ8ayflSWXljvQoqnmWXIlNYA==
X-Received: by 2002:a05:6a20:a106:b0:21c:fa68:9da6 with SMTP id adf61e73a8af0-220291cdb15mr3344166637.8.1750420343408;
        Fri, 20 Jun 2025 04:52:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a64b1c9sm1834000b3a.115.2025.06.20.04.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 04:52:22 -0700 (PDT)
Message-ID: <e435366d-f561-41d6-ad25-9f8c96e61f24@rivosinc.com>
Date: Fri, 20 Jun 2025 13:52:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: misaligned: fix sleeping function called
 during misaligned access handling"
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Nylon Chen <nylon.chen@sifive.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250620110939.1642735-1-namcao@linutronix.de>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250620110939.1642735-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/06/2025 13:09, Nam Cao wrote:
> This reverts commit 61a74ad25462 ("riscv: misaligned: fix sleeping function
> called during misaligned access handling"). The commit addresses a sleeping
> in atomic context problem, but it is not the correct fix as explained by
> Clément:
> 
> "Using nofault would lead to failure to read from user memory that is paged
> out for instance. This is not really acceptable, we should handle user
> misaligned access even at an address that would generate a page fault."
> 
> This bug has been properly fixed by commit 453805f0a28f ("riscv:
> misaligned: enable IRQs while handling misaligned accesses").
> 
> Revert this improper fix.
> 
> Link: https://lore.kernel.org/linux-riscv/b779beed-e44e-4a5e-9551-4647682b0d21@rivosinc.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  arch/riscv/kernel/traps_misaligned.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index dd8e4af6583f4..93043924fe6c6 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -454,7 +454,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
>  
>  	val.data_u64 = 0;
>  	if (user_mode(regs)) {
> -		if (copy_from_user_nofault(&val, (u8 __user *)addr, len))
> +		if (copy_from_user(&val, (u8 __user *)addr, len))
>  			return -1;
>  	} else {
>  		memcpy(&val, (u8 *)addr, len);
> @@ -555,7 +555,7 @@ static int handle_scalar_misaligned_store(struct pt_regs *regs)
>  		return -EOPNOTSUPP;
>  
>  	if (user_mode(regs)) {
> -		if (copy_to_user_nofault((u8 __user *)addr, &val, len))
> +		if (copy_to_user((u8 __user *)addr, &val, len))
>  			return -1;
>  	} else {
>  		memcpy((u8 *)addr, &val, len);

Hi Nam,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks for noticing that.


