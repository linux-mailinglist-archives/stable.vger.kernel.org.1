Return-Path: <stable+bounces-188868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1ABBF9C36
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 04:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CD124E59D0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 02:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6FB15CD7E;
	Wed, 22 Oct 2025 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSXGcZnU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43115687D
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101264; cv=none; b=lDcF697NdXA+TEte2SIL99x8pvWPK4D67gysWF+Oe/WhdFTPhcXPhr1l/VEboMRC8uKoRc6IGob3nUEA/UPTag5vSsDsG4uz99200piVqOQ2+QnmBOFe/coFdzSTYIpbHFuVSa4UwviE+wUJaJ3TiSv0AGfU7zeHhmCjta5vpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101264; c=relaxed/simple;
	bh=8wXGKm6DUxI/W19y08JL6KjPHN5Amq0Rx+ianN8ybZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHNL0l7QiaxD37GZFJMVHmQRUqSAXlCRPFxPTXVnI99kEeLnPy7evWiQYXqpmhDwbCpA6SkjZgzVGYwMqreujeY5g81b47+Nf8w+y/ovtT8T9Zxo9i/nPUmvagRltzUfkUgVVNdD/sczeA/ltOFOZ2zxV32m4IeJ15iHfqg1MZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSXGcZnU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso5610775a91.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101262; x=1761706062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Is5hZBe95ARo9o9vNbLjG6y2uIXewO4LIaE8nuciUpw=;
        b=WSXGcZnUg4TL9d35Pq09LzTJ6Dm7m6W82IdVxsqSaQEk8ri0CL0nDr+Yyakyf1S3Mo
         Q7b/jjZWaroWa4/JtC7LTfS6xOX8a1SSREq+8el6FIFfrjxQFIrgvZ0fy24wk2nPY7SV
         F0/TH7L0W7CRmfvl/3OStqcJmQODk8SH10FeWSJ4jPBlSXLa9vLCIbKfD4UwD6y0/L79
         HYr/DFl6ED1PFKJh+BNp+ToDBOOqWP6gTJUELjtUn9p9fLF9VrgYkjIsrgG7z3K/XsF4
         Djr/+o4h//PXFew4Trsdjs8b50f2D9V0QYM2qVKG2BtE8rAqTMqFQh751yT7usx01Qjz
         zR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101262; x=1761706062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Is5hZBe95ARo9o9vNbLjG6y2uIXewO4LIaE8nuciUpw=;
        b=u03qB+Bt87JAOW+7Vl4YX8ZXnLJSuN/LchPNEGiz908jMeJefO0Invv797qzAPcA2X
         NZEbio4U6E+wIg4i9D2d+VsxiC4MNLf8NAUqa5A7RFd8qEC4f/4O5J2y5SL3olU+6aUs
         gyd+CFYdGoq6xHq6ysfmooYnhCLPkjRw3Z0QDs3HymFoCmIkpL2iz/5kJo3hnlHMngaO
         Edn550myDiPOv3zlD6uOAumiMzIunHJ0WSrdoacxAyDnLAFtaDObvJ9VseNn48sDwzaZ
         TLXQfAxNd/FTE6YjfDtx+B/JfOpI7Ftq3IrU97KBA3Qd3Li7yoj26dOQYKFrYvougcwi
         BX6w==
X-Forwarded-Encrypted: i=1; AJvYcCWgT1WLA9blqNXLrd37aAqszMr0RQ3lKFdBoaiUwkRx3ibbcPZP3knIE/crz9xXoYM9sl2DI68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfK/4tWxf28s1prC2WJAZBFsuE526ucpkgiD+dVGcUMvvRRADn
	MVm2IKf8irET/CHNlXh/W3uCgJFs9opwg82Cp3CKgh3d1yEjw366FgMi
X-Gm-Gg: ASbGnctgzwXULAgw2LAu3etcCZ8HuU9h/e8jtc8fMtagM5ndFK7LWROCLs1XWWmX5gk
	d1b6zFG7PNJkcYg7LSpOfGgJDJKRMgdjEiQApTwmIUtwbvDRBBHJVVL9eRf5jOpYI4kK4fZGhVB
	1nnCmq/UXs5ziIVxGMnshFNffQ2angwJ0h3rtwNkL6FSPKLvBz3zh+TBHHw05hQvM0FVLo4Oyq4
	7/Zf1RCm0iR/i8Bi3IEMmESQ86xN8of2/hU6qLlj06FwrWJJLhmoexx31bDyHrYLWt2mOC/wcjI
	EbumYkKDphNkVRLgDrCo7cctkqr20+pmZFXZtmmkJpSAUnGPF7UvgmkQzBKm+RY5vxnc/ng6A/7
	xJpmERLn0dGaJx5VF7tUKvzhmjRVNyxE87Fcp/qqPk2GVdcg3K4tyLBlfQej3G0TUUXiz4+2C5P
	gCaYdixayf2aG7I6nqT1Ftt+fCFcVPH1Xz0/c17MIf9ArbckuGuqx3
X-Google-Smtp-Source: AGHT+IFavwVqCCJX51O/QL9n0GDxtahmjbc0ecv27WqJFcgjvOksegxUDTtOpcgnKqBiINrdJt0TZw==
X-Received: by 2002:a17:90b:1d0e:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-33bcf9222e2mr28788633a91.35.1761101262106;
        Tue, 21 Oct 2025 19:47:42 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7e19sm991944a91.3.2025.10.21.19.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 19:47:41 -0700 (PDT)
Message-ID: <c6090593-cead-4a3e-8380-615cd055f2b0@gmail.com>
Date: Tue, 21 Oct 2025 19:47:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/136] 6.12.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195035.953989698@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2025 12:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.55-rc1.gz
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


