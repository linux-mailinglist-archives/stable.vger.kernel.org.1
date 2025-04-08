Return-Path: <stable+bounces-128800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519EAA7F1D8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD663B4EEA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4EB25F98D;
	Tue,  8 Apr 2025 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJm3gbT1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E725F793;
	Tue,  8 Apr 2025 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073687; cv=none; b=fTz9qKzKqmNpAaE2GuWJ4+NRL3fn8N27lzNcZXvVtmzyxn5pC4Xli/uOx3vk4YgoP9yS+/J+Sjsp22IWRqZEKrJ5qep/o7yBqfkA2eqD+rpuW6DNhnuU289F10SbM/aFrvVrAeDOOzRM2EO9MsMvidT5s7YkTvqJ12xLcL+V6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073687; c=relaxed/simple;
	bh=uIclwtFQPhM45ra5x1CNBJS+U5d0woNUyIqzXH/gjpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EPJlguat9zxVyRSX46WcbQaGvWVzkY8hPfHU81K7KYZCx5i/LZyjUo83/Bpogl2XNHAilbRmKL+p9jBk3qhqCmW3veHgJjJFkQaiUEUrKr5Kiu/2ao/z4WP3WzLw8wM8tsNpQ8iaWxgRVSRoQJ6j8T1PjKMjEwFctJM7CNKIFhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJm3gbT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86082C4CEDD;
	Tue,  8 Apr 2025 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073686;
	bh=uIclwtFQPhM45ra5x1CNBJS+U5d0woNUyIqzXH/gjpw=;
	h=From:To:Cc:Subject:Date:From;
	b=vJm3gbT19A1BqO671ArzM/3w4vpvc6bDAI7ohB/B0ZSpuwQBzgM9sGCcNQ3NJfn+J
	 9u/gZFMDM0lDGM/U7rmRAg+Y+K40Nh9CRq/joj3MLGyrR2XOsoGgLm4ovOk6NC7JAV
	 aThITcJRa4vP9DZTEMTMLTGz1WZTFsCymR0bofrlccuGcL4P4Ph4EtEPgTnZKBBHAp
	 ZKgYTWU7k8e5qgzTnN2cr9PzKUvc153FliMORl5VRG+THGz3OI/WHEVGCBg+4W0fGf
	 4uKnu/NGn4a+7hKdWuyz+u+Yss5VYsSUf2ll7xizlha/9nqIJMDUHTPGJtxoA/SG+o
	 JEskOPpI/peAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ojeda@kernel.org,
	aliceryhl@google.com,
	akpm@linux-foundation.org,
	tj@kernel.org,
	masahiroy@kernel.org,
	mmaurer@google.com,
	yoann.congal@smile.fr,
	jeffxu@chromium.org,
	roman.gushchin@linux.dev,
	axboe@kernel.dk,
	chenridong@huawei.com,
	jannh@google.com,
	mark.rutland@arm.com,
	brgerst@gmail.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 5.4] sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP
Date: Mon,  7 Apr 2025 20:54:37 -0400
Message-Id: <20250408005438.3335036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index f641518f4ac5c..01beb047aff2f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -559,7 +559,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
-- 
2.39.5


