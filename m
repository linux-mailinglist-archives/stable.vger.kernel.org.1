Return-Path: <stable+bounces-224497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDoiO8IEsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:47:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A138124B89A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0461A306E6E1
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C5389471;
	Tue, 10 Mar 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="y0w5Nlfm"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D7389456;
	Tue, 10 Mar 2026 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142929; cv=none; b=kAUi1BvjVB1FViQge7bv2gPUwVtCPPWnwSohjNmQsnEQ7qbXq+zN6pMl99xio4gZyO0aA+DrkUpqjp3aZu3nrt86eK8Qr+Lfe5RIPJzT3/9Lgr2xXQLiW9GH8hxuLM1MI1xEsz2yB5noamBwEMGXBy4Sw26pm18QHYUfpTDJTZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142929; c=relaxed/simple;
	bh=QAnoyRz0gmnLJAGPIY8fQSIow5eG5Kh+mQGo4+V+S7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AjXUZj1kz09i1IyWz6yHakEhqDamcluuD8wENL5jW9tnotpVO0LCQwN3z/XCqQbTUIx8FTBR78wjHuWso2mwDQvJ1kpLa6fFzfszlmR2McNHTGFi5je8RTnRnMVoZUajm4ZA5lVyGXyubUcprDn1Jryt7UitTxRzj7gp2nhTQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=y0w5Nlfm; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A5m0dI2617699;
	Tue, 10 Mar 2026 11:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=J
	H1Puo4dopCcnA7dDBouCZddNb1m27ioTA0rbL8cDBM=; b=y0w5NlfmQ18FxOMpf
	mP2njAIsVVZs/pdR2N4JnubBjEs+/A17weBrD71H5l8wP4S1pwDoWd70plp3K7Dt
	XQ03r/LzPd/8h3oQj9kFMNUEFjfCr0TGru2DiU7wHBjD4APH5lDN5Ume0Ewkc2ok
	G/LleDOIY5vKYugqKGXVnp3SgMqKUkzqPR11xZuuPEtYReKgyFdI1iqSpx1x78kC
	t+gix7xwbtegANeElVXkVTCa200dYBQN0ebJuUBLIXU/aVXX1uSaOY7gQtdi5KRB
	a4SdYJivJt1AXumAz+wPEPt5BpQB+dZQqcL/xrWWrcth40xbVv8jd2BNQ2gngUGJ
	psxUA==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4ct3kr8q36-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 11:41:40 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.8.171) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 11:41:39 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Tue, 10 Mar 2026 11:41:11 +0000
Subject: [PATCH 1/2] drm/imagination: Synchronize interrupts before
 suspending the GPU
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260310-drain-irqs-before-suspend-v1-1-bf4f9ed68e75@imgtec.com>
References: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
In-Reply-To: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        Brajesh Gupta <brajesh.gupta@imgtec.com>,
        "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Alessio Belle" <alessio.belle@imgtec.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773142899; l=6749;
 i=alessio.belle@imgtec.com; s=20251208; h=from:subject:message-id;
 bh=QAnoyRz0gmnLJAGPIY8fQSIow5eG5Kh+mQGo4+V+S7Y=;
 b=pPG6vnd0vb+M3Jqvgr1usnsmqWbrd3Shfr59td0dbwz2IqZGThmE2VMElPioFkkcjPoeSAIBa
 ee+ijVOzCBfAbKT+tVth/um07lGREdzJIpc5YwaBMfstXojlHyhpUxd
X-Developer-Key: i=alessio.belle@imgtec.com; a=ed25519;
 pk=2Vtuk+GKBRjwMqIHpKk+Gx6zl7cgtq0joszcOc0zF4g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwMSBTYWx0ZWRfX53kFoKV+rUSs
 iTKehPjVgJPDwJ30ruhaelNXezEjEyMfbS0Chr/5Bjw1QzQPa87Cx+nS2QOAivmPEDKUn9Co5bQ
 5FizCsYJfDIfOh6woGFOxh5n+Haia8roYySxZSDc/Bv/ldGW8dOLTmED0L+VnS8pXRSLBaKuCDV
 ASEGXykENW8VkXLLBzJZeuV5TgHKOohRY4+2Qk8DEJ2xJB2Un2lVIkD7HDOKalToK9y0Lc/SnyE
 QapUc33jUseGyz/ju6iI+E3u5uCq4izqappRC7iY1oZWmsqHiRGqgr9sKmIKiOLsFfwjE134Rye
 oXPdLjm5IxcwBHMhuvMXM/FsvXynlEuOjC444RvtMLd7I2vRTn48ZvgPhncjBSt6EviIY3H5g99
 ufFP1E99jwmLy5VHaBC3Ok074ti+Cx+DbeMFghFu6qigtFHvFDUkPDvE3yT85Ul35Ss/34frkyM
 vZU5v6IB4wW4UmeWlTw==
