Return-Path: <stable+bounces-128799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF4EA7F1D3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B18E1898B0F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C187725F97F;
	Tue,  8 Apr 2025 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDENPvBX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F125F789;
	Tue,  8 Apr 2025 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073677; cv=none; b=CBNPwt3viGHNCCLDt78ukAeDNGxYQwtreKjs6XOG+SlUCECEA2eFttcqNZPwaWRFh4sLPBOxrQVxWuZzBfV1/RqQFxgSLnXzBr/s6UVqpOszkB23D+hJKKpC4W2mnz3dbya/QCwjqP7QLje5KwTquJ2prymJD+qkN5xaQk3ZbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073677; c=relaxed/simple;
	bh=y/GqHK7qnooxRLGgJ+6DRAN88StLJHdk9WAbJ/Gk47Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnTwMS5zlwsRZL6yQJZzvmiiq/0YzsAJI8LqlA2uHlwZu+2ocQO7P2FvbFDGqxH65UvjgmI853zSGIqUnLVtteCF73p4NdRQgfFwzZx6sto557rd1URWLwXPq5oT/OdNMIQJUNpm76s3ry8QFSS7C1KIGzKf4jb+F7gg4lFEjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDENPvBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25744C4CEDD;
	Tue,  8 Apr 2025 00:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073677;
	bh=y/GqHK7qnooxRLGgJ+6DRAN88StLJHdk9WAbJ/Gk47Y=;
	h=From:To:Cc:Subject:Date:From;
	b=ZDENPvBX5SRgUlk0ibP2efGO2DPHtLfZWoEX/hFG+k44yt4pv2AWzm+XMCB6JLbQH
	 IGs8yiNWCCBDnz+3kaJd6PmyeOkCOXjpMwoAXRikYrGVHnsjJcjo8SsrmCpW27QZ2G
	 MUdBn6acrAtRNMCUqOi6A+90ID3EeMn/zqxFo1jqAPNXQA23Cfeb/jwykw5JjZbUh0
	 W+XeAWWXXw4HVZnGmkHe++zyUszEmC6+mxclhf74huctH5FG4sE2TGxy9QhgeDw4vJ
	 c+dserEBKd9w7Fd8e0p1jhD0qQQISNsBvE+fkw6hvAhXco89TFB83sN3hnqyYYMH7N
	 zVTTKNtErLfbg==
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
	chenridong@huawei.com,
	axboe@kernel.dk,
	jannh@google.com,
	mark.rutland@arm.com,
	brgerst@gmail.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 5.10] sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP
Date: Mon,  7 Apr 2025 20:54:30 -0400
Message-Id: <20250408005431.3335006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 9807c66b24bb6..d9dd8cbe99b11 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -656,7 +656,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
-- 
2.39.5


