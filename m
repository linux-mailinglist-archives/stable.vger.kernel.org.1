Return-Path: <stable+bounces-106563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF99FE9AB
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 19:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3535E162417
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB1EDE;
	Mon, 30 Dec 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVzKmrSe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49471AAA2C;
	Mon, 30 Dec 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582260; cv=none; b=Dp6sg6cSKz6lhIbLmr0kc1499zreNxra3qR1e1LuDuoSNQqTeHF+Nr25y0oBCXFKGubMT56P4L4U8vrnpCLxJnBtNTB9bOnMf16TNU1GTds9ldimb1acPKKSzF39dDdXj+M0vHg9GMpJX4hwohRlzaagzC40UsnmBnSTkMKcE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582260; c=relaxed/simple;
	bh=76s1saDLVGxgpjPOn26jApFtMqijW95mlrh+Cqztvd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keEf7fuG6UzFHgxB3308j+5KboIpSZxO2xO5ns7kx4ZB1/Ty+NPpzdEtPl37vjJluoW3ehYClSVuLqOL14+nO+bZKpYfD0IXzC4cJ2gWV7zTNH9dCKRi2KYtJwGvePVYaKxJ1NF6eGqE90/aC7FJDeb4bwFzS9gigucIoMdXYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVzKmrSe; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b9bc648736so725204785a.1;
        Mon, 30 Dec 2024 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735582258; x=1736187058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+5WHTUr53iWR5qjukQpdlBNhsUdDFBx6Bhkt96FfO/I=;
        b=KVzKmrSeyU7hokfZaC84LYgMyddEe/ejpHs8jLpNhuXHPitpdnDYrZM6G4C7PDWkn+
         UWpiV0Lac2FFQwNsL+/xZ2KIdCdOsV23EJEAlXtjxU0ulV39a+KxdYZMdVOhQb2TLBgV
         aIdieKpm9hyeugXFupw0qhKAzOQPaK8Lgwg3ywWYykb1lCZcPPGPNYoltrbQq6L5Jcba
         po+d7SS40Ml4pLfdG8omG7mk7rZCEuoZJVH6Q5hVNSj9Ny/hB+OvHp8IwCb1Nz/XyYhU
         tMiux205ZA8WBAtcn5WyJfjaHYKD8qjSnAFNBU2dMAI1KO0zIB7FfgIB+OUVYcb0y+DP
         +6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735582258; x=1736187058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5WHTUr53iWR5qjukQpdlBNhsUdDFBx6Bhkt96FfO/I=;
        b=RwgpIn1vu5J27Lt3+MU7a7SJZnb4MzeNcwmap8vHRq5mCUEUMSbcD8NzIzZRQyXK46
         6su0EUmaZs/Gg062IrzcJoys+yYcBUIeT2/N5TxGxh+Z+TFtbYfVTd/l613dIL+9qmyE
         DlX3vY9WEpFIeZUpbz5mxO7TfNDYEiC5i3d5Kq6C2nwNHCbFClWQoNbQXPnM5+/gM1pU
         /R3kI5FCegROGfKA8Mr5xCH87pR7a/9/ppGv3ya7pp1aJvKLni+GIEm774dgRUxfgomP
         abUXpKgPk7sYNS1+w33233QxN2VdOpwiPYkrxag1m1i3yO8rhmqg6cWZWgqiKnoDpCDS
         QA8w==
X-Forwarded-Encrypted: i=1; AJvYcCUo8/1yd0Rl34Do4ssY9Zq2I2PLco4enzNj2x65VNiqC3bDt3cySz/71hv2xRlonNQa1ntU0AORE7epgvI=@vger.kernel.org, AJvYcCXoZ8nVuA+tQG5Q9eEw5DrSFkEuMPnKEWuwYRNvLQjSMVAur0EuR6AU+i7+3ngw0fHllMjQL/Xp@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9eZz8OEBj+418QFSrFnVuoEIRj46oSpVxuLkVzj1l5+PJiPD
	bmS0G4FYAq/8TeuX5cB/fapgm+Al7tHqWn97BA/77HoQUylma95h
X-Gm-Gg: ASbGnctFrsxjCk5tL6YOpgkhr6fBjKQsjFdy786z1rAZvN6EgU65g+XThxVwGtVq160
	qs5p3eifKEZmbCTA0isGvOXk7zNSI7pRufLo3D2sGjQlQLWAjkrB1Z5kFmWmjonDrY1iCILOvXM
	uRSnDnrh7bSZcCQn/NfpMgBHniYy28aLHINlv1p0jvr/EkIBUNNwr+P8g5W1Anye3KbZ1O5enB1
	0ItpcE2PpghzfKRgnoFO30t+z48prs/uNiIedjKfdhYPb4d8mW1wd46G87yxD+3hue+J4Q32cRP
	xyB1pJ8Z
X-Google-Smtp-Source: AGHT+IH/pyTi1GUrPCv8oVUrhjc/UCMbc1DGGQboZpm6KcCOxpSgKs5HNif+Vh+s/vC3q0LjM60wPw==
X-Received: by 2002:a05:620a:2855:b0:7b8:61df:f5e4 with SMTP id af79cd13be357-7b9ba7be7d7mr6471057685a.35.1735582257702;
        Mon, 30 Dec 2024 10:10:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb30b46sm107572331cf.87.2024.12.30.10.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 10:10:57 -0800 (PST)
Message-ID: <8edd954d-69c1-4018-b400-f66cf29c6f0d@gmail.com>
Date: Mon, 30 Dec 2024 10:10:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241230154218.044787220@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/24 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.8 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

