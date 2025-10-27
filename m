Return-Path: <stable+bounces-191320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D87EC116D6
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 21:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D600E4E6773
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05431E0E0;
	Mon, 27 Oct 2025 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im/ryDRG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDDE2D94B2
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597780; cv=none; b=c43gBiT5OEkxBJPv8Ut7zGG/gaa+iuLueGlAU4C/a/fOiZInJGAl+RoS2HdLXd4vaEw75p+OMkTCQiWAaUfklvuR+AXNIUC7NdOgsOIJDnsyg2S9o+1vx84qF6mB2MUSXQ2HFX9EmJzuwD8sYnAOKe1klRdRzvGpMwr4gQZ6keE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597780; c=relaxed/simple;
	bh=gWWe3paV3a/kYxDO1EPMAPiCjS1sugw4GH1dIZqDEUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q71+OG9smSOmqpcnwTK6Gc+DlLGIYppi1rilSJMwNQp89/h5uu5f5gxhEtShis70h2f933OpJ6SRiAzmoKzvGnVrL3OWGvhFLHjgsEmGkBI9BlXquDOmfy7jx68XvzUsosvAuT2sdUnQm1XYzq31mhJv56WJmRN6UWjkBkJ4eQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im/ryDRG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89f3a6028a8so306303685a.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761597778; x=1762202578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zODHDgIVcThjNTQxncSaZSJNvBOcC1ZxkNJs06nMyxk=;
        b=im/ryDRGW2j/YpVX8OxMpPCvo0UtWJLR7fTUWzxpou0Hs195/+gLryw2HFUf9Cvn5K
         ugcqH9FjyMnzb3of4LfPT+tCUNhVBBNX2nEaGoLiDXRy6xtGqFRNVNCorjnrG3w02Vmr
         8fEJW+FzCWUpjdLI0GNVA3/a7VJW/igG2Mekfw5EtrE3e1FmVCGBQMZUkSmWgzICnfgx
         t/QSst0rsXtFO+RuHS5RW0K2/XLMGHq5On81ws3ZRa15E/VzEtEi5AheDQUdOHIKaU2N
         PpN6RQM+vI5VqR5SjMGbZkv+gwX6Ht2e+c0ghboVEYAN04uL5XgYOjwmgroE/mdCbq3G
         FRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761597778; x=1762202578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zODHDgIVcThjNTQxncSaZSJNvBOcC1ZxkNJs06nMyxk=;
        b=cOm8ugrOrqnMzAJbEa5CADcSwkHcDaUzttSTKkpw708w88zflwXCp9UlNsFWcK+dKV
         FguvfGeZoJQUnQ8CWV9YukjljDWUGG7c2HTv/yjPjKuuwFkrEEKS9s2/5GA6i8NF8ZyR
         kRx9vW4I8xPCxBg4daDlrx9dVw3WtfEWeON6uas6B549KWH+7MPvC4z4xJt5NGht7nEd
         UIJ5JswVftn0SKsYqZEE1MVat1bp/tZZSV2v3NBR7s656vYn9E3H96gYaWerAOWrkcSD
         Zyl7Wr+Pq6w6+klHk46W0VlJhNyT51sUy+Zw+0oP4s+Ld1haK8jyWyZmnsdiNKxdy3cK
         f+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpo9LkgfRQYaZI3UeKbwkaC9qALvW/Igq4PVAEXOt4DgXclcp4eYbIui4Ut4c0bHVBg+Bp8Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCg5q21/A6klBYJMO4/cNsgsh3Onx9wPhu3HBD/fvTpMnp12Pl
	WY55JbzxXVX1QInpaXgL/eZ5WOMhDskXbk5kmjx8nLPoU2FB0QRVzjL8
X-Gm-Gg: ASbGncs4sxKJ0g/QqRPyJT57T1JxeQZ8H0nwDE+OMoPyh2Pu0qctFBkv3JQ1Y2pnJBT
	6HV4f0c2jdxsaPKS2d/lOvcluRlukqDPnuQesw68kaZCI1zE4Km0kNtGmLz3K3A0l+hrar9wiZ7
	3v4dgp/wNSbDQFGgBVWm2emStHt8X4SKobXvGxBZ73HZ75YV+DL0WUYZkLTROdtXopSCp5YxrpZ
	lXl41rjH75ZiUxI9aCfz4e5TSmcZBFDfWg0uQQPScwxiGZ26dL0LquiC5rME8/X8qAwYattfqsl
	t9je2nVUIo2IYnizfXHWA/wkZd8INonalzVIxFV+Tx8Sv4rqKoFmmjVWtXRAnK0DVkeHv8oT3v/
	FZFmE3Rt4pYhwuE7YbBA4BwV+dfcr2YJ6M9nzipTKD4hGzlMgiBxyxCuxscnjdmirKLYlJY1Df7
	3imSI62alD1ffAtNZLZsJZCVfqNcI=
X-Google-Smtp-Source: AGHT+IHjY1h62yk27PivH7Y+anegVGVxs9iDSQpJ7ULwNyIzYPD2WxXDfIKBytoxE1XNdGRwtGRCmw==
X-Received: by 2002:a05:620a:2953:b0:8a1:b5ab:bbd6 with SMTP id af79cd13be357-8a6fa37ded9mr168442885a.71.1761597777922;
        Mon, 27 Oct 2025 13:42:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f3497793esm657733485a.1.2025.10.27.13.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 13:42:57 -0700 (PDT)
Message-ID: <4d3df05a-36af-4e1e-b904-a995a3744e55@gmail.com>
Date: Mon, 27 Oct 2025 13:42:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/332] 5.10.246-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183524.611456697@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.246 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.246-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

