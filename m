Return-Path: <stable+bounces-150605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB5ACB9D4
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32181172813
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC218FDD5;
	Mon,  2 Jun 2025 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJobAp6v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675E42A8F;
	Mon,  2 Jun 2025 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882952; cv=none; b=r8cJtP8gPVV+MyHQ86+eIRfFDTY7kGq1QpiTCCq9riBZWSTT8/dNdVpth+XH8uit+c2Kf97hDwFtvTjjHGOjBmlMWRhV5rXaWZuIJFS1rFSt5JSAiyJJqsnmR1dYGjC9jXoCSa9TLI4tq+sJ1K8ljKr2QhNTUkDwu7xSLNjE14A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882952; c=relaxed/simple;
	bh=c0gEGMhBwwH3EsG3J6mtSe3TBHd4NML2arG+mH1i/Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PA6eyPaFH5MtbaLlR9HsVBzXkLBTKqlFcf56zinjumjFcm36fw+zR9HHUdY46LD1H+8CgbUrqJMhurWiyZwKuaA7x3c78u+xVVre1B5GSpVLIjMf6F4/+J/zpWr3xHQ+nGVgO42WmgA8KwJ7RdTee+bnJJivFlqPpJaMR+wNPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJobAp6v; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2351ffb669cso35979545ad.2;
        Mon, 02 Jun 2025 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748882950; x=1749487750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HknikpJA2FcmTw342+lb8lkp3yYgT8HLedmbOD4V3nk=;
        b=bJobAp6vNH5FAdKqBoxSz7GPfuXVWjfwFxaHxX9BPGvBu7VynGFBVwe/p4udxdIv2G
         TNr6n+pw7fwq4Cb4PVM3ZgHO2MAd/CyoWiZx97uQ5WBKQVEH/5Q6v7TPLcCkpSVIU5Ps
         u7ic/vLH0SkVBjhxYeMV1x2iodVwaptI/VQLwjq7al+ksfPCNDAB4R/O/Z765YRd07Xu
         Lu9AEIluO8bnmyoqTX22q5C2ke4vAMQplS2ZAk3bgr+AsAkKnD1w8zQO90XgJKhYhyrP
         ezna5AJh2d5W0UOxt1W09tbsgQDslrZObLddanlP3GZg0o+EnPEAhhs2+E9njoodnT41
         dP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748882950; x=1749487750;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HknikpJA2FcmTw342+lb8lkp3yYgT8HLedmbOD4V3nk=;
        b=E/uvrNNUZdTvi0nfQoDa0MHDmLCq0nhdaSNg4prYcATBAs0YFdKs19UwtLpQLkNQuf
         aMlEPEImLwHenNEkj9LumDevhi85d3d66+s0EvxTIf4UA4F9zkS+/EtYaggILDUX9J72
         NZBYEUuuJwkg6gCJiIhfNB9UyL0cUN02XBIcEga1R9HYLOhlWlZCwheVQ51/VcSDpymf
         EM7yAErV3bQYdEr5aoYXQIGCgC+lj2JdIJzA9UloFTP0ePk9dxoXq76/brLIzhn/spk5
         ghmcOuyIE+SH5EQjZeLM8dnTb1S+RxBZRMHf/jDMNyM+qMwWFW4khuQsyGCLy082vnJQ
         1l4w==
X-Forwarded-Encrypted: i=1; AJvYcCVFukudEwoFtMUv2oC+Z4og6GhvjbMjfvd4DqK0lowJnEpkPkX5kuin0PytNLHFbwUenxf5jhVm@vger.kernel.org, AJvYcCVQ07jkVUAqgvj90cagerQetFY8qFVVBZN79IfT0utZ9O/7HL/5Du1rwCYWVCYGvvTbSIxF47CCU8AVd/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGlMYvcT5GquA/XHNqdx1VgIDezJ+0vxfREtMQwIT1woGw2ls
	WJZKJKRPKbYnmfw+loNY7wX9UFppk3AUmDy5UoF4UNUHBPg/ByJFwswo
X-Gm-Gg: ASbGncusRmrvuikoPpIkg8NPFioZccteaCbiMbLY8DP5AtuUsCO0GcRFWbPev+D49l5
	gAfwkelvtKiQhn/f8xIdaI27f9Q3D68Jq33wTf34aHBwkyoLHrRYhOg628SC43eKe6o5Tr1JjoU
	Xjpg+wH4OcBDGmeQ6Am5+d+HgThWwAUrZ0FzGc9QxdW+lVSJE8Wh+BMBTEYJqlrjm4RGg4BfJQ0
	qis6JVVbNVPSGZl0ZreKDcp0EGkBsWz9Vd8CH5kCVBlU7koeFVI4VpXAGM9Fqv/Zi2XPmrnqOv/
	mROPvQ0HGe72jud4ejGb6rTzPZvS1rN5gOebi4EMAB2rxJpVjnF4p5qv+kfcRbs03sVylvcRg8g
	QBKI=
X-Google-Smtp-Source: AGHT+IHI1CdVRfDD9bf+nXVVrQOXSVtm+Yt+Yys2GsvFnPNTkgMLFR5+P/Cn+V3/3WtyF1CZOw0dEg==
X-Received: by 2002:a17:902:dac5:b0:234:a139:11e7 with SMTP id d9443c01a7336-2355f76c20amr137080885ad.35.1748882950526;
        Mon, 02 Jun 2025 09:49:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb96fe8sm5767803a12.59.2025.06.02.09.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 09:49:09 -0700 (PDT)
Message-ID: <4c608184-5a64-4814-a70a-d2395662d437@gmail.com>
Date: Mon, 2 Jun 2025 09:49:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/270] 5.10.238-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134307.195171844@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 06:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.238 release.
> There are 270 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.238-rc1.gz
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

Similar build warning as reported for 5.4, due to the same commit:

commit b47e6abc7dc5772ecb45383d9956f9fcb7fdf33c
Author: Jeongjun Park <aha310510@gmail.com>
Date:   Tue Apr 22 20:30:25 2025 +0900

     tracing: Fix oob write in trace_seq_to_buffer()

     commit f5178c41bb43444a6008150fe6094497135d07cb upstream.

In file included from ./include/linux/kernel.h:15,
                  from ./include/asm-generic/bug.h:20,
                  from ./arch/arm/include/asm/bug.h:60,
                  from ./include/linux/bug.h:5,
                  from ./include/linux/mmdebug.h:5,
                  from ./include/linux/mm.h:9,
                  from ./include/linux/ring_buffer.h:5,
                  from kernel/trace/trace.c:15:
kernel/trace/trace.c: In function 'tracing_splice_read_pipe':
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer 
types lacks a cast
    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
       |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
       |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
       |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
    45 | #define min(x, y)       __careful_cmp(x, y, <)
       |                         ^~~~~~~~~~~~~
kernel/trace/trace.c:6688:43: note: in expansion of macro 'min'
  6688 | 
min((size_t)trace_seq_used(&iter->seq),
       |                                           ^~~

-- 
Florian

