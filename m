Return-Path: <stable+bounces-185402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0CBD4D43
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFDD546E39
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A00314B64;
	Mon, 13 Oct 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HPbHB5U7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE00314A9C;
	Mon, 13 Oct 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370191; cv=none; b=P0ehau5+UpZR3TEpuF32K/gY8DK6YsU975sjzFlQeyUeX0YwMBCjN5sYCoGZBmD/Fl0u2yB51BVDiShdg2S60nMZYGbFa+Mo0F8eknnuIxW6NFFaO1VtXSD1ilGgNjMM1utbIZER41eqcfBiLWgOReJ0r1mDxxQEjCQKuyWCPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370191; c=relaxed/simple;
	bh=rVdc1jkhYuRxuA+tvObg5Rm8Pc+3j1X+PgwBV0Kfm3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQMeL1jGHx2d6ppx6Cpaapl9T75IN6nFSxQ8Aohjj30pPxeWjgEiTYvtiTJ36qToI3cNPVN0MWP8cJu6j90SRcwdeDBUfS5YWxMmDh3nYb7Y58Ey0QzkjXRMDSwcX9rCNX7ab6E8DaCRARQ+wkBo3WeCUEwz/PRqnSViRFREX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HPbHB5U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE7EC4CEE7;
	Mon, 13 Oct 2025 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760370191;
	bh=rVdc1jkhYuRxuA+tvObg5Rm8Pc+3j1X+PgwBV0Kfm3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPbHB5U71w5wbW6tieuCPj2J691uMfNQWd4b/Z156oz8YURyFMsGi+3Skj2+f7eVJ
	 /A5PLP1Vn5K6Qk3x7VPdHkCldRNIsGa4mUZ5MgMzAL+CIsPtDPlxXcvilnOror6AuU
	 beX00ail7rTnb2krkVfC8Suf7/vo5aw8fQDsdtus=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.17 510/563] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon, 13 Oct 2025 16:46:11 +0200
Message-ID: <20251013144429.782942111@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hansg@kernel.org>

commit 64e0d839c589f4f2ecd2e3e5bdb5cee6ba6bade9 upstream.

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



