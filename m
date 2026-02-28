Return-Path: <stable+bounces-220098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rFVqAI0oo2k++AQAu9opvQ
	(envelope-from <stable+bounces-220098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CC1C502E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 487F23125DAE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42DF392811;
	Sat, 28 Feb 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDjaMBNZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502E36F40A;
	Sat, 28 Feb 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300003; cv=none; b=isv5JbV06NTyPY3hb7yCcpDDVHBimKqJ+73JfA5Jbt+6SekhR7n5oCYAitIdZu+PSRQXrguyMi3gxbmA+FvSbe0CjDY04QI3WTGJAk3NdUE4w4o+DLn13YsTyYD/SShNFOXrNJIMvV9dkt3xK/MyR91HZRqQQsuIyJdIr5iJT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300003; c=relaxed/simple;
	bh=YS4ql6IaG0Yax69ihYE0M0rLl2ObJX9geCS7pWfRBR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dey+OhUmX2LdRQu5VRi7UwYwPeQxApfzFJobhLx0BMCFzvmGKveTvp1vRqLJ2umzxjA+rSJs2zLODyhrmepzze5I9aoDpR97Y19k9AjhyJlHr9Wf/UotiA9GiBI4gUkLhEaiL+Q2tZ9aGaznday0J83w2g43B7CUCnKuyI/7jD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDjaMBNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04945C2BCB0;
	Sat, 28 Feb 2026 17:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300003;
	bh=YS4ql6IaG0Yax69ihYE0M0rLl2ObJX9geCS7pWfRBR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDjaMBNZzh4f+lS/VU63ytjjUxw0aV6ndD2g7NzdP5vxeSxZkawFAF9l2hgev5Uyw
	 0PBFnsZU7rg3so2BYLuyBM264LZX+D1aWx1osdeFyU5CsyxQJmyje1ai4RYjv8p5S9
	 4l+GKwneLmI5BYcCO6/RRtPljR1rWOB+WOpV9x+qa3HuNJ+zs3R9QB80z/0AAVyvAG
	 1n99BQFIduUqz8k3O+7iZKwoMSojEb7SNsyxnhx5Vg6fxABZlngLICbGN59cxLC1PI
	 7iDZSBz+RhhCzCbYR0+NrYJEeDXUKxV5x2AAfqm6yNhR/0YOAHExfcGZVppdSw2pHm
	 xU6AOgWLEeFEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 020/844] tools headers: Go back to include asm-generic/unistd.h for arm64
Date: Sat, 28 Feb 2026 12:18:53 -0500
Message-ID: <20260228173244.1509663-21-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220098-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email,arm.com:email,intel.com:email,gnu.org:url,linaro.org:email]
X-Rspamd-Queue-Id: 9F6CC1C502E
X-Rspamd-Action: no action

From: Leo Yan <leo.yan@arm.com>

[ Upstream commit 096b86ce08332fbcb0ec6ff6714c44899ec03970 ]

The header unistd.h is included under Arm64's uAPI folder (see
tools/arch/arm64/include/uapi/asm/), but it does not include its
dependent header unistd_64.h.

The intention is for unistd_64.h to be generated dynamically using
scripts/Makefile.asm-headers.

However, this dynamic approach causes problems because the header is not
available early enough, even though it is widely included throughout
tools.

Using the perf build as an example:

 1) Feature detection: Perf first runs feature tests.

    The BPF feature program test-bpf.c includes unistd.h.  Since
    unistd_64.h has not been generated yet, the program fails to build,
    and the BPF feature ends up being disabled.

 2) libperf build:

    The libperf Makefile later generates unistd_64.h on the fly, so
    libperf itself builds successfully.

 3) Final perf build:

    Although the perf binary can build successfully using the generated
    header, we never get a chance to build BPF skeleton programs,
    because BPF support was already disabled earlier.

Restore to include asm-generic/unistd.h for fixing the issue.  This
aligns with most architectures (x86 is a special case that keeps
unistd_32.h/unistd_64.h for its particular syscall numbers) and ensures
the header is available from the start.

Fixes: 22f72088ffe69a37 ("tools headers: Update the syscall table with the kernel sources")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/arch/arm64/include/uapi/asm/unistd.h | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index df36f23876e86..9306726337fe0 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -1,2 +1,24 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm/unistd_64.h>
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_MEMFD_SECRET
+
+#include <asm-generic/unistd.h>
-- 
2.51.0


