Return-Path: <stable+bounces-185530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DECBD6A57
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2CE18A1458
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D1B2BE638;
	Mon, 13 Oct 2025 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT4MPrEx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E4308F0A
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395019; cv=none; b=nHaTKASzuqVqjgBNqFiqnFf+LZy/n3bO23JaJti8Fx9odqUrh4Rq/HDZpFr8ANYqY2dmDXe4uO9KMzwkVVWhNdbXQBsU97GtY/rSUxMsP32iSu/g7bwa7fkY9+T6X9NifXGX2Z70LVeCWvERtUa1/fvDAxty2fW7tdJmtXrOGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395019; c=relaxed/simple;
	bh=MwlyRZ1S3FOoieomNbG5PxaJH9IzP1/ZJmPlLzsxYjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnllZD/nG9f6G2fwhI8y/4TO5XeZ9VtUbpXQMnUCYTp2vEnu/D1FDGzeWotgntPDycinwDht7Png1e+tjZQ5D25URZ0L+CgDpZh+YyEeYVm9gzMsdK4lZfUF2iZfcnYtQnN3r938t+fdHH0I9WKEfd+BQfIS9M6YtIDLCYzYhuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT4MPrEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23905C4CEE7;
	Mon, 13 Oct 2025 22:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760395018;
	bh=MwlyRZ1S3FOoieomNbG5PxaJH9IzP1/ZJmPlLzsxYjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AT4MPrExmaXb1TLMtBbszVjG/dRlVyJzLRY5HGq6aH4gC8I5ARp0adSCkACOKo5F9
	 MZ0HPk3EVYaRhYxlsN8uMIndgGEcBvGwPownuAhCM+dVqA5iPUf16EfTiF7uGbR6Ng
	 ZcLAkvginyiLbMKeYtK2MmganYWIhLRxn8oSBtfn2ShB+tQ2H9vmNB20g9ugj5V4re
	 Mt3d82PIwLWkdjBZuGO71werbq5RMGSTbIIw6uPzhTZKftIlDHAzJ+2Po6X6srPRMx
	 EA2kbLtsWxL+Yyoe+Y37wvoTNp68MD4YGysVUK70E+7yZ0MggNjN4yUBDBvtnAWGhp
	 Q/ojCWHYgOqog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
Date: Mon, 13 Oct 2025 18:36:54 -0400
Message-ID: <20251013223656.3673902-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101305-cheek-copartner-c523@gregkh>
References: <2025101305-cheek-copartner-c523@gregkh>
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
index 992855bfda3e4..8582ae65a8029 100644
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


