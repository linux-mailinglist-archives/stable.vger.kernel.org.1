Return-Path: <stable+bounces-144287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F309AB60AA
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 04:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DF41B621A6
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 02:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC88018859B;
	Wed, 14 May 2025 02:07:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD6717C220
	for <stable@vger.kernel.org>; Wed, 14 May 2025 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747188434; cv=none; b=Bys5t3ZjhIasf7DbL0SuqZzdVm0puiu1hGLgCm9UKQkjhCUJVUuvYUNNOxxAm2OllRMc9hpSvS5LpZ9RHN5eCqr12Z7TQJz9S++HMLwtSvK+vb3wpBFo9KKpKsSitjEBX2nPmPEEdU+szNUjCuyy3wIHkWE7VdkOcqQr8olk/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747188434; c=relaxed/simple;
	bh=XtSfXrhHNvEz4wVdcVwfYc0EY6zxJ7NxBTKRksH04GE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RrAYI4xj3oUpYU2Pc/lgOQ25SPyhtjG6YTcpgPCLbEq1Cf8mXYdJjaGwXz6/S7Rn99ue/MLX1Iw+EHPsaBbIdDq0xTEE2U/ZHrk1B6kMquR2o9oTXACfFF7HfWG8euuJTbFb/vQdfJBJFkdsRXvEYJOMIIE0a47f/wC00W62wTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAB3fBSt+iNo_EZ9CA--.64466S2;
	Wed, 14 May 2025 10:06:37 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wDXoqKs+iNoUbnRAg--.27638S4;
	Wed, 14 May 2025 10:06:36 +0800 (CST)
From: Zhaoyang Li <lizy04@hust.edu.cn>
To: stable@vger.kernel.org
Cc: dzm91@hust.edu.cn,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Zhaoyang Li <lizy04@hust.edu.cn>
Subject: [PATCH 6.1.y] platform/x86/amd/pmc: Only disable IRQ1 wakeup where i8042 actually enabled it
Date: Wed, 14 May 2025 10:06:32 +0800
Message-Id: <20250514020632.387957-1-lizy04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAB3fBSt+iNo_EZ9CA--.64466S2
Authentication-Results: app1; spf=neutral smtp.mail=lizy04@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy3Kr1fZrWfZrWxXF4ruFg_yoW5Xr4kpF
	WSqF42kr18Gr4j93W8t3WxuF9xZr98CrWxCrWDCw1S93ZIvF1fJF1ktw1SqryvyrW8Wanx
	JrWDJas5uanY9F7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jhCztUUUUU=
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQYCB2giwOE-IgABs1

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

[ Upstream commit dd410d784402c5775f66faf8b624e85e41c38aaf ]

Wakeup for IRQ1 should be disabled only in cases where i8042 had
actually enabled it, otherwise "wake_depth" for this IRQ will try to
drop below zero and there will be an unpleasant WARN() logged:

kernel: atkbd serio0: Disabling IRQ1 wakeup source to avoid platform firmware bug
kernel: ------------[ cut here ]------------
kernel: Unbalanced IRQ 1 wake disable
kernel: WARNING: CPU: 10 PID: 6431 at kernel/irq/manage.c:920 irq_set_irq_wake+0x147/0x1a0

The PMC driver uses DEFINE_SIMPLE_DEV_PM_OPS() to define its dev_pm_ops
which sets amd_pmc_suspend_handler() to the .suspend, .freeze, and
.poweroff handlers. i8042_pm_suspend(), however, is only set as
the .suspend handler.

Fix the issue by call PMC suspend handler only from the same set of
dev_pm_ops handlers as i8042_pm_suspend(), which currently means just
the .suspend handler.

To reproduce this issue try hibernating (S4) the machine after a fresh boot
without putting it into s2idle first.

Fixes: 8e60615e8932 ("platform/x86/amd: pmc: Disable IRQ1 wakeup for RN/CZN")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: https://lore.kernel.org/r/c8f28c002ca3c66fbeeb850904a1f43118e17200.1736184606.git.mail@maciej.szmigiero.name
[ij: edited the commit message.]
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
---
 drivers/platform/x86/amd/pmc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index f237c1ea8d35..8eaeb1e8f975 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -834,6 +834,10 @@ static int __maybe_unused amd_pmc_suspend_handler(struct device *dev)
 {
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
 
+	/*
+	* Must be called only from the same set of dev_pm_ops handlers
+	* as i8042_pm_suspend() is called: currently just from .suspend.
+	*/
 	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
 		int rc = amd_pmc_czn_wa_irq1(pdev);
 
@@ -846,7 +850,9 @@ static int __maybe_unused amd_pmc_suspend_handler(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler, NULL);
+static const struct dev_pm_ops amd_pmc_pm = {
+	.suspend = amd_pmc_suspend_handler,
+};
 
 #endif
 
-- 
2.25.1


