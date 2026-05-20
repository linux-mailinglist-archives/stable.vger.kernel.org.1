Return-Path: <stable+bounces-250729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFCeFg/3DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:01:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A66595221
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E3537FFF67
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FB73D3CE5;
	Wed, 20 May 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0PCo8xa+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D073F20F0;
	Wed, 20 May 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296164; cv=none; b=bfRt292d6jjwUHaw/4Xh9bHzK2lHJ/7QiaEDaJBFuh4FVhzFAO8J2OCC+RQ4/SVVCjnxf/8kbbwkDdlURKWJuDYA/Tu5nAoQibjobo5nqjIOA2km7HzesI3kYluJUTzGsB6t+deOxsVjzaGW9XFFZVzhOqw5rCRQ0EWorVUcMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296164; c=relaxed/simple;
	bh=Ossh9XSNJKRyQcYQoWgR6xXHnHQ4L0j1u91iqarSPAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX2n1d1CK/8Z3undoY1l5caqspXo5jOy0Sk8xf+fVgU5mqsKeQfzS4Pvquebbm1CX+tL0xn97aDMGSQsMRajqH+9MRpdL5NZ1iLFo96WmXTzTkh0rKNIF90cnCpMu8pIxuB3gb9+tJf864bpS9F8Woagyw2RmASEUpJtEnqMxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0PCo8xa+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D0E1F000E9;
	Wed, 20 May 2026 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296163;
	bh=/ISppEt1hyd7zGPi8pYb/Ih5FciaJwLBmeKGqPcOdDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0PCo8xa++9omXgmMugHVncVBWljYXy3G1wCJDoiIBhZsKS2HBtTj4BR/NYs/03kxD
	 l10PcWFKeYsxHgi0F7Ony8rVtVtbrJgi/BcwI94FdF3Yuu4+74V1NxmVTCnOELyS6l
	 QrAm5b3bmWOdZN9zersKJyDYAzV/PG05TtTqyeGI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0655/1146] perf util: Kill die() prototype, dead for a long time
Date: Wed, 20 May 2026 18:15:05 +0200
Message-ID: <20260520162203.006331776@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250729-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D5A66595221
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit e5cce1b9c82fbd48e2f1f7a25a9fad8ee228176f ]

In fef2a735167a827a ("perf tools: Kill die()") the die() function was
removed, but not the prototype in util.h, now when building with
LIBPERL=1, during a 'make -C tools/perf build-test' routine test, it is
failing as perl likes die() calls and then this clashes with this
remnant, remove it.

Fixes: fef2a735167a827a ("perf tools: Kill die()")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 394dbfa944ac7..e935438451b81 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -30,7 +30,6 @@ extern bool perf_guest;
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
-void die(const char *err, ...) __noreturn __printf(1, 2);
 
 struct dirent;
 struct strlist;
-- 
2.53.0




