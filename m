Return-Path: <stable+bounces-137924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D7BAA15E3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9A55A0FBB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435582528ED;
	Tue, 29 Apr 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FR9l6xuS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF32459EA;
	Tue, 29 Apr 2025 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947549; cv=none; b=tB4Xj/neqtGnfmRiNKy6MWKt4rrskDP+SkTIvD0PkTmYX+yeahI43Q9IsRsh5GrBrPCKOTZkVTaBJMr0m/Aqx9Z2HW00ReQQ5VBQFrlA8viJQ1K+wsTbAGql6Q72VAEe/+U2N5ABUJJCkn7B1jvMZJl11Q3aNofDEHg3JFbe4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947549; c=relaxed/simple;
	bh=728dPU9oUY1dF37oXTS23lcgiy2gaUe34PZnXGx+ns0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozqUmVAb0zsfG4fgCazufpR2jBpsWBcgiwi/896GTPVD+N8HNaRIKYnpx6a41a3HHcN5LLOdP2PXv9/Buyd8zXxoU6k2BizILWIXBC3g6H8tJdJUCnF7tvcMFR1MUIcGET61su1pf6J+Vid4+i1h94UZclpniztWc+p6w+GKbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FR9l6xuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750B3C4CEE3;
	Tue, 29 Apr 2025 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947548;
	bh=728dPU9oUY1dF37oXTS23lcgiy2gaUe34PZnXGx+ns0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FR9l6xuSdf5d05C+jbU4uA8mVcg63VEh5oJm0eVhnfCToYYTlwvlK5+jMksnysraT
	 5ba3prxkElYeSIrsRo1z3PsbDt4O+vcQaywBkod97LDpHpylYAcJSFlNWR7J672XLG
	 aKiRLnzpPb2CVo8fTlwK7XJoXM/s3tAFvgWwR0UU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Halil Pasic <pasic@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 029/280] s390/pci: Report PCI error recovery results via SCLP
Date: Tue, 29 Apr 2025 18:39:30 +0200
Message-ID: <20250429161116.296725371@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 4ec6054e7321dc24ebccaa08b3af0d590f5666e6 ]

Add a mechanism with which the status of PCI error recovery runs
is reported to the platform. Together with the status supply additional
information that may aid in problem determination.

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Stable-dep-of: aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except for ISM devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/sclp.h |  33 +++++++++++
 arch/s390/pci/Makefile       |   2 +-
 arch/s390/pci/pci_event.c    |  21 +++++--
 arch/s390/pci/pci_report.c   | 111 +++++++++++++++++++++++++++++++++++
 arch/s390/pci/pci_report.h   |  16 +++++
 drivers/s390/char/sclp.h     |  14 -----
 drivers/s390/char/sclp_pci.c |  19 ------
 7 files changed, 178 insertions(+), 38 deletions(-)
 create mode 100644 arch/s390/pci/pci_report.c
 create mode 100644 arch/s390/pci/pci_report.h

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index ad17d91ad2e66..0efd6ab4473dd 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -16,6 +16,11 @@
 /* 24 + 16 * SCLP_MAX_CORES */
 #define EXT_SCCB_READ_CPU	(3 * PAGE_SIZE)
 
+#define SCLP_ERRNOTIFY_AQ_RESET			0
+#define SCLP_ERRNOTIFY_AQ_REPAIR		1
+#define SCLP_ERRNOTIFY_AQ_INFO_LOG		2
+#define SCLP_ERRNOTIFY_AQ_OPTICS_DATA		3
+
 #ifndef __ASSEMBLY__
 #include <linux/uio.h>
 #include <asm/chpid.h>
@@ -111,6 +116,34 @@ struct sclp_info {
 };
 extern struct sclp_info sclp;
 
