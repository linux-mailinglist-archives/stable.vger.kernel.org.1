Return-Path: <stable+bounces-134053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7975A92959
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8CF8E29D1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7E2571DC;
	Thu, 17 Apr 2025 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="je5ShN7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B752571D4;
	Thu, 17 Apr 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914951; cv=none; b=ool/9dv7J4uudjoHChE7pamjlXrfbAz3DeTIWhVvQFKpIeCiJlAwMHs6HWLylXOo7S0ZlqpCBX9qEj6y6vWzzg+Odbl5817+qkGwCxehwl2ccCztxS3BW5jPyXxoVGSFT0FFo7QcEuWdO6lNJG4GlnW56/kqRjK/Z1wHB5HfeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914951; c=relaxed/simple;
	bh=2g1SGogA1NABKZ6ahBeI52bKs4w6qYLEJ9EwGJ9RhvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe4FodgRnT2ZiuilcrvD9yxRDg7gKSU5MpuzTx9/8IldJrhunB2JzFYgLrTDMk7Y18lbPFfF98yUeS5GSXyCd8A/ZZ3G97MjKvHxxAModR0hj3Y3xXwkErVM1de0bGQjwqlRVwKkTlbsKXQ7AE5cBI2Lde32koshwN0Y7je/yX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=je5ShN7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EAEC4CEE4;
	Thu, 17 Apr 2025 18:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914951;
	bh=2g1SGogA1NABKZ6ahBeI52bKs4w6qYLEJ9EwGJ9RhvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=je5ShN7Jc+5AyDuH8n+L+rBrBCvKh3VyJo1Wji+8sPVsmLclE6o4D5490DdZ4LKJM
	 nDY+zomQBKvPYTzbBbbuSK1yqSKVFJjl8ytAB0P4OkUiz9Lqd0iy0WAM2CFUOAN6Wk
	 fIZOVWCFwXwmayQf34brYRxjf/O73kUb6mwpEDzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH 6.13 385/414] PCI: j721e: Fix the value of .linkdown_irq_regfield for J784S4
Date: Thu, 17 Apr 2025 19:52:23 +0200
Message-ID: <20250417175126.955133172@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siddharth Vadapalli <s-vadapalli@ti.com>

commit d66b5b336245b91681c2042e7eedf63ef7c2f6db upstream.

Commit e49ad667815d ("PCI: j721e: Add TI J784S4 PCIe configuration")
assigned the value of .linkdown_irq_regfield for the J784S4 SoC as the
"LINK_DOWN" macro corresponding to BIT(1), and as a result, the Link
Down interrupts on J784S4 SoC are missed.

According to the Technical Reference Manual and Register Documentation
for the J784S4 SoC[1], BIT(1) corresponds to "ENABLE_SYS_EN_PCIE_DPA_1",
which is not the correct field for the link-state interrupt. Instead, it
is BIT(10) of the "PCIE_INTD_ENABLE_REG_SYS_2" register that corresponds
to the link-state field named as "ENABLE_SYS_EN_PCIE_LINK_STATE".

Thus, set .linkdown_irq_regfield to the macro "J7200_LINK_DOWN", which
expands to BIT(10) and was first defined for the J7200 SoC. Other SoCs
already reuse this macro since it accurately represents the "link-state"
field in their respective "PCIE_INTD_ENABLE_REG_SYS_2" register.

1: https://www.ti.com/lit/zip/spruj52

Fixes: e49ad667815d ("PCI: j721e: Add TI J784S4 PCIe configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
[kwilczynski: commit log, add a missing .linkdown_irq_regfield member
set to the J7200_LINK_DOWN macro to struct j7200_pcie_ep_data]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Link: https://lore.kernel.org/r/20250305132018.2260771-1-s-vadapalli@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/cadence/pci-j721e.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -355,6 +355,7 @@ static const struct j721e_pcie_data j720
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.quirk_detect_quiet_flag = true,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.quirk_disable_flr = true,
 	.max_lanes = 2,
 };
@@ -376,13 +377,13 @@ static const struct j721e_pcie_data j784
 	.mode = PCI_MODE_RC,
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
-	.linkdown_irq_regfield = LINK_DOWN,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.max_lanes = 4,
 };
 
 static const struct j721e_pcie_data j784s4_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
-	.linkdown_irq_regfield = LINK_DOWN,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.max_lanes = 4,
 };
 



