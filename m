Return-Path: <stable+bounces-141053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E988FAAB049
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D247BAA99
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F1286D67;
	Mon,  5 May 2025 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1A5bhxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F737F09F;
	Mon,  5 May 2025 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487330; cv=none; b=oh50U8294PgsSsIoXf6w+d2hwQl4zWNpj0ID/prcSAmuZQzBN6XE4iRxkhpaYA11MnrbC5FpXbDkWhzc+xfsuhEtgU7/vWX8JdN4qIkrsQfwy6kG02L5Ur02vgjkvMC+Qvk0kmTYvbPbe45bn8WCzhhOWaXmDATRcIQ/ZIIc4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487330; c=relaxed/simple;
	bh=Nwo0NnYQJbIpCtIyFQqmwhx7MaWot18zPZrNlbb/MmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiM/BEBKPlb793s6QTxshNgncFtx568FrP17cvrEbEkyKqgJ6W0DC88OZrHye73+vGmQM1Nv3EbviC7w4hfRuTnHWiJkq/Q9afq1KJTXqS46w57V8QN7IgI40F14xw8+nc82GdV9Ke90cH05u9uNRtHH2dfUzpG1QHJo1vCGXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1A5bhxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D0DC4CEED;
	Mon,  5 May 2025 23:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487329;
	bh=Nwo0NnYQJbIpCtIyFQqmwhx7MaWot18zPZrNlbb/MmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1A5bhxwBlKxedJe4MlpXWUtjC3XBzb6GS8TAYusCOSeAUwZ5Wd7zs9n1fUWQ4R0/
	 baPs38N6f03PPF3POWwbkW0INMS9mCPc3riuk/3V2A4HHnBUVSolMTCzz08I1N6q4U
	 vPGVnlbIVCr4rrCZgzOYIVhssZGFpgBYQUm4ClYQdDRobu03oaGts4G+eHeXCb1Kxx
	 9WMzZxtc1OrzAXlWAllNL22Y2en+Ox9fZzazMdTT7n628UqED5MwMFw3OW0idDzRQx
	 ybQlFUfm/SIxlnpVZUvozV14YhbG5D33f1/yKbVgqW4lHOp8BCcEWFj5OazUds41th
	 NMFy5EaMJrFsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	charlie@rivosinc.com
Subject: [PATCH AUTOSEL 5.4 09/79] tools/build: Don't pass test log files to linker
Date: Mon,  5 May 2025 19:20:41 -0400
Message-Id: <20250505232151.2698893-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index cd72016c3cfa7..ab0630ae6be85 100644
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


