Return-Path: <stable+bounces-164673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39825B110D9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0161CE1609
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B852EBDD7;
	Thu, 24 Jul 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="gtJZUEnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp119.iad3b.emailsrvr.com (smtp119.iad3b.emailsrvr.com [146.20.161.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A81DA23
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381625; cv=none; b=ZU2udlf0nc3kbUAkNCb8vP7hniz/vMq7giXN3IcaxjNqZO/44Wv5oljcRRMsZca3iZoQ9cBS9cB6rajjcW3x+FA8/ruc226gk12VSFHdK3xZrfsAr3T/QLusLJbuviq0IlTfqlqy14FBAWE5UpWPxGXUeD0sE9A/GThanzCQ3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381625; c=relaxed/simple;
	bh=U8imHUOgI9+psT8tLYlRziI5dGzHAPj5el8FWZJILxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeaBHay6EZSKgFFHXUTCOt5t835qvBLyAHq7zVTnZY9sX08AKnXLxtiXezKeNm4VpsVpjv5psbYr67OtyyAJy5HMTAsS54Qmq1imaa5ivmzB/7fMn5KfYwCJLPj+dDhZ/MiXB/IqFWw5JOCF1+xN6TOt8k209DTC+pA4M6xgBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=gtJZUEnf; arc=none smtp.client-ip=146.20.161.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381025;
	bh=U8imHUOgI9+psT8tLYlRziI5dGzHAPj5el8FWZJILxs=;
	h=From:To:Subject:Date:From;
	b=gtJZUEnfK2Kep55pLQcoIE5VJEibky5LZIa5lBxO9zmpIhbqhauF6p2403C1bGv6p
	 pbKchmwFL2QRwT7E3GxrJOdbSnEudRJBTr0/zraZdFIPfTAvJQR1RgbK6btNMSPEGF
	 0/f9Ct1gnSp9sPXbo0tK/JvrnWh3FKqDeQjOSiyQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A5D36600F3;
	Thu, 24 Jul 2025 14:17:04 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: das6402: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:16:43 +0100
Message-ID: <20250724181646.291939-6-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: d9dea1d7-0c3d-4a32-a1eb-78b88e148596-6-1

[ Upstream commit 70f2b28b5243df557f51c054c20058ae207baaac ]

When checking for a supported IRQ number, the following test is used:

	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
	if ((1 << it->options[1]) & 0x8cec) {

However, `it->options[i]` is an unchecked `int` value from userspace, so
the shift amount could be negative or out of bounds.  Fix the test by
requiring `it->options[1]` to be within bounds before proceeding with
the original test.  Valid `it->options[1]` values that select the IRQ
will be in the range [1,15]. The value 0 explicitly disables the use of
interrupts.

Fixes: 79e5e6addbb1 ("staging: comedi: das6402: rewrite broken driver")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707135737.77448-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/das6402.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/das6402.c b/drivers/staging/comedi/drivers/das6402.c
index 96f4107b8054..927d4b832ecc 100644
--- a/drivers/staging/comedi/drivers/das6402.c
+++ b/drivers/staging/comedi/drivers/das6402.c
@@ -569,7 +569,8 @@ static int das6402_attach(struct comedi_device *dev,
 	das6402_reset(dev);
 
 	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
-	if ((1 << it->options[1]) & 0x8cec) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0x8cec) {
 		ret = request_irq(it->options[1], das6402_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {
-- 
2.47.2


