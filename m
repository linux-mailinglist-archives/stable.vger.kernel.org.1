Return-Path: <stable+bounces-185556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD980BD6DFF
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 02:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89E074E4A4A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDB92C158A;
	Tue, 14 Oct 2025 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdV7l9OV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3742BF3CF
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401059; cv=none; b=uafXuBHeqlJjAEGTgxwVX8lvg9pnLGSRLVaxh0tyVjS6hqPPiqK2boyQI6wJ84Dcw3bWJJo7uBm0GvR7CyPnaJxXHnzFUybEee6+8b/YLk4O9FOBNLgvYr/6gmbZ3apK+V/KeOXDwWptVkPGb8Uhn/ZzkZ7/NjV6Y7L+zZD/E1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401059; c=relaxed/simple;
	bh=RCgVmzfCtn8oLkMrVC1ZpjfNbKz/4uqOuALe3a4Oxt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3IX3fP+98cm7XbLpBjRyodUIR/YbJfzpOpv4Purf+Gra0MU1PAuz0fheLDwAyx7tp1Vf++M2pdsCbs/sYh4iHMBqPo4zp+WkzOHtH94LxmviTjE1oAtVqK7B2MHxcQSPr03XbsB8ci2aZxUBJnto0+SIo0pGcyf96GNb3sXI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdV7l9OV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F86C4CEE7;
	Tue, 14 Oct 2025 00:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760401059;
	bh=RCgVmzfCtn8oLkMrVC1ZpjfNbKz/4uqOuALe3a4Oxt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdV7l9OV6BJDI01Ya59hereYXBsE8nT2hxo5fqNPUO3vqMOH26ehYxxISgozGJK2A
	 c+Uvemj5hUW0//WHxLo5ODlQP/oXYrZHanhWn7QjpcbmWeopY8fDLGKVNio7XrPqah
	 J6mDqKYp41MHMdhSOHWMNxx9ULgXpMTUVYGAX4r1E6XrOHu9A7cbsCPMKgxzXeiTT5
	 jnkPfhXqA8N+eN2Qc4RrUq4aDQffkyJCDqrJnqNMKSM/jFl6QpLeBd9GQXfPFdYV/e
	 cMXtTGXBZPlJ25yE2rqdzLihlD+bwYBdi+n5pOvrV0YeemcxI2uq66hOIvXRlvu5y5
	 C/kh/2oIJvcGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 3/3] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon, 13 Oct 2025 20:17:34 -0400
Message-ID: <20251014001734.3748199-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014001734.3748199-1-sashal@kernel.org>
References: <2025101316-disarm-pried-7a1f@gregkh>
 <20251014001734.3748199-1-sashal@kernel.org>
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
index 31b30a919348c..c629624fd4a59 100644
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


