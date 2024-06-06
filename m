Return-Path: <stable+bounces-49914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29938FF41C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 19:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87781C25F27
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A95E38DD4;
	Thu,  6 Jun 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SscEjZfv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A60196D90;
	Thu,  6 Jun 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696388; cv=none; b=AQWM5GnU9X4NhLjNv3vmeohQR7IQGum1HNHG+RZ04hPsb1Pwyhyayk0XUN8bEf73VwaSNrlBj4XhyVnDMw+EgkVfReNoeEzMIam78fKrsdbhqYdmN5/6dXCy3XSEoFRmzHWsyNsgcaVtXe5KkTNbLs3s+VyT7kVqNPQB/n7+LhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696388; c=relaxed/simple;
	bh=72KbuHgMtEP2B2/tz5p4IsOuMiK9DtKXN1Hr9vWO7Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onb87fQIq928Q1DnrijAqd5RhFx96p7cBffuoekQp2wh3CNi5ldyh7HjM5trlIOkV/mmlMkt8oJOVOSd7aegj916dl26C3/g82A+qXKOwsU/fvmkAbAN/+jJJBI0aTb6GVJklh02zf+oPIi8OPJQAX2XxTLKFAkSxecVBV916jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SscEjZfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FA2C2BD10;
	Thu,  6 Jun 2024 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717696387;
	bh=72KbuHgMtEP2B2/tz5p4IsOuMiK9DtKXN1Hr9vWO7Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SscEjZfvtiNF3DZHoSMdMgKPK2qVFdpP/EuBX8s/mUChF/xj1300wrQz72mVp0XEJ
	 DhUqmZe+MtS4NP0Vy4qIm2dfC5MlfY/iWiZEMhi/UMSAuZx5LxHNdSWIVR+S4dlL78
	 ClunW/mWXyyPOieDHDAGKjFoaFS7eAA9IUktF39i1Mi5Jr8N2yFh/aoCQg5lQQKDJV
	 k/7p20ZL/Az5F3tsvPwbP3dxC7tssEMtZncFBJ0yS9ZiQB3Vze1NMDrg04Bgcdpm2t
	 mgsQaUUImMGeDbkGVp4wiOaCULWeSv3TUCZ9e8tvjHJYYf9cxgW+vyzZLa0bhLi/8A
	 Ond6PyGfbtmOQ==
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
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
Date: Thu,  6 Jun 2024 10:53:03 -0700
Message-Id: <20240606175303.20463-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu,  6 Jun 2024 15:54:32 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.33-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 39dd7d80cd65 ("Linux 6.6.33-rc1")

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

