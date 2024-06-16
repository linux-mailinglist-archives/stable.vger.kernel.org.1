Return-Path: <stable+bounces-52333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F2909DC4
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696B41C2172E
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFAC18733D;
	Sun, 16 Jun 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EstAIx8U"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491A1DDF8;
	Sun, 16 Jun 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718545110; cv=none; b=oGjfVs75m/0pNBssW+bsQV848GMMxnrOotg1ha+oryDsc0D9j4x9GQ3UmPD+F26AP9BKiNsq/4Rqop4Uolf6eX9YDWZVrhnBDdfKrc+/ahAYmb0jpDtZA4T/8MgIY69JUSJOGEzepHrSXafv6hFfShx4DuK6rqLIFHVVYxU+qFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718545110; c=relaxed/simple;
	bh=fvd1/YHl6pz1RnlW6Ey53ZlnHS0ejE7GuNi/czxTkUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmBs82MUlrRb8jljkx5D+QzttwlHy3uD/G/gbh0p+NvjLDLiAMtGC0fRNpSQHfO6iMPm4K6AzSSdejZPXBdnpZOy7nhvVBdDgtWcNP5rjE7tntWF9m4zuZSsdNKWp7MlVyI8zRfkS2ZdAcN8dTSxf4JIWVSTtgPVrbLoFPFsQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EstAIx8U; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b07937b84fso19103966d6.1;
        Sun, 16 Jun 2024 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718545108; x=1719149908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1LtXcrPyjj9J3TgmCk17n1mr9AKTJmDlg5xMC8/WQxs=;
        b=EstAIx8UCx9wWOMipalsua3owBifNnJgCNGtsZamIFLZDII2s665BCzjFtlztRZ7UE
         KV/AyNA/HjhI7LNWQtL7OirA8Ee6nDviP3hqLnL7mKLyUDrCD1h16vNXqfKs8VpQUYVL
         eChkJPqzRb0ipRonOJKPnVHUJ4PZWe1OIBUgUyAuKEnU+/Nav8Es4eFMOFn34+Mxz4jN
         xj0ULVhl8x3fCPkVBe9Nl/8y0/5SMoX0YeAitnifKsDUnu9erhkg3dzrYTIpbfadQKMN
         wvRbyNfUKVkvMzyprPzcAosr0yAj1DLk/n4kVjMha39nmGZH4AWELtPxnQjHvt+GvaUl
         nsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718545108; x=1719149908;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LtXcrPyjj9J3TgmCk17n1mr9AKTJmDlg5xMC8/WQxs=;
        b=HZugyFIXU8ByZAwQtAfNXQrcVqmrsSFK5P5YCNu2oXg703GOL2BWOpFRIEyRjxVc7h
         EhhuoIkHTI01XDT2UC2uzeOcRqWOJWdA0GXzd1CFF7QeG109o5kONeRKRhcIEma15ol+
         tQmazvmjY9gA3laQILDcnBfKNt7C50kxIvWcRA22RuhKYDgu6duHZQB0B99ZdQcJx7wC
         zA8d13Uio1RMLYYQWb8os5Z354QRhp2T1hMakn4onlQo09/FvtYhC7Ckx3E4Gv/jCHsw
         QMZTUY42oOWUkMxXrwdttaVTtjVka0pIYzxqWSx3jIk/0IXSJvqQziZ4Ups9cvPt2fXG
         x7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjPhiRNLMfN0yR47YW4rbsz+dNqT0fQGpsbqpnOtggHfzl42fDT+DHBsY7TkN6IYH3MDGhGsX5OyphGLodr+lOSzx5eqXv7P93e5mduu7POM5Y2dQpl6XNdJSBBhlxbrE5RGLd
X-Gm-Message-State: AOJu0YxjdHGh5jR3lS+UYhAcZAnsNJBEOZtcFcgVB6zA3qZe0Ckw06Cc
	24c3tB2D3DUY7lphKEdK46aEtfelBKEYww3Fm2k3Z10HXmLwEw5p
X-Google-Smtp-Source: AGHT+IHyreshO6JV99I51xrlWbnTLq5i6Ts9sw6w+Xja/KSiFNzNdMkl+OfFsZMsBVYwB7i9ADIx9Q==
X-Received: by 2002:a0c:e40d:0:b0:6b2:b9d9:f8b1 with SMTP id 6a1803df08f44-6b2b9da6738mr54576206d6.0.1718545107649;
        Sun, 16 Jun 2024 06:38:27 -0700 (PDT)
Received: from [192.168.1.114] ([196.64.245.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee07d9sm43394716d6.110.2024.06.16.06.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 06:38:25 -0700 (PDT)
Message-ID: <eae0a431-0cb2-4178-bb65-50cb3d331429@gmail.com>
Date: Sun, 16 Jun 2024 14:38:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240613113223.281378087@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/13/2024 12:33 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.34 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.34-rc1.gz
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

