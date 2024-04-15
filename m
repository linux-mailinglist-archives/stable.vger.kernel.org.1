Return-Path: <stable+bounces-39589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D28A5379
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C35AB21AFC
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C347F7F5;
	Mon, 15 Apr 2024 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mL9qH/28"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A287F7EF;
	Mon, 15 Apr 2024 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191215; cv=none; b=K/kafKyMOgpPfU5/twL0yWm8mBtaU6BcpbW9GPVGpJYJgI84VfJmU8vZhx1Lg3lddYIHm13oQvagJuqKPq8/Szv4h79Qez8xuzE46T60zscaaWtiVf0Prqfg+imEDSYWxHcatvXUsOPc358OXx7pKJ9o46fhbCjDAFkepvTk4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191215; c=relaxed/simple;
	bh=g//tdNvOBVsv6iHkNxWofXTX5dXDuOYvWYM387YWgZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM4wU/dGLcFqJlvmpUUhwEpdLtgK13aa4Z4/HMd5zlC4KiDjVnvNwB8wM7K0Ihmk0OPrAMvQ5FTH4Qy8G5CRav0rlVjzI+k83p3ePRZa823jpSATnNVguhxVUCJN/ZBcD4R0JtUfpuoXKk3+Rnyhoy1mcYFEcOE9IZ09ZgFVrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mL9qH/28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E14C4AF07;
	Mon, 15 Apr 2024 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191215;
	bh=g//tdNvOBVsv6iHkNxWofXTX5dXDuOYvWYM387YWgZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mL9qH/28uMPPL+9JwePAefG/pfS6YjkAb4y4ovKBp+23trqJ3GIkC7t4LttemBsVS
	 E/xAchYSqvjVOsXt9pbshh+UCPWoGK3ZOih2QTJsEaYME1gCXUth00vm0V/hKtMPhr
	 FKE4bNKvpPiZLAbPvfMIs0w9II75QxlgkEECDclA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 070/172] pds_core: Fix pdsc_check_pci_health function to use work thread
Date: Mon, 15 Apr 2024 16:19:29 +0200
Message-ID: <20240415142002.535640928@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brett Creeley <brett.creeley@amd.com>

[ Upstream commit 81665adf25d28a00a986533f1d3a5df76b79cad9 ]

When the driver notices fw_status == 0xff it tries to perform a PCI
reset on itself via pci_reset_function() in the context of the driver's
health thread. However, pdsc_reset_prepare calls
pdsc_stop_health_thread(), which attempts to stop/flush the health
thread. This results in a deadlock because the stop/flush will never
complete since the driver called pci_reset_function() from the health
thread context. Fix by changing the pdsc_check_pci_health_function()
to queue a newly introduced pdsc_pci_reset_thread() on the pdsc's
work queue.

Unloading the driver in the fw_down/dead state uncovered another issue,
which can be seen in the following trace:

WARNING: CPU: 51 PID: 6914 at kernel/workqueue.c:1450 __queue_work+0x358/0x440
[...]
RIP: 0010:__queue_work+0x358/0x440
[...]
Call Trace:
 <TASK>
 ? __warn+0x85/0x140
 ? __queue_work+0x358/0x440
 ? report_bug+0xfc/0x1e0
 ? handle_bug+0x3f/0x70
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __queue_work+0x358/0x440
 queue_work_on+0x28/0x30
 pdsc_devcmd_locked+0x96/0xe0 [pds_core]
 pdsc_devcmd_reset+0x71/0xb0 [pds_core]
 pdsc_teardown+0x51/0xe0 [pds_core]
 pdsc_remove+0x106/0x200 [pds_core]
 pci_device_remove+0x37/0xc0
 device_release_driver_internal+0xae/0x140
 driver_detach+0x48/0x90
 bus_remove_driver+0x6d/0xf0
 pci_unregister_driver+0x2e/0xa0
 pdsc_cleanup_module+0x10/0x780 [pds_core]
 __x64_sys_delete_module+0x142/0x2b0
 ? syscall_trace_enter.isra.18+0x126/0x1a0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7fbd9d03a14b
[...]

Fix this by preventing the devcmd reset if the FW is not running.

Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/core.c | 13 ++++++++++++-
 drivers/net/ethernet/amd/pds_core/core.h |  2 ++
 drivers/net/ethernet/amd/pds_core/dev.c  |  3 +++
 drivers/net/ethernet/amd/pds_core/main.c |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 0d148795a8d09..dd4f0965bbe64 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -595,6 +595,16 @@ void pdsc_fw_up(struct pdsc *pdsc)
 	pdsc_teardown(pdsc, PDSC_TEARDOWN_RECOVERY);
 }
 
+void pdsc_pci_reset_thread(struct work_struct *work)
+{
+	struct pdsc *pdsc = container_of(work, struct pdsc, pci_reset_work);
+	struct pci_dev *pdev = pdsc->pdev;
+
+	pci_dev_get(pdev);
+	pci_reset_function(pdev);
+	pci_dev_put(pdev);
+}
+
 static void pdsc_check_pci_health(struct pdsc *pdsc)
 {
 	u8 fw_status;
@@ -609,7 +619,8 @@ static void pdsc_check_pci_health(struct pdsc *pdsc)
 	if (fw_status != PDS_RC_BAD_PCI)
 		return;
 
-	pci_reset_function(pdsc->pdev);
+	/* prevent deadlock between pdsc_reset_prepare and pdsc_health_thread */
+	queue_work(pdsc->wq, &pdsc->pci_reset_work);
 }
 
 void pdsc_health_thread(struct work_struct *work)
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index f410f7d132056..401ff56eba0dc 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -197,6 +197,7 @@ struct pdsc {
 	struct pdsc_qcq notifyqcq;
 	u64 last_eid;
 	struct pdsc_viftype *viftype_status;
+	struct work_struct pci_reset_work;
 };
 
 /** enum pds_core_dbell_bits - bitwise composition of dbell values.
@@ -312,5 +313,6 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 
 void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
+void pdsc_pci_reset_thread(struct work_struct *work);
 
 #endif /* _PDSC_H_ */
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index e65a1632df505..bfb79c5aac391 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -229,6 +229,9 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
 		.reset.opcode = PDS_CORE_CMD_RESET,
 	};
 
+	if (!pdsc_is_fw_running(pdsc))
+		return 0;
+
 	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
 
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 345b16127fe8b..a375d612d2875 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -238,6 +238,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 	snprintf(wq_name, sizeof(wq_name), "%s.%d", PDS_CORE_DRV_NAME, pdsc->uid);
 	pdsc->wq = create_singlethread_workqueue(wq_name);
 	INIT_WORK(&pdsc->health_work, pdsc_health_thread);
+	INIT_WORK(&pdsc->pci_reset_work, pdsc_pci_reset_thread);
 	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
 	pdsc->wdtimer_period = PDSC_WATCHDOG_SECS * HZ;
 
-- 
2.43.0




