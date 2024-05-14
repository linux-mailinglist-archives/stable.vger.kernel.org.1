Return-Path: <stable+bounces-44921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC78C54F9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2FB1F22BC1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5857B3E5;
	Tue, 14 May 2024 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/u8Ymz7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE81CFB2;
	Tue, 14 May 2024 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687563; cv=none; b=YwHrxjmOg03LAjB/wD/jGF8nXZrJbzeu0KwdPAIg1GgBw+fpGR6NKfhNadLrRiXk4i8sXlBxSNvYCDOBv9Df1MjVM1sJDwxWb2r/1T+xwQJDPV6sz7vtxHzuUdGcfpLrVuSJAM09ABwhlOLU9ytCisrmKlHzyiYPbzDALtWw7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687563; c=relaxed/simple;
	bh=kgJowunwldrHm820nkOIOBkUhDcEM64ZX90aWsHJvK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWYV8d7YdjL5wkdb4MYofuRwWsu4kg8WvXLTLMdWHq9mfAaqwEdBBJe8yX9lN61MS6i9ywARMHPkYIDwn0sydEcgTkQGoZ6uxJXcR42lxeHnn+JGSuqTr92pDzmXsQRM+ZL/M27fjD5ruyUAILQOV1cm3d4vVTWZBRfGgbC98Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/u8Ymz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9DBC2BD10;
	Tue, 14 May 2024 11:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687563;
	bh=kgJowunwldrHm820nkOIOBkUhDcEM64ZX90aWsHJvK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v/u8Ymz7BkW47BX/wEqsPTWsAAk5xvpu/zKcN5rPRKUbZz2AaM+wW3yrRSR7/pVel
	 /4QsHaVC2O+kMUDhJ+5udp822zlZ2e3bWkLxDxSItDVjt26VbM1nBnQS7PcxsGQayd
	 mO6t6p9y2xOrRpNM3r/0ptK9DF2wE2d53Ey5JgtM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Devyn Liu <liudingyuan@huawei.com>,
	Jay Fang <f.fangjian@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 027/168] spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs
Date: Tue, 14 May 2024 12:18:45 +0200
Message-ID: <20240514101007.715629257@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Devyn Liu <liudingyuan@huawei.com>

[ Upstream commit 7430764f5a85d30314aeef2d5438dff1fb0b1d68 ]

Due to the reading of FIFO during the dump of data registers in
debugfs, if SPI transmission is in progress, it will be affected
and may result in transmission failure. Therefore, the dump
interface of data registers in debugfs is removed.

Fixes: 2b2142f247eb ("spi: hisi-kunpeng: Add debugfs support")
Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
Link: https://lore.kernel.org/r/20240416015839.3323398-1-liudingyuan@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-hisi-kunpeng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 525cc0143a305..54730e93fba45 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -151,8 +151,6 @@ static const struct debugfs_reg32 hisi_spi_regs[] = {
 	HISI_SPI_DBGFS_REG("ENR", HISI_SPI_ENR),
 	HISI_SPI_DBGFS_REG("FIFOC", HISI_SPI_FIFOC),
 	HISI_SPI_DBGFS_REG("IMR", HISI_SPI_IMR),
-	HISI_SPI_DBGFS_REG("DIN", HISI_SPI_DIN),
-	HISI_SPI_DBGFS_REG("DOUT", HISI_SPI_DOUT),
 	HISI_SPI_DBGFS_REG("SR", HISI_SPI_SR),
 	HISI_SPI_DBGFS_REG("RISR", HISI_SPI_RISR),
 	HISI_SPI_DBGFS_REG("ISR", HISI_SPI_ISR),
-- 
2.43.0




