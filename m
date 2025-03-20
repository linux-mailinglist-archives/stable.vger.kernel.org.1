Return-Path: <stable+bounces-125644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104AA6A663
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2643B1668
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59D1DF247;
	Thu, 20 Mar 2025 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0lfyI2E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771E1DE4F6;
	Thu, 20 Mar 2025 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474582; cv=none; b=fRBXGEdYtTMM65f5vft7HKpAPA1F0uwQ9nRnjqKSV3hfM7M/7lvt2QSK2EXJ353t+E0+/cz/IJc6plKevk/kLfDwz2kBpkhaLIpyvea739djduZkyONm8EYYLtZkirVJF0ugU7Clk6taaWqllr7TtRWTCQEwxOEdyNRmAFdsiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474582; c=relaxed/simple;
	bh=wTdaPTDa0jCwylQO/d7LcQaRxibO4+U7IE3VzJvXwMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzqJ2RAwXELxUFTjrkcrDSzPQaFWllDWjEBcCIAj8zxgAzES5hw0j1Zrg/+2Q80z7N8mmxNpKbHp7F0n5/dtuNepofrRkMuGvQnLhYmQNC8mOjz28MCKdqH00/a9FvBtuBIaPP5aATuAAPdEaNG9EPjwgCswrEHXaQmBQ2DzF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0lfyI2E; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301e05b90caso649795a91.2;
        Thu, 20 Mar 2025 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742474581; x=1743079381; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+uL3IGjTjiuqrVnOz2Ww5dOwcBX+a3DDkjY6XFGUpLc=;
        b=X0lfyI2EXw7DjPF1/kcpayZBdHt/m4Vfm0ibDhceqR31AL5qih2eL8crX6iPqwWSRe
         sMEUM+DVEjINbqmEBQKcpp2yAAIvYYXCbgsC7ex54ZpVrOnzllzR03AN8jfGXTzQRsT1
         gU+sJVlgkfrqyRHr8QoSlEMVKsxGCF0AqLzSJapy2HQmaT1x8Cdt+WktXIFCZwlvk1CZ
         7h7yQ4mcdNSq/EMvM+ChDVmNObT2lmJ1F7XO669TAuvbxB/lWTP3rEz1zfFIJPx8atzT
         Mx5IHrcj6eR4tzQ3Z9x3tNppWV3hZaDEIbCJr2JesvgvrY/sc7uCdH6sN53qChPcnkFc
         tWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742474581; x=1743079381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uL3IGjTjiuqrVnOz2Ww5dOwcBX+a3DDkjY6XFGUpLc=;
        b=MXSuwE4Zqryp1QFmN8U3OWZb4uXXXtvpVZcW3U15Pt78UwYWvI0vyVDituhc0E2VsE
         8vMK/L6XnNeEQ1JheGp7XBmPBGK1uehkJ+c/WQFVreYXMidlB4JshHpxw2F/baH3StRb
         bq5Osu9Ry/+gHrL4mlFfPJFABBh7Od2hv8/fdFUi4AVz8h5HpYB/biYUpv6XitkxDAHK
         HEiz3tldyMObeR6q1wwMcZ9s+ReyJKFMKp0FQRaaKxuIXY7D4JJmsczde2k84lX+lMug
         80GFTlTgqL7Q8SBSv+ziWCvTr4826Kj/lUOeVVa+Vz1EYRrEW1aTUcVZRG5MiAZmp27l
         ly5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmf4IXohd5FsEjnG+Mj9p+E5ZmQqzmb/0AQV/G0yNvLDwBAZYSlULVLuXgw0wYmv3lcGo3g56o@vger.kernel.org, AJvYcCVzItY7qAJqgIDE9BITK/eqyNMcvNV9cJvu6RxckIkkOkDbj1pSfqaMZbLqKnkRUdQvddYf32ApCtdqf68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/1/xZInT95uk+v0XKW0DM7BI65vANunNVDEXlvDxeLvR5KW2
	64VErDdYdED+Ia3qlPTjTc9Uvqxi3b5AMOv18y8M7KZwH51du9+C115MMjDG06MTO5KAqE+uVYL
	0UMKSAzsAJUlUiR/9GZR4Ml2/uBs=
