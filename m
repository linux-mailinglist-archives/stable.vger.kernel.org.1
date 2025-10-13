Return-Path: <stable+bounces-185553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54655BD6D0A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AE5420723
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F42F49F8;
	Mon, 13 Oct 2025 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXroGxIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB826E6FA
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399788; cv=none; b=p80P/Hx8HJcSTeCu4av87OUHtmHKN3XWj3ZeivhAmYq105zVptRYxTx9Uj5eyY0vUvyNt8aOPtOnijMdSUT+Y97KgrwTxO7S+jGxiROzV2ur1Uys2J0mPLh2RLCjPmifL9hHBJrz7DSjZRPGVRfhE3ID0IIogWJZgrexZgJ3HKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399788; c=relaxed/simple;
	bh=RCgVmzfCtn8oLkMrVC1ZpjfNbKz/4uqOuALe3a4Oxt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zt2hPQE2fBy8rCj2sbzNIf2iBtc0b0o8zGnOZ0Fqf3RQkT7CVKKwW5vkucjTbndcMWrF7TNbkNXOWnNlCZbfjbFWQ1Yjdurq9pJUvfQjUAJ5x/EbL7ngknEiyFQXIecA65FiMGRk8KAWVeTAPsnbAtwPO/UvykoP+ifdi8XXnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXroGxIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD75C4CEE7;
	Mon, 13 Oct 2025 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760399787;
	bh=RCgVmzfCtn8oLkMrVC1ZpjfNbKz/4uqOuALe3a4Oxt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXroGxIZAD5xYNbMEzFsdYzsLNgB74oOmKVoYuH9dN5U3rqhVdAzbHMVrRnq8P5rv
	 APg1JyknU9lXZgfj4rr36vB92mQjhy23UDZMFn03xIdDHbPseSxXEUCThgw/DSx6D+
	 4ibP6F+aQaizZ+5EmNZzJOrEoFDypGDy8VX7j0Ca33ElsFCFDgbcMKkYmPaVV5gqN7
	 omY87Uplmyo/wFL22pU8EvBxjjo6hpIxXMexowhhGTS+4U92tbooV61LoxKW3wJGP6
	 ALLqZycaoc21ygTxISQ0WFrqyqePr/7EHxSzTgAhbT35MlyP5h2LzS1FrOLy2Gom9Z
	 OS9UNP1RVvnIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon, 13 Oct 2025 19:56:23 -0400
Message-ID: <20251013235623.3733198-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013235623.3733198-1-sashal@kernel.org>
References: <2025101315-glue-daylight-739b@gregkh>
 <20251013235623.3733198-1-sashal@kernel.org>
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


