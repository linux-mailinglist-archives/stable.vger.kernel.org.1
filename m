Return-Path: <stable+bounces-98807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498AC9E575B
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB16618802C3
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962C9218AB8;
	Thu,  5 Dec 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="O+G8DrPB"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC88214A75;
	Thu,  5 Dec 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405844; cv=none; b=CG3jY0fTMyRxkytjuJXoX/moVEJTp5r+qc5bpULEFcGWMP16jtDIvVK8tMAwEHH8t0fKoSUd7Z7b+3Sokg5Z8YRfz5nukRREQ5L92YLtEnwgba1ljO2Q33qJoO/amr6lKlJX7ieM/d1VFGjfnD66KKeFfCxGuHFKSE/pVu7I/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405844; c=relaxed/simple;
	bh=MuSNupq+jL+RBETivFuja2wUSUSVxq0rZUu3LD74f0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YEWI7axTZL+U1tGtSwbqlhqiCyroBQVS9uCMYEhd4heHzFJh6cpu03WI3opWemT2QiN/1MTmtmQ4c/vH6laLY5FD1PNqsdwnYby4DXdL+maMn7ltprmHC5/pgjYMKZimPyNQ21cAx1TTCuKNPs30EqvyMfuoon6j2JWDmrqHoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=O+G8DrPB; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id B21D840762DC;
	Thu,  5 Dec 2024 13:37:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B21D840762DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1733405838;
	bh=qXC+JNnge7175eBGv9qK1hEZB9g9/Z0J1dck2au77iI=;
	h=From:To:Cc:Subject:Date:From;
	b=O+G8DrPBjhnD1EYq7qabhUTvbia72WC/ekLgb4ASGWXXRm3IyF9eC2fEYbhO8OHKu
	 BQlzBJgk/PfHRsM6LbfmycmnUm0wJXPuB8Rd+Hge1vV0oTZtUBO6tI31Fxo5S5plWG
	 dB8vzJ44uxbZbUYeybs1tC0mfOoeWBwYSMfrTSis=
From: Vitalii Mordan <mordan@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Magnus Damm <damm@igel.co.jp>,
	Paul Mundt <lethal@linux-sh.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] usb: r8a66597-udc: fix call balance for r8a66597->clk handling routines
Date: Thu,  5 Dec 2024 16:37:03 +0300
Message-Id: <20241205133703.885145-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock r8a66597->clk was not enabled in r8a66597_probe,
r8a66597->clk will contain a non-NULL value leading to the clock being
incorrectly disabled later in r8a66597_remove.

Use the devm_clk_get_enabled helper function to ensure proper call balance
for r8a66597->clk.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: d2e27bdf2870 ("usb: add clock support to r8a66597 gadget driver")
Cc: stable@vger.kernel.org
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index ff6f846b1d41..8518feb90792 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1812,10 +1812,6 @@ static void r8a66597_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-
-	if (r8a66597->pdata->on_chip) {
-		clk_disable_unprepare(r8a66597->clk);
-	}
 }
 
 static void nop_completion(struct usb_ep *ep, struct usb_request *r)
@@ -1876,12 +1872,11 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
-		r8a66597->clk = devm_clk_get(dev, clk_name);
+		r8a66597->clk = devm_clk_get_enabled(dev, clk_name);
 		if (IS_ERR(r8a66597->clk)) {
-			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
+			dev_err(dev, "cannot get and enable clock \"%s\"\n", clk_name);
 			return PTR_ERR(r8a66597->clk);
 		}
-		clk_prepare_enable(r8a66597->clk);
 	}
 
 	if (r8a66597->pdata->sudmac) {
@@ -1953,9 +1948,6 @@ static int r8a66597_probe(struct platform_device *pdev)
 err_add_udc:
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 clean_up2:
-	if (r8a66597->pdata->on_chip)
-		clk_disable_unprepare(r8a66597->clk);
-
 	if (r8a66597->ep0_req)
 		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 
-- 
2.25.1


