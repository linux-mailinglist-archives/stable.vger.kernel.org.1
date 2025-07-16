Return-Path: <stable+bounces-163178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE6DB07B0D
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466FF4E5AD2
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395F2F50B8;
	Wed, 16 Jul 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtgzgmHy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CBE28A1C8;
	Wed, 16 Jul 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682945; cv=none; b=TK8wp4y5bU6laQjVDuxijPv8tdqaQS3md9kKttH1lpAWv9C2GeVvbuSAhU6WgkcLWgWfE2bR51hfipUyJrPHnRebO9GtBBg2cA7KKwEYGzDBpavH1KLkswicQb1N3IXGo2bFtxtz77dRc0lJ/zeBCxjxgfsetiAVn2vV4D8uO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682945; c=relaxed/simple;
	bh=AEkYO6oYj3n8YvSDi56gQddt6FxNyzr/xpDU2dcuCbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8L0Xx1snDj7OssZmE6Bc+pIVJu/lCUUpdm+MYiE/ijc6VHRcog4zroMKin7ezoVYaqNDSauW5xp8hQe/ktxOmvHR2PiRFmELKxOdaEBeBQliSSklx+CD2Ptt39D0WdPMy9u4ZfIhAwSHT+LGF1R5awvsHdQKyzV1HfTINqTUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtgzgmHy; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fabb948e5aso1286816d6.1;
        Wed, 16 Jul 2025 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752682943; x=1753287743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8JyUIA1wZL/E/w4gMI2RQwwZYPmSniyeepn20poSwjQ=;
        b=AtgzgmHyuz3B6Gubs/JqCwwdJ7oH+zUkM1oy3k6O5o6Hbsx/6dILZEr78YzcPO8FXF
         jnybWqsVWp1pb3fF/SGpXbR8NS7qeubrB+cc/VryAa4ZiaLz/OPH9sXbm9ppZj6JGW5T
         ApJFtSzdlhGmRBdvk7lDA2PyiXr8bOt9HVrYajZID4ETuIijzxeztJFsrS9pIL7n/qOK
         01xLmZewowqDsOZ/ojVk/O8fORW6UFh/5INO7YKi52y24VtiaVKSwHJPzVvVseMwX3wT
         W9NkG/NBOoypV6gwtQTIQpMf6RM9J6qH9ymuf0nWbCMqhHzBsIZ2oUkcH+0hRUFbRpkg
         uueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682943; x=1753287743;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JyUIA1wZL/E/w4gMI2RQwwZYPmSniyeepn20poSwjQ=;
        b=ICRRHesTy5gCeWmibx1vuK4Aj08DyegVH9lTipyU0YcmSq1tVCJnEYoV0LomiOVUR2
         Zn6bALndjayshhEIOrUnb9xsc589UxLFkQAfr2s0VJai7cDEid3ZDZZh1gitWvDZZYr2
         zHWSy6vejS8VYPFhYrbEJWn7kOD9GjqVODYSuTDlV6RVJJ/bZhheQhF9GzPwI5VdODCq
         nvFjqSygCLZM11YRTBvKz0BFS+pFmRPEOKDmyfF7wzeRDSI8BNlNl1Jiic0YrcR8WBnv
         tb5vgi6pAauPW5R7hJleMeUp91ohAK4fL32pBueDC9V8i7oDa2Mssz55FuPrcLR8gKzR
         aJTA==
X-Forwarded-Encrypted: i=1; AJvYcCVphMUpdS8Bixhw9PnBGFVOz9cZ29Xo2FW0CMFv1CN05WpkwbfOAxwait41U10t/eRzVdwQaCFW@vger.kernel.org, AJvYcCW34wo69fCA3Nn7l8Svgg6S1/kBAaweZBHwiyxKYltMsKoJAjRKwJO6XUQrQRaOp71ZNkpcUjklmSOUxqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovUrX3PorDXlFig1NrtGgrvO7JATHO9m1PIS3CE8eJKvhPN3p
	qd6/W5VYe47sJJ11LaSYfqWHrWKu44S1m1XenF4YfOQssGYDCtNYx+xO
X-Gm-Gg: ASbGncsEqj2krn7C9JENMEZsAaczNtLH7KFlCNztkLcBNiLMdRfeGm/OFTsMo3aNSxM
	4uo8wUsa+j85um9j0vo+HWJ7Nc20Jbj14QNiOiZBz/qdy9dCuHuo13rHaPIPEGuuzBCMvIxCqAH
	7goeGwmmTbDiDuSuuEPCw/gvS26bJLTDvrSwHRMwp3Z8zKXnqluZMlCqD1pdQseeK5Yvm3KRfpQ
	pEGkYKsQtJD4aKiq3M5yaRvRGYwUPI3c7WvPy0YCn2c4isuGIx3bevM0AbFvASqZkeso9lEwsn1
	UjNctAoy1IANPlJ56vvnWDBu3Jvc8+hsKlAlMMdNQYINYDRttqmoVdGgvo0cwG5yP8vI4SRSC5J
	qz3xkJor0lydGjWSloCpamWhgwImajjPrWeB83dnWI7cSCzbOwA==
X-Google-Smtp-Source: AGHT+IGnq+ZTdn91l5dBQONzf+LTqEAMtSkk8h0S1ZABalUhbOBTvCKWG5dV1L2XaCxeaaYdzTNzEQ==
X-Received: by 2002:a05:6214:31a1:b0:6fa:d8bb:294c with SMTP id 6a1803df08f44-704f6a55fdfmr41080086d6.14.1752682943230;
        Wed, 16 Jul 2025 09:22:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39d1fsm72406036d6.64.2025.07.16.09.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:22:22 -0700 (PDT)
Message-ID: <fc781703-e355-4ea3-aaf9-50c6fe90b628@gmail.com>
Date: Wed, 16 Jul 2025 09:22:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/144] 5.4.296-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250716141302.507854168@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250716141302.507854168@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 07:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.296 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 18 Jul 2025 14:12:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.296-rc2.gz
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

