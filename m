Return-Path: <stable+bounces-128790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE29A7F1BE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095751897730
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B725EFBB;
	Tue,  8 Apr 2025 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8euAkG2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291325B663;
	Tue,  8 Apr 2025 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073626; cv=none; b=l1LTiYcP2J+ffGxDWl8X00yiwkr0QIRgR5UCG3jbCy9rSYXKeyrwxNGvxlUxpBPTWFPjFlHrwZGTqCex9BUNpqGao0IVGJytu8ROWSo5ZSibZtMXXE6hSBqrUfpbo23bXDkMiiVNOmKQJ/9c5y4WxT10nWnDG0tWZez3XEelvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073626; c=relaxed/simple;
	bh=WOAaFxJI/oBVgcpwNAUw5hg8oiieXFP2edo3ENGH/sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kh6IUGpjbPyVukDsEdTMkGbm7wbpEx4cx4OP12N8RpwJ+Zkccu4InsKC4TBXZrUDW6vEXYr7qC2AAIK5PrJ/N+yGGsHZsFaPymkVOilzEh4XpkKW1637PPNofimLbH/ySCRFYJqANthO0A6rE+I2KDaslKa5W1cPkhRH24m4WO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8euAkG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C7AC4CEDD;
	Tue,  8 Apr 2025 00:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073626;
	bh=WOAaFxJI/oBVgcpwNAUw5hg8oiieXFP2edo3ENGH/sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8euAkG2SNMtNKOlfQsgyFGh5yt+BhiN5/5Ysl+Mo2Jv6Nr2OoGjalvlzyxtDZ4jj
	 lvh9McdcwDQ8kRTJ64bk5QNh8Uv7FPA6YDfnLTPeTFqa05kUb8Agyo0x8LNpRKnW5r
	 Qyc7Ty2b320PJFezN6NaWzrLsB+aPjQ7NKpD9NOfDuKRb4lttOK8bP65uU6o5QzBy4
	 7nOtlMIBkTsHKqa/gQ8PFIKJEDWgA7D268xoXVTtHqskoPExk4OGuTG95nNHH5YRFA
	 162kgyiVT1qVA8mQMu/sf7QH35vtwh9VURvtysbgJP3akHdwGD0XGy34Pj5FmECoCy
	 ewdjMDq4pjF0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ojeda@kernel.org,
	aliceryhl@google.com,
	tj@kernel.org,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	jeffxu@chromium.org,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	jannh@google.com,
	mark.rutland@arm.com,
	brgerst@gmail.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.14 3/3] sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP
Date: Mon,  7 Apr 2025 20:53:35 -0400
Message-Id: <20250408005335.3334585-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250408005335.3334585-1-sashal@kernel.org>
References: <20250408005335.3334585-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 975776841e689dd8ba36df9fa72ac3eca3c2957a ]

kernel/sched/isolation.c obviously makes no sense without CONFIG_SMP, but
the Kconfig entry we have right now:

	config CPU_ISOLATION
		bool "CPU isolation"
		depends on SMP || COMPILE_TEST

allows the creation of pointless .config's which cause
build failures.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250330134955.GA7910@redhat.com

Closes: https://lore.kernel.org/oe-kbuild-all/202503260646.lrUqD3j5-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 324c2886b2ea3..a39fe292a0457 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -706,7 +706,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
-- 
2.39.5


