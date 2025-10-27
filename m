Return-Path: <stable+bounces-190238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B49C10365
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 127A64FAE1F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2D32863C;
	Mon, 27 Oct 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3TwOxFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A01326D74;
	Mon, 27 Oct 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590776; cv=none; b=UcszhuZ/ZglHHEUUQQjaD3I3cYJQi7dRH8VU8GM1Yp+/av/GDY0XbGFxOwO3aw+cTRvwc3MLs3lSe3RDnR6qAPHhLDxkBNqKFo0JveqnYM9Ct67KIW4C0WLf0i28JkE0iITmyhQzda09xRZki/aCiO2ZOa4CITAFvWMU1ItI4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590776; c=relaxed/simple;
	bh=uOCkmO2c+C+t0FuNJ+4qKR2g4A6nPowH1+Y3Pk4G8L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIKKeVhFaW9F3GbSdE1I5485+EeXWi2RWzSCpVvZeB8T7tevfK8mWQFl5FnXIyD0zK86tU6Md2fV6ROTgFiXznr/amNZ9JZFPeaIsYCFLzEhTg6FyZXrcLBVPxkaqqIukUmeEzJ1fqI3GapdccAiVSAJeBubT6OooeD70vAXOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3TwOxFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E56C4CEF1;
	Mon, 27 Oct 2025 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761590776;
	bh=uOCkmO2c+C+t0FuNJ+4qKR2g4A6nPowH1+Y3Pk4G8L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3TwOxFH23qk+233aGdQb5nUXB87L5kqK67xw61x8bn+lkBU8cnn2zuFddwSrFb3W
	 ODjNPr1IDoYaPe8MpbVEwZ5fwoVv2J70BwxOk41PwEVfwiKgXpaubScF2IJPYcv8DB
	 hF9T3wlVT/UWTzAMRsaLdgSd3zkzsTkuIv0GRSak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 141/224] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon, 27 Oct 2025 19:34:47 +0100
Message-ID: <20251027183512.746229094@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
References: <20251027183508.963233542@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -82,6 +82,8 @@ static const struct regmap_config chtdc_
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
+	/* The hardware does not support reading multiple registers at once */
+	.use_single_read = true,
 };
 
 static const struct regmap_irq chtdc_ti_irqs[] = {



