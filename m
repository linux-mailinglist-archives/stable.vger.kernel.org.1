Return-Path: <stable+bounces-89110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F2C9B3841
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B5A282D51
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D10E1DE889;
	Mon, 28 Oct 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUVqrNBp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2A21106;
	Mon, 28 Oct 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137952; cv=none; b=Y9mGT7eO/O9wCiPQo/wOLz0+ImVEriK/FZedFMxzZ4vCcXWEu0usM9ghqoPhRUKcAt1Pl2UwN4JkS/z98p4uCBl8NJG7Gs95B0CikCUKUPNR/SPSGy//tYbXr0WNlfwuUUkgIFp8g7QQOiG54VhdD7Fcmp/1TBwug4nbYZk6pRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137952; c=relaxed/simple;
	bh=fcPwTjX1HNmUkULnErWEzHJWCRTziYR6vypXu3nHVE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sz5vloYwWUWnr3FcTbDwR3tyqbej83kzB6Oz/dOAKrbsEjqzia/QIhH+KwqRJbF2LC4pV2IuG74X3WkIQFNN1N2WTQuHeiyWkbRlVkGVNk4XW6qpcJPO/0QgSsiJitqiuLlBdPIGZcDtM8jnr6jZqBMyb0FCNHBUfsKO28OI818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUVqrNBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE469C4CEC3;
	Mon, 28 Oct 2024 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137951;
	bh=fcPwTjX1HNmUkULnErWEzHJWCRTziYR6vypXu3nHVE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUVqrNBp8sNCnLdPjT5nBlZ9VdiH122aASmtJUy4Yosy24zzM34KH0o3xKwnPjC5n
	 V284J8VebcDuflZjsuGJ56P3E1Ny0RZvG/yQIIrfrjMqg+vLt8r/kvQV6CDfPEDfFL
	 csL5FC9G7xVxPDlMVGtl+bkxPQnTOJcy3Q2tyclDevQyXzoA2tiW1Zukt0H2iEWUP0
	 qeJ4fjHZAyn3jbDZJdl70epUrSAyMwg6yMNeEzXJmLV/L4+iOij2jc8iIeVb/d4ycA
	 xmH8DflhOTNtaf39uPrr5YTGEOp0XqgUqTMbAvhpeKwQagUTo2WtKrF9jSpwMJWK0u
	 nouLpYfEHaM6Q==
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
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
Date: Mon, 28 Oct 2024 10:52:13 -0700
Message-Id: <20241028175213.276786-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 28 Oct 2024 07:22:22 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.11.6 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/damonitor/damon-tests/tree/next/corr
[2] 4ccf0b49d5b6 ("Linux 6.11.6-rc1")

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

