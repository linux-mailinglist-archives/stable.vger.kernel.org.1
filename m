Return-Path: <stable+bounces-69466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11973956664
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00181F225B4
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8F15C15B;
	Mon, 19 Aug 2024 09:10:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0115B11D;
	Mon, 19 Aug 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058633; cv=none; b=qqiEQtQfwBkyVqbDW5SCrJg8Eo0/cl/ywHQrWzbXjDpfaY+CgU0BdmEOMNljqqiRYQJ+1HWtPJhnGPe3nOFDCgeTSezQaY+xPYxeuiykRhj6RlmnEwt6BkZiOELVa2UxZtmHefSXm+47im1B4b0NjNOQfwUIDmmPchiO0HPs9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058633; c=relaxed/simple;
	bh=nj6Sc1Tch/1JsyhOQg7Dy6FGbxjRBPS0rhbyf4DsayM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AWfGdMijYXGoO6MrBJw8LPOu+Pq4mi0JmryYYCP/NR3eH+644ZfoeQd7zgOcCBmi0E9sA0G60rG7B2fyeE8Gh+1GWjTHr1U6pPJ344oi0VqUSnx0sP1ANw0a92Kok7GHLqMOrGUwMAzEyk1CAdiWCP164l952sKbwdM5W7KEap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAA3Pfn5C8Nmc5QTCA--.22630S2;
	Mon, 19 Aug 2024 17:10:19 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: maz@kernel.org,
	tglx@linutronix.de,
	Suravee.Suthikulpanit@amd.com,
	akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init
Date: Mon, 19 Aug 2024 17:10:11 +0800
Message-Id: <20240819091011.1015745-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3Pfn5C8Nmc5QTCA--.22630S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWUWF18tF4UWF43uF4kJFb_yoW3CFX_Wr
	yUWF97JFW0kr4kGw1Iqr43ur9Fy34kW3WvgF40qF95X3y8Z34xCr129F95JryDCFsaqr97
	CFs8Zr1Iyr17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUp7KsUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Add the missing of_node_put() to release the refcount incremented
by of_find_matching_node().

Cc: stable@vger.kernel.org
Fixes: 4266ab1a8ff5 ("irqchip/gic-v2m: Refactor to prepare for ACPI support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/irqchip/irq-gic-v2m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 51af63c046ed..65a55ee7bb30 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -396,6 +396,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 		ret = of_address_to_resource(child, 0, &res);
 		if (ret) {
 			pr_err("Failed to allocate v2m resource.\n");
+			of_node_put(child);
 			break;
 		}
 
-- 
2.25.1


