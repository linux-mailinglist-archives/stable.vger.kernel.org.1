Return-Path: <stable+bounces-150731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4316ACCBBE
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80511169208
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12861BCA1C;
	Tue,  3 Jun 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/nV0V1D"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E41A3172
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970639; cv=none; b=JkFhw1vc/wuefqKp52btq7GJv9pHtLHXepceS/51LpH6lMZhg01c11BZQePLFFFEXGfByeAHDhXPRnn18XCbAtm0ipoqszfBEZPtMo63ZOUTPpAyqBf6yUL9vaua7XFDqvZWuZl3B/GQXf8O/eEibWC/0MW+HNouYzy2wkqitd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970639; c=relaxed/simple;
	bh=Y45fMnHMCP8TQX3oVIJIMV8ISnwVRnVRll8M0o7pQf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM47giUIUygHJN6vPEkAWGV47vCpKtDnNx6s8uEl9ungbv9+UvwtZpIsPZPi9beoyRfaZAkeuP+Jg2wE4IDy/FJ0S2drWUKomPd+ZOFddzwh/3ECmIfw975v10eeYrPOudSIGwX0of4yw86YDCVleTiGT0XffrZyH3vt+lTi3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/nV0V1D; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86d00ae076dso3211739f.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748970636; x=1749575436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJ2V51PhfTVTchVMF1vi5xy+6A1bllD/3ZSU6+R/gkA=;
        b=Y/nV0V1DkYRxlAdFNo6pYZwPb2pef1xgqENkfYMFnTHEH72WpIhnm2UcNP4erLjIOd
         MCbRHvy/etOpHYY6mBxeBIGAon23Jkps5HYHt/A/alto6mCoiOulUR75aTAiaGVXJXnz
         cdDFPXH8ce+Xf7vkvFrdAYLPeAoSedAU8LoyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970636; x=1749575436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ2V51PhfTVTchVMF1vi5xy+6A1bllD/3ZSU6+R/gkA=;
        b=UkugeSAffWM9GeFxClSAgThXjv2sPIqi6F+yAu2VEy6xT+vWA8VejDLaj01QgX0eVk
         FBJkfJlBmytxLY/CTt+LKl+57qxcrUOKeHf0saBFG4iGTOPWuxsD7nKhbSOnsvyXImtJ
         LZ38QchmiHkMq/dtbVkbatoHzQgH7vvAvgKdhFAVcIUuY7+cqnLs3CRzU9SktCMueJQL
         gpGljg2OL/Cyhp14Ht86sODZMjTRwdB4Tfm+0S5xE11XyKA9oTBb3dOGI9AaC+E6rFNS
         gqoXCWWdy6+HpwErKHWcQzH8USHTjakIrLMdm/cUNh81ngO/uWGbHMPrZxmbw5DJWdHz
         eZyw==
X-Forwarded-Encrypted: i=1; AJvYcCUjKmz8MEzNB4VlAm87b9HG5vnGrCZJzhOsW2LxJUMzCuCsASsCaNkVK1/NZoATJQAUxDhe0Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR23KiuK6PIAbV/1/o460KmIGKDFyH2V7m8m4jIJkPvrB+mCt8
	4SKb+RSKs/dL/uNFaRTk6F0fXak7hVnR2K3mESg0y7UOs1Yzphr7/CKa6mLbJfUdBHo=
X-Gm-Gg: ASbGncvWTMvsjnzw00SQOHLsoeXkqdCnnMsohISPLkcXJVhXKHh78o6jwpvohFWq5VD
	TBvKs0KhpefymJkJh12mWZxcLYwhZYUL/EUtoa88CwKVv7fvxNUgb6FhqmAxY/VBVl2VJW9PM05
	pp+2E+wJs5YEgFQ3KF001upbKYUgmPEIzRqnw0giFQ3C8y/hD0SpVSceVNZb/xE8A7jIH6TIf8A
	e0H/lHmrUEcDZm3gwYH7uTUpcYcqgg4WQrgqdt2rbW/bEqYZ/N+hKH19ktrq5ya3ncXuZqWiCRb
	gtMDQtntuq81HcTUb3OOTkrjYMfkIsX+0yvaonYWGZMj4yDBPJJhemkiTFtMPA==
X-Google-Smtp-Source: AGHT+IHCZSnIzYj+uUj9RtM2lKYcL7O0GbB3CDdlfDJe6XzzQYpAbREB6rRXkkRITOQuY/SMAth45A==
X-Received: by 2002:a05:6e02:681:b0:3dc:9d32:6373 with SMTP id e9e14a558f8ab-3ddb7808fc6mr26858405ab.2.1748970636272;
        Tue, 03 Jun 2025 10:10:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd9353e3c0sm27240925ab.28.2025.06.03.10.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 10:10:35 -0700 (PDT)
Message-ID: <460dbb46-ee6d-48ff-9d9a-779254dfd23c@linuxfoundation.org>
Date: Tue, 3 Jun 2025 11:10:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 00/73] 6.14.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250602134241.673490006@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 07:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.10 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