+struct sccb_header {
+	u16	length;
+	u8	function_code;
+	u8	control_mask[3];
+	u16	response_code;
+} __packed;
+
+struct evbuf_header {
+	u16	length;
+	u8	type;
+	u8	flags;
+	u16	_reserved;
+} __packed;
+
+struct err_notify_evbuf {
+	struct evbuf_header header;
+	u8 action;
+	u8 atype;
+	u32 fh;
+	u32 fid;
+	u8 data[];
+} __packed;
+
+struct err_notify_sccb {
+	struct sccb_header header;
+	struct err_notify_evbuf evbuf;
+} __packed;
+
 struct zpci_report_error_header {
 	u8 version;	/* Interface version byte */
 	u8 action;	/* Action qualifier byte
diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index 2c21f0394c9ab..df73c5182990a 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o \
 			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
-			   pci_bus.o pci_kvm_hook.o
+			   pci_bus.o pci_kvm_hook.o pci_report.o
 obj-$(CONFIG_PCI_IOV)	+= pci_iov.o
 obj-$(CONFIG_SYSFS)	+= pci_sysfs.o
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 7f7b732b3f3ef..7bd7721c1239a 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -16,6 +16,7 @@
 #include <asm/sclp.h>
 
 #include "pci_bus.h"
+#include "pci_report.h"
 
 /* Content Code Description for PCI Function Error */
 struct zpci_ccdf_err {
@@ -169,6 +170,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
 static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 {
 	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
+	struct zpci_dev *zdev = to_zpci(pdev);
+	char *status_str = "success";
 	struct pci_driver *driver;
 
 	/*
@@ -186,29 +189,37 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	if (is_passed_through(pdev)) {
 		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
 			pci_name(pdev));
+		status_str = "failed (pass-through)";
 		goto out_unlock;
 	}
 
 	driver = to_pci_driver(pdev->dev.driver);
 	if (!is_driver_supported(driver)) {
-		if (!driver)
+		if (!driver) {
 			pr_info("%s: Cannot be recovered because no driver is bound to the device\n",
 				pci_name(pdev));
-		else
+			status_str = "failed (no driver)";
+		} else {
 			pr_info("%s: The %s driver bound to the device does not support error recovery\n",
 				pci_name(pdev),
 				driver->name);
+			status_str = "failed (no driver support)";
+		}
 		goto out_unlock;
 	}
 
 	ers_res = zpci_event_notify_error_detected(pdev, driver);
-	if (ers_result_indicates_abort(ers_res))
+	if (ers_result_indicates_abort(ers_res)) {
+		status_str = "failed (abort on detection)";
 		goto out_unlock;
+	}
 
 	if (ers_res == PCI_ERS_RESULT_CAN_RECOVER) {
 		ers_res = zpci_event_do_error_state_clear(pdev, driver);
-		if (ers_result_indicates_abort(ers_res))
+		if (ers_result_indicates_abort(ers_res)) {
+			status_str = "failed (abort on MMIO enable)";
 			goto out_unlock;
+		}
 	}
 
 	if (ers_res == PCI_ERS_RESULT_NEED_RESET)
@@ -217,6 +228,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	if (ers_res != PCI_ERS_RESULT_RECOVERED) {
 		pr_err("%s: Automatic recovery failed; operator intervention is required\n",
 		       pci_name(pdev));
+		status_str = "failed (driver can't recover)";
 		goto out_unlock;
 	}
 
@@ -225,6 +237,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		driver->err_handler->resume(pdev);
 out_unlock:
 	pci_dev_unlock(pdev);
+	zpci_report_status(zdev, "recovery", status_str);
 
 	return ers_res;
 }
diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
new file mode 100644
index 0000000000000..2754c9c161f5b
--- /dev/null
+++ b/arch/s390/pci/pci_report.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2024
+ *
+ * Author(s):
+ *   Niklas Schnelle <schnelle@linux.ibm.com>
+ *
+ */
+
+#define KMSG_COMPONENT "zpci"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/sprintf.h>
+#include <linux/pci.h>
+
+#include <asm/sclp.h>
+
+#include "pci_report.h"
+
+#define ZPCI_ERR_LOG_ID_KERNEL_REPORT 0x4714
+
+struct zpci_report_error_data {
+	u64 timestamp;
+	u64 err_log_id;
+	char log_data[];
+} __packed;
+
+#define ZPCI_REPORT_SIZE	(PAGE_SIZE - sizeof(struct err_notify_sccb))
+#define ZPCI_REPORT_DATA_SIZE	(ZPCI_REPORT_SIZE - sizeof(struct zpci_report_error_data))
+
+struct zpci_report_error {
+	struct zpci_report_error_header header;
+	struct zpci_report_error_data data;
+} __packed;
+
+static const char *zpci_state_str(pci_channel_state_t state)
+{
+	switch (state) {
+	case pci_channel_io_normal:
+		return "normal";
+	case pci_channel_io_frozen:
+		return "frozen";
+	case pci_channel_io_perm_failure:
+		return "permanent-failure";
+	default:
+		return "invalid";
+	};
+}
+
+/**
+ * zpci_report_status - Report the status of operations on a PCI device
+ * @zdev:	The PCI device for which to report status
+ * @operation:	A string representing the operation reported
+ * @status:	A string representing the status of the operation
+ *
+ * This function creates a human readable report about an operation such as
+ * PCI device recovery and forwards this to the platform using the SCLP Write
+ * Event Data mechanism. Besides the operation and status strings the report
+ * also contains additional information about the device deemed useful for
+ * debug such as the currently bound device driver, if any, and error state.
+ *
+ * Return: 0 on success an error code < 0 otherwise.
+ */
+int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char *status)
+{
+	struct zpci_report_error *report;
+	struct pci_driver *driver = NULL;
+	struct pci_dev *pdev = NULL;
+	char *buf, *end;
+	int ret;
+
+	if (!zdev || !zdev->zbus)
+		return -ENODEV;
+
+	/* Protected virtualization hosts get nothing from us */
+	if (prot_virt_guest)
+		return -ENODATA;
+
+	report = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!report)
+		return -ENOMEM;
+	if (zdev->zbus->bus)
+		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
+	if (pdev)
+		driver = to_pci_driver(pdev->dev.driver);
+
+	buf = report->data.log_data;
+	end = report->data.log_data + ZPCI_REPORT_DATA_SIZE;
+	buf += scnprintf(buf, end - buf, "report: %s\n", operation);
+	buf += scnprintf(buf, end - buf, "status: %s\n", status);
+	buf += scnprintf(buf, end - buf, "state: %s\n",
+			 (pdev) ? zpci_state_str(pdev->error_state) : "n/a");
+	buf += scnprintf(buf, end - buf, "driver: %s\n", (driver) ? driver->name : "n/a");
+
+	report->header.version = 1;
+	report->header.action = SCLP_ERRNOTIFY_AQ_INFO_LOG;
+	report->header.length = buf - (char *)&report->data;
+	report->data.timestamp = ktime_get_clocktai_seconds();
+	report->data.err_log_id = ZPCI_ERR_LOG_ID_KERNEL_REPORT;
+
+	ret = sclp_pci_report(&report->header, zdev->fh, zdev->fid);
+	if (ret)
+		pr_err("Reporting PCI status failed with code %d\n", ret);
+	else
+		pr_info("Reported PCI device status\n");
+
+	free_page((unsigned long)report);
+
+	return ret;
+}
diff --git a/arch/s390/pci/pci_report.h b/arch/s390/pci/pci_report.h
new file mode 100644
index 0000000000000..e08003d51a972
--- /dev/null
+++ b/arch/s390/pci/pci_report.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright IBM Corp. 2024
+ *
+ * Author(s):
+ *   Niklas Schnelle <schnelle@linux.ibm.com>
+ *
+ */
+#ifndef __S390_PCI_REPORT_H
+#define __S390_PCI_REPORT_H
+
+struct zpci_dev;
+
+int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char *status);
+
+#endif /* __S390_PCI_REPORT_H */
diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index 6a23ec286c702..25fd4d8547483 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -84,13 +84,6 @@ typedef unsigned int sclp_cmdw_t;
 
 typedef u64 sccb_mask_t;
 
