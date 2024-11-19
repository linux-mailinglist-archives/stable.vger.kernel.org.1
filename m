Return-Path: <stable+bounces-93945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448AE9D21FC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB10281E8A
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F74C198A1A;
	Tue, 19 Nov 2024 08:58:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk [212.23.3.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAD146D53;
	Tue, 19 Nov 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006714; cv=none; b=kwKCubmA6AuBvccb9qC/Or+N0VMMegWVvF2s7X04C9Pml+5tBAk+bBnILuIPjIPzHZE07ik+7HC3d0p+HmJn9OdXxmDI1+trVPDmiGmUxxKPAzX/dTp68UsxuHV47tqsVzKR9dtActBLhlup3REy7OkDlVdF0gnASVIx4D6Zvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006714; c=relaxed/simple;
	bh=3MJqZujfzQTnUBOQrzwOW7HNIkITbNo0p80ffTxP4rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWva82Tu+1rdhCAFszVdIR+7rXYxoYxSgmjSq4LOx/3Wa/U5BvZgXUM5Rjtlc46YD8z9z/VCEGNvMasnmlCLKPmkXK+/jhHlZzDhSK1ma/hckkIvMWakKpg/cpVz2kWvXEHqvIda9DhAXarGY68Bo1ANDEWvOI2iwwIhb1uC6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.3] (helo=smarthost01b.sbp.mail.zen.net.uk)
	by queue02a.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tDK41-003kCX-Nq;
	Tue, 19 Nov 2024 08:58:25 +0000
Received: from [217.155.46.38] (helo=sean-Byte.localdomain)
	by smarthost01b.sbp.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tDK3t-000PBm-CV;
	Tue, 19 Nov 2024 08:58:17 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [Patch v] drivers/card_reader/rtsx_usb: Restore interrupt based detection
Date: Tue, 19 Nov 2024 08:58:15 +0000
Message-ID: <20241119085815.11769-1-sean@starlabs.systems>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01b-IP: [217.155.46.38]
Feedback-ID: 217.155.46.38

This commit reintroduces interrupt-based card detection previously
used in the rts5139 driver. This functionality was removed in commit
00d8521dcd23 ("staging: remove rts5139 driver code").

Reintroducing this mechanism fixes presence detection for certain card
readers, which with the current driver, will taken approximately 20
seconds to enter S3 as `mmc_rescan` has to be frozen.

Fixes: 00d8521dcd23 ("staging: remove rts5139 driver code")
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
2.45.2


