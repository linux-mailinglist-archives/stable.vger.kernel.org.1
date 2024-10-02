Return-Path: <stable+bounces-79103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CA98D695
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5E1F23983
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB51D0788;
	Wed,  2 Oct 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LrjwPlZr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72761C9B7E;
	Wed,  2 Oct 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876448; cv=none; b=KohyJvgmrkyLTn6k662Ors1hd9hjMR7yegfQ7g45V/T2w3DXdHdLxHZWr2PzHSprejmHWkR0Zc4T5bRmVVF7a2n113EFh0riOZ39/YenWwS35mQW2SjU/x5i88FY0/6c4IxYufgyH9Q3qIt4IDne+4gNv4j13xw8XKFvojOQDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876448; c=relaxed/simple;
	bh=N69aPJm/WmoQ1/bHIkOgvO7Avwer5zPlk3WkHuhk00o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRlKVSm+uhlQ3ff4/GILjEjk0OEWJ2rhQc2gLOymH2PO3Cg0oxRveP5HWTJ7zyrSHY0RBpcMK+OsFYO4MA2fFe3YGb314lnQLUPKpTxSPZb5Td5HSck/gAEGFrBrsiqfiTyi2jbqj16+ybWeyIiA06rCIgI0BBdzu7lD+jH40I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LrjwPlZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE41C4CEC5;
	Wed,  2 Oct 2024 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876447;
	bh=N69aPJm/WmoQ1/bHIkOgvO7Avwer5zPlk3WkHuhk00o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrjwPlZrKK2Z0tREzI0dwd6/M4U17IZSzj0EDV2v01bhzCbIN5AgsyV+9rAPxCsA/
	 dzuQL2CILsiR5vhQjlKQLXjZUR3b4990q35iQNweHNrVYkpZFpFrUOwORgADNX7n+4
	 DLYDnYGMtOAI3OB2Q1Sg811oa3sX+U93hSJJPayU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 447/695] spi: atmel-quadspi: Undo runtime PM changes at driver exit time
Date: Wed,  2 Oct 2024 14:57:25 +0200
Message-ID: <20241002125840.300220528@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 438efb23f9581659495b85f1f6c7d5946200660c ]

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time unless driver
initially enabled pm_runtime with devm_pm_runtime_enable()
(which handles it for you).

Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
to fix it.

Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20240906023956.1004440-1-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 5aaff3bee1b78..466c01b31123b 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -726,6 +726,7 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 	clk_unprepare(aq->pclk);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 }
 
-- 
2.43.0




