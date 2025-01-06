Return-Path: <stable+bounces-107750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B391A03005
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 19:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FDCA7A145E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857811DED79;
	Mon,  6 Jan 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4MxxU7T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94081DE3CA;
	Mon,  6 Jan 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189927; cv=none; b=JQDHHZNiOsd1tgnLv9msuLmtzbB6sZxyrHZ+9gH+xsCkGe9mU0CD+eFdh1CrzJLro8PrVd4uZi2AqcS885KXxPUkcmtjVg8iNFak0N03zOk0UvwnGAL7NLkWX2uYBQuTzm9eNOLLcMk0dQqYX4xpp2LBTk/GIVaE3LFCvfDkvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189927; c=relaxed/simple;
	bh=xDhhnqK0fO25WJKHfypvNfKT3ED7OAAq77nfThEGZHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tn5J/KNxSUB7eIh5UC/BiL9RIMgbk8apfJFU46ncwXYC0/fN2KGD7atqcaUARpVtAx8b/W8N3JJ261PqOt53QgAyEv59rRiC9dnLQg2jOz23rEs7//eXJt6K9TSYJfgQkJuNa6lxYZc5jWVn3nhagT0+2FhiBoGsr7i10NQvVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4MxxU7T; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so17239344a91.0;
        Mon, 06 Jan 2025 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736189925; x=1736794725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ieL3bDpo2mTMT/caEa+eoPiSZz7Ur1JFNT8c5S8RrMA=;
        b=l4MxxU7Tnj+PxnqyktfumAshsiw5EEKhXrkk729mvpNzndMqeECaM3sf/5h0I4DaFU
         tL90h5on0JaxjKiaBhH/SxvhiJyY6V3kJor2usU8SyEpn/ubuHEkvm3tzz6GckWtN/GH
         Toyq4lXbxadLuDkpOTpC4rDF1SPbmXqYHoWBNzMPC5aE7jfCT7Kc9cvCh9wzoAtnx7+u
         2tgcLF7ZPF3SlH9PHv4iwi8KITVBeUe1E5R0ZVbSLhew14kSVE4ybtZLbE8UF6Nq57PN
         WdX15Nr6xXVsTVdezqZB0KJyDGUulXjntlK9Y3unyf3DPh7+7nWES+p4/5smOyHBvRQ1
         o1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736189925; x=1736794725;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieL3bDpo2mTMT/caEa+eoPiSZz7Ur1JFNT8c5S8RrMA=;
        b=OxfUTpDYVtevB9mGB4LLd5/uHHhiGN5LedKRp2lgMmSyNMOme48yZr+e4wdbZMNyoM
         qLzYLAwsEQ/KnDw2KL8plnEKLZyvGqYvf3znuwp5ajASdfuItrVYyYge1846q4DVkt7x
         2U2Iqdgpny5MTHte0UuAh7jYWJWDZcscdoTEdfypkBICFIjZMeQRLDWSpRGANXx1wcGq
         bkC2/c9dAHtcva/GMfBLz2xVeq/dJKZoZ4owffv0MscTi5ncO02EnNne/YxfBuMoBkRF
         4W9DU3fOCoIdlpwQRyX3AvO1qMxnM3kuUw5rgtS1E3Bt/MTJFkDKtvY5tEQP3Omc5I12
         fM2g==
X-Forwarded-Encrypted: i=1; AJvYcCVXNSTeD76ADFdEkDZWODIW2lr1e8sV+jV1wU/blAx4Tot3d/r3L1TPYd9pdeV7uvwI2t8Mplg3@vger.kernel.org, AJvYcCWVcA7F85X8V6K3LBeFIJMAyIj1tSBU1CyuKh/dTgySnyq+VEeS0KTA8xLp0ORgYysnwHX1XyIFi7TI4hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwodCny7KL8b/xB5rWF8JUpP3foDNuffIKyCeqvb4iejITAJTOe
	mZYCte52X/ccBTcq3ZP2m79gOBCjpGETu8Cw71eA2RfWxLALcQRkyXv++Q==
X-Gm-Gg: ASbGnctxEMK/OG7ezL2c4QqjREqUhAP6AlGWxr+NREWr/vT1sL4zjTj5uk9C+pCZcKm
	C5fJeuvx4VXFoP1F1/TqAVfVEdG157j2v8iMTmhuppIE+zSB01RNhhr4SZte41fC1WLOx5ETmyM
	TL61jBfoKEI5dTJNMmwYZf6MuwKgD5XFTOQRF1Qw4gWuhhBIKqBvjaC736P7NkMkGATEv5GmsPm
	tOxar4OrLeQG/IlEQCkysizzmKPVsSKG4yVHcgUZmqFGKMAKd6XHSFd1PX6K66LZNsWc8JSbg8o
	AYPDwCn1
X-Google-Smtp-Source: AGHT+IHQaNSOO9eP/UWTVnnd/mFtg29iE7A5RcbZHb2hbaLyRfELBPX7ExgRit9uzlaF9N6HDttEzw==
X-Received: by 2002:a17:90b:544b:b0:2ee:c9d8:d01a with SMTP id 98e67ed59e1d1-2f452e1e54fmr84478794a91.11.1736189925014;
        Mon, 06 Jan 2025 10:58:45 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eb40sm296404185ad.86.2025.01.06.10.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 10:58:43 -0800 (PST)
Message-ID: <e630e160-197c-49f3-ba18-5af1e6a82bd9@gmail.com>
Date: Mon, 6 Jan 2025 10:58:41 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/93] 5.4.289-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151128.686130933@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250106151128.686130933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 07:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.289 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.289-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

