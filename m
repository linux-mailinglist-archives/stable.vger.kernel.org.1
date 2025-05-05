Return-Path: <stable+bounces-141597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8947AAAB4CA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C8918956BE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5C482D3D;
	Tue,  6 May 2025 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWCCMB0m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A031283FC9;
	Mon,  5 May 2025 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486837; cv=none; b=XAUe5V/qyXoqBmxkF3j17cxtDim7/y8TUFTpuqnKfPQXpNfNdP/eeUbLJPDx97gvbaayZ1Tb5ncVLO9RZ9oTUZzeFthqZ1Sk/VOU6nvGYSHrWO/AEvlFw/UnDwQlwmOprgFTq7ZJ8zKrwOWnQh73XswMs3M2EFU3J6bUaV/h3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486837; c=relaxed/simple;
	bh=pyo/ifuuvjKVbu8A8cuH/zczcsL7AJ4+xRVsuQK/wY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeYEiZf/eRvL362kjwDxa+2Ws/orD4TlGltBwiRUlwC5ZzzC9RH4tpJr77HDk0WoLnQ9Q/+PmDdFoEJi+wUZFINjoc19Y6cU9pMIgeY2jzdfSXxIIZ8l6uXabqRrLQUqHqgmPUn34S6iSpdMM5wQ4THBpQQTy9WQ3wDpQ95NmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWCCMB0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8584EC4CEED;
	Mon,  5 May 2025 23:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486836;
	bh=pyo/ifuuvjKVbu8A8cuH/zczcsL7AJ4+xRVsuQK/wY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWCCMB0my/Gg8ZAzsz8KA0P6G5SOca01GBVyhPBJsg58xbkS0LfUqQUNcdhq9Q728
	 zhA2edBT/mbphTzDk20GGnv7Nwc6tLNnoeDjnfvslsk4ZDdVUn4a7xC8+ktjeHiMnC
	 xi8zkKT/WBBHqgE4xfmbEgUNrxl2+sX5JBVVRKuChseaBDOqi10GY/Kf7yNYVhsN/Z
	 jCQT6AN3FdAuvIE7nBmDXgb86wjqwhDs84tTw5+vbmAknZ5wjv4mNS9mPDN69BSb+w
	 QFdgOeDmy+1N/NgnI/sRzW4s62DuuePQ0h8ajGmeUMMmRNWVvi1lbPi1szkxx0pzQj
	 xrVGyh15+DK4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	charlie@rivosinc.com
Subject: [PATCH AUTOSEL 5.15 016/153] tools/build: Don't pass test log files to linker
Date: Mon,  5 May 2025 19:11:03 -0400
Message-Id: <20250505231320.2695319-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 715092fc6a239..6a043b729b367 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -130,6 +130,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -140,7 +144,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
-- 
2.39.5


