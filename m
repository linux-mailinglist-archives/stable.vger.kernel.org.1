Return-Path: <stable+bounces-200965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDBECBBABF
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 13:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 405A83008882
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 12:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A5299950;
	Sun, 14 Dec 2025 12:53:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A81DDF3;
	Sun, 14 Dec 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765716823; cv=none; b=pOlGkmVVTjYLGuVFT/URhY+/IetuD8pmhb+Cz14YAD7qb/oVkKZsdjMtdSDlX00Fhu9h8s82BPDBpQUwWZZIl7SeK7wacynZjdoypN5SotH9FycvAnpT2xKj7YezcE6UXtC8SiyaBaEHbpI9ZaDyV51XE5X9dxwSn38KapOgIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765716823; c=relaxed/simple;
	bh=a+s01Y8XeApCsCOB/d+kvVefTC7plcn9Xkl6+nDmkRM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TP54DdNwQeNQzayvR+QBj0BtggP/NuYOOJaj5QRHiPm3crBCCyuUdef6NFf7AS9XId1L9rInwwilyAG8xHL/H2pOqj+VUWhGoboOujs5GcRDBe2E0dZABxjcaSmgmTWnlQ8MNn6Pacjg2okr2Tyig8ptHya6ybwqcYtkahR5ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowABnh94_sz5pJOyyAA--.52272S2;
	Sun, 14 Dec 2025 20:53:28 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: linux@armlinux.org.uk,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	make24@iscas.ac.cn,
	johan@kernel.org,
	hdoyu@nvidia.com,
	swarren@nvidia.com
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] ARM: tegra: fix device leak on tegra ahb lookup
Date: Sun, 14 Dec 2025 20:53:17 +0800
Message-Id: <20251214125317.2086-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowABnh94_sz5pJOyyAA--.52272S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF4fXr4DJw48JFWkZrW3Awb_yoW8JrW8pr
	48GryrAr98Wa48Kw40vF4UAFy5A3409w1rKr97u3yY9wsxXryFkFyktrnIqa98tr97tF4f
	KFyxtw18CF48WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUPfHUUUUUU
	=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

tegra_ahb_enable_smmu() utilizes driver_find_device_by_of_node() which
internally calls driver_find_device() to locate the matching device.
driver_find_device() increments the ref count of the found device by
calling get_device(), but tegra_ahb_enable_smmu() fails to call
put_device() to decrement the reference count before returning. This
results in a reference count leak of the device, which may prevent the
device from being properly released and cause a memory leak.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 89c788bab1f0 ("ARM: tegra: Add SMMU enabler in AHB")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/amba/tegra-ahb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index f23c3ed01810..3ed5cef34806 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -148,6 +148,7 @@ int tegra_ahb_enable_smmu(struct device_node *dn)
 	val = gizmo_readl(ahb, AHB_ARBITRATION_XBAR_CTRL);
 	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE;
 	gizmo_writel(ahb, val, AHB_ARBITRATION_XBAR_CTRL);
+	put_device(dev);
 	return 0;
 }
 EXPORT_SYMBOL(tegra_ahb_enable_smmu);
-- 
2.17.1


