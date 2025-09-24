Return-Path: <stable+bounces-181556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017DB97DD6
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 02:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF3C323997
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 00:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9C014AD2D;
	Wed, 24 Sep 2025 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ek3ZKN11"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449913BC0C
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673552; cv=none; b=o6sUDmkq0GmSemzEWKQXdk77hYq0db3qNuX5SI1Mjky6Ysi5NZUh1f5yNXer4rZ7xcMQ0iIDHTTWbsLBCnzLF/Pn0UgAhplNcYggBXPepKHZ2ug4ytllo4LAiuY+PEFAxV2G83BRo5kjZPxaVQtRZh3qozFLekHH0cjZd76cJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673552; c=relaxed/simple;
	bh=5moMFOSWjJHQFSqbTSHVzZPV2Ozn1SebUST8B99iuVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwqHdw84RYRZMsy9MtG4flJftf2VYIm0pmx3dczJWy/twU3xwmmLwfJLUObPXG1EZIFHrDVwKn4/zDIF/IHpdSPgyPKunhcf0J95n49VPbKO2uXT3+Is1e8VUXid7TyBiOwzDI1MTSw3gMJ+x8IoepB4oXEbSas8S0lX/wz9/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ek3ZKN11; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8e8f45829d7so88701739f.1
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758673548; x=1759278348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dt+syD8YMODVOGHzdazoi5hpOFsjySYX54UJ/Bx3CFI=;
        b=Ek3ZKN11alhv4UBgjw6yL0U2NvuE5KRIfeQBOG4vuC00RG85ZKvF20ZlkA0kc6HigO
         LI16Bm8fH/ruzSFegJDrlZtqGaQQSRctgljTROIaTzGoHvXNTcBYenzztICy3/f01Ym7
         t4Td/LpL1j9X1xWWMNdPwy2wb+0KYSAkY6xBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758673548; x=1759278348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dt+syD8YMODVOGHzdazoi5hpOFsjySYX54UJ/Bx3CFI=;
        b=O7nUQytvDqtf1I5tGoH7q3VqxHPvIpERzdNaFcilS4xK4vGOMD580XQX32Mcoqpu2v
         m1+LK9Uoju0bQkNpov1iBI726L9YBR1iY8lIuZ71/fPOJz8wA334P2gZAVjnh/bd4HFl
         6KWnryqV9RXjn+eSRiz7P5D41b6abZEC9H/UD9lK1QfL1+vqWthIY67JImMnFPD+fkXI
         cXDBD1Bzj5C5/8ailnW3zJqCQZm7skpUNUdm+CTmOJKwI0C7JkasUNZwXUUGJMVO3ARJ
         8hEHeoU2z64SmP7SJHHtsb+FurbJykbJSGlASQP9YM8Tz88dtRoxDZV/MRERIPXAJiEB
         gVWA==
X-Forwarded-Encrypted: i=1; AJvYcCXOj0YDKX5mxb2qmj5t9LD07LAOogsOQBdKOONMqy9GLX9afB6QK9eHs1M2R+pPRZvF5n1FWxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9U32A0jb3P0BgQoxSEtLNBx1QYHzKVqWWYy9FkVa5ErksZgn
	yo7/Hpoj+yNd2qJ6DDNggqMwllLIfOlaM8IDVrwaU6YRu20tmJW4DDztn/CN+BKnM2U=
X-Gm-Gg: ASbGncuy75r0ocv8z3DfffhfuY8vt+C9ZCYeF9eTLfR32p77JKZPkAUDTlq/A2J6KTA
	3ATORnv7qRe3sYDbsZGYNrXcRhWW5ZjsGcnzRwf5uXI5WmTKEX37ou47cfh2ZWcO9TjIKSHNfhR
	f7fWFEuW4WkpJy10vEKXUeAj4MKWVyZaA4vatwqqXEtnwgaj1d9YqZRNz57tYJY3zsQVcjb5wwy
	kD/oZUsKN3Bp2/RiF6Dw8Bj67qfxalsypDrzatGILIh1fGJedctVcC7XkpkIMGY25zv/TpARkSW
	KIpTJPzS7/rNEPQipL3XYvcCRE6yKEgcFazg31/ffh4pfOsOy1auPXCgGykHqIU6djRFAS+TEz0
	I5mn6fcxqDo9d415rA9ITVcR72cG5nEPSuC4=
X-Google-Smtp-Source: AGHT+IGWLxq+5GJO0TmX7pMwInHGmPQWK7BTkeoJyzyK+KqNZ0MVQTr9S3UBmomwYpmD1Hz99wjo1g==
X-Received: by 2002:a05:6602:6c03:b0:8de:d8df:e1ed with SMTP id ca18e2360f4ac-8e1c2f313a2mr866414139f.8.1758673548081;
        Tue, 23 Sep 2025 17:25:48 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-561261bdcb1sm2206193173.63.2025.09.23.17.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 17:25:47 -0700 (PDT)
Message-ID: <b9749593-7bb0-4ac0-aa9a-f8d68566a585@linuxfoundation.org>
Date: Tue, 23 Sep 2025 18:25:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 13:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

