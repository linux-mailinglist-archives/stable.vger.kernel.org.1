Return-Path: <stable+bounces-141307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F8AAB28A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298713A8D0A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537E4274F0;
	Tue,  6 May 2025 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlTI5LR6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6724278745;
	Mon,  5 May 2025 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485734; cv=none; b=AqxtZAP8txkzhsHWfj5YUMCg/Z+JJGNuF9F2mhbqeuPUqm5Elp5JugIkdoYq6cstlNcYlc++6JnOxF/FQaqKaDSQO2pMxISO9UcnoOX2dCbTbuJgg/EkH/GGnimTWXpDlT63bNQGip5SN+LLDK8JHcOdhUjyUZdDvjJolyib230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485734; c=relaxed/simple;
	bh=5Ul5afnxT4Ev7pMFKXsZJc0l/RU9J+GqH7JwLx6dk74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTfnpSgviKR8wN2fztvzTLg4ldPoT5Y3A4rE8k4HdfHD5KWjRcDkd7sf3DN/WLwGM7sMkW4jJqKvdU+X0jJ2YrP+2uYwEiw+QSVQQ+tEgaZm799pLIgph3O3exXyp6oqd2s/yNCXnAsC6SiumfPk0WElXONu3rqDiO/ccTV3ZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlTI5LR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2535DC4CEE4;
	Mon,  5 May 2025 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485734;
	bh=5Ul5afnxT4Ev7pMFKXsZJc0l/RU9J+GqH7JwLx6dk74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlTI5LR6js7dFUd1BpHxTagrwpqA0FOQnRhcrHodC3qEI/p24tpXoxDxg4IzF1xvn
	 3WvN5JwfAFX9sVxWHWMFNEhIUqCvOXk6QbIpwn+X6JxNDp3+lzNx03JJnTXzV1QEGP
	 VIbZlorf3gAhYD91wvn1V0L5Mv2/YGrmI522vP/k10E5UC9UGjr2Fhixa05/0HktD9
	 3N/UiDXS8wvFhnMY/CuJx+l7tWi2fVKxZYO1sXmsnr3UEcmBvUsQt3UTdo2xDg7e1E
	 GESMTG8+RJa81RVgcrFrLX58egX8NrdZCi7Bpk7xZWgFO0duAphjKJIpiHMYghpzdX
	 iMu5xrUbUQhgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 451/486] irqchip/riscv-aplic: Add support for hart indexes
Date: Mon,  5 May 2025 18:38:47 -0400
Message-Id: <20250505223922.2682012-451-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

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


