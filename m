Return-Path: <stable+bounces-107755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAACA0309A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDAD3A2651
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDE31DF745;
	Mon,  6 Jan 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxGrsOFV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612B4D8C8;
	Mon,  6 Jan 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191778; cv=none; b=S3CbdLpfS5dxvPa8ck3fFTqRhiDb1BTsGev1SkB0hiOXAw8XY93crBbkHwP1WyhfU6Ac6nh51lhXuUf25IF3jIhQWJrV4rASoT0xdUKgKq/y0Yt1XhykF0TOgjWg6k0s4VHs2TPgVdyLALMA02irKhKFrmAtO1xDy/D8To4qe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191778; c=relaxed/simple;
	bh=m27gq2zmc7kvNMqMV3DTbtBuPYQiNhPMnkMzc2A+E7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaorJuqfsmPF5wwNJjdppPWW9osPxYOId//GVAlgAYODsXR8ERY/phkW1OuQzIZmQYh6HcsK5JhrzMgveaWpZy2A+WWUQPURokhP82zMKBAL87N5lfeqgBIMgXduM3ecBHe9XYmxNlYUMMlbTRX7cdNFzrIEAu91hPY+rys7qFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxGrsOFV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso16225475ad.2;
        Mon, 06 Jan 2025 11:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736191776; x=1736796576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zUaieqfctkXU2CCCi25qY+ZkhVZf8NkRI6SfQCc9dW8=;
        b=OxGrsOFVBqyrJiK0IgC6P2CvHIBL+IldJ4zwGYuHxbjS2OSOP+kZzKp2nW3CiTjwYo
         GobQkAi/u+8yoXQ4ZlR8Hb7W/WkamBSh8/BMS0nD3bvV10UMEJF2hYWWdkYHNHM1Rxue
         g7k1hMuBhjduCDXegobatdBZFv9mpAVn0i+M2IhRcCfo1k8wWxQsFzXCjcuXV/CaKopt
         jAFlaazyef0Ck/SHQyvlVZZUkOVsFCCvXapVD65aUMKwf9nrLdIi8e0/tFwTzkx9TVHd
         Za62VPlAfw8ybY3rUoZJrBhFDvyNob8JribkDu76VDlfl3ZOH4a2J0aUdhGUpaC06/AU
         yd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736191776; x=1736796576;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUaieqfctkXU2CCCi25qY+ZkhVZf8NkRI6SfQCc9dW8=;
        b=a787CMhOLUY3T+TB5aYlZEHPt1TTrgdEIaBLuzRSNkQKT51jeqxNnBXghfmCw+H1Mg
         AE37E7cJ4GV/yImqmCcJJ527QdnQ4tDQnykixuczs+c+uYJ381J2bRRLLaJREJuNE8hy
         a2J+7fm9ELq58IZVH1iurfdE1pB25Xnms9CnUJecEwQVXva6aTy+L3lXiP1NmsbTqZVa
         7tD9zG6lpLXXsIjSrlvZg59tgEw9fJe3J4xJoF8tGiXDyyD/b3mTbf2XgHPHRZZEmlRn
         KXIPzf9FeRMdMo4KsHMrNS0IL/KqpDN8V8GYy2U2FxoYHD80w7kY0/JQnJfP7uyljUcw
         Tg1w==
X-Forwarded-Encrypted: i=1; AJvYcCWlMMWKF+pBooKSooLhdv6ae28/+bLjACThEYe8oAho7o+qSAw2sTXIpfss/6NIIaFugeylR4Rz@vger.kernel.org, AJvYcCXmDdV47PqY29h+2p2b9FcKkxhQQ4kjKcn7xDE1moulScgPneAH1cOk/idf6294EAOfXfSwOvrnzn3zVcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybyx6EzAwhxJv3ET4YjbRbKU1gormCX1sW6r0tuJdOkk0PhUY8
	atQXTE2rgjigseo+hPXyztD57ma9i6n+qX45K2q7H1GZgOcKXn8m
X-Gm-Gg: ASbGnctj57Frlk1RWy9/qfEGgokSj4K68g0FhYFJ0d3wutUbjS+bo8cp0RhHuijzZup
	O12O0dS2YFiPBHku6rw8Rpu1aMr1K9dMnXXBlV8q6NW8IlTUc7bLt7ocs0pFh562rrc4zuJg4E6
	lm1jLwxbgFVVbxcy58gLW14bUn2Dqwpk3HjAcBZCsvzQyJWiFR0JBqmunkPk2IH0kwRb/rP2hla
	gQNbT1ookYlEXaApoIxj4kpdrSc6gLJwj6EEQQskua65EwsRTTRKMldc5iyFPxxv82Yn9SDsOPx
	dsKQSYA4
X-Google-Smtp-Source: AGHT+IFqvOp0PMHhqa4e11ShEFSPiRjE+itmZA2gBLfKAhCcToPbflk/wEcWkvbncD5iPcmho22TGQ==
X-Received: by 2002:a05:6a21:9103:b0:1db:dfc0:d342 with SMTP id adf61e73a8af0-1e5e043f871mr91293714637.7.1736191776597;
        Mon, 06 Jan 2025 11:29:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm29421692a12.19.2025.01.06.11.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 11:29:35 -0800 (PST)
Message-ID: <b6017b2e-1639-48b9-8316-84667280cdad@gmail.com>
Date: Mon, 6 Jan 2025 11:29:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/81] 6.1.124-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151129.433047073@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 07:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.124 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.124-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

