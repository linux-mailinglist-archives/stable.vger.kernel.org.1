Return-Path: <stable+bounces-171631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79005B2AF57
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA95189D8FC
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03676343D9C;
	Mon, 18 Aug 2025 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5PLS+U7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B8345740;
	Mon, 18 Aug 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537963; cv=none; b=IG0d6BUSwU3c6UCa8HJTVRcjz48tokCnWbSDeFvVSUZidvLcOOR8bXsZ2IS2Cm6EFotzM7zkC56rUjR4FTnw7cErVFhc0gTpqMusezKBoAc8VdEe65g1wU/KO0IflmCFON13RFqrkuLAMgDAt5L2RBVTdQiJYwNEsJ5XX3grhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537963; c=relaxed/simple;
	bh=7wFcCIdtzByuKzVVBKSft7A6SsdODkG10FLfUcQhxUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDh5L6fOhOnKxA5PZq9NyoxJ76e++D6FHUmO/8U3jzCgQyjWfAcTDMNvIw/zD36lnRMiIYfPgnHiOjxG5s/IbWotRoe3/PUGN6yTCrq6EtEbJ6e24KoUeWctwRmx8YaDAsyEl89W42Cw0jcAdMnW7jFLObhNzUZLOWXIwzP1guQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5PLS+U7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109be3726so56253701cf.2;
        Mon, 18 Aug 2025 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755537961; x=1756142761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cdVy60UK4XlGfswi4XZuY+mTxp4M8xkViNVTFQyaMcw=;
        b=l5PLS+U7x3T7LUtnVKunZaXs9jtvcjg7+cPSizmzpMPTBib0xbDiRtsTS6UTtgC3Jq
         AofvF30G82i1m0KUttEZ6lxcZPZGW8cQJdFw/0+nJPI2TuwFLRR2DO6S7TKpZErN2SU+
         GQGO2Zx9KuHeQrn9o66KCDIAwTBrD9udb/bkYrsPoCOF5WWub6oU7OF9lIAk+6mFtXko
         iPuINAisGsPF9ckPDPBWJAAcWsRqh87FVebEm74Rwl/+eD70HD0DwMbfqOBhhkG+iNbe
         uHevflSlR8/JtMyZWL1rY9YGFWC4EQAX8qWGTbJLPj62aMWGc3Uno9UDoIBSSAethbTy
         V8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755537961; x=1756142761;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdVy60UK4XlGfswi4XZuY+mTxp4M8xkViNVTFQyaMcw=;
        b=KwWxEOagzw8IjUmvZZfre9MnS4/0Ag2RaLZDkBwjKaGlcVk/GgIwQ2f/XI6mn638CS
         X3mBnMCl+ifUiuUokWnWAqJMEgQaYkACfQPZzadBZOHv4UmtoqE7k7ushMEaXmGZNQI+
         9mUcsJXG3hdxnPY1MjZC/gMo4aBCpvkrnD7tjdIxIohJOT1CLY3qgWRlzQWiBRER9GS6
         lOY3rO/YAbVupRl+QEB/1q4W7NrI7GFr0WZSbGYHrKyN+egrlxeyf+HTbiMosm9mgG5z
         d5/x+tD/w03heiTzMqNDt3NCciDQrc4UQGn5Jamlv2BLN04KsTpnAatwfBFUhYp7iNkc
         aUcg==
X-Forwarded-Encrypted: i=1; AJvYcCUaPYOTJfAoE51WCedcCwzoPkxw5gyMUaBwi4vtb/EgrQ8KkrSzVCTTd+wgNGjHAA59ycBin3nB@vger.kernel.org, AJvYcCUrdVpgC5pi7bgp5/bTlPfHEmCeTUzL+e3uFTDJXH7hih3ZrOgn4eB9m2BLns2Nrj02UjcBqNyg/BOXo8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54PNKQyX5zfRGIqmr1fxE3aW1E2CxitjjZDWUsqWRedw9PDrR
	qoCPbH3zerJnazs68vvplyMHer4m9bRais9YqUmM4l75o9jDEBJ8CcOP
X-Gm-Gg: ASbGncv/N41/5V8Ebze6+lJivKVkdnPgX5ehjUcFl6aGoIwjb0f916Ba3pCQyTFJ5ib
	tmp5KC3vQHFGE/luUx4GR90V7ZkZNJ/fhZ+0p+CPpT23alWUIr/BRdX+lWpcZMayMsBhqCcRDA8
	fUacs7UHcrv8RdaSUnjAXhpZuTLeefu+r6w5FRkxVbIe8dlbqs4psq7BmnlvI3++WRmVydzHXIw
	Z8fBDLlgiGz7K55PB0oRy9p6Riy8gCPDB5rOBiAh31sb54V9zmy1EcnJSlkjWWXfJQ58hWMiuZt
	bus40dS5GtkMV8MAeykr3ea9XG7K1BmA5uVfjQsDFhRjFgmCkT6uB03lnGa5S4hflWNIDAfyhXC
	4/uJz62417o27wnnrYfBCfiRwLFKgVgsjsbVwFt0bulLMUU0CEA==
X-Google-Smtp-Source: AGHT+IHvhXsgzH17G0UYlIoGa3qpNRIKG5VI8Fmhjz2dTHAtZzo/L3UL9/ZeunloqFVeYml7TCVq9w==
X-Received: by 2002:a05:622a:1cc8:b0:4b0:7b6c:935d with SMTP id d75a77b69052e-4b11e2cd15cmr157327391cf.46.1755537961066;
        Mon, 18 Aug 2025 10:26:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e020514sm619869585a.17.2025.08.18.10.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 10:25:59 -0700 (PDT)
Message-ID: <a6f7f083-7ba9-4052-8ff1-ba6b784a578d@gmail.com>
Date: Mon, 18 Aug 2025 10:25:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/444] 6.12.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250818124448.879659024@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 05:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.43-rc1.gz
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

