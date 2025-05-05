Return-Path: <stable+bounces-140985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF72AAAD05
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24394C33A2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836D3DFA73;
	Mon,  5 May 2025 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3I3hayo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DED392FB7;
	Mon,  5 May 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487130; cv=none; b=egtAehOKFSjgxqYa8PRMOjrKBy/TaBZ1OrQkxtT0amkggv1gS69fTrVy1fT4nrbvwlajm4okjpEqzAa+dsR/pNIou8QEnYxkpeoyNWWOv8cusKyC0mGXNb7aBnNm+SDLyEr7rt1stAIsQAt/Ytri8Uc5wKMjy6GG8k9y42+/kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487130; c=relaxed/simple;
	bh=Nwo0NnYQJbIpCtIyFQqmwhx7MaWot18zPZrNlbb/MmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTefQsWxUcIOa8wtwGR4PXSeWQs/eJ4Nw4sZ8QATMsEfs9CuZxFMLj0eAxZPheXvt8ez7o52boRC2sGWDhXAF0lkAf6apyWyk6T4EbfYkzcdGCN2xXdFSNtxhPerD3GRE1fkwJxc9lKVJoaFuPXIEi7S5P/U0pifzTY3P59WhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3I3hayo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976D1C4CEE4;
	Mon,  5 May 2025 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487128;
	bh=Nwo0NnYQJbIpCtIyFQqmwhx7MaWot18zPZrNlbb/MmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3I3hayoFcXe4QjKWmzf9aFeQWPClF1MMxb876XPFwTp62cPcnrpPI5RKIpdRUHnD
	 OZwm1lJQskh5W4RzCCZgvR2XI6N9PXb6GenrR3/Q11lLniP6ul5I5PncjsRceTKY/+
	 nmUpgbheRNxSJPhyi7fUgW5Kw0fn1+alIBnOQq6RGTLxv3LKPFOPme4V04P9ByiCpo
	 puHL07kN7JbuA7AHCsjQZFHy5nlxZ9J35gGQRKOaeuI5rITs8uHWbsXihqjHVTMqS2
	 kAw3U3nq4C4Onp8uhpQq1m8auwsQKORkvcrrl9liJF76spCrRTM9VJeoZJexwhGTqz
	 wbYwBxPCh5FYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	charlie@rivosinc.com
Subject: [PATCH AUTOSEL 5.10 013/114] tools/build: Don't pass test log files to linker
Date: Mon,  5 May 2025 19:16:36 -0400
Message-Id: <20250505231817.2697367-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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


