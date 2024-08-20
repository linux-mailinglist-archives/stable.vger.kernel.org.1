Return-Path: <stable+bounces-69683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A1958061
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8361F2204B
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A29189F5C;
	Tue, 20 Aug 2024 07:54:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B842189BAF;
	Tue, 20 Aug 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140476; cv=none; b=ApuPa/O2Y1zM7D9YkQ8WN+icwpke2xEADuP2GVGWOrxjHCOY6AYSkiu+vvPDYWOOM9PIl1WfBuQlGDSSLq2fcExuDYEMbqKV56NNlFDwPx+X9KBIkAQAtwrOpCsjbbisejrA+58q7ymjggGmlqbYoGHPVMwUpBYkxq41nu6F+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140476; c=relaxed/simple;
	bh=+KpdcvUTND5J5Va9g0E1ckgOjItSX9mNrRy01W0IVqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pNAjOYUi2dLZK2KFnnf8FwZbkZx6ngNt2/211rg113sFzUNXoR6yhPPusk+OFn4ZV9ZlCxmQ6dJV8AXOWfYnmB5gKyVMFzhv7Y+bNfS3B01r/9GUFs0Rjz9V0aUMmHb2FX3QB6yZGP846vE50I4pl1ao8pQ6Bhds6BELrPomTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowABXXByaS8RmkLiHCA--.57264S2;
	Tue, 20 Aug 2024 15:54:10 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: maz@kernel.org,
	tglx@linutronix.de,
	Suravee.Suthikulpanit@amd.com,
	akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init
Date: Tue, 20 Aug 2024 15:54:01 +0800
Message-Id: <20240820075401.1206522-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXXByaS8RmkLiHCA--.57264S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWUWF18tF4UWF43uF4kJFb_yoWDGrb_Gr
	y8XF9xGFy0kr48Aws7Cw13uryUZr4kWF1I9r40yF93A348Z34xArnrZa4rJ34UuFs0vr1x
	CFs0yr1Skr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUvg4fUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Add the missing of_node_put() to release the refcount incremented
by of_find_matching_node().

Cc: stable@vger.kernel.org
Fixes: 4266ab1a8ff5 ("irqchip/gic-v2m: Refactor to prepare for ACPI support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch according to suggestions.
---
 drivers/irqchip/irq-gic-v2m.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 51af63c046ed..d5988012eb40 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -407,12 +407,12 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 
 		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
 				      &res, 0);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}
 
+	if (ret && child)
+		of_put_node(child);
 	if (!ret)
 		ret = gicv2m_allocate_domains(parent);
 	if (ret)
-- 
2.25.1


