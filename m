Return-Path: <stable+bounces-116326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB7A34DE4
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 19:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAA43A7968
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EC724503D;
	Thu, 13 Feb 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br8gKH8g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DA24169B;
	Thu, 13 Feb 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472208; cv=none; b=JYV7vooX7AyfJEZr6nzcimLplnvLHzMOb/uLVOKiTXFuuM3twzactGJPhWh0cKURNevW2S5O2NWEboER3oxRYhdQEJ+iSKzwwToBM/BUwBu6xWv38AT7iGRXhjstAx/qBzy8ir3IzVsFjl8XFTTovUcRJseWmDBOjelqWmuXpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472208; c=relaxed/simple;
	bh=j8D9HVuYEQZzRHCnCks0gq6o4p+maMQM238sXf1/1PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OctG39Obu372RxwMHg5QZVAJDBvJvkHSuWFg3MO2GrZEqsQ4NyZRKAXJXd3+4TSAK1tdhrGV38DAOq9R1pD7L/CPgdvlwd9WxUcuqix43HNvo+hVAyIcMoH+w8LjP3m2ZuNazL5moOAbAigEqLhcijliShdbDN62AsIuXA9UCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br8gKH8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E563C4CEE4;
	Thu, 13 Feb 2025 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739472207;
	bh=j8D9HVuYEQZzRHCnCks0gq6o4p+maMQM238sXf1/1PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=br8gKH8gep+lO4PvnpP/O+OhIZ1BJF5WQu2ULg4N8bKcai99QEivyvop1XvozK2TT
	 vofOMtFDRr8+byanlbUjsvJj35IPQeiFG3AGHjO4yNwMcWKosqSKidEVCks33Z3imM
	 /oO6CbRUbMhSd9FIGCvdgE/rzXr4GIkxXAaxIkqE0rKDrDJH21HkXVIOaxBdBpv1zH
	 5msP3FgE/e0ehWOpe8hIMJaeIwi2tmYvzm2W57tWSQJr8L7fwzvxmk0gSrQ17ItT06
	 EHGpM2/0k9eWIqXuHWjAFOqkvU/emxhvOXgjOME1mWS9WQQeOTtKNCcKsjP8Ic05bG
	 S0OE5XHQ5UGRw==
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
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
Date: Thu, 13 Feb 2025 10:43:24 -0800
Message-Id: <20250213184324.243034-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 13 Feb 2025 15:22:29 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.14 release.
> There are 422 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/damonitor/damon-tests/tree/next/corr
[2] fb9a4bb2450b ("Linux 6.12.14-rc1")

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

