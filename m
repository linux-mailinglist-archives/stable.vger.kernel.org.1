Return-Path: <stable+bounces-43470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A68C05FB
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 23:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A2F1C20D6E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E838E130AFC;
	Wed,  8 May 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG9C/SO3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7142130A58
	for <stable@vger.kernel.org>; Wed,  8 May 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202058; cv=none; b=JKO9AFmlOSf4SoFmkk6I39Il2TZTYOFNZxT8mdzcrXMu0cQ04aAP5KMv3BpgZfxH39qyNqissqWuYoLq4zD1a7tBE3VKcEWf9Ej94a670ejbS1osBlszVkAp9XA175YI2d8LdoCbYeh+YerO0XPLfKuUbiy8T5uO3t5BTkQ3yOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202058; c=relaxed/simple;
	bh=TAeFf8IARM+7xW/JUWkBWPQ/QZ1kk0bk10CYigI+of8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMFeT+pl9ih0Zdd57ijOoxw857qnNqHpL2qiDKClszRUIOtet8xmsXht8rQTUQZkqEvTBEF5ImNZVfTRUvPbAeMz4kYqhjiFOraQrAFIPCt3FxsjZd5ueDnPt01VosylLWeGUdex2HPYMCSeqI72IXXfPPbEVZDQOtg4wtmPSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG9C/SO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A94C113CC;
	Wed,  8 May 2024 21:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715202058;
	bh=TAeFf8IARM+7xW/JUWkBWPQ/QZ1kk0bk10CYigI+of8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BG9C/SO32KLsyAt3yDAmFgT2b05+cwXpDFIgE8ksLRJA1f/zRc/zMJoMp0D5ftai1
	 UJcNZeBz/nPePH/iKPODHXlt0/FnG4bq2f4hLZHdQ7kK+Z38REq7OoeCfVXEuclFlx
	 6Tb7cSGPEoH0rZXWIf9U/f2CX5fgAq9CcF5aZVJvphB+3poRWUdasTXgjla14VtdwI
	 KkSHsTEZ7laTkWg/dsh24fM0kAjarvB3vY63dUQw2xaMut5VQCxMLFLonZWEd1rYVU
	 6HFOcv+XfEtY0/lBE2b8FaLdxgmpauPZfCkzbeQGGYrHe3QdsdCB9m86SLsUL8cFTl
	 BgIK4cn9pAN5A==
From: Namhyung Kim <namhyung@kernel.org>
To: stable@kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Pablo Galindo Salgado <pablogsal@gmail.com>,
	stable@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Fangrui Song <maskray@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Milian Wolff <milian.wolff@kdab.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH for-v6.1 1/2] perf unwind-libunwind: Fix base address for .eh_frame
Date: Wed,  8 May 2024 14:00:55 -0700
Message-ID: <20240508210056.2253626-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <ZjveA_YEh_N5l9o5@sashalap>
References: <ZjveA_YEh_N5l9o5@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 4fb54994b2360ab5029ee3a959161f6fe6bbb349 ]

The base address of a DSO mapping should start at the start of the file.
Usually DSOs are mapped from the pgoff 0 so it doesn't matter when it
uses the start of the map address.

But generated DSOs for JIT codes doesn't start from the 0 so it should
subtract the offset to calculate the .eh_frame table offsets correctly.

Fixes: dc2cf4ca866f5715 ("perf unwind: Fix segbase for ld.lld linked objects")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Fangrui Song <maskray@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Pablo Galindo <pablogsal@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231212070547.612536-4-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 81b6bd6e1536..b276e36e3fb4 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -327,7 +327,7 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 
 	maps__for_each_entry(ui->thread->maps, map) {
 		if (map->dso == dso && map->start < base_addr)
-			base_addr = map->start;
+			base_addr = map->start - map->pgoff;
 	}
 	base_addr -= dso->data.elf_base_addr;
 	/* Address of .eh_frame_hdr */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


