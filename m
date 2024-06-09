Return-Path: <stable+bounces-50054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD89016F9
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E610281357
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557047A60;
	Sun,  9 Jun 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn2WBcSc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08347781;
	Sun,  9 Jun 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717949530; cv=none; b=t5ilF5KBR+6T8oc7kIVEUTmX7TaItxnos3zbGnkPsSkMaodG4C7RBFCYRVOFVbhY6+rAYxMDSX7aWKlksXpLlm1derAVffMXsjcy28ozsQ1p1EeajbV7wjmuqt5NAcT4c8ULjGckUfgilhbabwPwvF/NKUNbcqJ7UbTLLIl/6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717949530; c=relaxed/simple;
	bh=RbRhDqabPCXgr35nSOZGQ+0QSqxJ/NOzuTax/VfPgLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=maRM9lkBYZKZAnGRGg0RuJj/YZjtj4x/e9aaQgOUhLyjmAw/FCuMd/PUVTWaxdbPl2OQmzLflho9NVUoC3C22Ss8Djn8WOy6ylOzJ7It0zdcD9HPXBfZglhKoPQA13hUg2M3PRtW7vKeND1IipgJRtVpyhG15Jp75yLJ6vJsnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn2WBcSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D770FC2BD10;
	Sun,  9 Jun 2024 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717949530;
	bh=RbRhDqabPCXgr35nSOZGQ+0QSqxJ/NOzuTax/VfPgLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rn2WBcScrAyUTLc3Ync1nR5BUaQeoBLa9ix+dNFtyR1FRae3FHWOdB1hoGX51e+Gw
	 iwbR6SXWjRFmR1oe6gmwlIR1nTssnlp5/tKh9FzvbFWbEEulrs5EvIOhn4H3CI+AFB
	 5ZGBvuMz5AByUWjYYr9Py3QlhyaSx1FA1ShAfk1S6kTSkKgLD8Fx+mviTLMyVo1muv
	 HowQQ/Q4JhV2/tjACAHoy2PNB+UPolldM5Y4m1UEOU1TFOK3Vm1pABZ5u0BRSBnhVw
	 J1WYQFkqmmOjPJIRHtu7eBGMWZi9GbKf8M74ZdVSdTT3kAjK9TmuAxfJkHm4qTwHdf
	 dQik3pJZuUH4A==
From: SeongJae Park <sj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	broonie@kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.9 000/368] 6.9.4-rc2 review
Date: Sun,  9 Jun 2024 09:12:06 -0700
Message-Id: <20240609161207.63641-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240609113803.338372290@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sun,  9 Jun 2024 13:41:29 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.9.4 release.
> There are 368 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 11 Jun 2024 11:36:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 4aee3af1daf2 ("Linux 6.9.4-rc2")

Thanks,
SJ

[...]

---

ok 6 selftests: damon: debugfs_duplicate_context_creation.sh
ok 7 selftests: damon: debugfs_rm_non_contexts.sh
ok 8 selftests: damon: debugfs_target_ids_read_before_terminate_race.sh
ok 9 selftests: damon: debugfs_target_ids_pid_leak.sh
ok 10 selftests: damon: sysfs.sh
ok 11 selftests: damon: sysfs_update_removed_scheme_dir.sh
ok 12 selftests: damon: sysfs_update_schemes_tried_regions_hang.py
ok 13 selftests: damon: sysfs_update_schemes_tried_regions_wss_estimation.py
ok 14 selftests: damon: damos_quota.py
ok 15 selftests: damon: damos_apply_interval.py
ok 16 selftests: damon: reclaim.sh
ok 17 selftests: damon: lru_sort.sh
ok 1 selftests: damon-tests: kunit.sh
ok 2 selftests: damon-tests: huge_count_read_write.sh
ok 3 selftests: damon-tests: buffer_overflow.sh
ok 4 selftests: damon-tests: rm_contexts.sh
ok 5 selftests: damon-tests: record_null_deref.sh
ok 6 selftests: damon-tests: dbgfs_target_ids_read_before_terminate_race.sh
ok 7 selftests: damon-tests: dbgfs_target_ids_pid_leak.sh
ok 8 selftests: damon-tests: damo_tests.sh
ok 9 selftests: damon-tests: masim-record.sh
ok 10 selftests: damon-tests: build_i386.sh
ok 11 selftests: damon-tests: build_arm64.sh
ok 12 selftests: damon-tests: build_m68k.sh
ok 13 selftests: damon-tests: build_i386_idle_flag.sh
ok 14 selftests: damon-tests: build_i386_highpte.sh
ok 15 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m

