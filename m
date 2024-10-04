Return-Path: <stable+bounces-81078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F3B990EA8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EED72811C4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5874522913C;
	Fri,  4 Oct 2024 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMBJPQ/X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF6229134;
	Fri,  4 Oct 2024 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066643; cv=none; b=kHEPT6E73DvDGUMngFVKZ0iSaeManA2KN3qVUncrYPWdw4EPruS2zngkMmMFeV8te73u1WVRwFtryEzdY4ywCjyxP5wmuTSIfDEMuZAPgifTsP0aZW6lDjTtv2hDuI3CdQTLT/bjURWc8Z0AizmNPeLYkHtWSwaVYAKvBhZuiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066643; c=relaxed/simple;
	bh=MaYjvsyoatj4NdzTuFjW9Ps4VH7HsttdzXPfap09Soo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLjD+bMtTI/ajcY2iL6wADlcpRbczH6cghxLtw/gep053cp2EHDKwwTZNvn/HmWzojFmR+7J1B03a2oWDQnlrqru3cVY1SWPV07lFmuxQu9i0KJJMD+lX5DBJbX2FSEAr7m9wpkGF2SJ9rUc1LjyBk/gQ5+RL5bwE3gs14J9VS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMBJPQ/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCBFC4CED2;
	Fri,  4 Oct 2024 18:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066642;
	bh=MaYjvsyoatj4NdzTuFjW9Ps4VH7HsttdzXPfap09Soo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMBJPQ/X8XY5x0H5Zn0zneu3Z8IrHLtbH4SnXp6IfNJTwy354tnHcCpRrTAcflaKk
	 IbRLHzJ2MJAcC0JZxGwOGSz++nhtVyULmnxxvj3nLR9WjnPwzD7fPoXE0osdM+Y9gO
	 aOSSBo9kmgOQbSFgwVeEqyRXm/SuaZpKJ7hH/DYiwKWGAkhO3T4x6bmUe5GHDW++g8
	 KTf3ZV199FaLAMkwwSLSxPbd/6j44e9c5JSqczw7ZfBLIcXHQkAQYEBBISuidJ8ls8
	 88Is+umNRjDzs+fefqsShteQ3lxdnekzWhYKutHUIuy7eNPgp0KEBPAEyiHQpRDGpt
	 61mDzcjf8OGbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 20/26] usb: chipidea: udc: enable suspend interrupt after usb reset
Date: Fri,  4 Oct 2024 14:29:46 -0400
Message-ID: <20241004183005.3675332-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 67d8da04848ec..5cdf03534c0c7 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -83,7 +83,7 @@ static int hw_device_state(struct ci_hdrc *ci, u32 dma)
 		hw_write(ci, OP_ENDPTLISTADDR, ~0, dma);
 		/* interrupt, error, port change, reset, sleep/suspend */
 		hw_write(ci, OP_USBINTR, ~0,
-			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
+			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI);
 	} else {
 		hw_write(ci, OP_USBINTR, ~0, 0);
 	}
@@ -862,6 +862,7 @@ __releases(ci->lock)
 __acquires(ci->lock)
 {
 	int retval;
+	u32 intr;
 
 	spin_unlock(&ci->lock);
 	if (ci->gadget.speed != USB_SPEED_UNKNOWN)
@@ -875,6 +876,11 @@ __acquires(ci->lock)
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


