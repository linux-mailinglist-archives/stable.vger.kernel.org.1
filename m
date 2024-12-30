Return-Path: <stable+bounces-106242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A09FE1A1
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 02:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DC51615CE
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688871096F;
	Mon, 30 Dec 2024 01:39:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2CB173
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735522773; cv=none; b=SMz3fla60FcpmNO9K5i+vtXSIySOZcbOuSSHrS1zTnDjimbDP+ymKQgqDE3YdrSNsEA3Vx5e2t7BWMUkQMyTECt9V8ItPmjwmZLbXIn3pc8a8mD5c1i9kKrEorcaiiw0aeWUwfOPQ6VhPPpV3jxIyvo/f1YeqPJacyAH7ER9PEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735522773; c=relaxed/simple;
	bh=pHyEivHkIlR3zbuDEIyOwLRm+HEA8dZF8judVNTdubg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYt6Dahf3ui0IL8hX75ykCdgtI1TYEKADFUS3FiKiJ2Yrba1J2+qL4pdpYQaEucz6TBRN7S10Gr9JT+7De9k36oTgvLjKdNXKozqag2n8NsYkIqxlh7/OU/TLYZai+jfvNVpCf8rGX5CbnBIdUUZtOWVLBwbhj5m2VxUKJcgKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.63])
	by gateway (Coremail) with SMTP id _____8Bx++HL+XFnh6BbAA--.48644S3;
	Mon, 30 Dec 2024 09:39:23 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.63])
	by front1 (Coremail) with SMTP id qMiowMAxQMbJ+XFnAkcNAA--.1525S2;
	Mon, 30 Dec 2024 09:39:21 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: stable@vger.kernel.org
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12.y] dmaengine: loongson2-apb: Change GENMASK to GENMASK_ULL
Date: Mon, 30 Dec 2024 09:39:19 +0800
Message-ID: <20241230013919.1086511-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2024122721-badge-research-e542@gregkh>
References: <2024122721-badge-research-e542@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxQMbJ+XFnAkcNAA--.1525S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw4xWrW8Xw4kuF4fuF1xZwc_yoW8AF1fpF
	y7W34I9ryUt3W7J3s8ta45XFy3JasrJrWUWanFv3y5urWfZw1qv34rXF43XF1jvry8AFW0
	vF97J347AFZ7ZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=

Fix the following smatch static checker warning:

drivers/dma/loongson2-apb-dma.c:189 ls2x_dma_write_cmd()
warn: was expecting a 64 bit value instead of '~(((0)) + (((~((0))) - (((1)) << (0)) + 1) & (~((0)) >> ((8 * 4) - 1 - (4)))))'

The GENMASK macro used "unsigned long", which caused build issues when
using a 32-bit toolchain because it would try to access bits > 31. This
patch switches GENMASK to GENMASK_ULL, which uses "unsigned long long".

Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/87cdc025-7246-4548-85ca-3d36fdc2be2d@stanley.mountain/
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Link: https://lore.kernel.org/r/20241028093413.1145820-1-zhoubinbin@loongson.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
(cherry picked from commit 4b65d5322e1d8994acfdb9b867aa00bdb30d177b)
---
 drivers/dma/ls2x-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ls2x-apb-dma.c b/drivers/dma/ls2x-apb-dma.c
index 9652e8666722..b4f18be62945 100644
--- a/drivers/dma/ls2x-apb-dma.c
+++ b/drivers/dma/ls2x-apb-dma.c
@@ -31,7 +31,7 @@
 #define LDMA_ASK_VALID		BIT(2)
 #define LDMA_START		BIT(3) /* DMA start operation */
 #define LDMA_STOP		BIT(4) /* DMA stop operation */
-#define LDMA_CONFIG_MASK	GENMASK(4, 0) /* DMA controller config bits mask */
+#define LDMA_CONFIG_MASK	GENMASK_ULL(4, 0) /* DMA controller config bits mask */
 
 /* Bitfields in ndesc_addr field of HW descriptor */
 #define LDMA_DESC_EN		BIT(0) /*1: The next descriptor is valid */
-- 
2.43.5


