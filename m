Return-Path: <stable+bounces-6527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D180FA37
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 23:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342E21C20DD3
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 22:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4321B4C93;
	Tue, 12 Dec 2023 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpcGsEbv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B88660EC;
	Tue, 12 Dec 2023 22:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0461C433C7;
	Tue, 12 Dec 2023 22:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702419781;
	bh=5dPGXxqfXKxw1hVIRuRVe6k0SkGWWTyZG7n/oXk917I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpcGsEbv2eBhpj3fRWl1LgQ0sovTUGa2b/n3six7/ebXptzq9CZejp6wCCrISBlGN
	 M6uD66dZQtP4UDy/RjVWzLlCeBa9e8ESYGyEakVvEQ18jKdnavpaHQ9qpN3VmGxlmo
	 9KRfy8SE3bBDJqI11jFYKtiIx91ZN8EQrtDDBFO24jkb5OLtpbgahb3XEzJeOHeES9
	 fz073fkcs3TRNBlzcfVSEBg4P9G7+hvG7KHlOo3AzrRGglEou3V+1V0bTzg1gf75/6
	 VduSIyYQkb38s5EIjAacu1zaL9cVEw2Q7r5M7dH1t+ZgRBissEa25L9NKBDXWMkz3K
	 fS/Q8UNWd656g==
From: SeongJae Park <sj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
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
	damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
Date: Tue, 12 Dec 2023 22:22:58 +0000
Message-Id: <20231212222258.55116-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On 2023-12-12T13:04:56+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 58ec986ace5f ("Linux 5.15.143-rc2")

Thanks,
SJ

[...]

---

ok 1 selftests: damon: debugfs_attrs.sh
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
ok 12 selftests: damon-tests: build_i386_idle_flag.sh
ok 13 selftests: damon-tests: build_i386_highpte.sh
ok 14 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m

