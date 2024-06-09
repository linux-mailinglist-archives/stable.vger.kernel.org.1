Return-Path: <stable+bounces-50053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB09016F4
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94311F2106A
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7F46B83;
	Sun,  9 Jun 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDQihVkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34E14265;
	Sun,  9 Jun 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717949490; cv=none; b=Bv/gk677NQ2adOECMrhn3U2Gu4q2Y/Dppj2e+nswXQ0ueS+SkNOQ7O8V1pracOMekB4kh6a4nX4sHQU1uTcIImvSxUQomWZjeyEcj7CTXlnE44D1yuYinYggd8ZWmoDiIaA/kfUgsNgx32oS01SIHGhHvilrRA+7+C57vHzi++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717949490; c=relaxed/simple;
	bh=GCUbyhkaoU9v37dMBnobn5ipDWVREsD+rZ2Elh00PZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YaduJk31GFypqucCVhifCL6O/8PTUA1bsbjLWg5e3FhJuo02lWRMC8df4e0yEqn55u06kN4EnvxHS2mGjO9y5JahGM6z1SX8//NKiiJpISvgAT6NuoYFDpwsQbkq/njcIFX8AJSbH3f9smVt/F10vLQvmrwM0oDntQLTWtNTBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDQihVkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A810C2BD10;
	Sun,  9 Jun 2024 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717949489;
	bh=GCUbyhkaoU9v37dMBnobn5ipDWVREsD+rZ2Elh00PZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDQihVkZgdSYC8Ucb33YIyXu4IG6RiBZZghkTIGcqLuFpeHfhUlsHyuLowDU2T+dP
	 FRPRjCBCJYMJnP0xdcferbZOx18RtV/3y2nI3q+lvJGDJ5y/BcASiDP2QbR6I6APao
	 nGWR9YSMx8UvASW0UYQR1I4ttm3luXzZyx54KTWQu710faaH+mmjojGUCEZy+reLGf
	 kJ8h7a0VuRa0mUGjIV2VLtfQm1YOeA13zrdY7oQBmXj42FNoKBfnSOGjz3Dz95PYGe
	 qwSwCWFIotWAodpMwdjP8yt4LYKIrxMfMBfjoVJvS1Xpi42fpRR4jDEPuan2taUnRC
	 UPDuwEhPGsBQg==
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
Subject: Re: [PATCH 6.6 000/741] 6.6.33-rc2 review
Date: Sun,  9 Jun 2024 09:11:26 -0700
Message-Id: <20240609161126.63583-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240609113903.732882729@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sun,  9 Jun 2024 13:41:16 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.33 release.
> There are 741 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 11 Jun 2024 11:36:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.33-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 7fa271200aef ("Linux 6.6.33-rc2")

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

