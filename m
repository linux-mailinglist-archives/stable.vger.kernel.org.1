Return-Path: <stable+bounces-185551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB90BD6CF2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07E0F4F7BDC
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7932FE57F;
	Mon, 13 Oct 2025 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEz+YtFS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96C2FBE18
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399786; cv=none; b=bLt70agBaGtRtm1OrgssGfMzmQVQBqUaBWFZgxUl5+BUncd6HtesM94AcTSmyP68qWyQIa6z+2Okv0+d1GPHKX+bOCCodBaqz5V02D97a7gn7YzkTmmSVprmTxKw+FDG5uieO9b550i70JDeUBNre1ZhTTUyWARknbmNxiXUVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399786; c=relaxed/simple;
	bh=N/ZQMFzVhPoV1pD5/tnnXgDoT9Z807F3DJnnElnOYuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCMBgs1GDTxOgviu+VEZfLr0Uo5xN+HPIvpZAO9FzKSaOrxs3qEZnYuzywkk52y60LxEr+Hl+Z5NwNrt1Oak6bbQyhUAliEGke1glBfzDicu8gLA7Z9+2caju3DGRBtjCRgdQh9K+3uZHDVsgsVweXpfcfcb2QGIhG7QVRUjjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEz+YtFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573AEC4CEE7;
	Mon, 13 Oct 2025 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760399786;
	bh=N/ZQMFzVhPoV1pD5/tnnXgDoT9Z807F3DJnnElnOYuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEz+YtFSX9skyGhqN5AoLdfW2ZJ3KW+L2dh0kUZV9QFEzHikwIXoDRAFjPAsoQWFB
	 8QbdS28Jj2SJ1e1oapaG2BiyuUBghdb4Urp0ii31r/CCd9lHCLINkuuVM29IMKgqyF
	 KVMxw8pLT2GLabK8nIixKpPju81kqrnWD2xUO1ceLYdpIY3v4tn+poNs5f8TOWN9BF
	 qTG5WtDZ5ax4WMAaO20W4DXkraeYsMEOwzArfTTcJMXKr0YnYCDIcc+1wC9wLccjEn
	 +gHKiW/CnKPOzBxBLt8MLRX9oj5PTYP14jEpIALcFSAD58W6FK2xNKI0dCEtv7faLk
	 7z8IfyX3PbDKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
Date: Mon, 13 Oct 2025 19:56:21 -0400
Message-ID: <20251013235623.3733198-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101315-glue-daylight-739b@gregkh>
References: <2025101315-glue-daylight-739b@gregkh>
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
index 64b5c3cc30e74..e787d5655a315 100644
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


