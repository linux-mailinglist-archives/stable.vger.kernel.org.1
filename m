Return-Path: <stable+bounces-56906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB32924C46
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 01:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E323B23B4B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA517A5BD;
	Tue,  2 Jul 2024 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EIHyJU9E"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFAD15B0FA
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963860; cv=none; b=O+/OCetgqnRt6Xxg550S50DeBdyrk5y13y4Mg+mrRjz1kXbX1HuHdI4U1kyu/1hIfVU/NoQlqGs3f0sUDXeOjJjb8mH8alA2ez8cbdrfP9CZd5itWPmhCu7ZCIfkbDhI5u3Xga4+TIh916EQCwXoGnfnWk33hvDNhQ59vpS4Rts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963860; c=relaxed/simple;
	bh=nugYxFvqkZ3GdtJPIrAFiDsnYPiIlN3gx7rBB0rx1kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhuOgY5TfpsgrZcQq+zJXv2Vty59+N2rvl0uREy7MnrGj9bRaw5vQGUAjhBv0/lZ082wJ0SL5RA/F4iwHvbP/ICKfzMxl6/xcbxOpqqa64/LiOXXbM9fkPN8bCmBB/m8w0bz/WfCaf/8tOi5cn9Xf0JxWsn0pQVQVhPdGzyx0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EIHyJU9E; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25cb5ee9d2dso722086fac.1
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719963858; x=1720568658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pm45MIjIaeWm4BhjkbsfpReUNUivy1UEQs0ZvejH8fQ=;
        b=EIHyJU9E3/Pdp81jNZe92O+49Aa5NDKbQnumuZX5YPtPgDV7fttXYCit+82ogGha9P
         gHzUqfnki9u8kbujp6EMYwsX10XFjm7W4c7DYY2MKMfynf8hM5R3DQorqJuBEB4pJJXf
         aborWGugO5u6mSh30kgvqeCq7HRyI/p7xsfGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719963858; x=1720568658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm45MIjIaeWm4BhjkbsfpReUNUivy1UEQs0ZvejH8fQ=;
        b=DbHKkS2MMO7DPN0HZHfRhNlBXYbMdq4hK9W3pcMX2ZoHU4tVbmWqiGVVp7H2+EWQks
         mnJav5ijdullMGjFpfZzBRF/jgXvwf7QEHH53yqujPC6fXep3TiE2Qjqfkbv+M+3uBXa
         7zy1I1v8tSP4O4h1rRFD5y4ODgx21mPHKh8gifF68Z1pgOiPDsi5Tg6gVJ4bwSpX3rWg
         tGFI3RTlDePhIpISSBS4hJ1zUJCpBLCHcKsDDM542YhDIAc5dfErjz56iZ0SewBQGm9d
         yiNPQfyqqjYvBzeLJs5QbeREWV7TTk25rJ6iP3srmCl7cmM3UnKyrz3PDkFGiGCJhSuf
         h89Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh/fadwdC/9stNgiEgRKYGxPhJO0tB2wv9K8j+UAViLyErilAgktmWn8xk2mxkTzlQ+88U/horbLr+7RbZeKIezD4gRxj7
X-Gm-Message-State: AOJu0YwuD8MJgb4jkcT6d91eO7fix1mci9wyTDW/hZnvOQnFfiWzNtx5
	fLsXWijgjW+SxIBiiCuafxQg+bDi/zVqOlBm0La+gMJ4iWIJpFsbmvo3QCzIlhs=
X-Google-Smtp-Source: AGHT+IGmqmuHlWuvkaXE07Rh5CKoFmBmZoQmtyD6UtHJqCbjW06Ub0MNM9EHQlJGbJkxvCbgPsH50g==
X-Received: by 2002:a05:6871:24d2:b0:25e:180:9183 with SMTP id 586e51a60fabf-25e0180af8amr2263497fac.4.1719963858211;
        Tue, 02 Jul 2024 16:44:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25df77cef10sm434167fac.19.2024.07.02.16.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 16:44:17 -0700 (PDT)
Message-ID: <bb8f0689-0989-4c18-bc75-f73ce6743c22@linuxfoundation.org>
Date: Tue, 2 Jul 2024 17:44:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/128] 6.1.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 11:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.97 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.97-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

