Return-Path: <stable+bounces-146925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D8AC5531
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B747A33FF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED282798F8;
	Tue, 27 May 2025 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V1b59qxi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD94139579;
	Tue, 27 May 2025 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365734; cv=none; b=dPCi2KQle5QNQkw+595r8eFFj+57hXnAupbcj6VBIlS/Glwd5NUn1IazK/SCnhIp4vZJEzIxqytmQiacoWVUvCwmhRrgcNCImysiiC9xxvlTLTW48VJ2rgEJ8IUYjitIBHM3ToIFqECbrDesa9z/f7ioXHtxHDai0EW+MXBx9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365734; c=relaxed/simple;
	bh=aspSdoeBJVDpCWOQ9Gn0vQ7LVxSH4eLDTzL1TgkUfLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+1JzdJvWRLAVBdFyzr6wYt83RQflaLv64gWQsdRveXG2WjR85wOlAq3rcTiSnurUr+nP0HHXiYyZV7hrXayfKD+G4vAZcU4hp9Z2rf08x58qVvWOhIRtGumZFYUnXHqY46UEoVgx4L2lVT6M2OY8G0vS9lCmEd2vTX92FNr0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V1b59qxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA876C4CEE9;
	Tue, 27 May 2025 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365734;
	bh=aspSdoeBJVDpCWOQ9Gn0vQ7LVxSH4eLDTzL1TgkUfLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1b59qxiZjZCbbbhuC/nem22q6zqRVS6sLbkFLqOyUyE/BsOTrik2fMeGSofYTPbo
	 IPs69F+0IIsYwUS3PGpJSKC87BD4t0sbbEAzgtSOmWEYMhbo2ZII0tLmBvjDXlPucO
	 IW6RBGu6yVWYoLua15B5RM6n/yYLKKnuvGnXheH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 471/626] irqchip/riscv-aplic: Add support for hart indexes
Date: Tue, 27 May 2025 18:26:04 +0200
Message-ID: <20250527162504.131631501@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

[ Upstream commit b93afe8a3ac53ae52296d65acfaa9c5f582a48cc ]

RISC-V APLIC specification defines "hart index" in:

  https://github.com/riscv/riscv-aia

Within a given interrupt domain, each of the domain’s harts has a unique
index number in the range 0 to 2^14 − 1 (= 16,383). The index number a
domain associates with a hart may or may not have any relationship to the
unique hart identifier (“hart ID”) that the RISC-V Privileged Architecture
assigns to the hart. Two different interrupt domains may employ entirely
different index numbers for the same set of harts.

Further, this document says in "4.5 Memory-mapped control region for an
interrupt domain":

The array of IDC structures may include some for potential hart index
numbers that are not actual hart index numbers in the domain. For example,
the first IDC structure is always for hart index 0, but 0 is not
necessarily a valid index number for any hart in the domain.

Support arbitrary hart indices specified in an optional APLIC property
"riscv,hart-indexes" which is specified as an array of u32 elements, one
per interrupt target. If this property is not specified, fallback to use
logical hart indices within the domain.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/all/20250129091637.1667279-3-vladimir.kondratiev@mobileye.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 7cd6b646774b9..205ad61d15e49 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -31,7 +31,7 @@ struct aplic_direct {
 };
 
 struct aplic_idc {
-	unsigned int		hart_index;
+	u32			hart_index;
 	void __iomem		*regs;
 	struct aplic_direct	*direct;
 };
@@ -219,6 +219,20 @@ static int aplic_direct_parse_parent_hwirq(struct device *dev, u32 index,
 	return 0;
 }
 
+static int aplic_direct_get_hart_index(struct device *dev, u32 logical_index,
+				       u32 *hart_index)
+{
+	const char *prop_hart_index = "riscv,hart-indexes";
+	struct device_node *np = to_of_node(dev->fwnode);
+
+	if (!np || !of_property_present(np, prop_hart_index)) {
+		*hart_index = logical_index;
+		return 0;
+	}
+
+	return of_property_read_u32_index(np, prop_hart_index, logical_index, hart_index);
+}
+
 int aplic_direct_setup(struct device *dev, void __iomem *regs)
 {
 	int i, j, rc, cpu, current_cpu, setup_count = 0;
@@ -265,8 +279,12 @@ int aplic_direct_setup(struct device *dev, void __iomem *regs)
 		cpumask_set_cpu(cpu, &direct->lmask);
 
 		idc = per_cpu_ptr(&aplic_idcs, cpu);
-		idc->hart_index = i;
-		idc->regs = priv->regs + APLIC_IDC_BASE + i * APLIC_IDC_SIZE;
+		rc = aplic_direct_get_hart_index(dev, i, &idc->hart_index);
+		if (rc) {
+			dev_warn(dev, "hart index not found for IDC%d\n", i);
+			continue;
+		}
+		idc->regs = priv->regs + APLIC_IDC_BASE + idc->hart_index * APLIC_IDC_SIZE;
 		idc->direct = direct;
 
 		aplic_idc_set_delivery(idc, true);
-- 
2.39.5




