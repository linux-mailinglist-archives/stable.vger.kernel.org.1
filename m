Return-Path: <stable+bounces-189026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017CFBFD9C0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A1F3AC226
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B82C21EA;
	Wed, 22 Oct 2025 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMp9SCMN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201432C21D3
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154395; cv=none; b=FmPANhHrG8H+tzi19ZalWjkGLKeGu7WwgjjO1i0HW3JWqjxHhXdfi9r7oaj7S8V3F4RAV1kio5/L+xjftISbxq0U2Z7O2N90WSWB85l+RVUC0aMEwIDyogbcxMMqtKCqwhVnA8qjMhzIcNDGkIJ50pUm+leYp15u1YtpeYxp0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154395; c=relaxed/simple;
	bh=X6lF8zIJjF7s5ROui5zboNzCSWi7qJozziFtgW7mR/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWaJeuO/OZ9qQlRQTgY59uSve7U9tBEI36jNcIQuuiGP/kb3vFqPg4vZzFE6MzWUAVU8ksraSRfUSGs5ZfRgXgtwvUl74QBoSWY6KO3X3yh9Tj9ybIoWmgE2niuuhm+FobHCOMaghWczbDUV3ytm+LZPNSUbGjB4RV8qjtjF4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMp9SCMN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781997d195aso5451773b3a.3
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154393; x=1761759193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OroZpdIC1yf+MDvOR3gnvSgvT2N1FiEkEXy4YQzpI70=;
        b=hMp9SCMNjvPhuLTXuw6lmv3mrsZRWO+t91neV44I7KqAWMkCE78QUmXOY0oGm+Pfyt
         rTme2YCzB/NmRU9R8kLLiCLPvMrq9St5MpLMTyJUP3QrRrqhDR1K9bhxMacnVUlwGHKZ
         cEPhnBz5w8PmDeOGFznaQGCwgkmbp7WDhmlJV4y0vsSr+WvN1cpe18LBQ0otkcvpFDqT
         p/4xoN2hFMiNaQBt5uzAMN3qCIF0vW0gt2C/UzhV5pXlc22k6cIej1p2m+ReBFWqizvG
         Dn70GyDs29YoOyASX+b/8DPXxhtkqf7gW9QJKH8FwnqRLmHNbzmbE5KjOj52HcDnnIwH
         ZkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154393; x=1761759193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OroZpdIC1yf+MDvOR3gnvSgvT2N1FiEkEXy4YQzpI70=;
        b=Yo/FoBlsZn8oPMSzJxxDSeTZhySd0dnyztkopd/sNPA5JdLumPHspoFz/YXShAPBAh
         flDMDcsPrsoMAC9fBG6Iu75uUZ34Q84g85WW7/XNp2FWgODHshE4PzEVRTEADJu+JMf/
         i6X0rGwAPOwSnIveXgGtItyQgokLsPX0ngV6ZKoD1b1GQgxDt5dS6aeSBmRy9Du+Hm3T
         BXS1AH7XzvhqKFOZ6ms0xr0jIt4A1zPyWbGOFkP8ooX+VO7oAphgUTXIO3LWFmnH1aEk
         SW3ZdE5C4ud7+9HcrUURJb4Q0RKancwPZbJ4MCmmrNIkYBKop7ugK4n65r/HgMxV8NaJ
         bgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0kQz67ZrgEkeCk90tCGTLzk3bHJlQc/yJN+EhOWCj6EilOudLIr2mqJuRuF3q61Gph05+hHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwa7psIUBmHqf7h5z60csQyZFEtKbucf2LoI99bSYzUt4S+E1
	wEaw3o/3f1ZkTY2V3gPodWTbS5ioriaq7K1jgd3JiahVM67Lj/h53Efr
X-Gm-Gg: ASbGnctG9h0ho7QUkoadsdEb+1zweLmkmLscl0hj3nX7uJ8BiZBPmYwoCvhf7gr6BNF
	txYARe5erBnsfnehMKoIvQYy7KvygAl3NueD6lktmSV8/pNfRyr6B1SDYY/v5EXF0DW+ez7+vGz
	XretAo4lwUVsGPAlJi9vHKzSwMjzqTLYLAuol82TSKPVSUuJP3WdxpAgdI3cEkSE7P0AOLh/V7o
	eaicFJfpZZef2M5X8cwCK6EVqC7/aYDwf/DuQ7EAzJxhUVbPT4xRW9e4gm/60ChT5WCwhvhsYfv
	LnS9pVK4CvVi85QHIP/zC+5fw2R/GydbifqLKiBi+FbfsLxQT9/8Q/GjQ1Vd76j1VyVIIp0BlO7
	SDxHDEVK4HOaaeHcCGP73hrri3o7UCmXQ9tCIJI8rZZ8ZLKLeBu5TocqxOoRnRwK2+R8G5QxZbM
	V+BbPNOL5q+HOysDl6xf7ihbVjT2MM9mvmESbl9Q==
X-Google-Smtp-Source: AGHT+IH2Iq8OrJ8QYXSfjxY6+hOLsa6tF8yaRUdubPLGMOGZUqcxqkOZLieRbhpzfe7R9WCuEBEiww==
X-Received: by 2002:a05:6a20:a11a:b0:262:1611:6528 with SMTP id adf61e73a8af0-334a85fdab2mr28401979637.29.1761154393201;
        Wed, 22 Oct 2025 10:33:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff349bcsm15116989b3a.17.2025.10.22.10.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:33:12 -0700 (PDT)
Message-ID: <bd847f60-5d93-4924-8e92-ec0e3b809817@gmail.com>
Date: Wed, 22 Oct 2025 10:33:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/135] 6.12.55-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022060141.370358070@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251022060141.370358070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/25 01:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Oct 2025 06:01:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.55-rc2.gz
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

