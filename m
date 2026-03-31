Return-Path: <stable+bounces-231649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOACNUP5y2lENAYAu9opvQ
	(envelope-from <stable+bounces-231649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:41:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9536CFB8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D91F32BF497
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D69423172;
	Tue, 31 Mar 2026 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XnfE8z3+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A53E3C5C;
	Tue, 31 Mar 2026 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974711; cv=none; b=IqiOilKLLmQF6NZfhYIg/IjV3bJDAVVTPlLRVKacJM9tqhk4u00l3pfZAHrWJBXdI7CaMHtNH8jmE6dhxX8nlHv8vd+2u5w5QRqGm6QggfXg0XVwjWv16D8MejkNKPWSNeQWGZFR8ntFzPN8l5VDJqvyvkCuMaDm+s/Na84Si7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974711; c=relaxed/simple;
	bh=EK0aqCrqMNxXjbfwnSbeS646kZWIco34/2B6QKSfBqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+QCprCNlR5Bz9DVjAFvx+CjY9sP+wakzkwITzVpxreqzRxyhYYWzXVHTu13eoumVOaPeLXFoipsNaNmD5O5FmWJzuAmplhlwNF7zgu1ypPRzCOp4mTJ9KSUV6XXrRI/X87Y01IUyJD5juQBQoTSLUSd2ulDnZ3PfAPToJ7aFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XnfE8z3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98715C19423;
	Tue, 31 Mar 2026 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974710;
	bh=EK0aqCrqMNxXjbfwnSbeS646kZWIco34/2B6QKSfBqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnfE8z3+WKfjohopJYUISozQ2BzNHBot3whZIF/f32J7o9nHwm/tfpDCcgp3zidRw
	 X3Fq4w1uizPOlyOWcl1o8cuJvpd6i9BTyoVC1WqjkqXJZvzUBTbDG+w5mswDScLTyD
	 esQps+yf15j5TNwsIfyZJryslFbkUrx88hUysm4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 015/342] perf metricgroup: Fix metricgroup__has_metric_or_groups()
Date: Tue, 31 Mar 2026 18:17:28 +0200
Message-ID: <20260331161759.468675274@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231649-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 61F9536CFB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 8dd1d9a335321d0829aeb85d8e1a897248d0da29 ]

Use metricgroup__for_each_metric() rather than
pmu_metrics_table__for_each_metric() that combines the
default metric table with, a potentially empty, CPUID table.

Fixes: cee275edcdb1acfd ("perf metricgroup: Don't early exit if no CPUID table exists")
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/metricgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a21f2d4969c5c..45bb94da97b99 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1606,9 +1606,9 @@ bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_gr
 		.metric_or_groups = metric_or_groups,
 	};
 
-	return pmu_metrics_table__for_each_metric(table,
-						  metricgroup__has_metric_or_groups_callback,
-						  &data)
+	return metricgroup__for_each_metric(table,
+					    metricgroup__has_metric_or_groups_callback,
+					    &data)
 		? true : false;
 }
 
-- 
2.51.0




