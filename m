Return-Path: <stable+bounces-23262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F07185ED54
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 00:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C069FB21B6A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07512B179;
	Wed, 21 Feb 2024 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kj7vU/Vn"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0467C33062
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559169; cv=none; b=rS/hAl4+nRmUlN6VhK+ixpZunduI2SyrRGDElOz8rc8I7HygpY3/KMegckTkzZkZZoSB5iT/QUhGViVQ71aETxw0f5T/2DRZ5JrDnUDOwPksdrfbCjjSClCc9aTk/iYY8j00HUibZEk3BeqeTbs3CUmr0taf0U3N2g6Wp2teiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559169; c=relaxed/simple;
	bh=gt2zbHp09sQ4E0IXRMe5CLcXg4e6+9enng0YONTvvo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMBXgUBqeHJft+EWHfEBCLjpA+/fYBNMwh+0KNKGUWszxEOXgl+lLfkIaqJHB9foVaoxq1Z2vj2eA9tiqEdpHUWJpoPtdvF18ZMSy8iBZQZRWn5BSRiVrj48ROTGdMc4yp8LSiITCWvJISppnAp7GK5aQlPfWnDv/ZI8aQJqYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kj7vU/Vn; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c495be1924so84104239f.1
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708559167; x=1709163967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAKcgOx4dnAtWUXFdt+Zxs9fPqeZZy1uNdBw2DnFh8U=;
        b=Kj7vU/Vn3mJbILJ0ZQe6NnB3yIvTWOjHOH2pShWdnMjTg+x78FKawvYRGwcijuQmcw
         KE5yBxyIhc1goKdYUH2vJjOl5wO3gbT4h7Rzqm9ty8Wnqjwz8qXJwRSFr0Tasvjw6BMk
         QmHhfbFk6LKHkSoe0hybaPTa5mLCDk0GLgwH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559167; x=1709163967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAKcgOx4dnAtWUXFdt+Zxs9fPqeZZy1uNdBw2DnFh8U=;
        b=BID8RA6s8fFi0pV0h1LufOLHZetFmlceT3Qy9bb1YwLX83U5cq6P3IuI1dD1dcYQo9
         SQDK9D1nJmbZLeJq6GwBHM9I1elmiMEMAOVq9OUw/BPcVszAOia5XJ51pJ/y0pPYZ1pv
         G8LqO3zPnU6bh2Nviehx5D+MjBtWihhtqyEoK+6tBpO/b8JZh1/2JNBKkZPMpyu6P0aU
         dg5NHoRB8zBp/FqyIyAU01bvpzpyIcq0ESwLTuu4Mqctq1wgyd7+tETv4ndcYPxHcw2L
         xDRSa2hoKuMgaWkKZqX7HilpEeo1Qm/JNxXwD9oyiZzgL2NCjV+0hf+LdTGOSTYbcRlk
         CR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdaXd3XWY2UOItcVAfm9KEuDZZKAN+LFZ9MW3AXuu9L6p1b3Pkg1n2mkezsansL7cUbjOan8kQXh1r4BE5O44ZfPUkP98w
X-Gm-Message-State: AOJu0YzL05MnzeqiIYa3Go0UjkQ25iUI/MMlUUhBf/UivMiRRMv/KwMn
	+hc1eYIw9u0T+cC64blLM6WdJ9VBmECBEE+cLx0OwuS0jph/8VHuD3gUT5xWb68=
X-Google-Smtp-Source: AGHT+IHUxQhgcp++EYtIQCs8Ay614fr69uXwCM/LhRP+kEK0r1PasMk0Q7ScDHW9tdbD2SQB9Lxj5g==
X-Received: by 2002:a05:6602:2545:b0:7c4:c985:145a with SMTP id cg5-20020a056602254500b007c4c985145amr835299iob.2.1708559167143;
        Wed, 21 Feb 2024 15:46:07 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b14-20020a05663801ae00b00473fbb3eb4asm2936835jaq.105.2024.02.21.15.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:46:06 -0800 (PST)
Message-ID: <46cb9bb2-2af1-441e-9a99-44600c1ca33e@linuxfoundation.org>
Date: Wed, 21 Feb 2024 16:46:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/267] 5.4.269-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 06:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.269 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


