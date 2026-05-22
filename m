Return-Path: <stable+bounces-253792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEfoAkJZEGpcWgYAu9opvQ
	(envelope-from <stable+bounces-253792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:25:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A35DF5B51C6
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB47E30058F3
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94BD284881;
	Fri, 22 May 2026 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="pJk6JTWW"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B09381AFA;
	Fri, 22 May 2026 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455753; cv=none; b=u7LkSdWjD9qr7LaHfNKSgujm2/FjdU0CegOcM+k8sD5RgVkjT4cNE04I5f+K8ESa1TMFG3vuGZC4z88qf27MbIyv421SUJnQoQPSIXr43JYcRH5C4/0rDNlfUJ/ZPv90fl9fb2W8DTpIeCd5+WbkPAbvB9Rez+HC4W+/PNOY8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455753; c=relaxed/simple;
	bh=fL66KdxuMYYzK/jk3Z3iXcH/ZdM/jwC1r3OEN+ueeIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Qa39KBO+njKF09YXxGxgfb2pG0Nc8jv+ORIdGPET7wM5dkcnUJX4H2g7WTDtLl60R4gwS2s7SNKjkoZ91OePlWmXot/41iR5TNb0tqnSHu4u8jjHhrN3uT6L3ICXIweWvZ5DmhL2LKPQrR6NiP+rWW0fIZnCugQQvtoJ5tIcsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=pJk6JTWW; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MBaawx065105;
	Fri, 22 May 2026 14:15:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=XxsnKDXR/eGbvj4MOBU8MjX
	+HuSTAvLW6j5mOJIJzos=; b=pJk6JTWWv2nafVPGo5fDGLfp0mzAAS23LfbMqcu
	3NyXDFRQ8c1rpbfx1DwmW9bdUw0j6C77MJ0cxhNMblRdsnc3YrkxpveDchcgqvHQ
	CEXeNnG89dk7lrajT2AbQaPkr0QJqeY+oSDZ0FYSAlyFSlF+7xHEaWQBwpulGF8e
	pSQzQSruMAZv6ZMIh4vPSLbppFcMpuEWRY2xPRInu2r8N9dZF/V8JbsfKAyvAh1S
	0K5pInDfzu09lS3/0mTZA232Q4yVyjK+835cqY8gLYbwEE0uPrHqkUic6zQ6GbBt
	carVkkAujvEAfqfFZDynZXdDsIdqzcLmJWND37G7h7Pfc5w==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsnfkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:15:28 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.81) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 14:15:27 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Fri, 22 May 2026 14:15:00 +0100
Subject: [PATCH 6.12.y] drm/imagination: Synchronize interrupts before
 suspending the GPU
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com>
X-B4-Tracking: v=1; b=H4sIANNWEGoC/x3MQQ5AMBBA0avIrI3opBpxFbEoBrMpOoloxN01l
 m/x/wPKUVihKx6IfInKHjJMWcC0+bAyypwNVJOrGyLUFCaUeCo6NISLsXMzkvOtZcjREXmR+x/
 24CpDVYLhfT/+NPZZaAAAAA==
X-Change-ID: 20260522-sync-irqs-6-12-f14d5b26a84e
To: <stable@vger.kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Frank Binns
	<frank.binns@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Brajesh Gupta
	<brajesh.gupta@imgtec.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Alessio Belle <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779455727; l=5150;
 i=alessio.belle@imgtec.com; s=20251208; h=from:subject:message-id;
 bh=fL66KdxuMYYzK/jk3Z3iXcH/ZdM/jwC1r3OEN+ueeIk=;
 b=z5FxstMo5Jat6iQ/7vzys6qXLSvYSR/Uj9XzGhsQZHw7gF6pCnf0BWZzzfEBwdn4Y+5YjI3Hc
 0zbukf2Y6xSD81/hafUFK7zxF2bWOYtzcqBzwEMXQt8UUwz+2nqMuOg
X-Developer-Key: i=alessio.belle@imgtec.com; a=ed25519;
 pk=2Vtuk+GKBRjwMqIHpKk+Gx6zl7cgtq0joszcOc0zF4g=
