Return-Path: <stable+bounces-166475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F5B1A0D7
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931AE176666
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C834E1EF39E;
	Mon,  4 Aug 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0nvbXPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC6253F3A;
	Mon,  4 Aug 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309316; cv=none; b=iajIIfG9R8KUEITuByAhHUI7Nuq00y+umBCYweJ7oX+jRwecSKlxMWgsVFk8Rg0xTAJYgFfIY5WyXgEE559Aoj11EWBRT6EAtgandZS+6cNBnPccQO5qRS4t6ixV5EQ0DN+ZrosRK6F/0IILF3L6qYYLgFHVqxIy0pQGAw/5QgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309316; c=relaxed/simple;
	bh=5i8ksXRMF4rm+8efDBv2Ptfs9c/P1ws+pW5IDHMDSiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tN1GXlsFij2vVJGIPjMqkq9zjzubdbg2BORtgu8GoZpN+/b3oNYL4y4owBCE2oMgf6Jh7ttSfr/YDHvRpD5kR2wcexrsTS5rVM52qfXh/Qea7InZiVEZ/U6s1+m+O4SmN8TPCdqCn6VrJraVy6WS9Tk/FZIUf/dmVPi402o4juA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0nvbXPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165F2C4CEF7;
	Mon,  4 Aug 2025 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754309316;
	bh=5i8ksXRMF4rm+8efDBv2Ptfs9c/P1ws+pW5IDHMDSiY=;
	h=From:To:Cc:Subject:Date:From;
	b=u0nvbXPmUEkT+f75WNAeRw557UDmTQoiGBO6tDYlSQbZIZyOgQJwwYtDQVui3CiY2
	 eiyvSkc472/4dc6vrxktLARiVRBeC3BZtCvFKqRq9STuL1DwBSh10iez6RrFvODrIy
	 dnQ84yua7L2iU/i2s9U8ELBPjLXqULy1NsfAOTpec25jhUIoKn2Rkr8W9k3aGRIFf8
	 zAmFipaG3DIXX4aPUktWKibWtvUUa9KFfncwbAPpaZQ4+mm6QyfpB/r3ix41G+EGTF
	 m9Zv+Bmp8YXjY5O1eoXRjwGaHrAR3qh3mZJa1S81rAxgEeZMo+KZNf0erHOUUEEdXo
	 8rhCB6vo8Lc1A==
From: Hans de Goede <hansg@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon,  4 Aug 2025 14:08:28 +0200
Message-ID: <20250804120828.309790-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing has shown that reading multiple registers at once (for 10 bit
adc values) does not work. Set the use_single_read regmap_config flag
to make regmap split these for is.

This should fix temperature opregion accesses done by
drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
the upcoming drivers for the ADC and battery MFD cells.

Fixes: 6bac0606fdba ("mfd: Add support for Cherry Trail Dollar Cove TI PMIC")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
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


