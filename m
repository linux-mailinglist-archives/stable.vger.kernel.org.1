Return-Path: <stable+bounces-43473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746AF8C072C
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 00:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E1A1C21258
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 22:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CDE132803;
	Wed,  8 May 2024 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CwzyizMs"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB42D530
	for <stable@vger.kernel.org>; Wed,  8 May 2024 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206055; cv=none; b=g2yYC4kxtNUw2P1Y61rrmejL+6f8kJBPF8rT1V9c0CnHmJgaLQCObvqdbIFWGFW97CprFo15XnAkE4ZOu9Llezhyd0TZd4l/HvhondKGxSrdj+nAY38++KomNs8k+SkmMfulqtfoBXbf3T5uaH94pow0ZfrZI6zzBHcoU6/sh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206055; c=relaxed/simple;
	bh=UNQQYMWFNs0kQVmGKlUHZL0Rod0v4rJT5i6QrMmpKJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxLCqvDLv2++TJK0mVBXmZYDk8uCiVpgJMkPUMJIfteo9nx292cboQlLFdTbUqUU9kceYnmd6AT7UHD8dNmUPzdvRkhvi1VZA2Gw+0wSJhZFZ/W1yBuNkGFs9SandhuSNWZIomfYvkwlcX8cqYlupT8BZH5x1ivoYz1gp2ayTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CwzyizMs; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5af12f48b72so41595eaf.3
        for <stable@vger.kernel.org>; Wed, 08 May 2024 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715206053; x=1715810853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrR6rD4uV0NWj9Mtfj80ICejUkAUV9ddFodP5GG8PKA=;
        b=CwzyizMs0kAhj7zzlgbnDlp3uYeIw2cuk0vlmeGWxW2SKSTy275cArOlNYB0v8Zo7Q
         9zVYfVNt+Y4+I0hC77eV5HewXExwsGRuTklgI6FSWKjgDf3YJGPym8if8wGCN1n059S0
         dAjM3sC/b8ahg6et9Z/w/zBLRK8fWcRwr9LkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715206053; x=1715810853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrR6rD4uV0NWj9Mtfj80ICejUkAUV9ddFodP5GG8PKA=;
        b=bncSFkKL/N0P8etn7469YfWebwj5+wf/hWKAB6Eb7mj6/FETjNOUrYTiCW1o9DuAwB
         5blnnVdlY5qMg70YGjNQ6qy5yC7vLaVFJorhKRXcvzsxUe7djzMngbfGH0zvzqq9tgiC
         lTgvizJy0KHgSys4/MVWHEFOjxPWuFvPAxEEEQiysDFHmhqRL/uFK0QzS6OEZWJ/ky+F
         BjdHIxVlzbctZVV1+mmshFxh9W26tfvLzZJiQ6O2FYySfRK2RN5RqsCmvEnQjPy9SFSc
         cpvVqMDDthGY+VzjlLOFn2sEtcvVSWrjw7Trq++TaHxYjvCMt54UDDn4gqcQJVBF9JpE
         x0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV68tcpzKaQ7tHX+7Hi1UtOksGlkXvseQ0BGQ4Fc5jKGEBvzfKLdah5AVlTyR9M+3tSAtvkwifJSTFyVY+Pxor+JSn6yTZV
X-Gm-Message-State: AOJu0Yxe9J+pBiVN8LrsBZbRMl0o5tzwQdRKVlV1VxiK69mz80u7Lxm9
	a0qhwIzkuT0wOkZKSVbPuHyENc6bXgvglWq9UZGbN/qbsufNEDH98vBuQ5gMeo8=
X-Google-Smtp-Source: AGHT+IEM3Pj8I9+gHm1+NAJehSxGsNNxChqRTiddFXmj82xn1mZVNlI+xbZBOFvJcoc5eJbgCspdhQ==
X-Received: by 2002:a05:6808:181a:b0:3c8:4de7:6736 with SMTP id 5614622812f47-3c98543850bmr4485798b6e.4.1715206052674;
        Wed, 08 May 2024 15:07:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fd14acesm12313b6e.48.2024.05.08.15.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 15:07:32 -0700 (PDT)
Message-ID: <527dd523-18c3-44bc-b8e6-adad397cdb43@linuxfoundation.org>
Date: Wed, 8 May 2024 16:07:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19.y] Revert "selftests: mm: fix map_hugetlb failure on
 64K page size systems"
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: shuah@kernel.org, sashal@kernel.org, vegard.nossum@oracle.com,
 darren.kenny@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240506105724.3068232-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240506105724.3068232-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/24 04:57, Harshit Mogalapalli wrote:
> This reverts commit abdbd5f3e8c504d864fdc032dd5a4eb481cb12bf.
> 
> map_hugetlb.c:18:10: fatal error: vm_util.h: No such file or directory
>     18 | #include "vm_util.h"
>        |          ^~~~~~~~~~~
> compilation terminated.
> 
> vm_util.h is not present in 4.19.y, as commit:642bc52aed9c ("selftests:
> vm: bring common functions to a new file") is not present in stable
> kernels <=6.1.y
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

Looks good to me. Adding Andrew.

> This can't be tested on 4.19.y as the selftests for vm/ are not
> compiled since 4.19.17. I have bisected it to this one, commit:
> 7696248f9b5a ("selftests: Fix test errors related to lib.mk khdr
> target"), the reason for reverting it on 4.19.y is to keep 4.19.y in
> sync with higher stable trees(i.e reverts are sent to 5.4.y, 5.10.y and
> 5.15.y)
> ---
>   tools/testing/selftests/vm/map_hugetlb.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
> index c65c55b7a789..312889edb84a 100644
> --- a/tools/testing/selftests/vm/map_hugetlb.c
> +++ b/tools/testing/selftests/vm/map_hugetlb.c
> @@ -15,7 +15,6 @@
>   #include <unistd.h>
>   #include <sys/mman.h>
>   #include <fcntl.h>
> -#include "vm_util.h"
>   
>   #define LENGTH (256UL*1024*1024)
>   #define PROTECTION (PROT_READ | PROT_WRITE)
> @@ -71,16 +70,10 @@ int main(int argc, char **argv)
>   {
>   	void *addr;
>   	int ret;
> -	size_t hugepage_size;
>   	size_t length = LENGTH;
>   	int flags = FLAGS;
>   	int shift = 0;
>   
> -	hugepage_size = default_huge_page_size();
> -	/* munmap with fail if the length is not page aligned */
> -	if (hugepage_size > length)
> -		length = hugepage_size;
> -
>   	if (argc > 1)
>   		length = atol(argv[1]) << 20;
>   	if (argc > 2) {