-struct sccb_header {
-	u16	length;
-	u8	function_code;
-	u8	control_mask[3];
-	u16	response_code;
-} __attribute__((packed));
-
 struct init_sccb {
 	struct sccb_header header;
 	u16 _reserved;
@@ -237,13 +230,6 @@ struct gds_vector {
 	u16	gds_id;
 } __attribute__((packed));
 
-struct evbuf_header {
-	u16	length;
-	u8	type;
-	u8	flags;
-	u16	_reserved;
-} __attribute__((packed));
-
 struct sclp_req {
 	struct list_head list;		/* list_head for request queueing. */
 	sclp_cmdw_t command;		/* sclp command to execute */
diff --git a/drivers/s390/char/sclp_pci.c b/drivers/s390/char/sclp_pci.c
index c3466a8c56bb5..56400886f7fca 100644
--- a/drivers/s390/char/sclp_pci.c
+++ b/drivers/s390/char/sclp_pci.c
@@ -24,30 +24,11 @@
 
 #define SCLP_ATYPE_PCI				2
 
-#define SCLP_ERRNOTIFY_AQ_RESET			0
-#define SCLP_ERRNOTIFY_AQ_REPAIR		1
-#define SCLP_ERRNOTIFY_AQ_INFO_LOG		2
-#define SCLP_ERRNOTIFY_AQ_OPTICS_DATA		3
-
 static DEFINE_MUTEX(sclp_pci_mutex);
 static struct sclp_register sclp_pci_event = {
 	.send_mask = EVTYP_ERRNOTIFY_MASK,
 };
 
-struct err_notify_evbuf {
-	struct evbuf_header header;
-	u8 action;
-	u8 atype;
-	u32 fh;
-	u32 fid;
-	u8 data[];
-} __packed;
-
-struct err_notify_sccb {
-	struct sccb_header header;
-	struct err_notify_evbuf evbuf;
-} __packed;
-
 struct pci_cfg_sccb {
 	struct sccb_header header;
 	u8 atype;		/* adapter type */
-- 
2.39.5




