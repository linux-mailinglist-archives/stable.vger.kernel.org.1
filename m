Return-Path: <stable+bounces-61994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC9993E1C7
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BAC1F218F1
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46E55769;
	Sun, 28 Jul 2024 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgvxUSwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58805548F7;
	Sun, 28 Jul 2024 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127687; cv=none; b=fv/ke2BjjuP9Jn86TLPObDVFYhVCnRRJHpkjz/8Sylrwki2l1lBcpng6iLCV2vbMKM5+30Flw/w76eRekija1SZgSA/SUhiK2hnRSpuBqoKxfb26x5/B8j4PdWKSMT2rjYRpFHipcjcdTcCwmKEdarQISu0HO0U4K3fNSkYMBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127687; c=relaxed/simple;
	bh=lItotgKCa+r1uULXTz9TQ0z1LBqfvJJEZVGeuzFOkUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1fnFaB2M+50u4YnRa/hd7nScK+kmGeG21zJyg4adlA5+BvnRpff9PTbmgndarFa2YczpyUW6ExsmOAiZILxWSY4Tvc5fphjx/hMrqP+S8mBW5bmvrop55R/L6uvjTFqcBzOtxxqrNrBYmT7YoPgTYs9tctKT3IXMbPnQiHSD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgvxUSwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72785C4AF09;
	Sun, 28 Jul 2024 00:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127686;
	bh=lItotgKCa+r1uULXTz9TQ0z1LBqfvJJEZVGeuzFOkUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgvxUSwjUnJSB7HWTCnL7HEV06MDe7Evu6nUz9BQgQWqi7/tMwoggH1YbyfzT/2xq
	 4Knazyedf+fvWhF6Vh1ikN89Hw34GDW9qvYpizyFP54RUjOloXwXJ9piyAKV/bSRu8
	 AniAN0NdN5okBN+7o/odG3/t70/EZuo6NJgo+D7mUxM+lK+7tXUnFpsMR0lZP8D6H7
	 TGAfpXqTB0WTvDQJ07H+4mfRUU6+X7WaJkYwdUUtY12SoYcxTbDGAQSn5v2w5qE8vf
	 hF03K9Ha9605wvDUfZza2Dp3qrKCHLoCvIaQnRzHdr4oGf76ANn8KpT4PYf+CdXVtK
	 JnmkvSIa+3oBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 14/16] irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
Date: Sat, 27 Jul 2024 20:47:31 -0400
Message-ID: <20240728004739.1698541-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004739.1698541-1-sashal@kernel.org>
References: <20240728004739.1698541-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

[ Upstream commit fa2dabe57220e6af78ed7a2f7016bf250a618204 ]

gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
It should only count the number of enabled redistributors, but it
also tries to sanity check the GICC entry, currently returning an
error if the Enabled bit is set, but the gicr_base_address is zero.

Adding support for the online-capable bit to the sanity check will
complicate it, for no benefit. The existing check implicitly depends on
gic_acpi_count_gicr_regions() previous failing to find any GICR regions
(as it is valid to have gicr_base_address of zero if the redistributors
are described via a GICR entry).

Instead of complicating the check, remove it. Failures that happen at
this point cause the irqchip not to register, meaning no irqs can be
requested. The kernel grinds to a panic() pretty quickly.

Without the check, MADT tables that exhibit this problem are still
caught by gic_populate_rdist(), which helpfully also prints what went
wrong:
| CPU4: mpidr 100 has no re-distributor!

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240529133446.28446-14-Jonathan.Cameron@huawei.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc8..10af15f93d4d4 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2415,19 +2415,10 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	 * If GICC is enabled and has valid gicr base address, then it means
 	 * GICR base is presented via GICC
 	 */
-	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
+	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address)
 		acpi_data.enabled_rdists++;
-		return 0;
-	}
 
-	/*
-	 * It's perfectly valid firmware can pass disabled GICC entry, driver
-	 * should not treat as errors, skip the entry instead of probe fail.
-	 */
-	if (!acpi_gicc_is_usable(gicc))
-		return 0;
-
-	return -ENODEV;
+	return 0;
 }
 
 static int __init gic_acpi_count_gicr_regions(void)
-- 
2.43.0


