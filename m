Return-Path: <stable+bounces-195437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A12C76E0F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D47D4E439B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 01:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9A267B01;
	Fri, 21 Nov 2025 01:44:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51A239085;
	Fri, 21 Nov 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689474; cv=none; b=cYrk3kiMGUfAHSpF+PRpElJoYuFvqWE2oMGB1T9SKsWyLqFri7RX8822hObP5Nu7mTBW6URwVOZN09f3YlqW3SETk8MoGzokZzy62DiHKFdBbGoIiX9D92wOXMGaiZ1mtfqH8eDr4bpCVD203M9bj02fZE7pkMCpv5nX7+ELuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689474; c=relaxed/simple;
	bh=snv/CBURD/r6ZL7U2wyqjwuj/fCPGtpgRE6CoDkNVr0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=i0K4tiffZXKNpPXqZX+9gMLapfnEAkI0Tjy1GiQI2cIfnbw+K44t9mYo7phPB/clkAS3/eYj3TRNmSuBiOF+kwtSxGxjSnW/zV/VHVw5IDV6lNJ5rt7xjjl2dgFFpe1gwUcU8SY5ru+cHxuc6wcQe7VNKrQUHkfv5iEZQ/mvQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowABHTW7wwx9pQxd0AQ--.5417S2;
	Fri, 21 Nov 2025 09:44:23 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	make24@iscas.ac.cn,
	evan.quan@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix error handling in amdgpu_atpx_detect
Date: Fri, 21 Nov 2025 09:44:15 +0800
Message-Id: <20251121014415.37964-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowABHTW7wwx9pQxd0AQ--.5417S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy3Jw48Gr4DAw4ftryUGFg_yoW8Wr1fpr
	WSqF4UKFyUuFnrAFWxAa4UuFyDuw1IqFWrtr48C34S93yrXas5t34rGr1jgr1xArW8AF43
	JFsxXFWrZ3ZFvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

amdgpu_atpx_detect() uses pci_get_class() in two while loops to
iterate through VGA and OTHER display class PCI devices. Each call to
pci_get_class() increments the reference count of the returned PCI
device. However, after the loops complete, there are no corresponding
pci_dev_put() to decrement these reference counts.

Add pci_dev_put() after each while loop to release reference counts
held by the last devices found in each class.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 5d30ed3c2c74 ("Revert "drm/amdgpu: simplify ATPX detection"")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 3893e6fc2f03..9eb776a2e8bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -617,6 +617,9 @@ static bool amdgpu_atpx_detect(void)
 		amdgpu_atpx_get_quirks(pdev);
 	}
 
+	pci_dev_put(pdev);
+	pdev = NULL;
+
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
 		vga_count++;
 
@@ -627,6 +630,8 @@ static bool amdgpu_atpx_detect(void)
 		amdgpu_atpx_get_quirks(pdev);
 	}
 
+	pci_dev_put(pdev);
+
 	if (has_atpx && vga_count == 2) {
 		acpi_get_name(amdgpu_atpx_priv.atpx.handle, ACPI_FULL_PATHNAME, &buffer);
 		pr_info("vga_switcheroo: detected switching method %s handle\n",
-- 
2.17.1


