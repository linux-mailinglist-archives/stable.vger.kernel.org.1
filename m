Return-Path: <stable+bounces-226154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJJAD76EuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:43:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0DF2AE481
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC4C930288CE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58A3ECBE9;
	Tue, 17 Mar 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DXzqrXa1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057BF3ECBDD;
	Tue, 17 Mar 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765536; cv=none; b=caf2kAIU5rg3aVBk1+U+F3GHWVNF0ayKI9zDqOh5hPnnfPuKDvU/OdpfUlj9RPV/EBRbUPqv2ctwydRO/snHh6W/y1a/f7NWbFfxklbYdMScEBRvCsbb/k4BDzaHS6vbXtdGZJZqzywNZMRrVvqYRxAmCByPVnBTYywBqYXA/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765536; c=relaxed/simple;
	bh=mXZqbcXYYuzK9yF2v5ossP1gHpSiUmTRZbMHhxr8tvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cT/z49JzDTnLc34r3Fb0pBrtWJbNZvQCI32zG5q40TA5v/4Lro6PcySJQQEQCY4aPqkBvt3FtdSZcVqYQIK9uqrF7Nteh2PgvI94+i9e+yyTqVZ3HMHqXMLFeEMg6fo5sbs1uC8toO2TQ4/M2M39i9/AWq1lIL2QAIaNOKiQi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DXzqrXa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A28EC4CEF7;
	Tue, 17 Mar 2026 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765535;
	bh=mXZqbcXYYuzK9yF2v5ossP1gHpSiUmTRZbMHhxr8tvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXzqrXa1C+uMaU3EQzt5DnJhrd9IP/lEkey2cwqlbT+fdGjQ3s0qT1DSEwEwgOCGU
	 o9+e8oj54bSbCBtPLSVODQrxow/RV1djWrtCC36SbKdTwfqN9KizDrkzgpO+o5rZb9
	 STAhhHVWzrGHB4SiFzKFydbZR1Wr6EiWirBTyTfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Peter Collingbourne <pcc@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 033/378] perf disasm: Fix off-by-one bug in outside check
Date: Tue, 17 Mar 2026 17:29:50 +0100
Message-ID: <20260317163008.200618444@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-226154-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,intel.com,linux.intel.com,redhat.com,linaro.org,kernel.org,arm.com,gmail.com,infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,googlesource.com:url,infradead.org:email]
X-Rspamd-Queue-Id: 4C0DF2AE481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Collingbourne <pcc@google.com>

[ Upstream commit b3ce769203a99d6f3c6d6269ec09232a8c5da422 ]

If a branch target points to one past the end of a function, the branch
should be treated as a branch to another function.

This can happen e.g. with a tail call to a function that is laid out
immediately after the caller.

Fixes: 751b1783da784299 ("perf annotate: Mark jumps to outher functions with the call arrow")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Collingbourne <pcc@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://linux-review.googlesource.com/id/Ide471112e82d68177e0faf08ca411d9fcf0a7bdf
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 88706b98b9064..b1be847446fea 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -412,7 +412,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	start = map__unmap_ip(map, sym->start);
 	end = map__unmap_ip(map, sym->end);
 
-	ops->target.outside = target.addr < start || target.addr > end;
+	ops->target.outside = target.addr < start || target.addr >= end;
 
 	/*
 	 * FIXME: things like this in _cpp_lex_token (gcc's cc1 program):
-- 
2.51.0




