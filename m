Return-Path: <stable+bounces-123115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52104A5A38E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8616C1715E2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B0F1CAA86;
	Mon, 10 Mar 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPr5Sndi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7B1624C0;
	Mon, 10 Mar 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633409; cv=none; b=EcWYF0YoZN55L7YKg0Tacj0mbQ8Dsm1kPJaqRWbywz6CqzMdEjOXSBHuk7qcUbJaPGO1xuI27jIFDZYhgGlw2sGCJwZQNto9olQuGwtIIq6QXCA74Wby2nME7nhXXnbFONURmi8unaCpCQcxAoPsxEpHY70HTzfYFSOQteAePE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633409; c=relaxed/simple;
	bh=jWRvNf8J4VJE9MojmvXzc8EayEUFziXCYpO5mSfIe8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOZ0za6HMJowSTiWMND5IdWQ6Ch52GjU19J7iJnq8L9Wo8d6QJgFsG/9YyJqdaG3KHSFgpHbakGU3U0KBar8VTkXzrbrth+HyU56W362sDLOk/ei8zd++j2Jp5zLaUpvdKJ+RtW/57wBvL5OeOSeV9qPpPAdqGoysmUQTtsP9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPr5Sndi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F477C4CEE5;
	Mon, 10 Mar 2025 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741633409;
	bh=jWRvNf8J4VJE9MojmvXzc8EayEUFziXCYpO5mSfIe8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPr5SndiS+JRK0WdQPYwc2bI9czx3mgLpWe9R1KeKKkdSCRPsH5jEPLvPJ3s7Oi08
	 kXwEZMIM7A7TJ8EuHeAR2biWppL4ca/5QLiWIsljCEfjTobZsDHdgR5g6JkkCBE0FN
	 9+opDdBTqOapdmjmAojo2MZea8lFkVWXn0IVO7c/iU9Gp2iIg4mP5XCpYDcnqDWm20
	 dht5Nu4TGXi8rcl8aKb9hGC5gLzo9cHpIZscB7rD+HA/bE8bvWwVCnt0YQSknIQhet
	 u5W8zMJgorvWgi6e+XRoh7s0uys6gZ5vDGocnLZYHjmsJEvL/JpNDFG+CkCLauh5wx
	 veReXNnNjJbrw==
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
Subject: Re: [PATCH 6.6 000/145] 6.6.83-rc1 review
Date: Mon, 10 Mar 2025 12:03:27 -0700
Message-Id: <20250310190327.656494-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 10 Mar 2025 18:04:54 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.83 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/damonitor/damon-tests/tree/next/corr
[2] b49d45c66a5e ("Linux 6.6.83-rc1")

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
ok 11 selftests: damon-tests: build_arm64.sh # SKIP
ok 12 selftests: damon-tests: build_m68k.sh # SKIP
ok 13 selftests: damon-tests: build_i386_idle_flag.sh
ok 14 selftests: damon-tests: build_i386_highpte.sh
ok 15 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m

