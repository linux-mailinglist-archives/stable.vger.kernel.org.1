Return-Path: <stable+bounces-226211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJo1M6KFuWkPJAIAu9opvQ
	(envelope-from <stable+bounces-226211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A72AE6AF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A55B230363B3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9113EDAB2;
	Tue, 17 Mar 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f8JQYyqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384023EDAD3;
	Tue, 17 Mar 2026 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765730; cv=none; b=XfjAqat7CiAzFuaBpHfvKu7zXoql6cPlugm31gu6c5J+Iw8nx6lIeWL52NG9zHS/nhpP19gAaWKmu8k0SixocnW6I0q6q/vgTLTV9oZmmXD606byDjz0vgLMbUUMWMZ4IkqXdFsQ3g7rFHqF8mknXCQZ9oFfRD4EhP0OEKiPqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765730; c=relaxed/simple;
	bh=bXo1PfcuvCu+DVo9mQxmzmSMSaotT2NDzj8uvQxcrLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZErK746xEzU9XYJdyLRAEdQlZb5eajJHiqUKS4m/JSGNo6jB3IcOtCacqQq8FUQ6BvsCVIpdmdSfru6UNhc5hjHV7v1xR4HDJtOVPEVNGtesFluQtbSPM5/wPU37yL9XfI73dMhswrMzsVSJnYy/276huea+SyXGttSEEBY4zFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f8JQYyqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDE6C4CEF7;
	Tue, 17 Mar 2026 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765729;
	bh=bXo1PfcuvCu+DVo9mQxmzmSMSaotT2NDzj8uvQxcrLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8JQYyqNonNPa/DMOU0INUXY1C8u60V83rEygWFM8azfIwS9z9PXq6KWuNckqTZSV
	 vUlaadHWi43T3vhT6ErxDu0ssE+VqYo258ap2lyzDeKiqSC7r/0/3sDdGowHdcmZbP
	 N6cpBRRHKsiwwmGwNywU3d4uwJp1sfxx0+U5tyyA=
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
Subject: [PATCH 6.19 081/378] perf annotate: Fix hashmap__new() error checking
Date: Tue, 17 Mar 2026 17:30:38 +0100
Message-ID: <20260317163009.996873208@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226211-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,infradead.org:email,linaro.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D15A72AE6AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
index 791d60f97c23e..df7b7e70c19fe 100644
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
@@ -137,8 +138,10 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
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