X-Proofpoint-GUID: p6rKugC5h4WRTgINmRXfv0jnUrJLvY1y
X-Proofpoint-ORIG-GUID: p6rKugC5h4WRTgINmRXfv0jnUrJLvY1y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzMSBTYWx0ZWRfX9IrNXgC7Tj8K
 w4b69p3yj8WWejU16c6ojUawnXTjJBN/zJW6NWWmhOhwef+0pVcfWyODfmEZaSUQEsl8GqzFFIc
 4LbUI4QXBiMKfIbd98JKRpIZdydQ8RiWIoznsVjVPM5creiO0eIYjDaOtBQj+BIhXsGKy28lBkO
 oxwzE+45tz7clN1JES/W4haGQIRVSMPt6MNcMATTdP/9bcnJJCKF1I5qLlKh7eSSPqNInwjmK3Z
 Ds6Mtz/6oZ5jNbZIKVHEjnMIgPRLj1sanEkD4zuSD4uB/h/tFaupqx4OhnbXNplctrro8E/xkGj
 z6LUMF2vHT2n1eUdFPBwObztgJkK9oEMI3eCJLo/8glSVuzMSuu36pUMqIThkwtBkqRvSNLKPjU
 nQrx1EO1p/qXgHXcdxUwswrNqEPm6npvkyyDCm4BooG8zWyPppnEzSne3NtGIroeS2gd2reW4hM
 aIuLTqGw6kfR2wEzT3A==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a1056f0 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=yF7cHsaFFYkA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=Ol410iqxPhN9chiBww0A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,imgtec.com,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253792-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[imgtec.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.belle@imgtec.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A35DF5B51C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 2d7f05cddf4c268cc36256a2476946041dbdd36d upstream.

The runtime PM suspend callback doesn't know whether the IRQ handler is
in progress on a different CPU core and doesn't wait for it to finish.

Depending on timing, the IRQ handler could be running while the GPU is
suspended, leading to it being killed when trying to access GPU
registers. See example signature below.

In a power off sequence initiated by the runtime PM suspend callback,
wait for any IRQ handlers in progress on other CPU cores to finish, by
calling synchronize_irq().

This version of the patch contains only the part of the upstream commit
that applies to 6.12; the rest was a revert of code added in 6.16.
The second paragraph above is different because on 6.12 this kind of bug
doesn't seem to crash the entire kernel, only the IRQ handler, leaving
the driver unusable in practice.

The crash signature below is also different, both because of the above,
and because there was no support for TI AM68 SK in 6.12.

Example signature on a TI AM62 SK platform:

  [ 7827.189088] Internal error: synchronous external abort: 0000000096000010 [#1] PREEMPT SMP
  [ 7827.197311] Modules linked in:
  [ 7827.222015] CPU: 0 UID: 0 PID: 461 Comm: irq/405-gpu Tainted: G   M               6.12.90 #5
  [ 7827.230461] Tainted: [M]=MACHINE_CHECK
  [ 7827.234203] Hardware name: Texas Instruments AM625 SK (DT)
  [ 7827.239682] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [ 7827.246637] pc : pvr_device_irq_thread_handler+0x64/0x180 [powervr]
  [ 7827.252941] lr : irq_thread_fn+0x2c/0xa8
  [ 7827.256872] sp : ffff800082d8bd50
  [ 7827.260179] x29: ffff800082d8bd70 x28: ffff8000800ce374 x27: ffff800081829cc0
  [ 7827.267328] x26: ffff000004701e80 x25: ffff000005b884ac x24: ffff000005bd5780
  [ 7827.274472] x23: ffff00000da40bc0 x22: ffff00000da40ba0 x21: ffff800082d8bd58
  [ 7827.281614] x20: ffff00000da40000 x19: ffff000004701e80 x18: 08000000c6af9003
  [ 7827.288750] x17: 0000000000000010 x16: 0000000000000068 x15: 0df234008df66400
  [ 7827.295886] x14: 0000000000000000 x13: 000005c68f6e7191 x12: 000000000000025e
  [ 7827.303020] x11: 00000000000000c0 x10: 0000000000000ac0 x9 : ffff800082d8bd00
  [ 7827.310157] x8 : ffff000005bd62a0 x7 : ffff000077261380 x6 : 00000000000005c6
  [ 7827.317292] x5 : 000000000000425e x4 : 0000000000000000 x3 : 0000000000000000
  [ 7827.324428] x2 : 00000000000008a8 x1 : ffff800082d608a8 x0 : ffff000005bd5780
  [ 7827.331568] Call trace:
  [ 7827.334011]  pvr_device_irq_thread_handler+0x64/0x180 [powervr]
  [ 7827.339954]  irq_thread_fn+0x2c/0xa8
  [ 7827.343530]  irq_thread+0x16c/0x2f4
  [ 7827.347019]  kthread+0x110/0x114
  [ 7827.350248]  ret_from_fork+0x10/0x20
  [ 7827.353834] Code: f9446682 f943c281 b9404442 8b020021 (b9400021)
  [ 7827.359921] ---[ end trace 0000000000000000 ]---
  [ 7827.364820] genirq: exiting task "irq/405-gpu" (461) is an active IRQ thread (irq 405)
  [ 8011.230278] powervr fd00000.gpu: Job timeout
  [ 8011.230350] powervr fd00000.gpu: Job timeout
  [ 8011.230426] powervr fd00000.gpu: Job timeout

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Cc: stable@vger.kernel.org
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
This is a backport of the parts relevant to 6.12 of [1].

[1] https://lore.kernel.org/all/20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com/
---
 drivers/gpu/drm/imagination/pvr_power.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index bf4cf8426f91..077d2651798c 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -84,7 +84,7 @@ pvr_power_request_pwr_off(struct pvr_device *pvr_dev)
 }
 
 static int
-pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset)
+pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspend)
 {
 	if (!hard_reset) {
 		int err;
@@ -100,6 +100,11 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset)
 			return err;
 	}
 
+	if (rpm_suspend) {
+		/* Wait for late processing of GPU or firmware IRQs in other cores */
+		synchronize_irq(pvr_dev->irq);
+	}
+
 	return pvr_fw_stop(pvr_dev);
 }
 
@@ -243,7 +248,7 @@ pvr_power_device_suspend(struct device *dev)
 		return -EIO;
 
 	if (pvr_dev->fw_dev.booted) {
-		err = pvr_power_fw_disable(pvr_dev, false);
+		err = pvr_power_fw_disable(pvr_dev, false, true);
 		if (err)
 			goto err_drm_dev_exit;
 	}
@@ -425,7 +430,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 			queues_disabled = true;
 		}
 
-		err = pvr_power_fw_disable(pvr_dev, hard_reset);
+		err = pvr_power_fw_disable(pvr_dev, hard_reset, false);
 		if (!err) {
 			if (hard_reset) {
 				pvr_dev->fw_dev.booted = false;

---
base-commit: 2538fbeff8a94ee2b54eb09d92209e24a1e650d4
change-id: 20260522-sync-irqs-6-12-f14d5b26a84e

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>


