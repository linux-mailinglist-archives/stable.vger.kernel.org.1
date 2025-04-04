Return-Path: <stable+bounces-128328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B716A7BFE2
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA1417D6D7
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D251F4189;
	Fri,  4 Apr 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hYmJ77d2"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CDB1624C9
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778096; cv=none; b=cPyZRxheutc6xnTqfo9JKyDUzQARjn5LjnsoXVsfK5Jc8LyTI9l5nKPNSZEtb4V65C/Id3uitE/3Yvw3WnJi0VcjJHSdWxDA+1S0HV/ADF4lgpxZXU/XwEDRi/OzqbTT79VRvTBr8LvDWrvbT8/CbhoKj9iFpoy4ooiKYivlNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778096; c=relaxed/simple;
	bh=xR8q7hzgA9FXRoG+sY9ISOiAyQMLmpe6nTbBK8Ue+CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A11K5DMpIpyK/oz1oZp6rxNUMEXysjuwvZf13U55PadS5D1+dKn/2sprScCKEeAW115c+olg/AC+PyDQEpVtnQZPD5XrZrcY6mPgKXmQ3RWzjoJAR5Yyuu78Y+mUDhKk2IwvpR5EeNkvQawbcOl18E9GxKDrC8cK8ARrxOWSNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hYmJ77d2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce868498d3so8549075ab.3
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743778094; x=1744382894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7uwFeew0VDqMArV6F/glKB7hcKD1UfxHTGRSpLzJvE=;
        b=hYmJ77d2T8g8V0r7eXCGgkC3m5R7mP8EJAX6VI7vPJudhELBKvZ8nPWIsiBQJbj0DZ
         ywMEOd23VDoLjjICRlD12KzNTA33e+48J3ef67DPxF0U4HzmtB9AHmSytCp3DKiVjD3r
         GtzHVr3EKig54q1mOLV09dKkKuh/M1+bZ707g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743778094; x=1744382894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7uwFeew0VDqMArV6F/glKB7hcKD1UfxHTGRSpLzJvE=;
        b=h83PYKsfaOWkqy3tG2wtuSPvx16Ci0JnxhsaQMm72SliYHWeXi+k8u6xZ6LgrOZRwI
         9yftlqikZDCLE/WwNK6IS2mwa573P6tPSAOAAV/RavcY2x3HprZxB2OYmWjgoRz+LY1y
         aru3fXek2TLvz0eiW7h2WUYfGpcMvP3NSFU9ICvySQC767+eDi6E3ts0S/4Kgr3YwwI5
         NcmcfVTPpCaW0UZYdii2ahFUX5XUiPizXAsRJphbTA70G5/UunvzngQM7VAdLjBwtZ+s
         Syg/tEqdKuAmok+Vnb6AxTB/EF8lK0yzUa23JjZRftJvIdfQU37UR7FqcuqvVNmR5moP
         BzAA==
X-Forwarded-Encrypted: i=1; AJvYcCXv9NeARELZt4SAfxxbM9ZQPUII3vrOmmmJeY502VQUEFH5QTwzQmxMYwC5AFMSIGaEKG0AdhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRr6kRl60weKqd9ie9ZX0I10k3rWpu8W1QE9FwJgGc8qf6B3e6
	seD6jmFNgklCBpSr+K+8VmDy9cKvxx/1QXFCuUTZ6xBwaEZJbcB614+uP9s5Etc=
X-Gm-Gg: ASbGnctSh4JBxm1DPDZ/KzqPlLto7P9QYEEnrbq3y8Rg3IcFc4d+y42K0PLF/fmoxHX
	XrcDVWqs3DookpdatB/rNiekSgKHrpzN7+0y/K97EJb7iKVP5Z2WbGjxPipsRAMi87+Lj8gCwn6
	N6cQpO7mX1DxdKyajlPxpJLoew5ynRiArw+duLtMtJpTZWxJpEqEPVvARujZxhKXZnEFURHhPOz
	Y6hrh0F3bx6sdvutuPELJEu9wQlwkoH+DTWkuybrb1bB6QloDHvxBHHwD8EgJkPc17yAKYSOfFe
	ODSsO6naBsUJUqNkueDArY+iePCrtMIiOfUqPy+JgMZAdbwrrwcBkxI=
X-Google-Smtp-Source: AGHT+IHmeVMxstvkkG/8A080OyDr0AsQTJp/ULWOhj+O2+I727qqrla8YXBKLW9XgqtGvSIgC8PYmg==
X-Received: by 2002:a05:6e02:1fe1:b0:3d1:78f1:8a9e with SMTP id e9e14a558f8ab-3d6e3f7f864mr42089095ab.20.1743778094195;
        Fri, 04 Apr 2025 07:48:14 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5c4b32bsm816259173.56.2025.04.04.07.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:48:13 -0700 (PDT)
Message-ID: <d36bda59-3198-4eaf-9da7-a28c5dfdc3de@linuxfoundation.org>
Date: Fri, 4 Apr 2025 08:48:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/26] 6.6.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250403151622.415201055@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250403151622.415201055@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.86 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.86-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

