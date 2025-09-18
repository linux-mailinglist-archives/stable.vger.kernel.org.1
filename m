Return-Path: <stable+bounces-173628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A080B35E30
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8901BC2E02
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8963375DC;
	Tue, 26 Aug 2025 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VBVidhuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70322FD7C8;
	Tue, 26 Aug 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208741; cv=none; b=YXWcDl4nvFq0beICoPEUAZvivCBet8r2EA4lZCTOf8uW8kq+HrtBnpmQoAgN0OQImwKgs+FjFB6YqhOZRa4pFZQ9HenEKd3viYXmcZjJThJF8lPR78CkUN5BAphXxEE0P39VW7xJ93DQhW+PN1KD5TwzmKR0JoVpBFxCpQWN7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208741; c=relaxed/simple;
	bh=5At/mSDMfRN8zvBAxMN8X/yN3uGfBOqeYH6SWG0nMgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeuKmu6pCyaFKswbFprcVxqSFLhjyIhwDS5fFGkAuPeWZYCaeIq2CN6M2RB3JlKgvk1oC5NjI4qSj5JCZ/b1bT4JXYIOQqJMJ7gGVl95XE9eJ431KWbZ+0dsb9ByODyjPjkNpLiuGXdthVm67QORtabebCldZ6VJ5zz3ZbIamos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBVidhuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440DFC4CEF4;
	Tue, 26 Aug 2025 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208741;
	bh=5At/mSDMfRN8zvBAxMN8X/yN3uGfBOqeYH6SWG0nMgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBVidhuR4EA9uTvGuqw+kwEAazmcuGabXCuOdxRdVV0QyguMH2NX7AI+2LA/ac7j8
	 7v5fe9x89gawtNvLtTnaiK/eksRGnEeBL3YAtPFYJitYy/+S3eJYicdFiz5wCbcTOo
	 itr9tn7e1ZKaLDWKhsmaibTni67q6ir4j5FEris8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mael GUERIN <mael.guerin@murena.io>,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.12 227/322] USB: storage: Add unusual-devs entry for Novatek NTK96550-based camera
Date: Tue, 26 Aug 2025 13:10:42 +0200
Message-ID: <20250826110921.502407191@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mael GUERIN <mael.guerin@murena.io>

commit 6ca8af3c8fb584f3424a827f554ff74f898c27cd upstream.

Add the US_FL_BULK_IGNORE_TAG quirk for Novatek NTK96550-based camera
to fix USB resets after sending SCSI vendor commands due to CBW and
CSW tags difference, leading to undesired slowness while communicating
with the device.

Please find below the copy of /sys/kernel/debug/usb/devices with my
device plugged in (listed as TechSys USB mass storage here, the
underlying chipset being the Novatek NTK96550-based camera):

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0603 ProdID=8611 Rev= 0.01
S:  Manufacturer=TechSys
S:  Product=USB Mass Storage
S:  SerialNumber=966110000000100
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Mael GUERIN <mael.guerin@murena.io>
Cc: stable <stable@kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20250806164406.43450-1-mael.guerin@murena.io
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/unusual_devs.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -934,6 +934,13 @@ UNUSUAL_DEV(  0x05e3, 0x0723, 0x9451, 0x
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_SANE_SENSE ),
 
+/* Added by Maël GUERIN <mael.guerin@murena.io> */
+UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
+		"Novatek",
+		"NTK96550-based camera",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_BULK_IGNORE_TAG ),
+
 /*
  * Reported by Hanno Boeck <hanno@gmx.de>
  * Taken from the Lycoris Kernel



