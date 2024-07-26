Return-Path: <stable+bounces-61801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF49393CB33
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 01:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0751C21455
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE059149E1A;
	Thu, 25 Jul 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7gt5KHD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A3146A8A;
	Thu, 25 Jul 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949715; cv=none; b=tULZuAZENClCGX5lkTPr3c3EJER1bJZXAy70qKjNvPuH6iLif8Dy+RuYNladvb8GTXxOokcP0vylGaX9FZh8Mnsl6YxAdmBdi03hKXXlPQjY6G+F1MchuaV2+m9iaEt94gdNZKwNkrHCDq7vcWM/HZx72EvSd3vRAcPsmhJFVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949715; c=relaxed/simple;
	bh=lprJpV4kcpklQ7c/1jZtCr4mWvTZRjFVkAgsdK8XmXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sh5AKj908T+BY70QlXOFIE15IzNveJ/FUt5DCTMpJDYxqwsXQTd6NaMwgade4q8p+mSkjPq1VW2cO+p8Uot/9snH+oGUGxhsdN+JZT0XrldcD6xBpk/c+O+fWFZIlDVsWDqflIrhwZgOG17BFj1wCfPy+RjCKIcIQkbaAcZKh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7gt5KHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA68C116B1;
	Thu, 25 Jul 2024 23:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721949715;
	bh=lprJpV4kcpklQ7c/1jZtCr4mWvTZRjFVkAgsdK8XmXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7gt5KHD9nj8MLNDN9KJfkh79j5v+yuRKfA5La108o5LoniAz5qjRA5XHPtXCeAEM
	 qU8n28kpCJMePTTRxVYYT+x5A7QOTm1gSBiC+tpLY9kL6wA9kWodEnxDfPx+O+dOhA
	 /x7gFmrDcHk6knSdL2M0ds3ARDoiim3+zT9tfyvOL7545hmNTQWosyTi0sbYToPeoh
	 l+rMsvf14QiSjpEPb9LVPj1MCrKeSu9g+AZHdc/A70lvm1bHGC+rfWzXeltQbQEBr8
	 4nckOCeD/YALyMCQnyZnaUcsoEVIXsZUmuxfBWaAM8pbsF8e5Nm0S+irgTGQfAza6z
	 Zpt7G35bscfXA==
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
Subject: Re: [PATCH 6.6 00/16] 6.6.43-rc1 review
Date: Thu, 25 Jul 2024 16:21:51 -0700
Message-Id: <20240725232151.29538-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 25 Jul 2024 16:37:13 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.43 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.43-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] e83c10183573 ("Linux 6.6.43-rc1")

Thanks,
SJ

[...]

---

ok 1 selftests: damon: debugfs_attrs.sh
ok 2 selftests: damon: debugfs_schemes.sh
ok 3 selftests: damon: debugfs_target_ids.sh
ok 4 selftests: damon: debugfs_empty_targets.sh
ok 5 selftests: damon: debugfs_huge_count_read_write.sh
ok 6 selftests: damon: debugfs_duplicate_context_creation.sh
ok 7 selftests: damon: debugfs_rm_non_contexts.sh
ok 8 selftests: damon: sysfs.sh
ok 9 selftests: damon: sysfs_update_removed_scheme_dir.sh
ok 10 selftests: damon: reclaim.sh
ok 11 selftests: damon: lru_sort.sh
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

