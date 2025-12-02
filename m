Return-Path: <stable+bounces-198017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA0C99A47
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 01:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9A8D4E1594
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 00:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D544450F2;
	Tue,  2 Dec 2025 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQGM2Qyl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C31862
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764634960; cv=none; b=oOGwVoRPE2Tak7XgVehj47rBF0XZOXGWO4wmPXKlVE3fwryh4CHA9UfoMj/JUzjBh6qQXAijMj1fD8u1dW96RXrZwFCjSfYZzfwwf5bT9ppUK5Ouag+E+Rh4x6dxUEmcA1sz8gDOuZTfMTumZM37ba0a7PsFGxY3cbAT/qP5sII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764634960; c=relaxed/simple;
	bh=+WNXxCru9nZLKn9N287aSyuLFrM9zcEI4fAjCx2Pkqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBtM1MTfpYTfzWARDpoSulAxomDPfil+JjcIFNB35boacuoeJcApVrHkvFyzrcBWS1zmfbwt5g3iYL1OzaNLaOlUdazj2MFxE27Cn6qBU8iZs8h/8ylXrP6GBdEg+1+1yDIgdmLbg9GsTk3j0PXAWtejekvCrBZo/iwBmLCo10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQGM2Qyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CD6C4CEF1;
	Tue,  2 Dec 2025 00:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764634959;
	bh=+WNXxCru9nZLKn9N287aSyuLFrM9zcEI4fAjCx2Pkqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQGM2QylnyTxqlKngIZfsgSddzVIO8Mv4mRQVSasbPRfNCKa1ayI4wxExNm4btmuj
	 9L+boR2Rt6sam5DOOC38ONNfFUNGatqH1ybzi97pBEbuCQnGGPXyKNkIW7UdX63/at
	 2iOd+Mu5XAgrgSis6px6sopO09sOKfLRfY2EkJ3tN6C7InC6852EZn0BDxoHUngeQX
	 omzlufYkfJ20XBBPwd1KQPW0iPo2eAIjnoTVO3WjqfTRduItbaCj2i3IBjqdfPHkNb
	 HxBB/rUoWmw9ZhrbZTZLxTiiSwBy6Gz8FMVhrp/O+Ps/z7lj+/ek5sov9CwTuX1iaF
	 a/DH5GGlxjOUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: renesas_usbhs: Convert to platform remove callback returning void
Date: Mon,  1 Dec 2025 19:22:30 -0500
Message-ID: <20251202002231.1497163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120127-recital-default-e35a@gregkh>
References: <2025120127-recital-default-e35a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 456a91ce7de4b9157fd5013c1e4dd8dd3c6daccb ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart from
emitting a warning) and this typically results in resource leaks. To improve
here there is a quest to make the remove callback return void. In the first
step of this quest all drivers are converted to .remove_new() which already
returns void. Eventually after all drivers are converted, .remove_new() is
renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20230517230239.187727-89-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: eb9ac779830b ("usb: renesas_usbhs: Fix synchronous external abort on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/renesas_usbhs/common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 6343ef4e184b5..818c1ad16e5c6 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -790,7 +790,7 @@ static int usbhs_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int usbhs_remove(struct platform_device *pdev)
+static void usbhs_remove(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 
@@ -810,8 +810,6 @@ static int usbhs_remove(struct platform_device *pdev)
 	usbhs_mod_remove(priv);
 	usbhs_fifo_remove(priv);
 	usbhs_pipe_remove(priv);
-
-	return 0;
 }
 
 static __maybe_unused int usbhsc_suspend(struct device *dev)
@@ -856,7 +854,7 @@ static struct platform_driver renesas_usbhs_driver = {
 		.of_match_table = of_match_ptr(usbhs_of_match),
 	},
 	.probe		= usbhs_probe,
-	.remove		= usbhs_remove,
+	.remove_new	= usbhs_remove,
 };
 
 module_platform_driver(renesas_usbhs_driver);
-- 
2.51.0


