Return-Path: <stable+bounces-4746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A41805D5D
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9198C281FDB
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A968EBA;
	Tue,  5 Dec 2023 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kFtZY927"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB8141BE
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 10:29:49 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 547B120B74C1;
	Tue,  5 Dec 2023 10:29:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 547B120B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701800989;
	bh=p9QL8Kt+5UQsFI8AQQL6+xEd4o+jfXrxLwgxf2qRJFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFtZY927UcOLS++18VuUQTd0Jp/H8okYShmfcOVrZ0Z1qWebTP3shnCIqKSYenHs6
	 8D+0VDxVdGmXFxiR7K0DQuVxTR+dTJALKYDVQTrQntvfB1Ensrr+YJWRxvRMv0N/U/
	 1y07tSVWMePQUC5rr1Wk/yZqXszxxDc0xn8JRg/4=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4.14.y 2/2] selftests/ftrace: Add new test case which checks non unique symbol
Date: Tue,  5 Dec 2023 19:29:23 +0100
Message-Id: <20231205182923.128898-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205182923.128898-1-flaniel@linux.microsoft.com>
References: <20231205182923.128898-1-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 03b80ff8023adae6780e491f66e932df8165e3a0 upstream.

If name_show() is non unique, this test will try to install a kprobe on this
function which should fail returning EADDRNOTAVAIL.
On kernel where name_show() is not unique, this test is skipped.

Link: https://lore.kernel.org/all/20231020104250.9537-3-flaniel@linux.microsoft.com/

Cc: stable@vger.kernel.org
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc  | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
new file mode 100644
index 000000000000..bc9514428dba
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test failure of registering kprobe on non unique symbol
+# requires: kprobe_events
+
+SYMBOL='name_show'
+
+# We skip this test on kernel where SYMBOL is unique or does not exist.
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+	exit_unsupported
+fi
+
+! echo "p:test_non_unique ${SYMBOL}" > kprobe_events
-- 
2.34.1


