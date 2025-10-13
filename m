Return-Path: <stable+bounces-185532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEDCBD6A66
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B4894F208E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5C730ACE5;
	Mon, 13 Oct 2025 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6d8h89E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA4304BCC
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395021; cv=none; b=pySVkE+qQskKy8ECBck3owyvjlCtgUiNb+pWO5C1vA0b/CAsghWK+qvKlnBm4oyUZFQPECdK3+/42WgSsqinzJxQ0V8qEiMgVGW7aNbDJjeylFJRkO/kD2WM8gIc6XVD9D5u9l7lyXgQeBTyxw27hiU0bmYjCPv+Fb3y1wJj/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395021; c=relaxed/simple;
	bh=TxIngv9pym1CwwsLUzyoMGBc+NchhzQYQUfwKPbwk8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwHEhO8vF+qZMK288AwKvvzqGuSv/eHkBA34Elvjjxs/PemiJd4Fk7DUJlSjojd5qJB+aSt25qnILnKyN/QUShXLpFusoHSD8dVphooAr3ep98AChGaYYuawmac3tLAUbCK6JfU3fNnsvyk9r3viU7Mga9jubl2TLk/bmLG7Uek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6d8h89E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABFDC2BCB4;
	Mon, 13 Oct 2025 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760395020;
	bh=TxIngv9pym1CwwsLUzyoMGBc+NchhzQYQUfwKPbwk8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6d8h89EGBrnlgEY9l2FBv2TFYhICJaj5AAPjRMGss1n+DvAKYdkJZeIWElABArxm
	 sFO+4OeHx9XZ2rHwUT8HF5Yor1BDBnKSdYqPsqV0MRcAPR7eG1HQbGdA+PctP2RYGk
	 4M1ARqnh9VePTnvUslEpmSpmP43tBSrDs0PClH6FRzueVsIVsRYixOxXwHNV/aAx0w
	 eTfS1QyfEwxuCafVun4axX8HPMNN6yp+za9eqK+dGQWl3rgptPJTFh0VdI1hPLczTA
	 CN/1y9wXs9rYMvKVFrBax38qS+tjL/pMw/MQkpZhx5nsLQRBSJX90LH6WFz244hfNY
	 7Lgl2UbGOZRxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon, 13 Oct 2025 18:36:56 -0400
Message-ID: <20251013223656.3673902-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013223656.3673902-1-sashal@kernel.org>
References: <2025101305-cheek-copartner-c523@gregkh>
 <20251013223656.3673902-1-sashal@kernel.org>
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


