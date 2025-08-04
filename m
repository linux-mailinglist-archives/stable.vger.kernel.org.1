Return-Path: <stable+bounces-166485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A8B1A35B
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 15:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D35B7AB94C
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C5272E7C;
	Mon,  4 Aug 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxNc3TSu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217A272E6B;
	Mon,  4 Aug 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314372; cv=none; b=qVOHwyygorAzut0W8Lkln2HIa5IysKTwQ0KsRqNyfKXzmBo9ZvvW0LOQHMtrltSazlKp7OOdhZ+XCFZ+1wApQwXarxeulB816Uk5cC3YoQ1FPje8k9PXV+ZWZl7IJ9QE0+npYQJDDSjttfcrLpFTisCzEobx+MOIKjaia0Hs6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314372; c=relaxed/simple;
	bh=hepMtxgdFJ9YFlSp+iRnoF0WpKwXLtv+dU1RIxscwqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yl5djWIlooK6Yb97MGlBd52pa9VmwEY392fhmS1ATa3MNETg2uZw8Ets4BIk4KXhRYE3DeYF7qSftr2VlDaQk7EUpHZE2ZJz/nBoVWgtG2cuoWQzqe6mqiUFZwX5lmLY0F+qIfKpyVAxEiaYMDsUesRsjOpK87gHEgSzPULcu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxNc3TSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8419EC4CEFB;
	Mon,  4 Aug 2025 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754314371;
	bh=hepMtxgdFJ9YFlSp+iRnoF0WpKwXLtv+dU1RIxscwqY=;
	h=From:To:Cc:Subject:Date:From;
	b=rxNc3TSuABB8OsG5HsEgxHMyZJybEXlOBJdiJ8wbKzywEr38S2INFArKjVVH5gVn6
	 JE9XYOf6ssGvkzU2+JKWRRQkGuDacTZM+7234H+CFr/m8uCQSiWLYcop1ZumgNrqaA
	 tuxSHm4KRe5SYw4ENm265whxk5PUZaCrW2o3ZbbbtbvH/a+4n7Q7hLvEp4/7xpYIYd
	 PU6LeKGBOQW+f8tqjxBidYNdJEdMnAzaxXC5BZOZZf3mQTZL+47Gah6Et+MCeR5rHy
	 fr+BgL2UlR65j/MYkS8I/4JPifQnG3ijVk3ohES/ZR3FdYtAqKYmJorddlkc+0tIXT
	 +orlH2gaHSk+w==
From: Hans de Goede <hansg@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon,  4 Aug 2025 15:32:40 +0200
Message-ID: <20250804133240.312383-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes in v3:
- Fix a few typos in the commit message

Changes in v2:
- Update comment to: "The hardware does not support reading multiple
  registers at once"
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 4c1a68c9f575..6daf33e07ea0 100644
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
2.49.0


