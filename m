Return-Path: <stable+bounces-228521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FEJJqROwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:31:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B702F4A5C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E72203038E8F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5383AF657;
	Mon, 23 Mar 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="phMDa4ee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292D2343D2;
	Mon, 23 Mar 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275352; cv=none; b=DH2c7nAcWc8FR2bixquxA+Fwd80/NTIEi0s+As0rV6ds9UTcdQMY7VvR//R+WUpkGOjrjb9y9hTA24f0adqdcsDn0ZvE/+tNvZUyNzlGibSK+uc++Tnd1cXbhLRBtTJm7+KAAnuhP1V5KVCu6Yns7WEdj/ku1C3v8e+UDn4NluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275352; c=relaxed/simple;
	bh=+16F4oczrZckXDQhDrjLlVTCLquG4rnBQn48ZeBxmUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXcEYO/4UOaw298eP2l3OZtVuD9bPd5LPeWa5JtfrD0xmfavwYR29Xac1ye5lnAihcKaUyLcaNUJ0jLTcVResdUdRPbKOXRP5cLKjdF7M6AnMFqMeQcfFLeLYqFceVGHdGjtnzJKXngr6CS1gX295kIXuUOVZPavwbepsyyggsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=phMDa4ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F479C4CEF7;
	Mon, 23 Mar 2026 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275352;
	bh=+16F4oczrZckXDQhDrjLlVTCLquG4rnBQn48ZeBxmUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=phMDa4ee896j0WlkDM9HgJ5IbQguFhYqNN+qTmJrAEBD2eRG55LAUr3qUmyekLvP0
	 LRoYlULeEFfHFIX+7XILPYcUaKO5jdecTfLP4iNeHACAdceHLSs60mnowhs9pjd+Ew
	 ca/QTsA3UwSWb37CHxYPfdKxCTiBU+BahoKK2Ciw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Tianyou Li <tianyou.li@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 068/460] perf annotate: Fix hashmap__new() error checking
Date: Mon, 23 Mar 2026 14:41:04 +0100
Message-ID: <20260323134528.372363382@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228521-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 09B702F4A5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit bf29cb3641b80bac759c3332b02e0b270e16bf94 ]

The hashmap__new() function never returns NULL, it returns error
pointers. Fix the error checking to match.

Additionally, set src->samples to NULL to prevent any later code from
accidentally using the error pointer.

Fixes: d3e7cad6f36d9e80 ("perf annotate: Add a hashmap for symbol histogram")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tianyou Li <tianyou.li@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index cb8f191e19fd9..890cc0a69fa5e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -44,6 +44,7 @@
 #include "strbuf.h"
 #include <regex.h>
 #include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -135,8 +136,10 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 		return -1;
 
 	src->samples = hashmap__new(sym_hist_hash, sym_hist_equal, NULL);
-	if (src->samples == NULL)
+	if (IS_ERR(src->samples)) {
 		zfree(&src->histograms);
+		src->samples = NULL;
+	}
 
 	return src->histograms ? 0 : -1;
 }
-- 
2.51.0




