Return-Path: <stable+bounces-45972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39D8CD8F3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 19:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFC41C216E0
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281306EB56;
	Thu, 23 May 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ditSwRTV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9CAD2C;
	Thu, 23 May 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483942; cv=none; b=IzFEcpiQORLXp8mfhI8YRyod6VjzaI6/hCbToakEJCJpZpFdsR0ic29ulL4u8tcrlJxApsmufFYD93FSv+sTb2+CCnZ4rdUomckfcdiWAZC8gU+NQVwO2IVw/wdoVb3lG7xRkU6Q9g3N6ziYFI/mnFrnIY4g/ZwNMBuluzJnKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483942; c=relaxed/simple;
	bh=Hx+39hQx6QYlBuuWKhndWNBU/2Re23i2gGpvEPQV+n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uCfkHJRR2dF92tYwyhgeyoEif4RB9GW96mC8X8NDBohycNYzdNTT6z7uQ5NgBJlKwHsYWLpztXTbtdZjQkc9hq/HC0AZPa3K1SOSqMLDOb9qSPkZrHFZgsazwIvmjtpR7Sey28M8FPcUUiXHFftqDlK6MlY8p5acsuje6kpX86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ditSwRTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CCEC2BD10;
	Thu, 23 May 2024 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716483942;
	bh=Hx+39hQx6QYlBuuWKhndWNBU/2Re23i2gGpvEPQV+n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ditSwRTVLdezJN+01iGMHpTcpt6Z2whtkEJR4evacVli4zq0k3WX2m3eZ99vdSiEX
	 xBcV4DFAYr1Tlqj1zT/pnF6WtfsPebz0d7a4hP35mHnlx1qXkFh0lcxiEpxD3vOrz8
	 6xui1CYNLYTTJGUswI7IZPbtsawCMcuFLiWn8IbWSXzyVcJfKSv3bsWWW2CNki1FO/
	 11G43kqLNIyxcZPH27xkaqpEdYetpj4PDvOjO0arAkhH7joMBOB5gPHXWGSVvI8Xgj
	 S2Q2M7l5FZ1+Ko+K3I020oozeOJiz2AIM5QNkHCASEAl9YqQzUNyQVGTx91rS+qFdL
	 xUM0wehYJf7lA==
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
Subject: Re: [PATCH 6.9 00/25] 6.9.2-rc1 review
Date: Thu, 23 May 2024 10:05:38 -0700
Message-Id: <20240523170538.95679-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523130330.386580714@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 23 May 2024 15:12:45 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.9.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 6a8a28e45f4b ("Linux 6.9.2-rc1")

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

