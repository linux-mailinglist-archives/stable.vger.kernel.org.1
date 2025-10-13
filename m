Return-Path: <stable+bounces-185544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE839BD6B2C
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7433734441E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75832FBE0B;
	Mon, 13 Oct 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5R2+Vay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961802FB968
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396868; cv=none; b=LYiCoe0OTUXiqcwom21GVKMhPthpS09dWxrG54NnJxVjpS6Z+3LWuq3FfvmYzSI9VftQO+yLigyKkszkfrtLRXHkMEB7bn2e0r+kvlTc1rlpL68Jbfi5C983MhtuZ4qRwVrK6NQAUww2y8i7JHrBvAZ+goad0o4HGWkPrTBNBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396868; c=relaxed/simple;
	bh=05zrlLNTtaJNwyHhbP9mihNoUoXtoTfgHFZW6ByLG4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwXau5iLxcq2+91y7Lu8rX/cR78pwlTJoaU05f/qF689sPyJ8AVA1sQtasH3KNaf2tpR7KVb6bGg5oCx/qmww9zp9wzGwOtd6+DEmTI6ZhFAEnX4nB5IJKglH5VSP08JaPHUVJtOLDGflkOrcMpO6uBHduEG9N9SqtYWJA/pRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5R2+Vay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9377BC116D0;
	Mon, 13 Oct 2025 23:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760396868;
	bh=05zrlLNTtaJNwyHhbP9mihNoUoXtoTfgHFZW6ByLG4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5R2+VaykBI6ZPySs3PT7BPOM8zUFx4xmy9C1peUIrvNUE24SKqbG2jfC6xjYaKp3
	 MUAdW/r9oSfbdmDTyW4cWnrefc5MV9npV5LNsw3wu26t+sKhaxHtNuCGoPyG6E+AwS
	 0GKDHRZov5Xks/fO4rOsrZE/OAEfAhJtwJGsGAeOYki8NqvdHrzK0M6mV7cRm2tDSG
	 bP2PQfI2L4c3F1UyvhdvmGNjniqQvop92XA2CTRroA8J2airBvCpCZMCaehOce/cap
	 lJI5UTbnfr0jvxIYDST2GvD5GTJkQg3XDZtyhNYZ/WwX+G2pAGJmdmAA8pfxHpFzlr
	 rX/vIdqufUagQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon, 13 Oct 2025 19:07:44 -0400
Message-ID: <20251013230744.3697280-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013230744.3697280-1-sashal@kernel.org>
References: <2025101307-little-reseal-5a13@gregkh>
 <20251013230744.3697280-1-sashal@kernel.org>
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
index 4027dc3d995ff..f0f0af677c9d6 100644
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


