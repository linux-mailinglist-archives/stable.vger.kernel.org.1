Return-Path: <stable+bounces-163472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468BBB0B8F6
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2583B7668
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 22:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81C220010A;
	Sun, 20 Jul 2025 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQLo2kD0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC41EE019
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051788; cv=none; b=eyy57pJgpItWlLVtwwCw9KBm7UgDkVzYVKciCTPjl90Yh0w7gKtCybxXeWUK9GUWoU4l8QQrSjuhFso+z7VXVWndu6BIdPs2Lz2ks4e9Nqk6i4C+pMbtRemBbkbx0xIyrS3vf+PbGkLOT6AePep+Rp3L5S3hMqLE/rLbKN1m4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051788; c=relaxed/simple;
	bh=ZVuqNtznO2rh1GwAd4exm3IDpC4yBqrhPQBrYD+xnmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3te2m2Q6iT97ECyxVmdKXRj56nlFaeNwURl+u+b37OE/tQtFUX1Y2e12YAz2B98R1IHo42lOW3Z+AMmHMJN+KjOBfdRjNVKFXACYZMWNGCzvi34uL0OxN6BK8mmFPfC76K4WY5nBRbBFZSkc5QO6RxLaCryo8uQTwgYgIvVb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQLo2kD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C86C4CEE7;
	Sun, 20 Jul 2025 22:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753051788;
	bh=ZVuqNtznO2rh1GwAd4exm3IDpC4yBqrhPQBrYD+xnmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQLo2kD0jhphX/AQiK/kX+PaBrN4nxjvRZawnyvzMfHYQrUGGTfA2kFgPTOV2JkDJ
	 kvhA9XvtkhsJY6rKe80+TuQIQfiabDxJBdEMH+FYxhXZ4Q6Lb7BeWVGGBwxyZrUAAk
	 kqG2elMAqlmTU0ohL5C20aZnKBGOxVlgZaWRSCoCqiO3P2r21CMjNQxm5ZtK66+Fpm
	 SWr2+Pasp9AIb4rns/YNjawLcE42d8TNYMxW1hwQbmRTb7QpDDDfPuzz8kiLaiyJG5
	 /7U8rhS4pbuQGN2jqTHfa8Pli5wnd7i4IOhGzC2Z7JYCIhS4Bfg7ii1HCHn30xAm3R
	 fPQxjlePbRWlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>,
	stable <stable@kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS
Date: Sun, 20 Jul 2025 18:49:42 -0400
Message-Id: <20250720224942.755080-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070814-harmonica-eclipse-ad04@gregkh>
References: <2025070814-harmonica-eclipse-ad04@gregkh>
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
[ removed xhci_get_usb3_hcd() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 83c7dffa945c3..daf93bee7669b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -361,7 +361,8 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_usb_phy;
 
-	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
+	if (HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
+	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
 		xhci->shared_hcd->can_do_streams = 1;
 
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
-- 
2.39.5


