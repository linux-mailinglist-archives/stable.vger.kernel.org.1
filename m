Return-Path: <stable+bounces-185537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B31BD6A90
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 179AD4EA091
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629A2C1788;
	Mon, 13 Oct 2025 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXkgijY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067761FCF7C
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395697; cv=none; b=GT4uUCPoyYG4+juEfm+uDZ8etZCxwk+WnHhC8tdN6WwtWGjIBJR8KJe0WKBwNU6+Uitqc+jFZpyhnW2pXxW8hJ/RLBrj6a62mpLS/i4ToRMl5KrEck3780TyzN7JhVYp3SL1f3xqvaoLBgEfiWUwFO7xUWoJc6SB+JghQnQz2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395697; c=relaxed/simple;
	bh=TxIngv9pym1CwwsLUzyoMGBc+NchhzQYQUfwKPbwk8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN5M6n/zN7fUPjIHF1BbmliP4xaMRQZc2ou37LlQtj6FhpTrCJbcGJ9wmxchU8hpuqCc+IIB8+gxeCSxAc760x3tye0Ojac7nPubLsg6MoaPgwoaqPjz1MlRNI6skiEFkS0k2cfcF7mmg0PjiA2otaMF2HOCYimobgFSLOalDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXkgijY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A31C4CEE7;
	Mon, 13 Oct 2025 22:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760395696;
	bh=TxIngv9pym1CwwsLUzyoMGBc+NchhzQYQUfwKPbwk8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXkgijY7BSiP1GSq/WuGwHHnQkzT3V81Ot82VpRaptM2aS84XcMeHnGU38psbdIFu
	 lGuzAauOOB1lxYpvkAG4+JHnvGDWDmMuzbkRwWhEHWkGKjExhSlbOOSOMbDGttWIkb
	 bplrtqE83EO+hScflcNNCswCubP2Q4vn4/FR34MTl/rqj6w0z0q0PUBUbpICvy6CeU
	 0KDC7A0++p8wqbHphY8TJ0jYI5jVq0ksyfZRzITETDPyULLTUYhupNiChkbtRpcHPs
	 /CsluqZZpO9AEfsw70Hz+l8oPiHOtZS8jI/OfqTOIFI5bpQS7xqNyFFBArRQ4CNQr3
	 Br51N/0XoU5sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon, 13 Oct 2025 18:48:12 -0400
Message-ID: <20251013224812.3682599-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013224812.3682599-1-sashal@kernel.org>
References: <2025101306-cufflink-fidgeting-4c7b@gregkh>
 <20251013224812.3682599-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit 64e0d839c589f4f2ecd2e3e5bdb5cee6ba6bade9 ]

Testing has shown that reading multiple registers at once (for 10-bit
ADC values) does not work. Set the use_single_read regmap_config flag
to make regmap split these for us.

This should fix temperature opregion accesses done by
drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
the upcoming drivers for the ADC and battery MFD cells.

Fixes: 6bac0606fdba ("mfd: Add support for Cherry Trail Dollar Cove TI PMIC")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
Link: https://lore.kernel.org/r/20250804133240.312383-1-hansg@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 4c1a68c9f5750..6daf33e07ea0a 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -82,6 +82,8 @@ static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
+	/* The hardware does not support reading multiple registers at once */
+	.use_single_read = true,
 };
 
 static const struct regmap_irq chtdc_ti_irqs[] = {
-- 
2.51.0


