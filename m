Return-Path: <stable+bounces-166447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF7B19DB2
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1941884736
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D724061F;
	Mon,  4 Aug 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8Xi7I42"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243A17D346;
	Mon,  4 Aug 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296468; cv=none; b=olQdDCTqOqJ9JokVwMV/07O/1N+DwN7BsUTNXpZldSIfYJ56/ORvODKE/kOEjmVoxJQaNec94Mt2NEPJRHPiowU4DqxE9AcEBCwrbDrL5a7z9eZCO6D80q707+4w2mLDxZLDs6ifG1GAuqOFrS5VMC3tRFZc3eDWDBczsEGH5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296468; c=relaxed/simple;
	bh=xGU8SrnP+viRjvp4iH3SDCyWJOmlYsrShYOR0Da0I44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4sCkxrkXFppTUFHqKSUtW7vTaCShqJyMvfZHvSM57gaaFKAxpk9t/3w/W+51nnc8wrtoP6bsUsmvRjzityajWFFJclY9gMDeVXtnG2lZgRib/Jy97MGJrfErwK1KoD3ryq+pw0MZP4VkXFBxHa2O3VdECsojch1sIF4BKZ2IHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8Xi7I42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880F5C4CEE7;
	Mon,  4 Aug 2025 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754296467;
	bh=xGU8SrnP+viRjvp4iH3SDCyWJOmlYsrShYOR0Da0I44=;
	h=From:To:Cc:Subject:Date:From;
	b=U8Xi7I42IPlKd3HMayHDfBvLdyhXUJSBP6S3O4stID7MJt5g5j88CnlW8veaGVIyi
	 K6OQ/WjXDfGGeQg+ytzwV2CtX0AD5Qnzjb9MjdeBaRGfjXpVoJXOH7ThzHgGo81HZJ
	 tLrxDSS1ulOAyLxeXscPlRXBdUwUt6ZEnkH63jjrLHYIsLa5GXa3/fmLVHusOKR8wJ
	 xmphFGkXXUNu15sVhzx+ZckKQuBGLj3P3g6wszhnuGl8gCob4t7UxP7hsPhymHc7Lw
	 aX/qkDkLqh+Cg+Aba4pGkivS6XfJCLI3CFtqp3F2tBXDZfGLMwwQU1CD6TGswMq8VI
	 3X26WG1Joi8PA==
From: Hans de Goede <hansg@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon,  4 Aug 2025 10:34:19 +0200
Message-ID: <20250804083419.205892-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing has shown that reading multiple registers at once (for 10 bit
adc values) does not work. Set the use_single_read regmap_config flag
to make regmap split these for is.

This should fix temperature opregion accesses done by
drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
the upcoming drivers for the ADC and battery MFD cells.

Fixes: 6bac0606fdba ("mfd: Add support for Cherry Trail Dollar Cove TI PMIC")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 4c1a68c9f575..a23bda8ddae8 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -82,6 +82,8 @@ static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
+	/* Reading multiple registers at once is not supported */
+	.use_single_read = true,
 };
 
 static const struct regmap_irq chtdc_ti_irqs[] = {
-- 
2.49.0