X-Gm-Gg: ASbGncuIqHm0Pd9Q/vDfiPNHtrrxS7R021Yi6w+UAV7/cf9kgyere1aTxPhRep11rtK
	bfa5o2aMjVLPhWCmj7idMKBjdr//we+4FlYpzTXsUdQ0RwDyN4haa96CPl9V7n8IYgxztn26URg
	bya0gfxQVdQL7YqAFvfsia3tqRrcs=
X-Google-Smtp-Source: AGHT+IG3IAgXvK8pSWNiHSoRiODV5fRdTOwPg8f+TG2YtMLkTzQixdJdL1YxVKheImSCU2oRd0FUdqQX1TmgTyEHAIg=
X-Received: by 2002:a17:90b:4a92:b0:2ee:74a1:fba2 with SMTP id
 98e67ed59e1d1-301bdf93ed2mr10044571a91.20.1742474580671; Thu, 20 Mar 2025
 05:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319143027.685727358@linuxfoundation.org> <20250319165703.51651-1-sj@kernel.org>
In-Reply-To: <20250319165703.51651-1-sj@kernel.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 20 Mar 2025 12:42:48 +0000
X-Gm-Features: AQ5f1JpMvwcK-1U-hbVAN0-qz9U6SBJvwStCRYbt1diHejdo2BJVf9HMKmOCCEk
Message-ID: <CADo9pHg+iuBtM_cz1jJKS82Cw1oP4G7KoJiaRwFzed1Af1uWCw@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
To: SeongJae Park <sj@kernel.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Works fine on my Dell Latitude 7390 laptop with model name    :
Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz
and Arch Linux with testing repos enabled

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den tors 20 mars 2025 kl 02:40 skrev SeongJae Park <sj@kernel.org>:
>
> Hello,
>
> On Wed, 19 Mar 2025 07:27:50 -0700 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> > This is the start of the stable review cycle for the 6.13.8 release.
> > There are 241 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> > Anything received after that time might be too late.
>
> This rc kernel passes DAMON functionality test[1] on my test machine.
> Attaching the test results summary below.  Please note that I retrieved the
> kernel from linux-stable-rc tree[2].
>
> Tested-by: SeongJae Park <sj@kernel.org>
>
> [1] https://github.com/damonitor/damon-tests/tree/next/corr
> [2] 14de9a7d510f ("Linux 6.13.8-rc1")
>
> Thanks,
> SJ
>
> [...]
>
> ---
>
> ok 9 selftests: damon: damos_tried_regions.py
> ok 10 selftests: damon: damon_nr_regions.py
> ok 11 selftests: damon: reclaim.sh
> ok 12 selftests: damon: lru_sort.sh
> ok 13 selftests: damon: debugfs_empty_targets.sh
> ok 14 selftests: damon: debugfs_huge_count_read_write.sh
> ok 15 selftests: damon: debugfs_duplicate_context_creation.sh
> ok 16 selftests: damon: debugfs_rm_non_contexts.sh
> ok 17 selftests: damon: debugfs_target_ids_read_before_terminate_race.sh
> ok 18 selftests: damon: debugfs_target_ids_pid_leak.sh
> ok 19 selftests: damon: sysfs_update_removed_scheme_dir.sh
> ok 20 selftests: damon: sysfs_update_schemes_tried_regions_hang.py
> ok 1 selftests: damon-tests: kunit.sh
> ok 2 selftests: damon-tests: huge_count_read_write.sh
> ok 3 selftests: damon-tests: buffer_overflow.sh
> ok 4 selftests: damon-tests: rm_contexts.sh
> ok 5 selftests: damon-tests: record_null_deref.sh
> ok 6 selftests: damon-tests: dbgfs_target_ids_read_before_terminate_race.sh
> ok 7 selftests: damon-tests: dbgfs_target_ids_pid_leak.sh
> ok 8 selftests: damon-tests: damo_tests.sh
> ok 9 selftests: damon-tests: masim-record.sh
> ok 10 selftests: damon-tests: build_i386.sh
> ok 11 selftests: damon-tests: build_arm64.sh # SKIP
> ok 12 selftests: damon-tests: build_m68k.sh # SKIP
> ok 13 selftests: damon-tests: build_i386_idle_flag.sh
> ok 14 selftests: damon-tests: build_i386_highpte.sh
> ok 15 selftests: damon-tests: build_nomemcg.sh
>  [33m
>  [92mPASS [39m
>

