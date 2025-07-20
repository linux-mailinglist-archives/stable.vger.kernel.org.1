Return-Path: <stable+bounces-163473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22713B0B916
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 01:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759903B6429
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083E221F06;
	Sun, 20 Jul 2025 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeNj++Ky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157E185E7F
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753053288; cv=none; b=U5PtEQcWCfGEk0VsTjyGFoyhApFdKwD3DAlkWQyILRsrG00m+sK1DGesKy8PB9MO1o4LNq7/vZXF0uM4ny3DuCOpTYDzfkQSebEJrHJFubfa9SQAXstCyYzoHal3EfBMGpmXzF1KvaRqFNoxnZzlnm0O/ALij5j+0CThaSPa/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753053288; c=relaxed/simple;
	bh=t1B28GjWwte2J+MxjkgSSxqRJpP/WN52ZNvK0hRNtaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HU8sbcllNbczC6Tycx2jZRfG5BlVsa/4i9hnuRA+fc8u5Wc01JlHmFobHxKIdFp+kxgOPY/lJHEueREOj3D8CuE36v/F59UWZaqN9l3FbG2I88Vd6pcnnL3F9veU7Wtfubx2eXvMiGDSH3HZunl2gcf4QhSQyCN4ANV0Ggvif5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeNj++Ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AA9C4CEE7;
	Sun, 20 Jul 2025 23:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753053288;
	bh=t1B28GjWwte2J+MxjkgSSxqRJpP/WN52ZNvK0hRNtaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeNj++KyudchPVXkSp9Tos8AyTXIncT4jpv2j6w5SVI9fPZLUV3bIv0z07SBC5qWG
	 Q1u/GawxTKceSHxhiU5OTNBemkjJdBxsdyaAnMntHdvbecwWxDrECOA4UCUz9zyeRR
	 Ara0l49ERfkeO0ot2Lwr0hv1wK6EiXC4fM9mNPMT8oQA4sE7eA7IgpKxNc/6XiQ56g
	 7UIGBAM4c4fviH6WFtN4kO9hNAhTB+iGQom8i9ZSRlEx/iXbRFN/sNh5fDuSf4xHiQ
	 VUiC5D8uDwb8x/dtn8vkdInSb6muOHAUkzPM4+5llu39mjQtNzJ6kqUn8IFuv9GukY
	 5a0a7us/ReAKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>,
	stable <stable@kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS
Date: Sun, 20 Jul 2025 19:14:40 -0400
Message-Id: <20250720231440.758157-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070814-pebbly-diffused-9cd9@gregkh>
References: <2025070814-pebbly-diffused-9cd9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Xie <xiehongyu1@kylinos.cn>

[ Upstream commit cd65ee81240e8bc3c3119b46db7f60c80864b90b ]

Disable stream for platform xHC controller with broken stream.

Fixes: 14aec589327a6 ("storage: accept some UAS devices if streams are unavailable")
Cc: stable <stable@kernel.org>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250627144127.3889714-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ no usb3_hcd in 5.4 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index fa320006b04d2..73570b392282d 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -333,7 +333,8 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_usb_phy;
 
-	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
+	if (HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
+	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
 		xhci->shared_hcd->can_do_streams = 1;
 
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
-- 
2.39.5