X-Proofpoint-GUID: EUQXzVcL-aGn0pU2ZCdtEX4JsJZaYyLh
X-Proofpoint-ORIG-GUID: EUQXzVcL-aGn0pU2ZCdtEX4JsJZaYyLh
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=69b00374 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Rd4DrVCMV_EA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=QeTBfRgPLbvQabU-eysA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Rspamd-Queue-Id: A138124B89A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-224497-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[imgtec.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.belle@imgtec.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,imgtec.com:dkim,imgtec.com:email,imgtec.com:mid]
X-Rspamd-Action: no action

The runtime PM suspend callback doesn't know whether the IRQ handler is
in progress on a different CPU core and doesn't wait for it to finish.

Depending on timing, the IRQ handler could be running while the GPU is
suspended, leading to kernel crashes when trying to access GPU
registers. See example signature below.

In a power off sequence initiated by the runtime PM suspend callback,
wait for any IRQ handlers in progress on other CPU cores to finish, by
calling synchronize_irq().

At the same time, remove the runtime PM resume/put calls in the threaded
IRQ handler. On top of not being the right approach to begin with, and
being at the wrong place as they should have wrapped all GPU register
accesses, the driver would hit a deadlock between synchronize_irq()
being called from a runtime PM suspend callback, holding the device
power lock, and the resume callback requiring the same.

Example crash signature on a TI AM68 SK platform:

  [  337.241218] SError Interrupt on CPU0, code 0x00000000bf000000 -- SError
  [  337.241239] CPU: 0 UID: 0 PID: 112 Comm: irq/234-gpu Tainted: G   M                6.17.7-B2C-00005-g9c7bbe4ea16c #2 PREEMPT
  [  337.241246] Tainted: [M]=MACHINE_CHECK
  [  337.241249] Hardware name: Texas Instruments AM68 SK (DT)
  [  337.241252] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [  337.241256] pc : pvr_riscv_irq_pending+0xc/0x24
  [  337.241277] lr : pvr_device_irq_thread_handler+0x64/0x310
  [  337.241282] sp : ffff800085b0bd30
  [  337.241284] x29: ffff800085b0bd50 x28: ffff0008070d9eab x27: ffff800083a5ce10
  [  337.241291] x26: ffff000806e48f80 x25: ffff0008070d9eac x24: 0000000000000000
  [  337.241296] x23: ffff0008068e9bf0 x22: ffff0008068e9bd0 x21: ffff800085b0bd30
  [  337.241301] x20: ffff0008070d9e00 x19: ffff0008068e9000 x18: 0000000000000001
  [  337.241305] x17: 637365645f656c70 x16: 0000000000000000 x15: ffff000b7df9ff40
  [  337.241310] x14: 0000a585fe3c0d0e x13: 000000999704f060 x12: 000000000002771a
  [  337.241314] x11: 00000000000000c0 x10: 0000000000000af0 x9 : ffff800085b0bd00
  [  337.241318] x8 : ffff0008071175d0 x7 : 000000000000b955 x6 : 0000000000000003
  [  337.241323] x5 : 0000000000000000 x4 : 0000000000000002 x3 : 0000000000000000
  [  337.241327] x2 : ffff800080e39d20 x1 : ffff800080e3fc48 x0 : 0000000000000000
  [  337.241333] Kernel panic - not syncing: Asynchronous SError Interrupt
  [  337.241337] CPU: 0 UID: 0 PID: 112 Comm: irq/234-gpu Tainted: G   M                6.17.7-B2C-00005-g9c7bbe4ea16c #2 PREEMPT
  [  337.241342] Tainted: [M]=MACHINE_CHECK
  [  337.241343] Hardware name: Texas Instruments AM68 SK (DT)
  [  337.241345] Call trace:
  [  337.241348]  show_stack+0x18/0x24 (C)
  [  337.241357]  dump_stack_lvl+0x60/0x80
  [  337.241364]  dump_stack+0x18/0x24
  [  337.241368]  vpanic+0x124/0x2ec
  [  337.241373]  abort+0x0/0x4
  [  337.241377]  add_taint+0x0/0xbc
  [  337.241384]  arm64_serror_panic+0x70/0x80
  [  337.241389]  do_serror+0x3c/0x74
  [  337.241392]  el1h_64_error_handler+0x30/0x48
  [  337.241400]  el1h_64_error+0x6c/0x70
  [  337.241404]  pvr_riscv_irq_pending+0xc/0x24 (P)
  [  337.241410]  irq_thread_fn+0x2c/0xb0
  [  337.241416]  irq_thread+0x170/0x334
  [  337.241421]  kthread+0x12c/0x210
  [  337.241428]  ret_from_fork+0x10/0x20
  [  337.241434] SMP: stopping secondary CPUs
  [  337.241451] Kernel Offset: disabled
  [  337.241453] CPU features: 0x040000,02002800,20002001,0400421b
  [  337.241456] Memory Limit: none
  [  337.457921] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Fixes: 96822d38ff57 ("drm/imagination: Handle Rogue safety event IRQs")
Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for < 6.16
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>

