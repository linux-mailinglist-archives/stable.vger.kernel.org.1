Return-Path: <stable+bounces-185542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF93BD6B29
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC918A81BE
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333742EC56F;
	Mon, 13 Oct 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMS/WQgJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505B2E06ED
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396867; cv=none; b=nSKE67lT6vcuzGEC4Ma/zMpWOqilXQCdsH01q5L27TNn+Zw7DLsOFj9/D04ihUSnrQ+v+XuYEDtjbrF/Wz+b62t1EjlyBQ2dqsfRJ7L9mvScF7LriEyyF5IHsDf4ZinDn1Whms6pn2o+NaGwER3zXmCPFa1B9Zvs8iFZ1oKzyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396867; c=relaxed/simple;
	bh=6SAy4c37I38+X6vfn9wK6wQCalDV/wL8zd/wSFtw4aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biVayXa6h2WvPalOfhP9HdmUov2nNh+RV/V3BUsl0J/K7yjP5MvUI1hTBr3xwC1UqFZkImEnN3SNddFHGs0sVE3FkrfRXcLgweGnapfO+R28gY4+Xri5eA2X6r3/0xGoydKJr9AEW4Pk0xUnyBqc57sozlU9SICy70O2bw5Phqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMS/WQgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB182C4CEE7;
	Mon, 13 Oct 2025 23:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760396866;
	bh=6SAy4c37I38+X6vfn9wK6wQCalDV/wL8zd/wSFtw4aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMS/WQgJhK4z8p1DqQ6uqCQJexg8HHagETmW6Kia/q+qB2IcNPWUnXGvQ0RIBnrkY
	 gJai6nfneOh4nu7erca4EvCvCl0xZcOIKK4JXV9ySW+WTDv0VmIObXEeqXqJqx3gmz
	 yOtgsS0bGcZ37LX5WCy6JAb+IsmGgKp1UMzPUuW6zOikMnBxFMmjbnG/g7jsJYJPMi
	 JPtfP3M522vqKgt0BBHusfjxIFR4BqqeVtveFLq2lN5HWTJ6eAn5jC9uZHfQBZrbkJ
	 pU7V8Vg+74S6zFdDwOaZm+/lyOWBQKWL9XaOem/JmKeLkmBAw1fIz7DuSALWtdXsbZ
	 1ABY5X4E8HQaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
Date: Mon, 13 Oct 2025 19:07:42 -0400
Message-ID: <20251013230744.3697280-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101307-little-reseal-5a13@gregkh>
References: <2025101307-little-reseal-5a13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 70e997e0107e5ed85c1a3ef2adfccbe351c29d71 ]

The max_register = 128 setting in the regmap config is not valid.

The Intel Dollar Cove TI PMIC has an eeprom unlock register at address 0x88
and a number of EEPROM registers at 0xF?. Increase max_register to 0xff so
that these registers can be accessed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/20241208150028.325349-1-hdegoede@redhat.com
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 64e0d839c589 ("mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 282b8fd08009b..0387d7b843e75 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -81,7 +81,7 @@ static struct mfd_cell chtdc_ti_dev[] = {
 static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = 128,
+	.max_register = 0xff,
 	.cache_type = REGCACHE_NONE,
 };
 
-- 
2.51.0


