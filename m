Return-Path: <stable+bounces-126839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72847A72CF7
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 10:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B2A17C128
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4E20E703;
	Thu, 27 Mar 2025 09:53:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D7820DD6E
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069238; cv=none; b=HPyZbLT2LUcr26qMY4VDUuaEGdsW0e3P80SWQ8LHbCDrj1wVDvriC0Aqbt4tNXdzh/XxO8mfNSpxUqXphoDt0jzXqohsmF8SocKGcLrhokZn7jBmWfCKJ7L6jnj9q82p2kYC70vOGT7A1mVDFqRYGi6DFgOypMLCEzJVFmBle8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069238; c=relaxed/simple;
	bh=FAP8K1iLfusZHJQ+J7vFlI0zvmFNj1nTDpr+55yqtNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADHFcEH5v64f9j2xsiwqaRNto0gmkrawxwvHd5F0e9db+6AmtajyjFt8YulRLT5+GmD/clcJk7I/Iwxj9geDvcXwyvA51mFExIRyvH+S38nTc+oopi5viyhBy9WSNVqRuk++ut9BEh5/Pn9TvIZZZMLAfvLYHiq/CXigDkHr/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8Bx12kuIOVnWRGoAA--.19344S3;
	Thu, 27 Mar 2025 17:53:50 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowMAxSsQpIOVned1iAA--.26323S2;
	Thu, 27 Mar 2025 17:53:48 +0800 (CST)
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
Subject: [PATCH V2 1/3] drm/amd/display: Protect FPU in dml21_copy()
Date: Thu, 27 Mar 2025 17:53:32 +0800
Message-ID: <20250327095334.3327111-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxSsQpIOVned1iAA--.26323S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryUJF1rtw1fXr1fKw4Utrc_yoWrtry5pr
	y5tr4rGrW8Ar12yw1jkF1UJ3y5XwsxCFy8JryUJw1akw1UWr1UJryDtrWUGrWUJr45JF17
	JwnrJw1Utr18J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UUUUU

Commit 7da55c27e76749b9 ("drm/amd/display: Remove incorrect FP context
start") removes the FP context protection of dml2_create(), and it said
"All the DC_FP_START/END should be used before call anything from DML2".

However, dml21_copy() are not protected from their callers, causing such
errors:

 do_fpu invoked from kernel context![#1]:
 CPU: 0 UID: 0 PID: 240 Comm: kworker/0:5 Not tainted 6.14.0-rc6+ #1
 Workqueue: events work_for_cpu_fn
 pc ffff80000318bd2c ra ffff80000315750c tp 9000000105910000 sp 9000000105913810
 a0 0000000000000000 a1 0000000000000002 a2 900000013140d728 a3 900000013140d720
 a4 0000000000000000 a5 9000000131592d98 a6 0000000000017ae8 a7 00000000001312d0
 t0 9000000130751ff0 t1 ffff800003790000 t2 ffff800003790000 t3 9000000131592e28
 t4 000000000004c6a8 t5 00000000001b7740 t6 0000000000023e38 t7 0000000000249f00
 t8 0000000000000002 u0 0000000000000000 s9 900000012b010000 s0 9000000131400000
 s1 9000000130751fd8 s2 ffff800003408000 s3 9000000130752c78 s4 9000000131592da8
 s5 9000000131592120 s6 9000000130751ff0 s7 9000000131592e28 s8 9000000131400008
    ra: ffff80000315750c dml2_top_soc15_initialize_instance+0x20c/0x300 [amdgpu]
   ERA: ffff80000318bd2c mcg_dcn4_build_min_clock_table+0x14c/0x600 [amdgpu]
  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
  PRMD: 00000004 (PPLV0 +PIE -PWE)
  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
 ESTAT: 000f0000 [FPD] (IS= ECode=15 EsubCode=0)
  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
 Process kworker/0:5 (pid: 240, threadinfo=00000000f1700428, task=0000000020d2e962)
 Stack : 0000000000000000 0000000000000000 0000000000000000 9000000130751fd8
         9000000131400000 ffff8000031574e0 9000000130751ff0 0000000000000000
         9000000131592e28 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 f9175936df5d7fd2
         900000012b00ff08 900000012b000000 ffff800003409000 ffff8000034a1780
         90000001019634c0 900000012b000010 90000001307beeb8 90000001306b0000
         0000000000000001 ffff8000031942b4 9000000130780000 90000001306c0000
         9000000130780000 ffff8000031c276c 900000012b044bd0 ffff800003408000
         ...
 Call Trace:
 [<ffff80000318bd2c>] mcg_dcn4_build_min_clock_table+0x14c/0x600 [amdgpu]
 [<ffff800003157508>] dml2_top_soc15_initialize_instance+0x208/0x300 [amdgpu]
 [<ffff8000031942b0>] dml21_create_copy+0x30/0x60 [amdgpu]
 [<ffff8000031c2768>] dc_state_create_copy+0x68/0xe0 [amdgpu]
 [<ffff800002e98ea0>] amdgpu_dm_init+0x8c0/0x2060 [amdgpu]
 [<ffff800002e9a658>] dm_hw_init+0x18/0x60 [amdgpu]
 [<ffff800002b0a738>] amdgpu_device_init+0x1938/0x27e0 [amdgpu]
 [<ffff800002b0ce80>] amdgpu_driver_load_kms+0x20/0xa0 [amdgpu]
 [<ffff800002b008f0>] amdgpu_pci_probe+0x1b0/0x580 [amdgpu]
 [<9000000003c7eae4>] local_pci_probe+0x44/0xc0
 [<90000000032f2b18>] work_for_cpu_fn+0x18/0x40
 [<90000000032f5da0>] process_one_work+0x160/0x300
 [<90000000032f6718>] worker_thread+0x318/0x440
 [<9000000003301b8c>] kthread+0x12c/0x220
 [<90000000032b1484>] ret_from_kernel_thread+0x8/0xa4

Unfortunately, protecting dml21_copy() out of DML2 causes "sleeping
function called from invalid context", so protect them with DC_FP_START()
and DC_FP_END() inside.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index fb80ba9287b6..a6b8df1d96e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -412,8 +412,12 @@ void dml21_copy(struct dml2_context *dst_dml_ctx,
 
 	dst_dml_ctx->v21.mode_programming.programming = dst_dml2_programming;
 
+	DC_FP_START();
+
 	/* need to initialize copied instance for internal references to be correct */
 	dml2_initialize_instance(&dst_dml_ctx->v21.dml_init);
+
+	DC_FP_END();
 }
 
 bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
-- 
2.47.1


