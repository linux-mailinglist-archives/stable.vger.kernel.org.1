Return-Path: <stable+bounces-220099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJMtGMQno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0546F1C4F73
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF1D130A096A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E19442847C;
	Sat, 28 Feb 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7z2mfJU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B63EBF04;
	Sat, 28 Feb 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300004; cv=none; b=RmNYH4tCq/z2N5nXXIQ95unJx4pbm8MVDN1H/trRHZpkckq8Ri/yGHnjq6bWSd+aX5DVa1or7gTKEcR3l5MOWdPidZj3zv8n2MIXHKLjcsoFzrAGllo0YkoBJpHurI/EFB3jeVMb1LiDIyiI6SIZMh2tLAfgDWYUwtUYY6pDNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300004; c=relaxed/simple;
	bh=oC5OwErzOvt25sNB0iDaPD1OFTzz8KCsCEwh8JtgNgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNAjUBg4d+yA4GEDyp+c8pG/JnBFyjf1vWYskMjmz/DFFiAU9CfbNhs4i/OLI7S0B8Ii5NVjzMK+WR399ps7GlJ/P9iN7AU22897CFftKyUjC9P3cokjlsL7m/cPu7BqOHVw/7sKjyRoviFE335uevdMdNSA1DSRNF9X1umUqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7z2mfJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADDDC19423;
	Sat, 28 Feb 2026 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300004;
	bh=oC5OwErzOvt25sNB0iDaPD1OFTzz8KCsCEwh8JtgNgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7z2mfJU80Rs3qOSbtc5CAx/TV9PBDRM3prRFrhXoPBz0z6V+4IFx0OPrdlDjdmEC
	 Qg0fuIzlONjob2Ihjpt65BWLviiId1Af7pthMJlWqQy54OwELQXfoKAJMh9v5NqvlP
	 XHjkDEs6Q5OHmTGd5X+RdNHUKkL4fzWezofD8VsMbCdMwWC0PB6r61UYVcAQcajOSF
	 e961fHK+194KspP1a2OzrLkpkY8ZC1DLCdLdL8Cq/2J1VvwPXKf5DMJ4N4JUzD9xlj
	 3mCuSpCF/YtQksrKShGyX2V+c+MLdoQ7lx892LEwXei/NJQFK5io893iw4pVGc0XiP
	 bJyG7X8jMINaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 021/844] perf annotate: Fix BUILD_NONDISTRO=1 missing args->ms conversions to pointer
Date: Sat, 28 Feb 2026 12:18:54 -0500
Message-ID: <20260228173244.1509663-22-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220099-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0546F1C4F73
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit dda5f926a1006c735b00ed5c27291fce64236656 ]

Fix a few missing conversions to pointer in the usage of 'struct
annotate_args' 'ms' member in symbol__disassemble_bpf_libbfd().

Fixes: 00419892bac28bf1 ("perf annotate: Fix args leak of map_symbol")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/libbfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 79f4528234a9d..63ea3fb53e77d 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -501,7 +501,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 	struct bpf_prog_info_node *info_node;
 	int len = sym->end - sym->start;
 	disassembler_ftype disassemble;
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct perf_bpil *info_linear;
 	struct disassemble_info info;
 	struct dso *dso = map__dso(map);
@@ -612,7 +612,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 			args->line = strdup(srcline);
 			args->line_nr = 0;
 			args->fileloc = NULL;
-			args->ms.sym  = sym;
+			args->ms->sym = sym;
 			dl = disasm_line__new(args);
 			if (dl) {
 				annotation_line__add(&dl->al,
@@ -624,7 +624,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 		args->line = buf + prev_buf_size;
 		args->line_nr = 0;
 		args->fileloc = NULL;
-		args->ms.sym  = sym;
+		args->ms->sym = sym;
 		dl = disasm_line__new(args);
 		if (dl)
 			annotation_line__add(&dl->al, &notes->src->source);
-- 
2.51.0


