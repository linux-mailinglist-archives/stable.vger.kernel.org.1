Return-Path: <stable+bounces-126840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC79A72CE9
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 10:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BF37A507F
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811120F09C;
	Thu, 27 Mar 2025 09:54:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48720F089
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069252; cv=none; b=NGof2/ax4oQSG9O9qCrmlWWzUI5eYsONeCSpt9hc+5CpryOChzZsD3u7tD+7STUtKwZ1baeGP2dOr/tT1i0Fzv3Yn2g1sGBfDrqNLz36Sf5hQdltuLBLWxt/4KF6SufFeM9wZWc7E9S7RDGggl9WSlDYd2JpyKmsPhBMc0k8kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069252; c=relaxed/simple;
	bh=pqYE9oWbFdUC6g4Pefn1kpToejUFDUDPHfecTlzjFh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN+4JZx+CKt2kj0EpGuqaapYJnMWOsXD4CpPnYPpnwnqMbLic2oJ+VJhmviaYopyJBaM5qxVmC37tHBUZgmzU4zhyTlC7W6avg7zOk+NNXdEReXD4kRFTruxobaszi54M8Km0woQvfbGx37SaTtiu4YxveESFwRbpRpv91OmCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8BxrOI_IOVncBGoAA--.45839S3;
	Thu, 27 Mar 2025 17:54:07 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowMAxSsQpIOVned1iAA--.26323S3;
	Thu, 27 Mar 2025 17:54:05 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH V2 2/3] drm/amd/display: Protect FPU in dml2_init()/dml21_init()
Date: Thu, 27 Mar 2025 17:53:33 +0800
Message-ID: <20250327095334.3327111-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250327095334.3327111-1-chenhuacai@loongson.cn>
References: <20250327095334.3327111-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxSsQpIOVned1iAA--.26323S3
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3AFy5Kr1rCFWDJr4rGr4rWFX_yoW7Kry3pr
	W5Xr4rGrWrZF12yw1DZF4UXrWYq3Z3CFy8C348Jw1a9w1UWr1DJFyktrW7KrW5JF45AFy2
	q3ZrX3yUtry0k3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

