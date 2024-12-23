Return-Path: <stable+bounces-105695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9959FB12A
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2427A1E82
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9110B1B21BD;
	Mon, 23 Dec 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yml2XT2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2481AB52D;
	Mon, 23 Dec 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969823; cv=none; b=WzrxyffmSRTVGES3prrElCIoCz41YaCTRxBNFJljEGGCrfZGv2stRStsopM0zi6DfQdSXNFvNjoWibER751CVAj+kO8Tvc3WMtQBlHoDHQBVWG4NQ2cr7uhlV4cegi6LumkpStiO/ChZCNVKPU3HkH3PUwH0zbNUR4tO4WXibM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969823; c=relaxed/simple;
	bh=ed6reQ7bLcDDopsmQgk6rZokgJvwg02d7k7k+1WvFyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOxxTm7fE5xDY0DMjvHOhFQ4gWIvn5Yp5nc1LgsAVoQvWNW4I4y8E6GjeYpDeXpGIQL7UvPtosHhQq+2kpAQ/dM7isTVIEjSBRnQMeandIqHhc8ewSOAqj0EoNTaNR1KITdP73iF5lv/oqkrIcGQJ8P4uyhcNvY9i96A11XFLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yml2XT2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FBBC4CED3;
	Mon, 23 Dec 2024 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734969823;
	bh=ed6reQ7bLcDDopsmQgk6rZokgJvwg02d7k7k+1WvFyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yml2XT2A9j62GdSbbIE7d8QnG4AOdX7upuQ99mTeNqqeLc75Adql6es75pl10eXrX
	 r6kyzl800dKxjkXQEMDjoKujcp2aOKz1598K0IAp69dTl/bJGjkHYJZKbpa92ib4wV
	 ogCM4Tqrz4eoNE6WFXm+NQbXCMy/uflNx/MCCbLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.12 064/160] mmc: mtk-sd: disable wakeup in .remove() and in the error path of .probe()
Date: Mon, 23 Dec 2024 16:57:55 +0100
Message-ID: <20241223155411.141808599@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

commit f3d87abe11ed04d1b23a474a212f0e5deeb50892 upstream.

Current implementation leaves pdev->dev as a wakeup source. Add a
device_init_wakeup(&pdev->dev, false) call in the .remove() function and
in the error path of the .probe() function.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")
Cc: stable@vger.kernel.org
Message-ID: <20241203023442.2434018-1-joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mtk-sd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2924,6 +2924,7 @@ release_clk:
 	msdc_gate_clock(host);
 	platform_set_drvdata(pdev, NULL);
 release_mem:
+	device_init_wakeup(&pdev->dev, false);
 	if (host->dma.gpd)
 		dma_free_coherent(&pdev->dev,
 			2 * sizeof(struct mt_gpdma_desc),
@@ -2957,6 +2958,7 @@ static void msdc_drv_remove(struct platf
 			host->dma.gpd, host->dma.gpd_addr);
 	dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
 			  host->dma.bd, host->dma.bd_addr);
+	device_init_wakeup(&pdev->dev, false);
 }
 
 static void msdc_save_reg(struct msdc_host *host)



