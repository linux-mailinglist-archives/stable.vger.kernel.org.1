Return-Path: <stable+bounces-189011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C007EBFCFAD
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A6189352B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857EE253F05;
	Wed, 22 Oct 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MtkCC1jr"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529B252904
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148469; cv=none; b=RxETHzXgkFn8TDlalmLboB7U93YJ7hpk1H7NCxW6ZMh3fHNgP9UnhdMe5hjX1DJ4oqk8YAJJDiWkJ938zxXAAHpjziHRfDXlSCNYcZeaP0q4x/Lk26XC7N0XZzD+MXLLNJcQUDoJf8v+TQmPJisKtExIaTxLgHQTEBXkENeQUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148469; c=relaxed/simple;
	bh=VtcfjPwuQZm0EMKKvDInhFF5KNaU7Il0txe6BbrjIJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpjbJ3fX/hiJSp0L0FwSaGF02QRgFhJ/rW/dPYFa29vngXfTpcg4L8Z0fP0bIsNEE1vT9V34qx8GtGUNS6zSPDVHj7446gyO4aBEOnd926wPTfo3Nq4GeKVmDzv4YwEC00TeNLPIahpdYfdDGtY9N5hN1ZPVIyxeIgcQiS0QRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MtkCC1jr; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-92b92e4b078so294045739f.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761148466; x=1761753266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIVUN3fWWhWOEdh7Hs/wcK5VnrTq8BMj3+c8cRQCw6Y=;
        b=MtkCC1jrWsjjdTGKlZsPJOKHOm/tRLRLeP8n6YjFUOQPwYK53/BmlSAvyxWKjp4TW5
         cpTn03g2exGP150iSm0hW3fUl9cTdOyydsbOC8R/bcgG5gYwO07rKvd51qkoce9SFJ4B
         2y+f+eyGwT3STyhIp2YeWRT1yoZ8rtq67PHT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148466; x=1761753266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIVUN3fWWhWOEdh7Hs/wcK5VnrTq8BMj3+c8cRQCw6Y=;
        b=LrnfBw59UJr2EvpITDGu9TQZdKJZTYvFyLC87/BzZbVFXlVf9vnvcr2wfe3mspDCJR
         4b0v/+JLw+CdgZEuChrPARYjzkB9IdZe/g9tIDKqbC/RZQvbWtZcaFbP0NfOngNfyD+e
         UkZga1gT2qFIDwHvoETKXS3ZYi7nFoCkEQ821aAUi3KDfCWEEl5orrlDoILs2Kw51kFP
         BkpJLzQo3ml2b+HMEjcM0E9uDEEXiBT1a7Mx8U746xIFpUWkyeUK/VLfwa1oYVgkyLio
         bENdHiIaX7hwqcP+/EFe8FpoUeETb8yWMrpxwWTg27yk2wvH0a1mJ/5XfJCAY/ZgTDFv
         ijHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn2yfrrB/XpnsZwSSUsBWBNkVqJ9LZc5YInVG/VSG7gaEeaWAeU0sDkb/qxo15gJ3bylLHzCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwvPUVnnAWDWlLI5ZuQMe3yTrMVofcum96aRfyCypvtV4GoqK
	A0+utiLirfLUnWujQMgwpN3FXYRkDt2pk6y+uZmq7Gjxr56tIYy59oMBC/IMW55alEg=
X-Gm-Gg: ASbGncvV8e8B/HFZjkWtAqM4MWKd/98g+9arqZW50uhObxsW1c1SXwGLdHLRhH5sF2t
	1846vG7hO69Kk8rqE9fNnreKmP8NGePIrPxA0wY7rPzIRB0Dxn+M5/bklZkAvDj0dDpZXfM3Web
	D+bONNGmnjAnjPeX+niqPkopJquIUW4h3I7q25q/8VkYyu2O3Ue8T7huaZS1L/dgJpyd4hxWj9d
	FuPfJo42M8gltULyv9Gzn6IIGsgUvtSZ1xTlo/bpJ8IAyjQ7jhGrH8UNvjVABukToeMRIjH8X2b
	to7qdPJbMUdgsSK0b5HgH3AHsXwVFDbbFuXxTDdtJwEU/ruIDK6VxBO7LPpsW+25XDSrgwtPv4I
	3uqDvN0qMlV116TvxDlZRTRzgqSRnF+2LhnMdqp7wzmC469iSxuMlfOShmYBgX6h/UUA3lT0ICO
	VP2V3oOiCkCCihhsOL5gv1LdE=
X-Google-Smtp-Source: AGHT+IEcWRugNt4PgDrDpPZh4hjUcHFJMLAEuTjX9qEtdywPClLHqCfX+99xjdiYkwyoiP2giGCghw==
X-Received: by 2002:a05:6e02:2584:b0:430:a4ba:d098 with SMTP id e9e14a558f8ab-430c526604amr321051155ab.14.1761148465999;
        Wed, 22 Oct 2025 08:54:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d06f9ff0sm54597005ab.3.2025.10.22.08.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:54:25 -0700 (PDT)
Message-ID: <bd81295c-d448-491a-91ee-bf07604bcc69@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:54:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.4 000/797] 6.4.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20230717185649.282143678@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230717185649.282143678@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/23 12:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 797 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 18:55:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Don't try to enable secure display TA multiple times

Verified that the error messages are now gone with this patch.

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

