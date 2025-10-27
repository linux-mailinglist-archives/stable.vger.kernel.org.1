Return-Path: <stable+bounces-189905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC07C0B9A5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 02:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC0F189AFDF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 01:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C428934F;
	Mon, 27 Oct 2025 01:38:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F287083C;
	Mon, 27 Oct 2025 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761529119; cv=none; b=gue9L1+jZciuapoHB+FnfEWn5/PM0efwQDAcLsKI0BCjvXJiTqo/cA23/0WlwQN5avmvJq9RgGsaZIOB5fAbtrWue1TMinCTD/ypKmiBCv2ytJGvPPYnufEsAWhqhWU1DsSqGq8DNW/EPicqFh+ntNIg3cCZn4ZW4xBgQsULJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761529119; c=relaxed/simple;
	bh=sSkiC8PgPA0Qqo06szF3QJjKcn6c0uld0w7sBEAOsbo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=L2vXTxVcdScBnb6W1R8tHStuU+f/5OaALJjp6kNK2kmtfy/Z56+BMl0XNVU54zHjdvTdWNO4h9NftJXegPSWR98pCPT4rr36h7+Xs4hfPQQIZ/FEO7Hn7x/M/oRqbhtlp/ypS5OIUfV/K4eTg6wnI8OFfZUCZ+f7oQJhI7QKN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowABn7GAAzf5osh13Ag--.14S2;
	Mon, 27 Oct 2025 09:38:19 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: linux@armlinux.org.uk,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	make24@iscas.ac.cn,
	hdoyu@nvidia.com,
	swarren@nvidia.com
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH] ARM: tegra: fix device leak on tegra ahb lookup
Date: Mon, 27 Oct 2025 09:38:07 +0800
Message-Id: <20251027013807.25214-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowABn7GAAzf5osh13Ag--.14S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF4fXr4DJw48JFWkZrW3Awb_yoW8JrW8pr
	4rGryrAr98GFy8Kw4jvF48ZFy5A3yI9w1rKr97u3yY9rsxXryFkFyxtrn0qa98tr97tF4x
	KryIyw18CF48WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4
	AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUmQ6LU
	UUUU=
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
index c0e8b765522d..6c306d017b67 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -147,6 +147,7 @@ int tegra_ahb_enable_smmu(struct device_node *dn)
 	val = gizmo_readl(ahb, AHB_ARBITRATION_XBAR_CTRL);
 	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE;
 	gizmo_writel(ahb, val, AHB_ARBITRATION_XBAR_CTRL);
+	put_device(dev);
 	return 0;
 }
 EXPORT_SYMBOL(tegra_ahb_enable_smmu);
-- 
2.17.1


