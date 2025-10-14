Return-Path: <stable+bounces-185554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF918BD6E02
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 02:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7360934EB4D
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF8B2C0303;
	Tue, 14 Oct 2025 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0U/r095"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E32BF3CF
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401057; cv=none; b=BluKYgxsv+5ohvaxZ7URCnxL/9t/DGJgaGI+3tD0+VM1Zs/YUudCnBUCmbZRrl/R7eVxBl3RcSfhd4Onft39c7H4fxMs3C32y62247esDYZ3hQQlB5r/r0TQbhA/mDpKNtuOF4hUDzTeHeIRo/qVPhoyEzaE2YRfQ9e+dd5mE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401057; c=relaxed/simple;
	bh=N/ZQMFzVhPoV1pD5/tnnXgDoT9Z807F3DJnnElnOYuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6d3Ltl9Lvxt7j++uU5K3FmV1kIAZn0Or3t1SqYTVJqWLgzRSuQQuutTfMsj3tNeGtedmAhnuqeZTLO/K3qGvgKQFW3BTiD0SIVH8EJl3F/JW25WCLCIKOTGIMdwBh5cxwlY6vXIvx6TnGuNmUJLYUveQ5UQbGhaBo2NV9GXhfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0U/r095; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F064C4CEE7;
	Tue, 14 Oct 2025 00:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760401057;
	bh=N/ZQMFzVhPoV1pD5/tnnXgDoT9Z807F3DJnnElnOYuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0U/r0951EaxOqBZzn45TUyPQga8OW/QY4FfKml//Gn7PbwFkZN+052KFaUo1dMce
	 Rpg6kilHayrY2sDMOZ16Me92Df4ShWLFsT7u8cr4lwc+l50TsRop8YcMcppN2yYWGX
	 6NuE2IH9mU2tcpoHgkRdczJrj0JtAIEZ2l2LapcPwc0vUnX5wNN/tdMsYvstByF9G2
	 lQfbDWKBZwocUhbcYfy0t34MfOLHQGA09TxHcOpx10RKuBnXZE6Y+TWK1vvxJSBvy/
	 jFU08qCfwypHJPmhEWk6NcnV0EXUBVd2inac5pk92KvVuirTAJbULoTu2nOvgbvDOS
	 anypxMVzKKiTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/3] mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
Date: Mon, 13 Oct 2025 20:17:32 -0400
Message-ID: <20251014001734.3748199-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101316-disarm-pried-7a1f@gregkh>
References: <2025101316-disarm-pried-7a1f@gregkh>
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