---

96822d38ff57 only appeared in 6.16, so the change in pvr_device.c
isn't needed before that, but the rest of the fix is applicable to
earlier stable branches which contain cc1aeedb98ad.
---
 drivers/gpu/drm/imagination/pvr_device.c | 17 -----------------
 drivers/gpu/drm/imagination/pvr_power.c  | 11 ++++++++---
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index f58bb66a6327..dbb6f5a8ded1 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -225,29 +225,12 @@ static irqreturn_t pvr_device_irq_thread_handler(int irq, void *data)
 	}
 
 	if (pvr_dev->has_safety_events) {
-		int err;
-
-		/*
-		 * Ensure the GPU is powered on since some safety events (such
-		 * as ECC faults) can happen outside of job submissions, which
-		 * are otherwise the only time a power reference is held.
-		 */
-		err = pvr_power_get(pvr_dev);
-		if (err) {
-			drm_err_ratelimited(drm_dev,
-					    "%s: could not take power reference (%d)\n",
-					    __func__, err);
-			return ret;
-		}
-
 		while (pvr_device_safety_irq_pending(pvr_dev)) {
 			pvr_device_safety_irq_clear(pvr_dev);
 			pvr_device_handle_safety_events(pvr_dev);
 
 			ret = IRQ_HANDLED;
 		}
-
-		pvr_power_put(pvr_dev);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index 7a8765c0c1ed..f50cdea30680 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -90,7 +90,7 @@ pvr_power_request_pwr_off(struct pvr_device *pvr_dev)
 }
 
 static int
-pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset)
+pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspend)
 {
 	if (!hard_reset) {
 		int err;
@@ -106,6 +106,11 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset)
 			return err;
 	}
 
+	if (rpm_suspend) {
+		/* Wait for late processing of GPU or firmware IRQs in other cores */
+		synchronize_irq(pvr_dev->irq);
+	}
+
 	return pvr_fw_stop(pvr_dev);
 }
 
@@ -361,7 +366,7 @@ pvr_power_device_suspend(struct device *dev)
 		return -EIO;
 
 	if (pvr_dev->fw_dev.booted) {
-		err = pvr_power_fw_disable(pvr_dev, false);
+		err = pvr_power_fw_disable(pvr_dev, false, true);
 		if (err)
 			goto err_drm_dev_exit;
 	}
@@ -518,7 +523,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 			queues_disabled = true;
 		}
 
-		err = pvr_power_fw_disable(pvr_dev, hard_reset);
+		err = pvr_power_fw_disable(pvr_dev, hard_reset, false);
 		if (!err) {
 			if (hard_reset) {
 				pvr_dev->fw_dev.booted = false;

-- 
2.43.0


