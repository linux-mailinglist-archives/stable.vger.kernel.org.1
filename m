Return-Path: <stable+bounces-220790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEFQNbVXo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:01:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2441C8B47
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02BA331BE2E9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F740C7B4;
	Sat, 28 Feb 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZFtSF7a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464D40C7AD;
	Sat, 28 Feb 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300674; cv=none; b=s/mvLrckvAKAsuU8RiPnWixC4xDiaKsYh7b7EAUtZ2sIGXyXE962EMct0jqbxXRyQORWOfK+kJuY1u4bH6bgXgylf085TV2hmACTTXDA19YdDtv2QInBw8jDmoTonognG94t44Rn58Y5NL5WhRgFXcAYOd1W8JZ7iuUuova9fYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300674; c=relaxed/simple;
	bh=jvUAgPlhKfZajov5c17TsQrh8cTqBVWq5FQ3TlPoW/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPK6i2MAVM8maoiUNTi5oM3Fceu63uBjyRq2wnYhSUPlbxk6bRCVeMGyaEseDxn35T+Ks3SKI6+974TJMZQE/r0/kPb+Xyi3jIoSFU+4V4mevZMFBHDt+jFlmfNgSaQPkWFjlRNpd/1yuIuhd7Dxenp4RkFggiV5D8HIxdB+haQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZFtSF7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704E9C19425;
	Sat, 28 Feb 2026 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300674;
	bh=jvUAgPlhKfZajov5c17TsQrh8cTqBVWq5FQ3TlPoW/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZFtSF7a3A2E3J2OzLxqprzWPwMdlFFnEoRP+zZ2b9j0E5HH5Cas/BIV6GxO38m5S
	 M3lPgk7ERDyTtplniitr6SD68zBUi5aIvRJJJb6jJH+hdiwuXvZ3vUC3Zl7Z0x/Qa4
	 /73bxq1Ihduj5E958tnIBD50uhEA02ew7LwZoccw0ARS82xpQXA93aTt1T8hjkD5f5
	 jrxtEJkyXy0jd4QERrlvVuxMFVrB/p0H3tevR/78NKP5MlrAod8tJaXzkgpKgiDZy+
	 FiRDcK1u70q7uV2WDrvPUbh5PcJgDbAgoxD0gq7eIwQilp5D1c+3bNNpbZ9G5YLJTf
	 cN05tizIpJI5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 711/844] ACPI: APEI: GHES: Add helper for CPER CXL protocol errors checks
Date: Sat, 28 Feb 2026 12:30:24 -0500
Message-ID: <20260228173244.1509663-712-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220790-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 3B2441C8B47
X-Rspamd-Action: no action

From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>

[ Upstream commit 70205869686212eb8e4cddf02bf87fd5fd597bc2 ]

Move the CPER CXL protocol errors validity check out of
cxl_cper_post_prot_err() to new cxl_cper_sec_prot_err_valid() and limit
the serial number check only to CXL agents that are CXL devices (UEFI
v2.10, Appendix N.2.13).

Export the new symbol for reuse by ELOG.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
[ rjw: Subject tweak ]
Link: https://patch.msgid.link/20260114101543.85926-4-fabio.m.de.francesco@linux.intel.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: b584bfbd7ec4 ("ACPI: APEI: GHES: Disable KASAN instrumentation when compile testing with clang < 18")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/Makefile       |  1 +
 drivers/acpi/apei/ghes.c         | 18 +----------------
 drivers/acpi/apei/ghes_helpers.c | 33 ++++++++++++++++++++++++++++++++
 include/cxl/event.h              | 10 ++++++++++
 4 files changed, 45 insertions(+), 17 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes_helpers.c

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 2c474e6477e12..5db61dfb46915 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
+obj-$(CONFIG_ACPI_APEI_PCIEAER)	+= ghes_helpers.o
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
 einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 77ea7a5b761f1..9919c31e42c07 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -741,24 +741,8 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	struct cxl_cper_prot_err_work_data wd;
 	u8 *dvsec_start, *cap_start;
 
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
-		pr_err_ratelimited("CXL CPER invalid agent type\n");
+	if (cxl_cper_sec_prot_err_valid(prot_err))
 		return;
-	}
-
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
-		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
-		return;
-	}
-
-	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
-		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
-				   prot_err->err_len);
-		return;
-	}
-
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
-		pr_warn(FW_WARN "CXL CPER no device serial number\n");
 
 	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_helpers.c
new file mode 100644
index 0000000000000..f3d162139a974
--- /dev/null
+++ b/drivers/acpi/apei/ghes_helpers.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2025 Intel Corporation. All rights reserved
+
+#include <linux/printk.h>
+#include <cxl/event.h>
+
+int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
+{
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
+		pr_err_ratelimited("CXL CPER invalid agent type\n");
+		return -EINVAL;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
+		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
+		return -EINVAL;
+	}
+
+	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
+		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
+				   prot_err->err_len);
+		return -EINVAL;
+	}
+
+	if ((prot_err->agent_type == RCD || prot_err->agent_type == DEVICE ||
+	     prot_err->agent_type == LD || prot_err->agent_type == FMLD) &&
+	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
+		pr_warn_ratelimited(FW_WARN
+				    "CXL CPER no device serial number\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 6fd90f9cc2034..4d7d1036ea9cb 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -320,4 +320,14 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
 }
 #endif
 
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
+#else
+static inline int
+cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.51.0


