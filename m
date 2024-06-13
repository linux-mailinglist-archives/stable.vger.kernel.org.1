Return-Path: <stable+bounces-52076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D39078BD
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271D4284B4F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A19149C7F;
	Thu, 13 Jun 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMfNpGla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28A149C6A;
	Thu, 13 Jun 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297502; cv=none; b=CxasQsrSjmBMXMeGoKxc49hGmbFhSX9RDmx+lMbvUEDTzenl+31Nty5vRjZ3oYvqWt6Whglr0040SKYpSWdnM3rnhCqpkivaVi4yhOhzu3080QQXKhHOAfcxTaCSQFIrks+6L9/UNW5toVSeirZMFA2TXbxlUklXzpi5ft9TaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297502; c=relaxed/simple;
	bh=ysxSPN1GZJ61FXtUViPGFG/7XkaykMc8yshAAseOWVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlZgZDcNIeEpxcRcYKAXd6DcPuTvpLN5nBlCIA29uMIaVBbqMoyG1ziEBsL/1nuE/kRONUDp3aQ+Ql/xtGhY9L74CbSbVTxJxcxFAEQ9bGa9PPRsxPjLSmwfOM/eYL4qkwA0niDjKzQq4+HGKys24AVukGepvk2aHG1EMnYHZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMfNpGla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14416C2BBFC;
	Thu, 13 Jun 2024 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718297502;
	bh=ysxSPN1GZJ61FXtUViPGFG/7XkaykMc8yshAAseOWVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMfNpGlai+EID6gB3RC4QCPP1hQyEm6J70uVWbp08o1nevYbr00faGlcRsadgaXU5
	 YTIbBd2REsoEiQI5FjqX62dxwke7iWAmjqfaQepEYmTOYXMr9VcutqkKywkGi8+xlI
	 Jml/JNNlUY2sX9cV9JB9DkeReI+UC0+uNyEMzesH6sNPzgWw06m+Z4woYH4jx+PSuD
	 pb53cnvscxJHbdNHpeeFsMOLUMeoXOeT2VGAmA8kQF94ip7EaSw8/0l0pEKiUjtX75
	 DRNPkHO0dfFcaDscxYTJCpaF/sdEtCc/9qwKIamWVPHxX96cnDaPSdR7QNPKqk4tq3
	 HQuwVt16ON6rA==
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
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
Date: Thu, 13 Jun 2024 09:51:39 -0700
Message-Id: <20240613165139.84941-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 13 Jun 2024 13:32:05 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.9.5 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 35fcf9de8f9d ("Linux 6.9.5-rc1")

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

