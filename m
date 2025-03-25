Return-Path: <stable+bounces-126508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D558AA700FA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E7D19A3B5A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8987125D91E;
	Tue, 25 Mar 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1pDXdrYS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858E26F440;
	Tue, 25 Mar 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906357; cv=none; b=bFgjI6iucRl2/EsGTKq1x4JBlMhgLX4r3liyZHeEUY7m8Nzpfloel9Q8ZBVIs/4zltZsIn1ZlEsOwZWb3TtQAGlq5qCyoEBfmuubNe+etmGVWtPDMtVSLCI8dBt7n+hu6ntgRM0cRhdVpNmzYnhj+wYtxJVJf6yfIZv47AMmgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906357; c=relaxed/simple;
	bh=RA7ySmJ7rdIQ6fTKxB9jakc+GKdhM+VJpokD7wTw99A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyWob44q5uCP0WZWAZBFGIhzpWNPm9/rRC7qToRy0D6sv/IRVcWqk7sg9NNn90hm398PvgduQZ/Znblf3BWk+z/zfQozTGYyMibo8NLuQ7B66XopFFNZxBjvnOJgf0wzRbizxJr9UhLF+UahDQolG0sHBMUoQ8fmCuqz+/GO+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1pDXdrYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85592C4CEEE;
	Tue, 25 Mar 2025 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906354;
	bh=RA7ySmJ7rdIQ6fTKxB9jakc+GKdhM+VJpokD7wTw99A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1pDXdrYSARNP9L1LHRi9BQYmGklE1RyEmM8vPYwaP3mNX1wH/N6W9NXX89fw5v1Zb
	 gAyu7iQ9xL5tfFS5Wd1giXGKjXMZfdrYN+zpvdbj/rm5ehtFl0f2mOv2Y4qC3CrJWY
	 VC0mmaN91nKsR6YBl4YAraRixeATdfhnuW72AmJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gu Bowen <gubowen5@huawei.com>,
	Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.12 073/116] mmc: atmel-mci: Add missing clk_disable_unprepare()
Date: Tue, 25 Mar 2025 08:22:40 -0400
Message-ID: <20250325122151.075965819@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
References: <20250325122149.207086105@linuxfoundation.org>
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

From: Gu Bowen <gubowen5@huawei.com>

commit e51a349d2dcf1df8422dabb90b2f691dc7df6f92 upstream.

The error path when atmci_configure_dma() set dma fails in atmci driver
does not correctly disable the clock.
Add the missing clk_disable_unprepare() to the error path for pair with
clk_prepare_enable().

Fixes: 467e081d23e6 ("mmc: atmel-mci: use probe deferring if dma controller is not ready yet")
Signed-off-by: Gu Bowen <gubowen5@huawei.com>
Acked-by: Aubin Constans <aubin.constans@microchip.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250225022856.3452240-1-gubowen5@huawei.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/atmel-mci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2499,8 +2499,10 @@ static int atmci_probe(struct platform_d
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
 	ret = atmci_configure_dma(host);
-	if (ret == -EPROBE_DEFER)
+	if (ret == -EPROBE_DEFER) {
+		clk_disable_unprepare(host->mck);
 		goto err_dma_probe_defer;
+	}
 	if (ret == 0) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;



