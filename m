Return-Path: <stable+bounces-123112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D96A5A388
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE803A627B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365701CAA60;
	Mon, 10 Mar 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj/CXasd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF729D0B;
	Mon, 10 Mar 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633295; cv=none; b=GSaIiTkJTKvGH1Q3IJB7xyZPDrVr+xHUToE/SfRb19wEdJ+3aEgr6lY/BS3XqJmPoudeFEIFIfLFY/a/Cphs1Q9vqJ9ixjRUBbDLgEMaaN8XJMn75AzNZn6UXwvqceTM9tm7Db/y2C8SV6QowBVLRxn5iHByZUOBuu6F6YyMbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633295; c=relaxed/simple;
	bh=zuCerm1biMrOVcRT0MSzAkPDgOLhWcEoLhmb7iCyYZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iP56dsLL9KA9DVLDw9C5TBWip+P3MHrH38vENCORgFvO7hvpKdZ8ifT6/xuX/o/PWgRfEy+J3P2nueADkkvhpwaW0Ect+HSYwNpJcY/N+8SdgaCafK/KLEtY9s8ngdVUFjbCw1kMKoLNfxCdAWxPSb+Mssae1e10lQxZJdjIRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj/CXasd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290FEC4CEE5;
	Mon, 10 Mar 2025 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741633294;
	bh=zuCerm1biMrOVcRT0MSzAkPDgOLhWcEoLhmb7iCyYZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vj/CXasdI4qgbsSZFaOQ0Z0zkagmoCDp4iXtH3p7LiBd/gNdi0CnnFjAs+bEiapL/
	 ++Vq0kIFcn73/GkWZoLm3dSfZs36qVQ9z8/yb96GA8/oidDR7C6RjdyY23017ItLh0
	 YdWVqtGD9PxrDou0PwrEkb3UVr/RI/w2koL9sRL62Aly0ML2ilm1+xl+HgOOYF347C
	 E71dRswgxkbokun6wYM/aAsg8JcbMmQE35pNrxVVOIUytAzKG++oyMgyWlr2HENHwl
	 C+Xwhel2S6GQleuvMAf3vW7uqyZHNg2OG+YSyu01VMu0oT+o+1e/9W848OB9r0rOih
	 V8uwFo9mnjmXA==
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
Subject: Re: [PATCH 5.15 000/620] 5.15.179-rc1 review
Date: Mon, 10 Mar 2025 12:01:31 -0700
Message-Id: <20250310190131.656356-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 10 Mar 2025 17:57:26 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.179 release.
> There are 620 patches in this series, all will be posted as a response
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
[2] cfe01cd80d85 ("Linux 5.15.179-rc1")

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
ok 11 selftests: damon-tests: build_arm64.sh # SKIP
ok 12 selftests: damon-tests: build_m68k.sh # SKIP
ok 13 selftests: damon-tests: build_i386_idle_flag.sh
ok 14 selftests: damon-tests: build_i386_highpte.sh
ok 15 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m

