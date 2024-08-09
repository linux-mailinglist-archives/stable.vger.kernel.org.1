Return-Path: <stable+bounces-66287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6C294D4FA
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 18:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DFD1C227FA
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125031B59A;
	Fri,  9 Aug 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dTp6fDN1"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700138F83
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222104; cv=none; b=ic3m/gOE5Iw0m6uDlnuWEleENEi9BpYEeczoXCh0/xgpn5LpVwe9pbN0q7NC8UVGXy3NU/u8hST/BIWVEhMrpENghSjmOZRx+9GRRylgAkDY2dHpZgAQuadC/Y4REVLxvJ4N/ZLzsmlbXbb88XgCCONnvekvivoO/ozM3HC3xpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222104; c=relaxed/simple;
	bh=DV24Qth48BZmZMiflU4Rk1Xti/jR+zRd72sjOu5E2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V13alK9KT4CMJ0utoaJCsf19xKGYbb0HAAa2L59FUYfX+YGXQo3T9DHsFeZLs8oLleq13Xy69DG3pyYUKzDnrJzhW+7504BzkuRwnEPRtdwejAuzcOjp+VbTAlOIvRhkruYcWjpLgh8G1+HYMK3eBVSlnYcJKuBjuxysPviIi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dTp6fDN1; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39aeccc63deso1136275ab.2
        for <stable@vger.kernel.org>; Fri, 09 Aug 2024 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723222101; x=1723826901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIBS2fiq1eabJ4IYCoixxVdAtJaZLZJZMFj7PGFDm3c=;
        b=dTp6fDN19CEDWhGpEnSiaWVC9pelPOYpKhF3VYf4qJ+nDreec5pZi+4cY+gM0runoK
         OIrZqUkzx6srTNQFgrskoPgp7j1cd1SH5P9j1/5/8WzHiF6SJeHHgqlrq24Np3fR/emF
         dmT6LUjEs3qXcStlPfYpkNxXaZ1mqBLFRV5qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222101; x=1723826901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIBS2fiq1eabJ4IYCoixxVdAtJaZLZJZMFj7PGFDm3c=;
        b=DEgc9pkOk7UZfeU4K37AoycwR4Gwk1a+BusTXrRunbkj12IXtDB5L8yrzmQFjZ+p/f
         Rnn3mvggzjtE4jxpTc+y9w4XNQHIsokt63IpAxVAQyFtmXsR1+QEduKUXly0t9SOXFg4
         SyQmt1ifaxYRseMYsJvfMmO7rArmB8dKgG2aQ0v7pGX+MwjOvWq7Y60Vg+zcvS8vuFRq
         FsgnBFGDUyZT9Igi+vONkIvHyieq1aT5IlsT9/Mr/0QktqsiseNFvthgvbx7UEb/UwXf
         kf+kqa9dYiC2Pu3kAf5p62bKoZDEYyLZWi9UNlDqqtx8RxAckBlFBmZZIKrzqnsOmoHA
         cPpA==
X-Forwarded-Encrypted: i=1; AJvYcCXy/ULyeVHysEA5CTzQGEaI0layRMubGK3cYNxO3vXVQRF7UAslBuLhxhzgS/dx5lw9RetOYOeWlDogEYZqxl3X50CCy8eT
X-Gm-Message-State: AOJu0Yw2eABZOBWu0maYpyizjvhqa59wmZnTizk/lKy8fe4cmHD1vFPW
	Xwffgf9ntHWW63Vdd2kejbsFGGpvI/sE1eAA5oNvB2w2HEbWKbeKhCZTl7ouLjk=
X-Google-Smtp-Source: AGHT+IEPtXUbZewJJPbHdH3NNNItqquYGOjjEuRG2n0DfjjJa+ymgUHQYn2ADond5MgNHtrhIJmfAA==
X-Received: by 2002:a05:6e02:2193:b0:39a:eac8:9be8 with SMTP id e9e14a558f8ab-39b7a40deb6mr15291675ab.1.1723222101188;
        Fri, 09 Aug 2024 09:48:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9ab7fsm65210735ab.6.2024.08.09.09.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:48:19 -0700 (PDT)
Message-ID: <cbb133f7-c447-4fc3-96e3-74952bb2bf44@linuxfoundation.org>
Date: Fri, 9 Aug 2024 10:48:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: memfd_secret: don't build memfd_secret test on
 unsupported arches
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Mike Rapoport <rppt@kernel.org>
Cc: kernel@collabora.com, stable@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240809075642.403247-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240809075642.403247-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 01:56, Muhammad Usama Anjum wrote:
> [1] mentions that memfd_secret is only supported on arm64, riscv, x86
> and x86_64 for now. It doesn't support other architectures. I found the
> build error on arm and decided to send the fix as it was creating noise
> on KernelCI. Hence I'm adding condition that memfd_secret should only be
> compiled on supported architectures.

Good find. Please include the build error in the commit log.
  
> 
> Also check in run_vmtests script if memfd_secret binary is present
> before executing it.
> 
> [1] https://lore.kernel.org/all/20210518072034.31572-7-rppt@kernel.org/
> Cc: stable@vger.kernel.org
> Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/Makefile       | 2 ++
>   tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 1a83b70e84535..4ea188be0588a 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -53,7 +53,9 @@ TEST_GEN_FILES += madv_populate
>   TEST_GEN_FILES += map_fixed_noreplace
>   TEST_GEN_FILES += map_hugetlb
>   TEST_GEN_FILES += map_populate
> +ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
>   TEST_GEN_FILES += memfd_secret
> +endif
>   TEST_GEN_FILES += migration
>   TEST_GEN_FILES += mkdirty
>   TEST_GEN_FILES += mlock-random-test
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 03ac4f2e1cce6..36045edb10dea 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -374,8 +374,11 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>   # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>   CATEGORY="madv_populate" run_test ./madv_populate
>   
> +if [ -x ./memfd_secret ]
> +then
>   (echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
>   CATEGORY="memfd_secret" run_test ./memfd_secret
> +fi
>   
>   # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
>   CATEGORY="ksm" run_test ./ksm_tests -H -s 100
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


