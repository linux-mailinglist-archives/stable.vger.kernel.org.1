Return-Path: <stable+bounces-128793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E09A7F1CD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C7817BDDD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75325F99D;
	Tue,  8 Apr 2025 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTOXRp8s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7B25F797;
	Tue,  8 Apr 2025 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073637; cv=none; b=EEJp4BRKmwvzwF96D/yjQMKvJaDA722adWGf+xTY/FXzifWVwAJ6kaZ51h3SUmAY4IArYUptdgcKOlbMTcdOV5jN8PH/FXe9sMa99bOfoPGbjwX+g4li5/lRJrusFCGAPuKb+R3yWYFUUbr4j1wuIj/clZQCFtA/FMXEupZ2mLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073637; c=relaxed/simple;
	bh=ZQmduZUjn0/G+1i2JlFG30rC2mteFzykTjg3UFX5bfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXnJ9PF10MY28Mo81XMbHUa68HSO7pMT5HhnE3IOpmkDh2o/QWFNZgR6vp6Z9j6TpOnebaz3obU+cBpk6b5K+YLQV6yUm2Poe6/pCeWihipNELux5fwkkugNV5f2cFBPdctzTeMSHS+0vgaYOBijigsHhRBXZPgFmG8iqZ4L+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTOXRp8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27579C4CEE8;
	Tue,  8 Apr 2025 00:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073637;
	bh=ZQmduZUjn0/G+1i2JlFG30rC2mteFzykTjg3UFX5bfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTOXRp8sOHCxTcxuQ9pQGqVKnVDR27VEp0LPqsP4iq4SKCur6wjDMs5B/97EhAEwo
	 R8Beoh3T8+TaUsMjQDTwKCUgPv49T5iOuQmczUbR3SZ9sTz/6Euc4Ifkn+n0TMtD8l
	 WUUb32FB8Vz7rmQN1T5ssDsCMI5V3jGdT3d2VTqMxBPQCKDRJB6pibRqDT6YGGlDZ3
	 D64PxxS7dZaGkaEwru+FCGvpNdSs2rmDWLXCok2cMghQsWMnsAWNaVjL9OYAZfWJGt
	 WEPiZGSNPGIdM8kJuqk11Fp4kCHSZpr/HzlB1eatfhzg6SZ/976A63Kks9z5ILhuOA
	 ychd8WZTzfbsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
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
Subject: [PATCH AUTOSEL 6.13 3/3] sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP
Date: Mon,  7 Apr 2025 20:53:47 -0400
Message-Id: <20250408005347.3334681-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250408005347.3334681-1-sashal@kernel.org>
References: <20250408005347.3334681-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
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
index 4c88cb58c261c..4719516ee8b48 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -703,7 +703,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
-- 
2.39.5


