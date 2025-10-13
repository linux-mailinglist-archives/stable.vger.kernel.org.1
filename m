Return-Path: <stable+bounces-185535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC0BD6A8A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B25DF34F4B9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75F22DA1C;
	Mon, 13 Oct 2025 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxjsT46P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899F1FCF7C
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395695; cv=none; b=sDP5v66Mo8MCJis6s0ogC+SVBsKqshvBRhAC26tourpuidg8xgnUjcpIyCVEgAvI+rTf6m9BALVR9YJqMn6W2vYJvPgPcI9rITc7YtczqtLaylko2SPklFHeyy4RmP7EqLexnZNWhYaKII6hOTZ6Ca2a17oJesLkNMaTqb9tv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395695; c=relaxed/simple;
	bh=MwlyRZ1S3FOoieomNbG5PxaJH9IzP1/ZJmPlLzsxYjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPVmZewyJUZ1nBTCIaJ6Z9b9KM3l+ojI9hMYMAGjx6KZmEzv4TjbkLrWpKBGt3kcw9J14KTcz77vXqOLy7WS69mkkYya65/nbdwbqzhaJAM2Su7FMc99OrZQZq6B324gsit7ezNxl/h4y9E/wYV4whAj6cQD6GQB9gHLHrMl2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxjsT46P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C71C4CEE7;
	Mon, 13 Oct 2025 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760395694;
	bh=MwlyRZ1S3FOoieomNbG5PxaJH9IzP1/ZJmPlLzsxYjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxjsT46PEaxH35OHnVNA4LoiPoB1/ZTr4rtVODNjY//C9Vi6qVCjr2aU7tNPR9hUP
	 Vg+xNAaRoyJRabiyBS/oZk/52hcK9ymgqv/Ofc6NiCnSv7ucyT5QJlyay1LDMUKt0E
	 YJEG8oaMg8dodoTlzZUvrAhlC+wY7qVfig/nA0CHJ7KhhmllIXaq04ML96XFOL8ezH
	 CChA6aY9yfQwHyD2y78UQKC2Q5GXDPAXJzwe8DmFQyMNUFKETHwyZftB7tMx+1mk4/
	 qtEq0OH8WGYtdH92XdrMqSp5rQwgdpLtjBSNSiwELq6ZBU38gvAQAzM2tV6/j5rKLE
	 qGfpLkV1JfoZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
Date: Mon, 13 Oct 2025 18:48:10 -0400
Message-ID: <20251013224812.3682599-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101306-cufflink-fidgeting-4c7b@gregkh>
References: <2025101306-cufflink-fidgeting-4c7b@gregkh>
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


