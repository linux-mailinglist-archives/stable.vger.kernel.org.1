Return-Path: <stable+bounces-250659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOZbDxnwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-250659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 551AC593E19
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9295A307B641
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77C3A1E72;
	Wed, 20 May 2026 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dd25S3oQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E536A366;
	Wed, 20 May 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295986; cv=none; b=eNDG4kYL1EusYVDlmGjV0UcjG79t6kw2BiXNMoSY0AR9Ce4q/NJthWOUBdy+LIPRumcymixaMv2mSxmXYM7AZGBqWBQf5sSvfkaS5+uQS7a/OqQ+bKt4r2PWHGkXIAwVICnWWnDLiHmFFXSHWx+Eglcifm57IDln0oHVdvXyhyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295986; c=relaxed/simple;
	bh=s1eUhWfBrLe9QnDDniIi6CfQiQEL+5vKcCgGyygKAl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMtUibOWI3FB7jnG2WpEMRpcNm3jhWN0Q0dTddWjoausTq3BBw8LMKI9px1Cgyk+zmbzsM2uO7AVpl/TbPuBs4zQpw/Y732T426lWlVaKJ6PYaznXC1tw93oVMvhipZUM3YXfBqOLnzOUPbUcXoJRXEmsfhZmcGlUeVPsgVwppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dd25S3oQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8111F00893;
	Wed, 20 May 2026 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295984;
	bh=fPWbC0SYXp8Rrr69vLYBUqXl4ad8oEwD28X4am2le1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dd25S3oQzFQBDy98Xj5kj5PCh3mepNZD66YGrohlTbvXKCCb8shUXCyEYdD0Z9FAI
	 69Vom2uQ6PjYI3VzYW628/HRGQsoYyD/mmTb6L/yjnAFjsO2mgCG1LUaKqS/aL+/fU
	 j2XY1neEXK/t9r07hVk7To+/UEJqz5bzdIczsIik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0627/1146] perf test type profiling: Remote typedef on struct
Date: Wed, 20 May 2026 18:14:37 +0200
Message-ID: <20260520162202.374680652@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250659-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 551AC593E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 6910944bf0b92fea63d5a7aeed69e4b9c14fd01b ]

The typedef creates an issue where the struct or the typedef may
appear in the output and cause the "perf data type profiling tests" to
fail. Let's remove the typedef to keep the test passing.

Fixes: 335047109d7d ("perf tests: Test annotate with data type profiling and C")
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/data_type_profiling.sh | 2 +-
 tools/perf/tests/workloads/datasym.c          | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index 2a7f8f7c42d09..fb47b7213b335 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -8,7 +8,7 @@ set -e
 # data type profiling manifestation
 
 # Values in testtypes and testprogs should match
-testtypes=("# data-type: struct Buf" "# data-type: struct _buf")
+testtypes=("# data-type: struct Buf" "# data-type: struct buf")
 testprogs=("perf test -w code_with_type" "perf test -w datasym")
 
 err=0
diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
index 1d0b7d64e1ba1..19242c7255c0c 100644
--- a/tools/perf/tests/workloads/datasym.c
+++ b/tools/perf/tests/workloads/datasym.c
@@ -4,14 +4,14 @@
 #include <linux/compiler.h>
 #include "../tests.h"
 
-typedef struct _buf {
+struct buf {
 	char data1;
 	char reserved[55];
 	char data2;
-} buf __attribute__((aligned(64)));
+} __attribute__((aligned(64)));
 
 /* volatile to try to avoid the compiler seeing reserved as unused. */
-static volatile buf workload_datasym_buf1 = {
+static volatile struct buf workload_datasym_buf1 = {
 	/* to have this in the data section */
 	.reserved[0] = 1,
 };
-- 
2.53.0




