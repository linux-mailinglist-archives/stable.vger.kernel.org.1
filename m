Return-Path: <stable+bounces-145846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0A9ABF7C9
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6B71BA44A8
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C81A3166;
	Wed, 21 May 2025 14:24:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3628682;
	Wed, 21 May 2025 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837471; cv=none; b=T60WB2/ruCKOj6Twtsrq7twDsV4x3yee5+u+ZWNfvSyK2CTPovZXy6OEVctVwKLJaTmHzhm7cqCqyTo/A5fI5cMnjavE96k6dtbHvcdSrWCS2U+ENs91LehcEMsKsKYLz42hPuMxJFrzXHjevf2YMpI5QFkM+vqz/8MOA4THbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837471; c=relaxed/simple;
	bh=Ourow4OK6/2Cln7586tL43/CJb5AAk27N8xfphvkees=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDGkD6m+0D1gY+PYAdjIuV4xhcanH+2/PCri8hNXNqBI0IH40AbLaVPbcxh02gU3YVtNATEQWBy5VKJB3z7EVcztkfAhBOKFktg3L77sxx/B0+9o8+hejypGlkNjb4i1kxYFMhX5Xy4EHmXF8F3qxnR60/EkB0jLkawfOOqxwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowABHtcQT4i1oHRX6AQ--.16951S2;
	Wed, 21 May 2025 22:24:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] remoteproc: mediatek: Add SCP watchdog handler in IRQ processing
Date: Wed, 21 May 2025 22:24:03 +0800
Message-ID: <20250521142404.1077-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHtcQT4i1oHRX6AQ--.16951S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWkXr4xCr4DGFWrXry5Arb_yoWkZrX_ua
	s0gFZrWF1vga1Yy34IyrsavFZa9ry8Wry8KFySqas8t39xXa47try0vF4kuw1DXF15uFy5
	Zr4v9F4fuF4xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSdgAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUJA2gtsvlq+gACsf

In mt8195_scp_c1_irq_handler(), only the IPC interrupt bit
(MT8192_SCP_IPC_INT_BIT) was checked., but does not handle
when this bit is not set. This could lead to unhandled watchdog
events. This could lead to unhandled watchdog events. A proper
implementation can be found in mt8183_scp_irq_handler().

Add a new branch to handle SCP watchdog events when the IPC
interrupt bit is not set.

Fixes: 6a1c9aaf04eb ("remoteproc: mediatek: Add MT8195 SCP core 1 operations")
Cc: stable@vger.kernel.org # v6.7
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/remoteproc/mtk_scp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 0f4a7065d0bd..316e8c98a503 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -273,6 +273,8 @@ static void mt8195_scp_c1_irq_handler(struct mtk_scp *scp)
 
 	if (scp_to_host & MT8192_SCP_IPC_INT_BIT)
 		scp_ipi_handler(scp);
+	else
+		scp_wdt_handler(scp, scp_to_host);
 
 	writel(scp_to_host, scp->cluster->reg_base + MT8195_SSHUB2APMCU_IPC_CLR);
 }
-- 
2.42.0.windows.2


