Return-Path: <stable+bounces-197983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37371C98D77
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 20:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D853A4358
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC6E1ACEDE;
	Mon,  1 Dec 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB94WNmG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742651B87C0
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616943; cv=none; b=snEARdXThq/fWYdCCN6sovKroNgVsiPavOpScicgTrUMZo8tckVDWWmUafmEULqIODJOSxFUkqd/9Rga3CS6mk3HVnVbTbIrUbRgDh69mRNL8R3GKODBOCkSVG/DP50FQNT1Iupmo5ezotjc8G7BF/6CxWjuoIyPkp6nxMgBfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616943; c=relaxed/simple;
	bh=Zgbj8PlSoDz3e4r9wFsN81LzssrEk4T1hX/dR5Q9zhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MC0d21/+cBZhOiGuCvhmABoLl3Oi/0X2bGd5Yea+T05I8VNr3IZr51/xHWJtsErNLsFbiipTKDc1cUpbThsf9L4z3gmhWaYDqJTtOi6ssFz4XFwoKf0HSQrBk69xTSJ5yQeSfNR9Bde3EzfLBFp6w66OgGl3FTNvTILhJm1u6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB94WNmG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b3016c311bso575846485a.1
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 11:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764616941; x=1765221741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzDebQjWZpMlRG+LtMc42JVB6/2Vh3cogJRGNlIZlvc=;
        b=bB94WNmGDSjotkoJL66LCs/lQBEjenb7Y0Ee2b/2Pc4lhaAKRVglwuelNZM2A/2I59
         Smsidm0oKNdIoof/AesmqrT9ag6AYRYiKhnB3ahNAZh/0uwIvLxzb/JGnS0bIbEsyuam
         Ysfue1/0ekDpHUHCKBC1ylxpihz8wdSB3Y5JOViywmtStpSaDfwkgarlfIT4rOnw6lqm
         kHEAt7L4Gww/E2pswhZ+WQhtta5gpnJ1Xen8AwDzQvFq7m8ikBEwjFwuI+ThU9tDPGvQ
         CBnBcImMy9HRaxWNNW4P4NmC+jtZ7jKLBXRHYq6P+p2LN1oWrb5xxckHbWtDIHY+FUdP
         g++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616941; x=1765221741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzDebQjWZpMlRG+LtMc42JVB6/2Vh3cogJRGNlIZlvc=;
        b=w2k9fKj0Mtsfhqc9GCNXgPtZQgw8kTKUpAGdI4DpNmdiOt6UZMLS2iqpMDR98QRgvG
         gYN8mESSNlM8CQoWZmSdDV2hy0g37+WuydOtF/+YwDwkKBxtMkau70KJs+2W3fD439Wo
         iTaSH9s+PJL5/qSoDCdQ0xD+cBI7rwrNVCoF6Sl0j+yLclm3XFgrGIeqM2VQaYw1vlYj
         ksQgLKK78w86zhE6kAXuOrFaCheSprZWn+Hg5fRCsxEJYAxDRl3m8bG/ZMEYdXnsU/Y8
         D1QraHUnnZhs9BaFZnEPDlCxZsXc3PUQN+/0COkuINgn7xS/eROyDeXtMCPOfV0LRd3S
         fVug==
X-Forwarded-Encrypted: i=1; AJvYcCVcHfJ9um9HhFWYTEXNnVKpjZP3YqRa4/7Mh+0OFBpHws7rq6HWKMe30LiirKM6nhLcTeVMvpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg33LslGtTDyvtxxV2TmLNuiwNO+p01wknyK1aiefGI3wDTdBr
	wLlX5qyZQyormgz0sc0Qrc++10meVab3vkhTFjoL5xwTCwLwww7/BZ2Mhv4D9w==
X-Gm-Gg: ASbGncs/ck80b283jFZVuzVPXsx3HDalnHsZWJ4PAgfXSJoFldZNjOyNnnquzLKIgyM
	1FaY5JoOzZD/D985uX/aMnVezl1XFUiKrQGHdv3YOi5cGULU/Z41LpWAajdY350hqoB53XZY1g9
	WuegWwwU3wwAGWIRXs0nkpv+bcAnkMASpqyBeIri0SqNZC0moTHDO/RASAWo+3FC6EsIHfo0HLp
	JmYrosKJsFbVIT2l+uc0BsrnpMu8SF4oH5VFS5pEkmfFFeaImSqejk30+XT99MT1H3OLlI4dhoH
	kwzn1q0F8XYEHRebRIWioMqTnvk7mpxHTd3yHpqUM1MwBB+kkjWbOTpR90704FQmaHsK/hNmHoz
	+/TJeEDCw33wD6UT97QaRBKtNJZ/fbD7vfbZfycBaZHdsM2RTSruqkCQH1d2QOdIUTqEeUzILoP
	2Wf+eCFRL3soqzhTx5f9ESoT7aZxgLzU4xKmpYxQ==
X-Google-Smtp-Source: AGHT+IEcZfYkFHsvEMBvJ/GDPn5E07Zsr5/1DwlC7SyfCIghNvunkD76FZLcDH5dLmHl8dQPucWPTQ==
X-Received: by 2002:a05:620a:450f:b0:84a:d3ce:c749 with SMTP id af79cd13be357-8b33d4cac81mr5684882585a.64.1764616941346;
        Mon, 01 Dec 2025 11:22:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1dd169sm907120185a.52.2025.12.01.11.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 11:22:20 -0800 (PST)
Message-ID: <e915024d-af6d-4919-ad17-153343ac0967@gmail.com>
Date: Mon, 1 Dec 2025 11:22:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/187] 5.4.302-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251201112241.242614045@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 03:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.302 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Dec 2025 11:22:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.302-rc1.gz
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

