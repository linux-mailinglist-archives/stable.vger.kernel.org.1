Return-Path: <stable+bounces-140438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B5AAA8B9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA1D1885802
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6082353115;
	Mon,  5 May 2025 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ7AFcNR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AB353110;
	Mon,  5 May 2025 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484851; cv=none; b=AEy8cTNzR5VufCGFULvyyap5ZxgBrWqnEQL9mXEI6MjfjxmyHZtjjvppuvFgThnico1CZDYWdJY9TvA7sDyFYytcW+YHim7pWuLaIlTsGvmiQ+N8gXYeavdgIG8Or7OKlPMEXmnVkpeTiKD0pwTh2haS7p7pDHG3PmhAbHbwpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484851; c=relaxed/simple;
	bh=enOBr+rWExAFssf2sVoh6LSpTIo7291bZ5Daf+vRlBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mz1gMsEdqfDSlzqzGFpGomEUSVOVshfOFWvUX+sVNCUccjq9v7+sbok2pmxVa4Lnye2tE7lSIzgJRnLxhCFghhj5iTmT2mjKYaEr/9jZgrJ6PdvZHkpanEtYlT4Kkga1OUvIyk16x3wi/8D1PqdC+phI9FyC4pkTWicYq36EyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ7AFcNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272EBC4CEE4;
	Mon,  5 May 2025 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484851;
	bh=enOBr+rWExAFssf2sVoh6LSpTIo7291bZ5Daf+vRlBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJ7AFcNRSRBWNN/Ao6at+FXGvcj+cTe3UwnEMlagWTAwiQ9vLBfwIJ2r+8/Twc59k
	 GrpXelzhWy3yu+Nyl/pEMZAc+Ah30vLMaDAQQoF2uj0lR19MFGL57uZ7IS1lfvj6nV
	 8fe24iLDw28oLUTYxyZ3zvj7TG2eoAZn1KquNgvPEHl6tN4GnPQONA5LRHd1mBqwac
	 0tecGUBSMDSCeR13vSYWfVv9dg7aDu0+hSTYLCJlVjYmbdSyyAOZ0fn/ssyvgjX5vw
	 UR04OxjXNx+x5bFWAXY1nBAG6VUyj1NGlD66T1+WOZ3Lcf8JWjyvm1W3Cl0yZmd+9o
	 6R3/k+DLpoz0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	charlie@rivosinc.com
Subject: [PATCH AUTOSEL 6.12 047/486] tools/build: Don't pass test log files to linker
Date: Mon,  5 May 2025 18:32:03 -0400
Message-Id: <20250505223922.2682012-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 5fb3fb3d97e0f..ffe988867703b 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -149,6 +149,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -159,7 +163,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
-- 
2.39.5


