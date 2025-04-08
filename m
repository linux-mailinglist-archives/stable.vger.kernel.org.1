Return-Path: <stable+bounces-128797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FDAA7F1CF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E9F1898B33
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9725EFB9;
	Tue,  8 Apr 2025 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCLE7QNR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F525EFBF;
	Tue,  8 Apr 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073662; cv=none; b=YZqdYeKEwrLtu/L5KpYwejpuf5zuoZT+EyZYSfBW1Mok0m0Ms6xmppPjdAH8Igns4KKlpOFMixo2e7NCKXpjVTzFKctNjvbg65Q1qNzSc3YOiBha6AMf56vcqNuSKALzPtWQzP9hopHOKF/o6i5tEe2fqe5FQTk4UTbf9yM9JRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073662; c=relaxed/simple;
	bh=EkrBKqACC5C4XNctk4OYs+595jMLXhpholdr99UmyFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PlNBrecRoE/bGKniWveHotzMJOm6YCDKXCIR/5teo/ziaI7fRrwTY9+QLnSJh1XvjdDozS5qB7CO/CE1RC0SAwFpK0LZX093SOzKA8VkbCRwRsjHkGgomrP9JNwechHfW+aXl+rh/fQUQDtd8x409e/+YUDYRhQCsaaX8LEZZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCLE7QNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771B2C4CEE8;
	Tue,  8 Apr 2025 00:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073662;
	bh=EkrBKqACC5C4XNctk4OYs+595jMLXhpholdr99UmyFg=;
	h=From:To:Cc:Subject:Date:From;
	b=bCLE7QNRoUSMFxAqepTSIZ2GwEcpdw3FGgkAw04mKLTDpRJnR54Xula38J1Sd32Qd
	 0NApCjE4EG6sdVx4iiMIgOSw1kSf6+VpSneAr0TzT8O5D1PtKR1tEwXrUBf8zjk9Z0
	 CV3H3xqn385Q/uRdj5kVYOxR1Ue0vmD+PKZZvUhmskepIxX497MMHe24ga/F5wIfTj
	 qvCspDg0tZLqCw8O6biy/SlAIA0qHxhVr3BH8fgH1kIrnY8JU2SqrUYuHXnX2GjmA3
	 Cj676viV++c6ESrJ9Y2dIpGyYoFeel1Bvf7Iki2/NKNsrkqRyn7hiBu8Vgp37TS17e
	 jLwIGHqsEbmww==
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
	masahiroy@kernel.org,
	tj@kernel.org,
	mmaurer@google.com,
	yoann.congal@smile.fr,
	jeffxu@chromium.org,
	roman.gushchin@linux.dev,
	axboe@kernel.dk,
	chenridong@huawei.com,
	jannh@google.com,
	mark.rutland@arm.com,
	vincent.guittot@linaro.org,
	brgerst@gmail.com
Subject: [PATCH AUTOSEL 6.1] sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP
Date: Mon,  7 Apr 2025 20:54:15 -0400
Message-Id: <20250408005416.3334910-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
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
index b6786ddc88a80..8b6a2848da4a5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -678,7 +678,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
-- 
2.39.5


