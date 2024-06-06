Return-Path: <stable+bounces-49560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4ED8FEDCB
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679221C22F18
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D11BD50C;
	Thu,  6 Jun 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p6ur/tQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B481990AA;
	Thu,  6 Jun 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683526; cv=none; b=TvDL+Pn0PXEeXz84jh3b3NXJ1DNtnUawHGZOxQIGUZMCF9VEpdYRTT7mcJgNX6hEyuaxUjuoFPyYX8/ooxkv9nC55w74CNx7umTUW8NSe0WoO66WKLdpokWPZeLrt9LyKd034V+5LisWtcMSu2PgpqXreKr2c4ORSVpzdRbWrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683526; c=relaxed/simple;
	bh=ggMbLLeG9lMe31+nWBgaMnw5Co1bYbVE8o5akJHtFBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTXhDXnuhmwW3T04zK51acaG3f7DirSSIXyfMLHS2ty/PE3wL5yGC/Wo8CHTPz64cYPldf/2U3GYfqozA/vNPK3AQc7x8ajb0GYlJJl/bU+5bKc4oFyXVIBUT/zgJY8QvVcgxepJosYwYOjXv7z8qMdW+kMkXiHTs+4Px69f4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p6ur/tQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740BAC32781;
	Thu,  6 Jun 2024 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683526;
	bh=ggMbLLeG9lMe31+nWBgaMnw5Co1bYbVE8o5akJHtFBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6ur/tQVpHehZt0GowU3hdL+Ea+rcjnWYt4y5rYWhZkvSxyp7VmMvVNvXCkqanfdE
	 mxDUFeaf3UGgGNpK6+Av64iUOc5f/DgXQRlziFbzgHolE5OMbeAwDWNRxVIyJtexrW
	 fcShpd9TcTtERuieYdoh0kUcswW+BqvPYeuKU074=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 467/744] perf intel-pt: Fix unassigned instruction op (discovered by MemorySanitizer)
Date: Thu,  6 Jun 2024 16:02:19 +0200
Message-ID: <20240606131747.446326613@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit e101a05f79fd4ee3e89d2f3fb716493c33a33708 ]

MemorySanitizer discovered instances where the instruction op value was
not assigned.:

  WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x5581c00a76b3 in intel_pt_sample_flags tools/perf/util/intel-pt.c:1527:17
  Uninitialized value was stored to memory at
    #0 0x5581c005ddf8 in intel_pt_walk_insn tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:1256:25

The op value is used to set branch flags for branch instructions
encountered when walking the code, so fix by setting op to
INTEL_PT_OP_OTHER in other cases.

Fixes: 4c761d805bb2d2ea ("perf intel-pt: Fix intel_pt_fup_event() assumptions about setting state type")
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20240320162619.1272015-1-irogers@google.com/
Link: https://lore.kernel.org/r/20240326083223.10883-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
 tools/perf/util/intel-pt.c                          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index b450178e3420b..e733f6b1f7ac5 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1319,6 +1319,8 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder, bool no_tip)
 	bool ret = false;
 
 	decoder->state.type &= ~INTEL_PT_BRANCH;
+	decoder->state.insn_op = INTEL_PT_OP_OTHER;
+	decoder->state.insn_len = 0;
 
 	if (decoder->set_fup_cfe_ip || decoder->set_fup_cfe) {
 		bool ip = decoder->set_fup_cfe_ip;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f38893e0b0369..4db9a098f5926 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -764,6 +764,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 	addr_location__init(&al);
 	intel_pt_insn->length = 0;
+	intel_pt_insn->op = INTEL_PT_OP_OTHER;
 
 	if (to_ip && *ip == to_ip)
 		goto out_no_cache;
@@ -898,6 +899,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 			if (to_ip && *ip == to_ip) {
 				intel_pt_insn->length = 0;
+				intel_pt_insn->op = INTEL_PT_OP_OTHER;
 				goto out_no_cache;
 			}
 
-- 
2.43.0




