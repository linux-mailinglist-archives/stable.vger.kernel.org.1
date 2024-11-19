Return-Path: <stable+bounces-93985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAD9D25FE
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222021F213DC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED621CB9E8;
	Tue, 19 Nov 2024 12:37:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from queue02b.mail.zen.net.uk (queue02b.mail.zen.net.uk [212.23.3.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61C13B780;
	Tue, 19 Nov 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019845; cv=none; b=uduvHtNABA8b0Fs7a1ZQZB3lsbg9j3wGI0R0nU5jy+IsNnPG0CX4ZczLjyBZ2FZWO0wc0JIbNLxdKKBjBfWfj3k/tAOIAvNDbNnwtwlLxuPQpShTQ3SgfTGuL3tyi8V/SpB5hKctP7cApDD4pv1LZi3xklNXJJKjVRmxxvKHJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019845; c=relaxed/simple;
	bh=CmIL7qeRA88NLl2b6sRdnrtxuzHKCP12Latcm7tyCHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFheu1kD2m2A7fBVyxTnnPVJ5rsOfQoLwxmX5+mcFGnFLyC42GtPGE34GhveNZLC5SMCgD0GRg5hQ3sWjyvqb0cc8BnFtLiBRjUStcfvz8edbrOqY5zR/CGxZ1ZnbMbKu7597o+57PA4FqWrAum5woYNvFj3twlvILkE859kMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.21] (helo=smarthost01b.ixn.mail.zen.net.uk)
	by queue02b.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tDNCU-003Rex-Qg;
	Tue, 19 Nov 2024 12:19:22 +0000
Received: from [217.155.46.38] (helo=sean-Byte.localdomain)
	by smarthost01b.ixn.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tDNCN-00Ghb8-92;
	Tue, 19 Nov 2024 12:19:15 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] drivers/card_reader/rtsx_usb: Add interrupt based detection
Date: Tue, 19 Nov 2024 12:19:11 +0000
Message-ID: <20241119121912.12383-2-sean@starlabs.systems>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119121912.12383-1-sean@starlabs.systems>
References: <20241119121912.12383-1-sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01b-IP: [217.155.46.38]
Feedback-ID: 217.155.46.38

This commit introduces interrupt-based card detection, identical to
the `rts5139` driver in staging.

This mechanism fixes presence detection for certain card readers,
which with the current driver, will take approximately 20 seconds
to enter S3 as `mmc_rescan` has to be frozen.

Cc: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index f150d8769f19..285a748748d7 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -286,6 +286,7 @@ static int rtsx_usb_get_status_with_bulk(struct rtsx_ucr *ucr, u16 *status)
 int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 {
 	int ret;
+	u8 interrupt_val = 0;
 	u16 *buf;
 
 	if (!status)
@@ -308,6 +309,20 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 		ret = rtsx_usb_get_status_with_bulk(ucr, status);
 	}
 
+	rtsx_usb_read_register(ucr, CARD_INT_PEND, &interrupt_val);
+	/* Cross check presence with interrupts */
+	if (*status & XD_CD)
+		if (!(interrupt_val & XD_INT))
+			*status &= ~XD_CD;
+
+	if (*status & SD_CD)
+		if (!(interrupt_val & SD_INT))
+			*status &= ~SD_CD;
+
+	if (*status & MS_CD)
+		if (!(interrupt_val & MS_INT))
+			*status &= ~MS_CD;
+
 	/* usb_control_msg may return positive when success */
 	if (ret < 0)
 		return ret;
-- 
2.43.0


