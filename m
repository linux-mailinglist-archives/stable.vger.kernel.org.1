Return-Path: <stable+bounces-139801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C609AA9FDA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B4A1A829E0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876A28A1D0;
	Mon,  5 May 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvPfN89x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583828A403;
	Mon,  5 May 2025 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483361; cv=none; b=qPIkszvvl+8q0wdU6Zd79Z+vPNRwhzbcvr837WYjL8f7+bJCIYte1fLOcITt/loSrA5oihu9g13LhjimF0TU4y2idoY4LtX8zMkv7mKD+n/H7PjtV40tK5ksGkcQt5hbxkDHlpkEF8rSSZXCI+9F6ilML3ZyMDzJpzKNjWS89qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483361; c=relaxed/simple;
	bh=0y5dqa+RSgTfi8DEeY8z0FFD517OjAnot03mldDqspQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7TerhIA6ihKDPnIi+v5dKmzbAMR3p1a4aG+ggi5LQNuz3btmlpZbhMIG6WN9d8wEtdrT/nQlrkG5cBjIICNugtmInsPT8xGYQ72ewvJHGr0C+aiyoVz8iHHDOnmerZt9AsRynlRlMdkE2tD5u3LJd+/LIq77xz+XjtKuOJtYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvPfN89x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CB8C4CEE4;
	Mon,  5 May 2025 22:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483361;
	bh=0y5dqa+RSgTfi8DEeY8z0FFD517OjAnot03mldDqspQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvPfN89xfTHt4I0OeX7SJT+Fyq4QfLwW3QawKJ8DzosceN9Ys61VAOIlRYxJ+GiFt
	 K7+u0itqcP5u01tHDIrY9zzpsLOf4fDrH/Z+CY3ZaybVrIHO9qJiKX1Lys7gyiAOAI
	 3UJ/0J6L+XGI9w5ItJhuVF/VLPy6Duzd1YALURx2V6Mxel67Cob31AC6LRPv6Vu3ob
	 TbdUDmjeoRSWVqfdPJ0K6o45obXCNmQObHRSWWRTYVKBhdTGQFCLoLHi8zhKbvRIFd
	 S2M7HjSEGXlWxv2iUN6tF8Dbn8cK6Gta/H7qaerllnzvQ1lzpe7r3Bsl0eCcv9RmvC
	 taV4ugvZULS5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	charlie@rivosinc.com
Subject: [PATCH AUTOSEL 6.14 054/642] tools/build: Don't pass test log files to linker
Date: Mon,  5 May 2025 18:04:30 -0400
Message-Id: <20250505221419.2672473-54-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit 935e7cb5bb80106ff4f2fe39640f430134ef8cd8 ]

Separate test log files from object files. Depend on test log output
but don't pass to the linker.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20250311213628.569562-2-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/build/Makefile.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index e710ed67a1b49..3584ff3086078 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -129,6 +129,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -139,7 +143,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
-- 
2.39.5


