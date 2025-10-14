Return-Path: <stable+bounces-185555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0537BD6DFC
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 02:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84A1F4E195C
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87522C0F79;
	Tue, 14 Oct 2025 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlZe7dza"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A702BF3CF
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401058; cv=none; b=pXJAQCnFfICUroOtZw/i3A05L8PWte3XBMzSk3kzL9yDitbuLZcXUBOa9Q5pzA13+jyzw5xvHeoVpin71H10EL64cJkpYmrUaG1R1dp/IdpDQELoKH7aWMXAgy/M4RZxiP5J2GuvTD2mi7+TtzjctXouDT/VGTl2O0A9zzlVkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401058; c=relaxed/simple;
	bh=ixWSgdv0V8B1x5iuEtwIBYT1UuRENhdJ1SbbYJc8Onw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikYpAhGodgZ4Nj5oyGCyaHLnJWGI9snM1RDS8wgPEL+R5acrzQPCQCCRHqEgHWnAUqyIqlGjYCpzNnVbTj5nbUOktLGThnmFiJanHMMIKl8+rGoLCCYTolDQmg0uo0nsyMNC1I7rRiYbl6Ah76CJEt12Zuk0gM/A0FW+Mpynm2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlZe7dza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C391C116D0;
	Tue, 14 Oct 2025 00:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760401058;
	bh=ixWSgdv0V8B1x5iuEtwIBYT1UuRENhdJ1SbbYJc8Onw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlZe7dza3Acj1gpCcFtuV5ffcatgIqYS2c+DjGEqJ+DdXLSAqeDfRJX1MHCTdFdWr
	 RL42QTUXoK21dxYijgK4SYtNuVQxTZKx/Baxpn3fc0pQkSXsKbAgt+T1KgPtvTJJMU
	 w69QWdcEQbcc4woXWYCw7pxr2vmR1Nve0A4nvKDQTZmMbGp9xnCws4jgwXP81ShpsA
	 5Fn6a3ZaAaCkhWtWc5ygswd7UTJ2+DHib8g93QmowZ6h1F3moaX1bVdBMyM87i8j+P
	 kFsUOkJEXaNoRM2h3st6ppcxhOwoOAnGvzmhZnrXguJWyyk5V9uBRMxvB2ApWPjp+m
	 qiWECnVVS48Sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/3] mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
Date: Mon, 13 Oct 2025 20:17:33 -0400
Message-ID: <20251014001734.3748199-2-sashal@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 9eb99c08508714906db078b5efbe075329a3fb06 ]

REGCACHE_NONE is the default type of the cache when not provided.
Drop unneeded explicit assignment to it.

Note, it's defined to 0, and if ever be redefined, it will break
literally a lot of the drivers, so it very unlikely to happen.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20250129152823.1802273-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 64e0d839c589 ("mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index e787d5655a315..31b30a919348c 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -82,7 +82,6 @@ static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
-	.cache_type = REGCACHE_NONE,
 };
 
 static const struct regmap_irq chtdc_ti_irqs[] = {
-- 
2.51.0


