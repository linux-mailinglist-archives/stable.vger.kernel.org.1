Return-Path: <stable+bounces-7329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2C81720E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB1A1C24D1F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3B37868;
	Mon, 18 Dec 2023 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KAZHVh+R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83956498A5;
	Mon, 18 Dec 2023 14:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F90C433C9;
	Mon, 18 Dec 2023 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908177;
	bh=t8s/MQ6K38Z2BBdrz6CHA8TiwwXIA2DvB6jHj/PW+rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAZHVh+RTUzNHLu6voeF89wHSRoSKv+pdMUSu2MF+/oPDq4501iW6rei5CH7yWaCl
	 JLQQ1UaAahuNwSXD+GxvAadzmjgtvR5CiRONwyyPHP5xLnZ7mcM+6PWKH8boYyo7Lq
	 ETPyGhoirEMRDHu6fuLGkjY/61wFeMzC5yZh2vUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 081/166] accel/ivpu/37xx: Fix interrupt_clear_with_0 WA initialization
Date: Mon, 18 Dec 2023 14:50:47 +0100
Message-ID: <20231218135108.645369456@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>

[ Upstream commit 35c49cfc8b702eda7a0d3f05497b16f81b69e289 ]

Using PCI Device ID/Revision to initialize the interrupt_clear_with_0
workaround is problematic - there are many pre-production
steppings with different behavior, even with the same PCI ID/Revision

Instead of checking for PCI Device ID/Revision, check the VPU
buttress interrupt status register behavior - if this register
is not zero after writing 1s it means there register is RW
instead of RW1C and we need to enable the interrupt_clear_with_0
workaround.

Fixes: 7f34e01f77f8 ("accel/ivpu: Clear specific interrupt status bits on C0")
Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://lore.kernel.org/all/20231204122331.40560-1-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_hw_37xx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_37xx.c b/drivers/accel/ivpu/ivpu_hw_37xx.c
index 2409ff0dda619..ddf03498fd4c1 100644
--- a/drivers/accel/ivpu/ivpu_hw_37xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
@@ -53,10 +53,12 @@
 
 #define ICB_0_1_IRQ_MASK ((((u64)ICB_1_IRQ_MASK) << 32) | ICB_0_IRQ_MASK)
 
-#define BUTTRESS_IRQ_MASK ((REG_FLD(VPU_37XX_BUTTRESS_INTERRUPT_STAT, FREQ_CHANGE)) | \
-			   (REG_FLD(VPU_37XX_BUTTRESS_INTERRUPT_STAT, ATS_ERR)) | \
+#define BUTTRESS_IRQ_MASK ((REG_FLD(VPU_37XX_BUTTRESS_INTERRUPT_STAT, ATS_ERR)) | \
 			   (REG_FLD(VPU_37XX_BUTTRESS_INTERRUPT_STAT, UFI_ERR)))
 
+#define BUTTRESS_ALL_IRQ_MASK (BUTTRESS_IRQ_MASK | \
+			       (REG_FLD(VPU_37XX_BUTTRESS_INTERRUPT_STAT, FREQ_CHANGE)))
+
 #define BUTTRESS_IRQ_ENABLE_MASK ((u32)~BUTTRESS_IRQ_MASK)
 #define BUTTRESS_IRQ_DISABLE_MASK ((u32)-1)
 
@@ -102,8 +104,12 @@ static void ivpu_hw_wa_init(struct ivpu_device *vdev)
 	vdev->wa.clear_runtime_mem = false;
 	vdev->wa.d3hot_after_power_off = true;
 
-	if (ivpu_device_id(vdev) == PCI_DEVICE_ID_MTL && ivpu_revision(vdev) < 4)
+	REGB_WR32(VPU_37XX_BUTTRESS_INTERRUPT_STAT, BUTTRESS_ALL_IRQ_MASK);
+	if (REGB_RD32(VPU_37XX_BUTTRESS_INTERRUPT_STAT) == BUTTRESS_ALL_IRQ_MASK) {
+		/* Writing 1s does not clear the interrupt status register */
 		vdev->wa.interrupt_clear_with_0 = true;
+		REGB_WR32(VPU_37XX_BUTTRESS_INTERRUPT_STAT, 0x0);
+	}
 
 	IVPU_PRINT_WA(punit_disabled);
 	IVPU_PRINT_WA(clear_runtime_mem);
-- 
2.43.0