Commit 7da55c27e76749b9 ("drm/amd/display: Remove incorrect FP context
start") removes the FP context protection of dml2_create(), and it said
"All the DC_FP_START/END should be used before call anything from DML2".

However, dml2_init()/dml21_init() are not protected from their callers,
causing such errors:

 do_fpu invoked from kernel context![#1]:
 CPU: 0 UID: 0 PID: 239 Comm: kworker/0:5 Not tainted 6.14.0-rc6+ #2
 Workqueue: events work_for_cpu_fn
 pc ffff80000319de80 ra ffff80000319de5c tp 900000010575c000 sp 900000010575f840
 a0 0000000000000000 a1 900000012f210130 a2 900000012f000000 a3 ffff80000357e268
 a4 ffff80000357e260 a5 900000012ea52cf0 a6 0000000400000004 a7 0000012c00001388
 t0 00001900000015e0 t1 ffff80000379d000 t2 0000000010624dd3 t3 0000006400000014
 t4 00000000000003e8 t5 0000005000000018 t6 0000000000000020 t7 0000000f00000064
 t8 000000000000002f u0 5f5e9200f8901912 s9 900000012d380010 s0 900000012ea51fd8
 s1 900000012f000000 s2 9000000109296000 s3 0000000000000001 s4 0000000000001fd8
 s5 0000000000000001 s6 ffff800003415000 s7 900000012d390000 s8 ffff800003211f80
    ra: ffff80000319de5c dml21_apply_soc_bb_overrides+0x3c/0x960 [amdgpu]
   ERA: ffff80000319de80 dml21_apply_soc_bb_overrides+0x60/0x960 [amdgpu]
  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
  PRMD: 00000004 (PPLV0 +PIE -PWE)
  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
 ESTAT: 000f0000 [FPD] (IS= ECode=15 EsubCode=0)
  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
 Process kworker/0:5 (pid: 239, threadinfo=00000000927eadc6, task=000000008fd31682)
 Stack : 00040dc000003164 0000000000000001 900000012f210130 900000012eabeeb8
         900000012f000000 ffff80000319fe48 900000012f210000 900000012f210130
         900000012f000000 900000012eabeeb8 0000000000000001 ffff8000031a0064
         900000010575f9f0 900000012f210130 900000012eac0000 900000012ea80000
         900000012f000000 ffff8000031cefc4 900000010575f9f0 ffff8000035859c0
         ffff800003414000 900000010575fa78 900000012f000000 ffff8000031b4c50
         0000000000000000 9000000101c9d700 9000000109c40000 5f5e9200f8901912
         900000012d3c4bd0 900000012d3c5000 ffff8000034aed18 900000012d380010
         900000012d3c4bd0 ffff800003414000 900000012d380000 ffff800002ea49dc
         0000000000000001 900000012d3c6000 00000000ffffe423 0000000000010000
         ...
 Call Trace:
 [<ffff80000319de80>] dml21_apply_soc_bb_overrides+0x60/0x960 [amdgpu]
 [<ffff80000319fe44>] dml21_init+0xa4/0x280 [amdgpu]
 [<ffff8000031a0060>] dml21_create+0x40/0x80 [amdgpu]
 [<ffff8000031cefc0>] dc_state_create+0x100/0x160 [amdgpu]
 [<ffff8000031b4c4c>] dc_create+0x44c/0x640 [amdgpu]
 [<ffff800002ea49d8>] amdgpu_dm_init+0x3f8/0x2060 [amdgpu]
 [<ffff800002ea6658>] dm_hw_init+0x18/0x60 [amdgpu]
 [<ffff800002b16738>] amdgpu_device_init+0x1938/0x27e0 [amdgpu]
 [<ffff800002b18e80>] amdgpu_driver_load_kms+0x20/0xa0 [amdgpu]
 [<ffff800002b0c8f0>] amdgpu_pci_probe+0x1b0/0x580 [amdgpu]
 [<900000000448eae4>] local_pci_probe+0x44/0xc0
 [<9000000003b02b18>] work_for_cpu_fn+0x18/0x40
 [<9000000003b05da0>] process_one_work+0x160/0x300
 [<9000000003b06718>] worker_thread+0x318/0x440
 [<9000000003b11b8c>] kthread+0x12c/0x220
 [<9000000003ac1484>] ret_from_kernel_thread+0x8/0xa4

Unfortunately, protecting dml2_init()/dml21_init() out of DML2 causes
"sleeping function called from invalid context", so protect them with
DC_FP_START() and DC_FP_END() inside.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index a6b8df1d96e8..bbc798e039f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -86,6 +86,8 @@ static void dml21_init(const struct dc *in_dc, struct dml2_context **dml_ctx, co
 	/* Store configuration options */
 	(*dml_ctx)->config = *config;
 
+	DC_FP_START();
+
 	/*Initialize SOCBB and DCNIP params */
 	dml21_initialize_soc_bb_params(&(*dml_ctx)->v21.dml_init, config, in_dc);
 	dml21_initialize_ip_params(&(*dml_ctx)->v21.dml_init, config, in_dc);
@@ -96,6 +98,8 @@ static void dml21_init(const struct dc *in_dc, struct dml2_context **dml_ctx, co
 
 	/*Initialize DML21 instance */
 	dml2_initialize_instance(&(*dml_ctx)->v21.dml_init);
+
+	DC_FP_END();
 }
 
 bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 68b882d28195..fc551c63c9e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -776,11 +776,15 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 		break;
 	}
 
+	DC_FP_START();
+
 	initialize_dml2_ip_params(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.ip);
 
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
+
+	DC_FP_END();
 }
 
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
-- 
2.47.1


