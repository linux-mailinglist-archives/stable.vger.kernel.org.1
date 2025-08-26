Return-Path: <stable+bounces-173478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12731B35D97
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A4188BCA5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349B32A3C8;
	Tue, 26 Aug 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CQiQMIc3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2D32144B;
	Tue, 26 Aug 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208353; cv=none; b=EE3x8w1zv3tstX3SGsXaSDVzZrn/gbg1SdJobBm5C21A3vPSALSrWkTpADm47TUwe/DP3e9I3A5ovO3aWKEsTQXw8cIuUfp0NrXnboka8xrSVTsGjlWsDxC7uTc+MmDlGD1YjiG8NVuRBmdbAzwaJMsI75/imdyl7x1JZVWvIto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208353; c=relaxed/simple;
	bh=qfUyHQQbwr/MX2a5pRozXA/+vy1aro+lMZwgo4Hx204=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDFbyr9dp/6toPFe9ugUM4v7t9BEQVzWKjwgwjWYg0F8P+D5fCglj75aFf7CzW38ZbSc5pTimyjDdnK7K5l2ZfnpcOVcApB88oM6RJgisRsQlAzGebGm1knqv9vmx5Jb3agMgKIkqEzZY9A/BiGIHbvWGg5aYqrI0Tw/OKzzwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQiQMIc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7077C4CEF1;
	Tue, 26 Aug 2025 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208353;
	bh=qfUyHQQbwr/MX2a5pRozXA/+vy1aro+lMZwgo4Hx204=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQiQMIc3TTs7l8FJXReMlAThBJ4vIRzTA5fa3jyV+QWbn89sJPfdw4P8Dvq5JSccv
	 hJb4coU95gakHuBCVEEhy5w0KBHgoB9D4DoqrMrWYBWDzd9WKf75gRbavgJ5CNbUZJ
	 VlmBpuUP5RNX0SkUFu9VOHpJWTr/YFSe2Xy5j0Ls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.12 071/322] mtd: rawnand: fsmc: Add missing check after DMA map
Date: Tue, 26 Aug 2025 13:08:06 +0200
Message-ID: <20250826110917.338937778@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

commit 6c4dab38431fee3d39a841d66ba6f2890b31b005 upstream.

The DMA map functions can fail and should be tested for errors.

Fixes: 4774fb0a48aa ("mtd: nand/fsmc: Add DMA support")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Rule: add
Link: https://lore.kernel.org/stable/20250702065806.20983-2-fourier.thomas%40gmail.com
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/fsmc_nand.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -503,6 +503,8 @@ static int dma_xfer(struct fsmc_nand_dat
 
 	dma_dev = chan->device;
 	dma_addr = dma_map_single(dma_dev->dev, buffer, len, direction);
+	if (dma_mapping_error(dma_dev->dev, dma_addr))
+		return -EINVAL;
 
 	if (direction == DMA_TO_DEVICE) {
 		dma_src = dma_addr;



