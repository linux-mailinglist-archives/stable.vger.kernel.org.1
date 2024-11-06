Return-Path: <stable+bounces-91689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B49BF3B9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C491C23378
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A692064E4;
	Wed,  6 Nov 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2iQ+iUG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94576205129;
	Wed,  6 Nov 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912082; cv=none; b=RS7Pvde5SMl0ZVvK18vBn5z1HrH9RowC6WAxAdrKPYuTBcPiaJ9GHe8uceev9O+gGVflBVhUF+85UiqXzZn4SxORmcf1Z88UcBvf7Epkuq4YnZT6khz5jggxDUY90iT8yWOIIRNws3b30xm7b+zpMhUB1TcP4WjiL6rEMTLoAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912082; c=relaxed/simple;
	bh=3ye4r4J80bAhjL2PqxPHxhLX8xOp8d+ANvu/xBRxFq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4VTqaccgxG1jutmoU+T6mdc++b36ebSD0QcnUafpsvXXeXR368uYcCLGT/BdsxJFgSmXYz1tcAHkI2LeSSH2Qwvca3FS4vE7pDBJf+Y0tty+lqFQIdXs34bPon7o2UzO+BV3Py3Qn3YQ0DqJo5uL4dLcYIv2hPDzGn7XGgXMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2iQ+iUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482A6C4CEC6;
	Wed,  6 Nov 2024 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912082;
	bh=3ye4r4J80bAhjL2PqxPHxhLX8xOp8d+ANvu/xBRxFq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2iQ+iUG0VcYcGrFsXpliHMEWnWAYDhwbnKtQZPrHQ1abht8Idw0fsq4f0zIUf0UK
	 Dvo2ntrl2yoQxvJW5n8nSv3/zuoAEB19Z6laZbHwqsKRJYVZAF0H+9Voz9pTr0iOG5
	 ypQA6UjV1D5899oUMwxUBNuS9KxCz46CWKd5lKAVb1FA+5/qh2MrBv9b8HQYC7d9IK
	 nEWUpSaPvfPCWz+7q39BwHYh+miAE6jN/lAokim5ItAmLtspuMO0qNBjmwrkVD5bgT
	 9MAFLF7scIeAgKCFwkhqOiUDgaRnOZeNzGyaH/gD4033b0Bwc8lxQwjlZ+2tq/dCYC
	 HMSElT6UL0OsQ==
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
	hagar@microsoft.com,
	broonie@kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6 000/151] 6.6.60-rc1 review
Date: Wed,  6 Nov 2024 08:54:40 -0800
Message-Id: <20241106165440.8139-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 6 Nov 2024 13:03:08 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.60 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/damonitor/damon-tests/tree/next/corr
[2] 2daffc45f637 ("Linux 6.6.60-rc1")

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

