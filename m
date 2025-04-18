Return-Path: <stable+bounces-134654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C80DCA93EC6
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 22:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386E17A9E9C
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294CC23BF9F;
	Fri, 18 Apr 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poBR87CH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A023537B;
	Fri, 18 Apr 2025 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745007521; cv=none; b=rmoZKHsIQcltQXhSOxCpnpJybNdYz0NvnpCSP0A9UuORJ+Hm4LYt9DwO7eNXP+nfpcjQ7I3ESRF7LSj7e+X2zSbXDndAoD9DUJFfQjIsurOrfsYMxe6tpmvjKo6IGUijw4nwLvcA8E2kUbGbFfs1OIajE5RCHCNO1RzsFeM06sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745007521; c=relaxed/simple;
	bh=rxntnv7lHwgv2GqchMX8dNKK+O/aKvl05mNSqeL6/zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6rwVr0haUCZstCxlcqzeiH2bASQXIluU71hXBywmRwVWGPZSdtdBjFZUcUQBVzXk45otsrQ0uTTJCMHbdwb1DIyJHc28rYNc4HezT2nrkX7ZeSx9BfN9c7U98pHy67QsFSz4W9kq7i63s0U6i1z84rlMQD4OVbad2pIDgW5LJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poBR87CH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A330C4CEE2;
	Fri, 18 Apr 2025 20:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745007520;
	bh=rxntnv7lHwgv2GqchMX8dNKK+O/aKvl05mNSqeL6/zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poBR87CHkAjkgL3D8LThtMdByTrTRF3QKMEntMJPrCbL4wLijzAYrJOHRF6mqtv2J
	 C7oiNXesKPuNj1rfmKwYDFmmVkjqawYgyO3zDPNuPde2PkY1fAvguHahqNoYE4R0mk
	 vmHQ8R1g+gDeUBlmoelzs0fMJ5B/HbFK9fenLpaz5tydYFFjZfzDQkhrGhmx69fosJ
	 KnYsXS1JCm1LXDsjmtDImOtRZRgPSHyDb4YL/0v2XTHHr83PPeN+QWbUb/ux+WTqXI
	 AYqccEegvBpnfWyY97RNNxEcylLg4OV7f8NZPLNt42ryhzR7sihHxV8WA7Xm/Ary7D
	 pv7LnHlwbglhA==
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
Subject: Re: [PATCH 6.12 000/392] 6.12.24-rc2 review
Date: Fri, 18 Apr 2025 13:18:37 -0700
Message-Id: <20250418201838.69125-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418110359.237869758@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Fri, 18 Apr 2025 13:05:08 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.24 release.
> There are 392 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 20 Apr 2025 11:02:42 +0000.
> Anything received after that time might be too late.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/damonitor/damon-tests/tree/next/corr
[2] 7b7562936f80 ("Linux 6.12.24-rc2")

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

