Return-Path: <stable+bounces-128798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F87A7F1D4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5D817E11A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D825F96D;
	Tue,  8 Apr 2025 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL9lq5dd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07EB25F78A;
	Tue,  8 Apr 2025 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073669; cv=none; b=NbHb1KXum7YESarPOuwUZsBMU2kMd/jgKZgSovSthaxT68jIEwBQxQWTVK+79OUTHCqy9hyBU79OqRbBCuQw5V4TRaNB2ZohWkgHQ8w2g8RB4avustmpJVxMxAddYX/apLMPl9zmSSObXlinMlewibv5ZC7JQTC0fOvqNcdDKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073669; c=relaxed/simple;
	bh=+QwO1WLnO79Bu7Zo5cxOUyEMBOqZlMWoTt+shk687wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U7+eVYPyBCo0DK1276J7wVSTCxlDbC4qlnymJQJsWom0DkQl+9f0ZKSV9PbY3L7NCA6CmlTxL4iDa2rbr2Jb3PFJdj+Z8VkE1mHCdAc+/2SB6AKztz7sHFQNr+opTogws8Q/S74EVpX3w63Avx8bFdteHtWgc6xuH3gkcINVvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL9lq5dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219FFC4CEE8;
	Tue,  8 Apr 2025 00:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073669;
	bh=+QwO1WLnO79Bu7Zo5cxOUyEMBOqZlMWoTt+shk687wk=;
	h=From:To:Cc:Subject:Date:From;
	b=LL9lq5ddAion7TfNYvlhBE6d2ksG4ckHS3BQvqKowffHmaRju3UJWfzPUHi42ItCr
	 CyJt1+KT9huOpMT33BVhE0TQRH71ByR2dUET2+c4cuySSC0lqlM2SzRXwexwwPcI1H
	 vF2S72wVTBdDpvZ0TEzsNoPLRgSAeKE7jCVPJJ0WRQaJW7l6+fPhB5MLhafxh4PzTf
	 RWIsYEHeRKx9Krd4grPICjwf32sNAb/U34lbG6an7xm+QsiRg7TSPnbGrQ2yT2Wq78
	 KBxbT+IGjGuN1YioX4hPi3oV91w2b8uuUFKMEEKfhbeMKlJEcyKvKF5PeG1tyIAOTA
	 xPoTSIebSWOfg==
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
	chenridong@huawei.com,
	axboe@kernel.dk,
	jannh@google.com,
	mark.rutland@arm.com,
	vincent.guittot@linaro.org,
	brgerst@gmail.com
Subject: [PATCH AUTOSEL 5.15] sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP
Date: Mon,  7 Apr 2025 20:54:23 -0400
Message-Id: <20250408005424.3334978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index dafc3ba6fa7a1..c7d81fc823964 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -674,7 +674,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
-- 
2.39.5


