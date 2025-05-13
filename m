Return-Path: <stable+bounces-144151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE59AB507C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2A21639E7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F346523A989;
	Tue, 13 May 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqsqlX8c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BA1B4159;
	Tue, 13 May 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130210; cv=none; b=kB7DQeh5CgFS1XuQtVQYbUOCNo0TB521HE5ROabSkYUBRberatX0AX3cLRt5Zdk/7q16Y1VifuwwLyatpq7aOBEwbCpMm62Gix3AvKXM7Z3Kn4UF6SRSSLbJ+Pbc3I71F61V2c4g4q6G7IX24oFg5/n+fdb9mSegaiSeOXj8snI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130210; c=relaxed/simple;
	bh=n5gTUq2A3cCjXQBJhBdlD3VabhPk0+yoS1TtRQ0hUB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwJdB8Y5ul+sn4bbwNHetlTt0vHu0PQl/25vt8SoowJLVGdegu1RaaIe0OUGvSnDPTdLl0QK65S8UjUYInx9n2PAWk986ZZ9xsZnbGIFS85P79VCv47OFg2P7XFK9xU33WDgDcT4zRjhZnRegk3bWoEe4mMuJ92Uq40dsoSrxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqsqlX8c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426c44e014so1857148b3a.3;
        Tue, 13 May 2025 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747130208; x=1747735008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pki/EgZscy894vyU92aEAzZPOJKRmJJ4M9eubywYQm4=;
        b=OqsqlX8cGmkD/aqJl6Jofbbar0NB0Se6nfozYDBuOlfTIBvYWcbCMnRJaeYbLq2Cft
         bVN8sRpWAn/Daq0AH2J+f9Dfd0EQKN9TsCNP1zRYl6ui7gqC+3JIzqu6FAcgDCaSCtxh
         pZuF6r3EtnQ+0MlBdqkDKoda5yLh1Z7jKje8EfK9BK0JZsMh6PGCpJsRojvMvwMFzA2Z
         788hOwgzkwQtRgHsTUJtL/Oj1owIVQpSHQfk6jp8VMbnUCN6+/59qke2yObAIXS2xw17
         vqolJx2mpb7WXdYVQjwYjgAxdZVx8w5HUYUIUqA9lPgNGbr5ie2IPqhAkZGuBC58ApXr
         rnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747130208; x=1747735008;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pki/EgZscy894vyU92aEAzZPOJKRmJJ4M9eubywYQm4=;
        b=cAdkWJu/Qf+r1BIxeSoZAIlXZpZbtnRZI0RgQp4PwaOphECoOIyPpwG62u9og3pvqi
         Ix1089jDg2d+kzAc1C+VawW1zAXFqaj05EY9RDHEFENFpH4+Rr5T9eQj4BsDLkK4evDY
         g9smIN3QfHFyPYOaDXnYKffvsnZDElIGuO+dyKB0L4B+H/8zmA8fxNcdL26yrexNZRBm
         WsswfxM4yhgPf4HfiWuNubfHDdUzftt8iQgpW83SPlrIZNKL+ntztJAv3advqwMSXIiE
         3TbX/aQzuAz709wVEEq+E6CZACsvCTm0SuH/073PVBaSH3vcE8lfJvnAxjjJJOuyR7m2
         wt/A==
X-Forwarded-Encrypted: i=1; AJvYcCUrA+eRm5qJoKEIA/e/yKBJEupkVA9FyYUuC4MYMm4UvxTJulYe69D+d/tgw9yNCpn2AgKuyiRB@vger.kernel.org, AJvYcCW0H8Uy+SGZyNeD3csPsSbu7lYDiXH8iZu9kTCKzYfVq7aOeh0GU8nm/NjIB366CncQLzvAuTbtQz45b6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVM2ChhMyku5fKann/ks9J4oW08hItVKciTl0yWx9lUsIZ/YpA
	z4kLqHCAmVoSgO6j+Sl0ka2qqEVS2VG+OSVAPMrhU5/RF4woPBrj
X-Gm-Gg: ASbGncs6i5YmCVt2FJewKaUtX9ZK/4u1X5c7+T2X5qsCYQ8+vbeGfcWSYc8aoqiYqSL
	hNfVyNvZ0POZwb0dNwZdVtr4WnfcjEcLc8CaJw2S2649TBqXgycX0jBNaJY2IbYVtH86t1LMYka
	is476QPB0jpTmNGiVljCu0slmSaMUVog4Rf6DesgjSBjP3x39sdrvMNi5Ts+ydSB3YKoFrdVrde
	LmYdQ2TK6H+//jdTS5Mr7XBcaApyJYac2d0NhU4Sgj5KUAeNfS3TsFYZjYj49Ke8hituww6xxM8
	qn4w4q3rGVE7rBEWuTfO3DGV4m2BD2rlNq/UxNDm1u+S/cJHXW9B2I+gF+kiz7g4zeHNFe7rP/i
	lwFX7c2nNhuyOo57NRkIu3MJJfi/k1eYCoYEibw==
X-Google-Smtp-Source: AGHT+IEXzU0Vx/0rdbja9WuSBpVoF5PK9FD9hf3b/6LWdghcq63a3ypBuFlWSuRDrVVgU770i0qL+Q==
X-Received: by 2002:a05:6a00:9286:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-7423bc1d5e9mr20468110b3a.2.1747130208537;
        Tue, 13 May 2025 02:56:48 -0700 (PDT)
Received: from [192.168.1.24] (90-47-60-187.ftth.fr.orangecustomers.net. [90.47.60.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a1149asm7347062b3a.118.2025.05.13.02.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 02:56:47 -0700 (PDT)
Message-ID: <ecabdcb7-f91a-4ca9-93be-e2162f4d48b0@gmail.com>
Date: Tue, 13 May 2025 11:56:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/113] 6.6.91-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172027.691520737@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/12/2025 7:44 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.91 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.91-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


