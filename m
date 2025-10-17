Return-Path: <stable+bounces-187716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F232BEBF87
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F4E1AE1709
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FC2D6603;
	Fri, 17 Oct 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/cB81Ts"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68A2C08BC
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742288; cv=none; b=BDgzZQ2iI/fHguM1qjzpv0oWHxP1YeAEWw0BUwYARMoVqRJ9iNA5DYnJEqFiFFQsmRO80HMKqMBRI4Hdojr04yaiI/VHKxFCfheHIst/FD0kEgJV96JXUYE3p8wg7GSSgPbrs3+l3Urig2/vIcZ04+l01EZo0ad4nykVTrnAGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742288; c=relaxed/simple;
	bh=34t2guKeP6RRMMYoEjTZ6QMeXJWGLVnlKOiJfockngw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aqMDoRbqyVbt50OvGlPZ1CqV7mBgI5MleYzxVXNaj9txNdwNhAICCSyYKKm2iTm1gm6Z56TXcbWMkyx9aTx3ltlnwgdAMNAM0us5abnoXXvv+GwWGAHwGFM7e6RWYvhKvMFcERXBSUZOJXn6xbVWQEOhD+y9xg22Kl60O6tA8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/cB81Ts; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87c1f61ba98so30929616d6.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760742285; x=1761347085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oYy8526wfT6JSdIqvj3HrQ0icx4SEndY8ccI3Hg2clg=;
        b=F/cB81TsBdvqmz/jzKwZ1HcGZhBba0bHkqMAe9lYVyTpPPYgbqF09/TU1cJAtmQhvU
         gjx04caz6lWJwFk/DB9JBHJV6WnkvXzHzrb77S1YRiFdK9joBi1KwqTr1IWwoiGt+hSW
         SoGfSed0j3MSmgLyNIBQxR2V3wCJwttfDvoevI2pCqFjf6+NKP54mFNemX2Divp92RuN
         r67urrWxerTa9jttvghkPWCYLVS8ys6HS52gkVus3JhjyH38i3958HEGK0DS2KiC40c9
         K5soWW99tlupF37pN7jVt758PSFXCvpuiDo2HVynt8xgDcG+ZiRsOtn8ir+pliQDshbe
         GXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742285; x=1761347085;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYy8526wfT6JSdIqvj3HrQ0icx4SEndY8ccI3Hg2clg=;
        b=m0s5vgmhv3xb+hybpDzsCbXT0f4KJcakR92f6ZQKlU+eLqtX7WhE1J6whzrggRZfD/
         GJn0GOd1iYzT0KLutB/ipXsbY0KLVU1heTo6WK2yWik3EtG0GjmRiGanUp1SR6d8HI2u
         wYq0fzl1HwkG+GLhH6lVHt+Rli13IDQdVtjLEGIGzzsC1QUOTW1TKw1zS9Swv4UR0Plp
         ucKTiQVzuWBG99NxEzQxNYpeyrlrulVs9QgdGr9uzfHDNU3PIYICf94cj6np4PJYDvMZ
         T6Tqbt9YzQwqUImi5IajL8QodUWEzc9rbGlPwDvnDv/ojbr7QEldC+6I/FB/GKVuLrft
         9FPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq/jE5GL5UjH+yiTsDvGLuA8uypOclceB5yyKV2T+9hmR5+GZ0aMsZkZIUGxCmrAhYQKnejis=@vger.kernel.org
X-Gm-Message-State: AOJu0YypaiS2bdDOLpXWr7vgntxFKitdFnec7CsfQhWGxqaJD8FAVXTY
	haUzUp9RAmmpjU20qgXTgqJC3M899umpZfkaMixHYwf6pigd6L08OCTf
X-Gm-Gg: ASbGncs1ag/3A3ZJb1Bxt5ShQ1nceFLqx/JynFjTazU5MCLkF2FQZ5QO7CXGXNRP3/5
	h9SX5h5Mvees27Vcl/woGTrRPKKXy5tsrhrDNDh44RnLeXineU2IpI8S1m2tT08Tht2iMuV+KIO
	9kmb20vAacoQNMp0nwvyuF95t4ckXYQq3qnjKffJZiP/XIpMGp8mqLdqjQn96d+ve0f+YCYIK27
	09eO3CXipiwhn4Enes6fWCJpFJ7CDrOa2eYef3jYT5AtleDxE7PPE4gZ9S3LST/IGYnzjxTEhNF
	koIqVnXQavG3zFoK7DkNUihFwtlio9rHm+6wBqJJDAvN0x6j9X/Yw/XV6jTo+BfqFiZfd7TCAIM
	hxDIZzTcNP4z2nOj0faziZcN9F2TOFd+WllV1V73Gr9P+s7zDH+p5FgKRQ0Qe1xL7Z1Rm/Mdy0p
	nbyVYPSNQEO3RgQmH7k1bWO4ym85g=
X-Google-Smtp-Source: AGHT+IGu5TpaguVbSh7DB4qrTllZFZhmQoXm1v7312k72abIPidk51MwdQlGrQgSmL1IeFVKXdneeg==
X-Received: by 2002:ac8:574d:0:b0:4c7:9b85:f6d4 with SMTP id d75a77b69052e-4e89d262ec3mr79164521cf.22.1760742284484;
        Fri, 17 Oct 2025 16:04:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf52209cesm6626376d6.23.2025.10.17.16.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 16:04:43 -0700 (PDT)
Message-ID: <acbbf30b-44cd-4f31-a979-dc576585c65b@gmail.com>
Date: Fri, 17 Oct 2025 16:04:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/276] 5.15.195-rc1 review
From: Florian Fainelli <f.fainelli@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Ali Saidi <alisaidi@amazon.com>
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145142.382145055@linuxfoundation.org>
 <c1b098d5-3499-4e24-aff9-6e5a293b4b1b@gmail.com>
Content-Language: en-US, fr-FR
In-Reply-To: <c1b098d5-3499-4e24-aff9-6e5a293b4b1b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Ali,

On 10/17/25 15:57, Florian Fainelli wrote:
> On 10/17/25 07:51, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.195 release.
>> There are 276 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/ 
>> patch-5.15.195-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable- 
>> rc.git linux-5.15.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> perf fails to build on ARM, ARM64 and MIPS with:
> 
> In file included from util/arm-spe.c:37:
> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/ 
> include/../../arch/arm64/include/asm/cputype.h:198:10: fatal error: asm/ 
> sysreg.h: No such file or directory
>    198 | #include <asm/sysreg.h>
>        |          ^~~~~~~~~~~~~~
> compilation terminated.
> 
> I was not able to run a bisection but will attempt to do that later 
> during the weekend.

That is due to commit 07b49160816a936be7c1e0af869097223e75d547
Author: Ali Saidi <alisaidi@amazon.com>
Date:   Thu Aug 11 14:24:39 2022 +0800

     perf arm-spe: Use SPE data source for neoverse cores

and this hunk specifically:

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 569e1b8ad0ab..7b16898af4e7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -34,6 +34,7 @@
  #include "arm-spe-decoder/arm-spe-decoder.h"
  #include "arm-spe-decoder/arm-spe-pkt-decoder.h"

+#include "../../arch/arm64/include/asm/cputype.h"
  #define MAX_TIMESTAMP (~0ULL)

There is a dependency on this upstream commit:

commit 1314376d495f2d79cc58753ff3034ccc503c43c9
Author: Ali Saidi <alisaidi@amazon.com>
Date:   Thu Mar 24 18:33:20 2022 +0000

     tools arm64: Import cputype.h


for tools/arch/arm64/include/asm/cputype.h to be present.
-- 
Florian

