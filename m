Return-Path: <stable+bounces-185545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA72EBD6B96
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6142735043D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172432C027C;
	Mon, 13 Oct 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqy081nX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7095212572
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397748; cv=none; b=GBldgO4bArUMIvwJ53svvV+uWwtj5Y56AHtKbgLJnubmuBzlarsLuPFeye1FDbQWbbFFQdkUuJYxem7OC/SF0bY58V5kaAQPXUR1ThnNODxBdBfQY+a1sz5OxG2kXMyio8AS5g23ewV/5IM31mt4n4LR8cx1a2avEgXkZfhWsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397748; c=relaxed/simple;
	bh=flnbE5JrNFGO8+XY30rA8onYp8fbnVryAFkOK77QHj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAahEiDp1kZZqQG5a0X1f3JWJ09sBeXheBzGiqlOkfvJEiuWLbS5Gy9Wrjbkxr9Zaltxd+JDAsx1BrCw2m4GrpOrIHr868TOZ+SBIsozUl8PHa9CGeOizqfsV2YdLWHHwcaIx8XlwbFLCxMzHfPX3VppRATtvxYj29siO+eftMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqy081nX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1687C4CEE7;
	Mon, 13 Oct 2025 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760397748;
	bh=flnbE5JrNFGO8+XY30rA8onYp8fbnVryAFkOK77QHj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zqy081nXS+m5CLWoMKPRfaY2FgFKjZ7QfbATQJU5fKFsnPeznOhwf0/epepI+gB5L
	 jAyCsk1Ga3COlyh06vZj1RxY+Ce6TuaUZMqOn7tOaevLvuIXD6Xy2vhZj4jRrWh6nk
	 MdhX/kCyDhtHz/1Iyz7lCF9845wvEVp/MQ4X95UyxfCmohCPfEwxFnrbiqYtzhO+xN
	 Ysc2qj2gUmTEeW/LA34l29OBm41gsIpf/+c0pWbWe7yewFgWnrh9OJpeOtYEcTy7k6
	 ynGLMk0EUxyeFKvf/jwN7XO5MxjwqSGR+1OXh49Qt4K9oEuiLLtusVu4kai+juIlc/
	 IMVArJRejlv2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
Date: Mon, 13 Oct 2025 19:22:22 -0400
Message-ID: <20251013232224.3709547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101308-pedometer-broadness-3e95@gregkh>
References: <2025101308-pedometer-broadness-3e95@gregkh>
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
index 1c7577b881ff9..6864d906d1957 100644
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


