Return-Path: <stable+bounces-141482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D49AAB3BD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CD317087B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4EF37AAAA;
	Tue,  6 May 2025 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdwhccNR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED412EC022;
	Mon,  5 May 2025 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486437; cv=none; b=YfiojeKkTraqS7njR3bcf5sen4V1sr9LmJxibnR2ewqHI2J5qaFEJ2DOaB/w+NIw7GwVzLs5kXL3y5hI39ufVjaoQ7DwyHC6/EYOURJV6rfip3SDMRqfN0eLJfMtcK5UfI43memx4ayOBE/h4TsV0Xs8Ade8s0Kjne7grWRSfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486437; c=relaxed/simple;
	bh=pyo/ifuuvjKVbu8A8cuH/zczcsL7AJ4+xRVsuQK/wY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdQUuJAfnoZUh+0btzW6ziq51bKGM2lo0RdEYgEphA7cBpPfYpAtZMDscV50I5Jg+lPNeeiDVCO8L2cV21wwyrhPhHqI+hXUQNnA9g6KPrFlv6uQvh1M7D9lDHTdw2DfNwixDLmBtYcFIOaQu0Bf9FLKQH7ueo5s8KimjfiEgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdwhccNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E40FC4CEE4;
	Mon,  5 May 2025 23:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486435;
	bh=pyo/ifuuvjKVbu8A8cuH/zczcsL7AJ4+xRVsuQK/wY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdwhccNR+KJiJUVi8428Ou/TjB/nJ4Wz4FoEWUhbO0UykNvJIva8KgxVnD8NjpBQ9
	 ico0RzIbDSOAxqqRUVFt8w/xBB2PTjeKKh4rT4kNfGr72BFyfiXQsZIUnG8iiiDbbV
	 rH4RZyeQPILmvagvh+GUhcpeXoMAou+HaxiAGPtzNePZJOwG19/ufLcm8RCAa8fErk
	 kOg+Ev5L+tiS6QdJZo6kGc3JY3WuE3DRa/6raXvtDXXyF+G9jQLu68rNPiubeuBrlL
	 Kg7X6ZAQ2XTK6KXlm9JE62s6gHwbc/ScB3COXCSVwcaNhxmX+vSB1fiPdc/jFH6K2z
	 H8KPJiwzrOgBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	charlie@rivosinc.com
Subject: [PATCH AUTOSEL 6.1 026/212] tools/build: Don't pass test log files to linker
Date: Mon,  5 May 2025 19:03:18 -0400
Message-Id: <20250505230624.2692522-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


