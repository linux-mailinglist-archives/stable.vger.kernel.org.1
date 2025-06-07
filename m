Return-Path: <stable+bounces-151752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE5AD0C73
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7477A9C90
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632B217F29;
	Sat,  7 Jun 2025 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LlzzlBiV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFF20CCED;
	Sat,  7 Jun 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749290897; cv=none; b=cdHSgreHK9TEKQ960+o3Itd+2UV146DZzkbC/pzodXOeKE7GWGinfQbGP5Z4SRZDAdCskugkyxy+YtGsETe3iojG9o13tcO56juD7A/9pyYPM9UAlgWKEPS4a1O8xpwdJrVgYp0c8jvB1xUlvR+LzSvm0pCdMH4MUzr02E9gPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749290897; c=relaxed/simple;
	bh=OuuipQSKdH0qNswtWfrDtpTtBzGZa3RuDJE4SNFhUPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5QJcTLXGSRio5saTyZT7ppe8LOPE4fpc3UXbcQiRmP/OxiYVc2sQTR59A6xtAJDemoPzahpi76y/elIzgV0j6zGervsL4JH0Ava60xqYwRj8jv+wUXRexh6XENnNtfGAs7nhtt0vXKXFwu1fIiJ0LC4y8Q9F5yQtax9qBpMSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LlzzlBiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AA7C4CEE4;
	Sat,  7 Jun 2025 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749290895;
	bh=OuuipQSKdH0qNswtWfrDtpTtBzGZa3RuDJE4SNFhUPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlzzlBiV42kGOYJQmRbJ3+R/opWkz/bUkeIJ8Bmd2fF26E84PfZpiLmPXnl2ij4+M
	 tuVER850X8yP4RUtYbEyDWj/IdLLjYbmIkEDEoyw2AnYCdhCJlL+5eTS4h/qqhdUNa
	 qH7XrxCiw/NpKJPkVsKZXyhXIV9L82DkF9S7DEVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiayi Li <lijiayi@kylinos.cn>,
	stable <stable@kernel.org>
Subject: [PATCH 6.12 14/24] usb: quirks: Add NO_LPM quirk for SanDisk Extreme 55AE
Date: Sat,  7 Jun 2025 12:07:45 +0200
Message-ID: <20250607100718.458648926@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
References: <20250607100717.910797456@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayi Li <lijiayi@kylinos.cn>

commit 19f795591947596b5b9efa86fd4b9058e45786e9 upstream.

This device exhibits I/O errors during file transfers due to unstable
link power management (LPM) behavior. The kernel logs show repeated
warm resets and eventual disconnection when LPM is enabled:

[ 3467.810740] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0020
[ 3467.810740] usb usb2-port5: do warm reset
[ 3467.866444] usb usb2-port5: not warm reset yet, waiting 50ms
[ 3467.907407] sd 0:0:0:0: [sda] tag#12 sense submit err -19
[ 3467.994423] usb usb2-port5: status 02c0, change 0001, 10.0 Gb/s
[ 3467.994453] usb 2-5: USB disconnect, device number 4

The error -19 (ENODEV) occurs when the device disappears during write
operations. Adding USB_QUIRK_NO_LPM disables link power management
for this specific device, resolving the stability issues.

Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20250508055947.764538-1-lijiayi@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -372,6 +372,9 @@ static const struct usb_device_id usb_qu
 	/* SanDisk Corp. SanDisk 3.2Gen1 */
 	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* SanDisk Extreme 55AE */
+	{ USB_DEVICE(0x0781, 0x55ae), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Realforce 87U Keyboard */
 	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
 



