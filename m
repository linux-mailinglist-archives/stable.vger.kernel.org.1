Return-Path: <stable+bounces-197655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 438EBC94846
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 22:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1013B4E1909
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5026FA5B;
	Sat, 29 Nov 2025 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnDWUWR9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3755246333
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764450226; cv=none; b=CZTNIqZq9L4ByYzeSDCqmjo5XA2elYJsoaP1NIhSgmLfTYrXUEYBiOLvbrT01c3Y2jzLNDZV+TIL+K56/gUftRqrL/VxH5VfaTZar+84rkLyunvuQHhTkORQRZMRG3LR//wluw6stmbSILLc2R6RjYp7Iqn+aSlzfgna+7FvgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764450226; c=relaxed/simple;
	bh=I4J065WtXbP0EattLzce1h3g+lCohohrgmSYwqTp33A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufGpPMotejxbIdAvomx4BiLD5xFkvyRQLqVfyudjnbZapXUUnOhkJG3RQcMk0gJbnqRJwzeECX9rhnJecEK4MRwmP8ijhUMA6MlcEHmat5J9eP/lva5Inq+ZqRPeG8Ecp717kGkvliiIVHf30JqYZQ2ujvs8sd1ZMm7T1Py4oak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnDWUWR9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso1779308a12.1
        for <stable@vger.kernel.org>; Sat, 29 Nov 2025 13:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764450224; x=1765055024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpfLBhneo4YXByUaX7wofPB4xvrmCVMQwWHAEbf81M4=;
        b=YnDWUWR9IJRQEihgzXxPXF4Nqc4aLiJilvzckrZBroR6mHrSvjlEQQZpSfL0GLA5ps
         hm4Lv9SPb7cbJtsYp/Q82BWAEhbkLQua2paIH2cS1gFscqY1LO4efuHKBNxLcdhNnLz/
         KGH3MYQvxhkS9ny7JlST+P93XDIqbj6bQTrfGxjkxPZ4Bk7iSSnDmgGul0KflbbTXXK+
         mQDksms8vlX7HhNLGUnpXHU2urHEJXTpEzm6xeGkLnCkZFJN886NPu3I8szgtkPl4ShL
         7r0teHeS/M+qbwve6UQPVGUt9uSrHVeSxOh78z2lka86SSEYdXEVfBr8gf1XUrfObdbi
         GHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764450224; x=1765055024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpfLBhneo4YXByUaX7wofPB4xvrmCVMQwWHAEbf81M4=;
        b=ukqkKAjDQfH8q8eLjKD2JrxSVkZOv7dhLGnUEqonSoXTlJqSDP6j4ef8bvP6QBA7TL
         fys+XxnIcWRT2v47HxhkgfluulwO0aEGEpqJY+U0XKB7uOEKXvSanBu8ZxS3WkViX1Ny
         tI/JKGjb1/8WPXkWRBH8H/WGfFXS084AblPPnLSBLcwyaiPyQ6U4uWA7rVA3rddFi0TJ
         tdNWLtsFQuB3tDcMjuawFO5wwd2I3+lH6jsvLtG5Pwk5Z0/Dm7EowrUSav1ynVax5DkS
         eq91s3f8rcm9eIHCyR9SxxdYGXbbfUYPwWKNFcIptLxjD1Cb8LaU2VeMSdudsIRqZdIM
         bZZw==
X-Forwarded-Encrypted: i=1; AJvYcCWPNOt1LWlHZFTnpItlD0Bkoz+YeQLbWemPW1EXLY6eaSJ/JIU6JTOExAjWsv72Pw9O75T710A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDLb+ntxofL2bUlZ36Pb0/tyuJvPPjItuUUT5RWGgcT04tbNl
	pqzPIDeuBDO/REZ5wXoyJq98U+qSVIhT/awuhLzPWMaq8ZLs2VWEhEkC
X-Gm-Gg: ASbGncuzdPcUlcf0cfYDGJ24feeKKz9CWBsstcQNBXhHqyCAS1V2B6AoWJoDpUCn/ru
	VJR5o2n2xkkyVYslPauVUEc+BMqcLoIYI+t2t5e7A/bHJyEb/nQ1b/V2NPm8oA9u7l4uAQKWzLG
	+m4QgKim8p9QSplwEqWHl5fmzvMWTTrL3XSPk1trU1p8taIyk2IcaBHGh8HSCdlSs/g+/8B26E8
	uYNL4prJtUJCaoPXWD+ESJUUxK1AYKrtwbf5oOyT8JQ3CkcSGYV7cW1ANBSd3YuSGI3LY0XtA9c
	SCGS+ZXEQOxVIZig44XcrFszCqML9C7bpOYKqCoh+2aEvouExLecPfs0smqb3V5nHBD0qN0fEI1
	X90t3lOdX/VOznE+2NqsVXVk5EZpTDWdquE7dXVAK4lJYuyPjLD135TQfmjE5DRKIzH68mZ7C5j
	OLjvaXlbC5oEGAUMFyOYBcCYPx9mNju/u7vMnMv/gl6JP3+wMRwmn1
X-Google-Smtp-Source: AGHT+IFcuwZ6jgBNxAZr695//dbYbEGdPM9zQx2bXMjJg8Ap1CJzJf1Y3GNY4nJND/s5PjrNzaQtIg==
X-Received: by 2002:a05:7300:d4cd:b0:2a4:5eaa:a9a7 with SMTP id 5a478bee46e88-2a9415730cemr13260287eec.1.1764450223888;
        Sat, 29 Nov 2025 13:03:43 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm28195477eec.0.2025.11.29.13.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 13:03:43 -0800 (PST)
Message-ID: <e91617e6-8801-4e26-8a35-b2f4d8297258@gmail.com>
Date: Sat, 29 Nov 2025 13:03:43 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/176] 6.17.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251127150348.216197881@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251127150348.216197881@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/27/2025 7:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.10 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Nov 2025 15:03:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.10-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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


