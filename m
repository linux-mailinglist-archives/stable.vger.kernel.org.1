Return-Path: <stable+bounces-186101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A44BE3911
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C531892169
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D32335BBC;
	Thu, 16 Oct 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHrbLyiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5C33437D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619685; cv=none; b=TcXSc24ph9h1BlXtZ0z9qmt2LjLuH6jw7EXFwWq3Utk+Wsi9c9a6hyq8JAUdtTPFZi2oKLoCZdP/uY69vg+TgrygS77hcNKKU+mXzh7GS8esy85EAutd4PYEeCdPuQcjccSeZN4cGDpOrPB6EdYNHxqn576AoVwpws/OYqGKBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619685; c=relaxed/simple;
	bh=ZanNtMuBy2rIhsC9jVOgH2eChCgm8E1YsehPUVkWHpU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lywsijNgda1z3ypZU5MFrlXzs3e7VXiHoW+QWyNYZ93PJy+dKjEmzGrT5w4Co5czLc3/mqSO9lidDQHQLI/Npv7QAbVrnb5cQQEh0xMmBopBateZ1dqZgdo+jSfgYlgVzchN6V9cUfhDF4Ey8M0vlUn+aqeEv0n3Uxpj1mcEfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHrbLyiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5443C4CEFE;
	Thu, 16 Oct 2025 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619684;
	bh=ZanNtMuBy2rIhsC9jVOgH2eChCgm8E1YsehPUVkWHpU=;
	h=Subject:To:Cc:From:Date:From;
	b=VHrbLyiKV0SvH8i9lRfGzEpl1r5BkZ/UXbyA4cQUcTLVNX5q23/LhmupyPQ4ijvSh
	 gkANXcUPmoyiONtzekN5+LYEi0vhShy95RBPwZ6AfXuokUrTtcmEbZ82Tbe4ou5mp+
	 yfHvleX3wI1cvUIvN7HFqvi/Utr5lMCtz/rK053A=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: Flush posted register writes before" failed to apply to 5.4-stable tree
To: pratyush@kernel.org,broonie@kernel.org,s-k6@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:01:21 +0200
Message-ID: <2025101621-blah-dyslexic-116b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 29e0b471ccbd674d20d4bbddea1a51e7105212c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101621-blah-dyslexic-116b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29e0b471ccbd674d20d4bbddea1a51e7105212c5 Mon Sep 17 00:00:00 2001
From: Pratyush Yadav <pratyush@kernel.org>
Date: Sat, 6 Sep 2025 00:29:55 +0530
Subject: [PATCH] spi: cadence-quadspi: Flush posted register writes before
 INDAC access

cqspi_indirect_read_execute() and cqspi_indirect_write_execute() first
set the enable bit on APB region and then start reading/writing to the
AHB region. On TI K3 SoCs these regions lie on different endpoints. This
means that the order of the two operations is not guaranteed, and they
might be reordered at the interconnect level.

It is possible for the AHB write to be executed before the APB write to
enable the indirect controller, causing the transaction to be invalid
and the write erroring out. Read back the APB region write before
accessing the AHB region to make sure the write got flushed and the race
condition is eliminated.

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
CC: stable@vger.kernel.org
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Message-ID: <20250905185958.3575037-2-s-k6@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9bf823348cd3..eaf9a0f522d5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -764,6 +764,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTRD_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTRD);
+	readl(reg_base + CQSPI_REG_INDIRECTRD); /* Flush posted write. */
 
 	while (remaining > 0) {
 		if (use_irq &&
@@ -1090,6 +1091,8 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTWR_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTWR);
+	readl(reg_base + CQSPI_REG_INDIRECTWR); /* Flush posted write. */
+
 	/*
 	 * As per 66AK2G02 TRM SPRUHY8F section 11.15.5.3 Indirect Access
 	 * Controller programming sequence, couple of cycles of


