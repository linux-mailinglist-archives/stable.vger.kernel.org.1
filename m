Return-Path: <stable+bounces-126928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26EA748F0
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 12:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7737A94ED
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89F1E8340;
	Fri, 28 Mar 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DEYAYcIT"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE4B676
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159973; cv=none; b=bwMNzf7IRH3pX9L1g/vtSSo3ZaLR88Mqg9oGFQ9N/bAEc/XuxHGlhzhfYtXgHtm3KqyvuqLLbkJFXHI8E0i8OrnWsf3JBwuNBZaOpSrdV0VPXHR0AddbGsOLCfDwAgoQmEJ0Z7y4JiGsL79LK9ebRIUG91ZVaCHogiRUYxjGZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159973; c=relaxed/simple;
	bh=2ww/HSkxtmbyICvSs3GlH78WawuM0kwn9o25La1WFLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oedKhTIWd9DmFGGB3hg7qaO4sq8FppuBhULv/EVOHJ/rtox/BR5eMy1UYThS5zFUCsXJanvaCb26PcFd5TqyKdfAtDpgtM/iE+yxWFpp9gibKeBvA2uXxZxucO8b0bCCdxbIrsuLY3wuSIEx2B65eGGEw7abmv+v/7mZp93x+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DEYAYcIT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1743159962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/v7B9RGyWZeLEuBecsSkmum+gXek0u/+2v8+vcabmY=;
	b=DEYAYcIToi2dVo2XbFn1sdgbAk40lkA1N6hy30QfcJ+LTAoKMQFykKyDAbnlmmhzfNHfLS
	WQwbufNYOJBXjLuRdz7vcYDzENRwguXemG8si9xsGCF8+Y5+oTH/NrQM4Gt+/eOqUw7Z1K
	yQuCnaehUXfUjv4f7m1/bCaBgq0eUrQL0dQUvhQdd+rvigmrmuuShpWd6FP8WPDXaLyS1u
	x4uEL+8JNwxfmILXREpPLY0wpS0MZ4jChPYQSThsn4hesybNPRv8reUwPsulvKXP6/x2ER
	QNWWiv/dYsImheJE5Nzz8ZzKOzUq+OxCS1g8MIb7PYGh9z2vxjl7BEgo03/ARw==
Date: Fri, 28 Mar 2025 07:06:10 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
To: Laura Nao <laura.nao@collabora.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
 Uday M Bhat <uday.m.bhat@intel.com>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250320112806.332385-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

Yes, I can confirm that with the current stable-queue patches on top of 
5.10.235 it compiles. I only had to not apply the following patch

ASoC: Intel: sof_sdw: Add support for Fatcat board with BT offload 
enabled in PTL platform

due to this compile error it created:

2025-03-28T08:55:34.9654713Z   CC      net/unix/sysctl_net_unix.o
2025-03-28T08:55:35.0056914Z sound/soc/intel/boards/sof_sdw.c:243:41: 
error: ‘SOC_SDW_PCH_DMIC’ undeclared here (not in a function); did you 
mean ‘SOF_SDW_PCH_DMIC’?
2025-03-28T08:55:35.0058317Z   243 |                 .driver_data = 
(void *)(SOC_SDW_PCH_DMIC |
2025-03-28T08:55:35.0059209Z       | 
     ^~~~~~~~~~~~~~~~
2025-03-28T08:55:35.0060110Z       | 
     SOF_SDW_PCH_DMIC
2025-03-28T08:55:35.0578564Z sound/soc/intel/boards/sof_sdw.c:244:41: 
error: implicit declaration of function ‘SOF_BT_OFFLOAD_SSP’ 
[-Werror=implicit-function-declaration]
2025-03-28T08:55:35.0580183Z   244 | 
     SOF_BT_OFFLOAD_SSP(2) |
2025-03-28T08:55:35.0581143Z       | 
     ^~~~~~~~~~~~~~~~~~
2025-03-28T08:55:35.1499457Z sound/soc/intel/boards/sof_sdw.c:245:41: 
error: ‘SOF_SSP_BT_OFFLOAD_PRESENT’ undeclared here (not in a function)
2025-03-28T08:55:35.1500818Z   245 | 
     SOF_SSP_BT_OFFLOAD_PRESENT),
2025-03-28T08:55:35.1501765Z       | 
     ^~~~~~~~~~~~~~~~~~~~~~~~~~
2025-03-28T08:55:35.2672363Z cc1: some warnings being treated as errors
2025-03-28T08:55:35.2740103Z make[4]: *** [scripts/Makefile.build:286: 
sound/soc/intel/boards/sof_sdw.o] Error 1
2025-03-28T08:55:35.2767794Z make[3]: *** [scripts/Makefile.build:503: 
sound/soc/intel/boards] Error 2
2025-03-28T08:55:35.2773462Z make[2]: *** [scripts/Makefile.build:503: 
sound/soc/intel] Error 2
2025-03-28T08:55:35.2801723Z make[1]: *** [scripts/Makefile.build:503: 
sound/soc] Error 2
2025-03-28T08:55:35.2802890Z make: *** [Makefile:1837: sound] Error 2

On 3/20/25 07:28, Laura Nao wrote:
> Hello,
> 
> On Fri, 14 Mar 2025 16:19:13 +0700, Philip Müller wrote:
>> On 14/3/25 12:39, Greg Kroah-Hartman wrote:
>>> Can you bisect down to the offending commit?
>>>
>>> And I think I saw kernelci hit this as well, but I don't have an answer
>>> for it...
>>
>> The same kernel compiles fine with the older toolchain. No changes were
>> made to config nor patch-set when we tried to recompile the 5.10.234
>> kernel with the newer toolchain. 5.10.235 fails similar to 5.10.234 on
>> the same toolchain.
>>
>> So maybe a commit is missing, which is present in either 5.4 or 5.15 series.
> 
> KernelCI is now reporting a pass on the stable-rc build (5.10.236-rc1),
> though I was not able to spot exactly what fixed this.
> 
> Best,
> Laura


-- 
Best, Philip

