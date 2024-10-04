Return-Path: <stable+bounces-81013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4C990DD3
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AF31C221D4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75931DB343;
	Fri,  4 Oct 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syYo5OKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4F1D9679;
	Fri,  4 Oct 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066490; cv=none; b=eUADTAq/8nTQXYoW5mzobePBtJJ/FpKnFWg/Wo8BbbE/SU1hsRTlThZaqTa9LUfHGmy9/77To4mwPR0qaFF8jWwpzecShCfzfm/woVhBvwiVJBiDya92MLemFgyoG6zeZdd0xAAn7FlBCjuJmGobZ0tTGr5b9KxMesLzqlrJ8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066490; c=relaxed/simple;
	bh=iMoILzupACCtZRHjdUiFHLqjkgzF4g9Kdj6WZGyAT1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pidCXvjlh1BnQ8GmueTdq3yNKmMRGfrYwyRdBj1VqOlOkNlNhZxJT8QtNqPVfGdavXPS4xlveH83KzqwJaFJ0hlHyHO+enQponkLpsSrDgoAmhS7YbAhR7sHreOtaUM4yT/rIenz1TM9lAuNbNVstx71yv6LGBiygtCII+i7G/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syYo5OKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85096C4CED0;
	Fri,  4 Oct 2024 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066490;
	bh=iMoILzupACCtZRHjdUiFHLqjkgzF4g9Kdj6WZGyAT1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syYo5OKUZayoXRZg4q2QMAX49fBvy74EJ56MPXD63hDt14GqHueFThE1QiSarMlq/
	 ZBNz9W5zfppvDYDThsVT3AIe6Hlod8C4sVnJAjs01DoHBGddRfl4kKRHiX1cLnDw0J
	 0WCMOg9vilOD7csA3XoP0yPJAKOe9tXWVZpr4vUhw87+1rNog20OCbXgBMroH1ZJkZ
	 HxBZDTaZ9MO10whwCJoANlV+WLlsoB58rdKwrk+/mM+9zCk82lxvswR81xatajcMYZ
	 5QHgsOviCw0DGulpM1GdaHb8UQLzRi8mvlb+xSXd9AZomrbGhk5R04gyOajLHF5HcF
	 NpHsNd0Ub8jug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 29/42] usb: chipidea: udc: enable suspend interrupt after usb reset
Date: Fri,  4 Oct 2024 14:26:40 -0400
Message-ID: <20241004182718.3673735-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit e4fdcc10092fb244218013bfe8ff01c55d54e8e4 ]

Currently, suspend interrupt is enabled before pullup enable operation.
This will cause a suspend interrupt assert right after pullup DP. This
suspend interrupt is meaningless, so this will ignore such interrupt
by enable it after usb reset completed.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240823073832.1702135-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 8c3e3a635ac2d..35dfc05854fb7 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -86,7 +86,7 @@ static int hw_device_state(struct ci_hdrc *ci, u32 dma)
 		hw_write(ci, OP_ENDPTLISTADDR, ~0, dma);
 		/* interrupt, error, port change, reset, sleep/suspend */
 		hw_write(ci, OP_USBINTR, ~0,
-			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
+			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI);
 	} else {
 		hw_write(ci, OP_USBINTR, ~0, 0);
 	}
@@ -876,6 +876,7 @@ __releases(ci->lock)
 __acquires(ci->lock)
 {
 	int retval;
+	u32 intr;
 
 	spin_unlock(&ci->lock);
 	if (ci->gadget.speed != USB_SPEED_UNKNOWN)
@@ -889,6 +890,11 @@ __acquires(ci->lock)
 	if (retval)
 		goto done;
 
+	/* clear SLI */
+	hw_write(ci, OP_USBSTS, USBi_SLI, USBi_SLI);
+	intr = hw_read(ci, OP_USBINTR, ~0);
+	hw_write(ci, OP_USBINTR, ~0, intr | USBi_SLI);
+
 	ci->status = usb_ep_alloc_request(&ci->ep0in->ep, GFP_ATOMIC);
 	if (ci->status == NULL)
 		retval = -ENOMEM;
-- 
2.43.0


