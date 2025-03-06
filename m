Return-Path: <stable+bounces-121126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF94A53FA4
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A296C17353A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F344681727;
	Thu,  6 Mar 2025 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY0cJZRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA129487BF;
	Thu,  6 Mar 2025 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223522; cv=none; b=O/gq3Yjd4XV8FW7Bfp8HYmeJWsVk9qKP14npqFtOrN1P5m69R9Nt5VZdcgoIuPaczzUECTKj8B6ZmPvnZDVs6dZtwafUrU9uXhAuHf4jhvzbEskFztUEVebbeMLXA6DMIh94Emb89qBiGhPcSdPi/PodXtg24Dq8SppCPV/Ya3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223522; c=relaxed/simple;
	bh=NoaY4nFPkc9jT0zrJ9Xqr6WgodFiRPcr1e1s7E7/B/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A3VMxZpg9Ri5qioRBm6Xf5v8juKAB8N1ZvGp2PYPMDc+JP4P6ZXjH9681TWtyKRPOtW8hIluLERzxEqHk3IGfpDi5A09dFpKmEVN5gybvMXPW8tf76f40YAXwF94LrtIT6Lsyx3Ew6IuE98pCSJAzMzBwtaTuMj+KGlhEZJa9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY0cJZRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0B1C4CED1;
	Thu,  6 Mar 2025 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741223522;
	bh=NoaY4nFPkc9jT0zrJ9Xqr6WgodFiRPcr1e1s7E7/B/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qY0cJZRWYfBzu7DG3UlndBDX/g0DkHEfFZYAdbcBfCZddJVUEM6kommfOvP2wAT6U
	 4+d7Vyscsw084MQz0omvL01PVR9lqXXA5JWEb6O3MNpQIYpMZY4YgOH6qnUYXeF14m
	 l70wBht+08/Mk3zsf+fu8lR3GcqvfG81EkHs/OXVEg+U8THtsDZgAUZ8nB4ujgBuvm
	 gp/9i3v2c76zfUEi0zhj8YZ++LcBHqDqaD+szvdQWT8R99Tje8dB66RaEVr1kE+iaM
	 fa69RfIiI7I8qF+xuLIl6OCKTXafaxJ1+JDFW+wB/AXe9fZh5Vowxj3Gln3MqzmYBM
	 t5IKxEy8aWUBg==
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
	hargar@microsoft.com,
	broonie@kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
Date: Wed,  5 Mar 2025 17:11:59 -0800
Message-Id: <20250306011200.138999-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed,  5 Mar 2025 18:47:16 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.13.6 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/damonitor/damon-tests/tree/next/corr
[2] 30be4aa8b957 ("Linux 6.13.6-rc1")

Thanks,
SJ

[...]

---

ok 9 selftests: damon: damos_tried_regions.py
ok 10 selftests: damon: damon_nr_regions.py
ok 11 selftests: damon: reclaim.sh
ok 12 selftests: damon: lru_sort.sh
ok 13 selftests: damon: debugfs_empty_targets.sh
ok 14 selftests: damon: debugfs_huge_count_read_write.sh
ok 15 selftests: damon: debugfs_duplicate_context_creation.sh
ok 16 selftests: damon: debugfs_rm_non_contexts.sh
ok 17 selftests: damon: debugfs_target_ids_read_before_terminate_race.sh
ok 18 selftests: damon: debugfs_target_ids_pid_leak.sh
ok 19 selftests: damon: sysfs_update_removed_scheme_dir.sh
ok 20 selftests: damon: sysfs_update_schemes_tried_regions_hang.py
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
ok 11 selftests: damon-tests: build_arm64.sh # SKIP
ok 12 selftests: damon-tests: build_m68k.sh # SKIP
ok 13 selftests: damon-tests: build_i386_idle_flag.sh
ok 14 selftests: damon-tests: build_i386_highpte.sh
ok 15 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m

