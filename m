Return-Path: <stable+bounces-141352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDA4AAB2C9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246FC188E44B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C758036D433;
	Tue,  6 May 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTa2LjBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF12D9DB6;
	Mon,  5 May 2025 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485857; cv=none; b=ibGAas7e2X0NI3xtUCXiCh6mNaTxcUEuGNJbaAKeLpAiZXA2Y5vrgnX0avWZQjv8XLScgrbAm2Bgqupm8Z9clamAAHo9PaBahqvR/RUA+usPlv1eaQVH5gAhxrJgFhvLMQiNCZuy7/nqqc1kWbnxbf0nIqCbWbuFvYfiBRdt02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485857; c=relaxed/simple;
	bh=bzBkeijRqyaaAXDGuRqa9M0jzYd/bHRMlIYBpTmmdB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yq/yNbHeiFIi+XITFTCC3Itk63hV1U9c53oSsFbkkDBmQP/xbMtgPlNW6lqK9hIQNIv5THBBl5NDzvPmMHKSJh+mTnIxoiFFuG8TXyyeuAkExjjxI6CZVGldKxPReeGVPc/eTg5dvIQSm8p6/UT17mA+i7eOoqMrSvQ0ofAmUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTa2LjBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BC8C4CEE4;
	Mon,  5 May 2025 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485857;
	bh=bzBkeijRqyaaAXDGuRqa9M0jzYd/bHRMlIYBpTmmdB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTa2LjBZlQH7CV49Pbxvjaru0hEU5194qtqsji2Xl9hPWKOULMCTxjX7Z+3U/MNfq
	 KrLa7RmbT+CVdo0QpKR3tCI62ntTRzLNWqzURvTgpvVIbNqsDOPJ0Dq1DZ+ImI7/t5
	 2XNBhhU4p5NQrgzvmtZTTEqA1YZuJ4RS9jbWmE77UY8JrHW0d9Vx12E9lyg8A68nSR
	 IesMIAw/jrxofJKGdrSmNFrU2W1a4d7YhnKKpdkGXM5hAjx+Mpa2nsaek+QsaRihnt
	 7qXiW4x/UEK0o7M/2/PrvoIFAz3sdhG8JEAn/v76jckif89wJZjRvUNuufJ2KCQ3ZV
	 nMgC/0FM7bcpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	charlie@rivosinc.com
Subject: [PATCH AUTOSEL 6.6 032/294] tools/build: Don't pass test log files to linker
Date: Mon,  5 May 2025 18:52:12 -0400
Message-Id: <20250505225634.2688578-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index fac42486a8cf0..27f4ee9cb4db4 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -141,6 +141,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -151,7 +155,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
-- 
2.39.5


