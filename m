Return-Path: <stable+bounces-211328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULn6I0zqcmmvrAAAu9opvQ
	(envelope-from <stable+bounces-211328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 04:26:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A44700A5
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 04:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0EDE300405C
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 03:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA234AAFB;
	Fri, 23 Jan 2026 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ItVOQlMX"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650D35E544
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138753; cv=none; b=VNimQHU4Tq++TQYXsrS9GhOEwTHyYheKBUOtOmBBG9H6rPo1N7jgrloy6BLvHyaWJamoHS3WJCUA0Ljv03iErCz8Ik50rPMccpDBXdn4u9erA1A0xPtlfO2MDBQoGQtJ4XvlZ835OK+rk6Nv+EK7TtjwF/LNb/3krsxgbG/ia3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138753; c=relaxed/simple;
	bh=m8JVYgbmYgVWIOjce/bEalEWCWSN4CBKiG5WSvfGgoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9tf5YnzLShryoqOrjTZSc5CTgynXC95vzZWbZdbysFNDCo8AIdCmbUcz6t25zPms/W1P2ivtkrSqvdSAwPtGKUDSQyXUhojiudD+sBXuJf8i08UXsh51pLmz4sm5AzN9Z6cwNd+jrBlfw5dMO1vC/4MVWepoQCkNkpm5BZ9d3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ItVOQlMX; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TG
	ZI/lkqQ4xEkJWcUR8v9k46LSY4lAujL+1FmgQNr20=; b=ItVOQlMXY01yS2pK9J
	IknL9K4LjlRmBbOVfcMXPFju2Di0eCZcC/kbz8ZzgtlMMJZismaaQ1mADtjxpCVh
	BmnvUL1kaF5/uC2G4ejPzTInxpYE/GmKu4L8OKGLIy1EHQ19yet37nRlh15o9+Re
	CO8zX+xSzzqnsUffyq832Q5Co=
Received: from ubuntu24.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAn4ybt6XJpYQ_GHw--.36820S4;
	Fri, 23 Jan 2026 11:24:47 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] crypto: qat - flush misc workqueue during device shutdown
Date: Fri, 23 Jan 2026 03:24:22 +0000
Message-ID: <20260123032422.4202-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn4ybt6XJpYQ_GHw--.36820S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWkGrWxJFWxCrWUJw13Arb_yoWrXrWDpF
	W5tayxArWUJrZrWF4UXw4rZa45Wa90ga45KFyUG3sY9wsFyFyrAw4Ska47JF98Cr1kWFnI
	vFWFyw1jqF1UJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pujgn5UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6x+weWly6f-N+wAA3G
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211328-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[intel.com,gondor.apana.org.au,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,apana.org.au:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73A44700A5
X-Rspamd-Action: no action

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 3d4df408ba9bad2b205c7fb8afc1836a6a4ca88a ]

Repeated loading and unloading of a device specific QAT driver, for
example qat_4xxx, in a tight loop can lead to a crash due to a
use-after-free scenario. This occurs when a power management (PM)
interrupt triggers just before the device-specific driver (e.g.,
qat_4xxx.ko) is unloaded, while the core driver (intel_qat.ko) remains
loaded.

Since the driver uses a shared workqueue (`qat_misc_wq`) across all
devices and owned by intel_qat.ko, a deferred routine from the
device-specific driver may still be pending in the queue. If this
routine executes after the driver is unloaded, it can dereference freed
memory, resulting in a page fault and kernel crash like the following:

    BUG: unable to handle page fault for address: ffa000002e50a01c
    #PF: supervisor read access in kernel mode
    RIP: 0010:pm_bh_handler+0x1d2/0x250 [intel_qat]
    Call Trace:
      pm_bh_handler+0x1d2/0x250 [intel_qat]
      process_one_work+0x171/0x340
      worker_thread+0x277/0x3a0
      kthread+0xf0/0x120
      ret_from_fork+0x2d/0x50

To prevent this, flush the misc workqueue during device shutdown to
ensure that all pending work items are completed before the driver is
unloaded.

Note: This approach may slightly increase shutdown latency if the
workqueue contains jobs from other devices, but it ensures correctness
and stability.

Fixes: e5745f34113b ("crypto: qat - enable power management for QAT GEN4")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ Intel crypto drivers was moved by
  a4b16dad4657 ("crypto: qat - Move driver to drivers/crypto/intel/qat")
  so apply the patch to files under drivers/crypto/qat/qat_common in
  6.1.y. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/crypto/qat/qat_common/adf_common_drv.h | 1 +
 drivers/crypto/qat/qat_common/adf_init.c       | 1 +
 drivers/crypto/qat/qat_common/adf_isr.c        | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index d2bc2361cd06..86aebe07db44 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -194,6 +194,7 @@ int qat_uclo_set_cfg_ae_mask(struct icp_qat_fw_loader_handle *handle,
 int adf_init_misc_wq(void);
 void adf_exit_misc_wq(void);
 bool adf_misc_wq_queue_work(struct work_struct *work);
+void adf_misc_wq_flush(void);
 #if defined(CONFIG_PCI_IOV)
 int adf_sriov_configure(struct pci_dev *pdev, int numvfs);
 void adf_disable_sriov(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_init.c b/drivers/crypto/qat/qat_common/adf_init.c
index 49f07584f8c9..9d54dc3beafd 100644
--- a/drivers/crypto/qat/qat_common/adf_init.c
+++ b/drivers/crypto/qat/qat_common/adf_init.c
@@ -337,6 +337,7 @@ void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 		hw_data->exit_admin_comms(accel_dev);
 
 	adf_cleanup_etr_data(accel_dev);
+	adf_misc_wq_flush();
 	adf_dev_restore(accel_dev);
 }
 EXPORT_SYMBOL_GPL(adf_dev_shutdown);
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index ad9e135b8560..e41ae70d69ed 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -380,3 +380,8 @@ bool adf_misc_wq_queue_work(struct work_struct *work)
 {
 	return queue_work(adf_misc_wq, work);
 }
+
+void adf_misc_wq_flush(void)
+{
+	flush_workqueue(adf_misc_wq);
+}
-- 
2.43.0


