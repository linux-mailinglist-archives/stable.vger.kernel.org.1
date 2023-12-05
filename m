Return-Path: <stable+bounces-4389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D568804747
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4C51C20C79
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB358BF8;
	Tue,  5 Dec 2023 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f1V6YSXs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D96FB1;
	Tue,  5 Dec 2023 03:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B5CC433C8;
	Tue,  5 Dec 2023 03:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747412;
	bh=ZkiuVZxtuoWuCaiPVBOJueyJAtBiuetaWwNkW1hhFp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1V6YSXs8hrQq2CukL5VBPgCxZy2mll5bxRqZUeVlSIxYNN8J7PbDbIXhcF8f+oB0
	 4G7BLcRvF1CZaaFzgL5LBOIcfGlcHgCpGNXzlU+a9W7pE9vsqAh39bAOBBB5rX8tJJ
	 U5oJEjq2iqhHyiBIZghc1akC35jh69Yl4SsxqvB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zubin Mithra <zsm@chromium.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.10 067/135] usb: dwc3: set the dma max_seg_size
Date: Tue,  5 Dec 2023 12:16:28 +0900
Message-ID: <20231205031534.656116220@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

commit 8bbae288a85abed6a1cf7d185d8b9dc2f5dcb12c upstream.

Allow devices to have dma operations beyond 4K, and avoid warnings such
as:

DMA-API: dwc3 a600000.usb: mapping sg segment longer than device claims to support [len=86016] [max=65536]

Cc: stable@vger.kernel.org
Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Reported-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1627,6 +1627,8 @@ static int dwc3_probe(struct platform_de
 
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err5:



