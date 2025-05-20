Return-Path: <stable+bounces-145612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD5ABDCEB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4617B79C4
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69724C076;
	Tue, 20 May 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KTvt30SA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14992512CF;
	Tue, 20 May 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750690; cv=none; b=QIqgCl0RdcgceYlkZF+Lf35Z4DnvH6lSNlccr+P/xKk/YRgaTMW1stPQtukL9oUnIF8arM1r1IBOzJe/KyRvcJc8FF3p3okbvUu9cmzkJjLIKedvmOiDKe4pPxb2egE/OKfpbwY9/GFHB6iYn1hkNJkb4pSqXu3YGrGKEMZ7Hz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750690; c=relaxed/simple;
	bh=kBrYfAV/qbMO0eWgbGltQA1986PfXf3Gtc7LfdRO4J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8+rNhKWw/Eb8XFoaLj4XwjUEp3pX4aI1BEQGFJIwwU/6RX8GC3DuBe9tpmoEK8H/HBqGCgwRkUY8XvelcciHAFdkGakk3k3iK9cTiLySbNm0cruVQPbH0XY3QHSm7V2QdXoJPlphQb3RQkKofh+1NJKnUgUT1OIBLTZfw9iIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KTvt30SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DBDC4CEE9;
	Tue, 20 May 2025 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750689;
	bh=kBrYfAV/qbMO0eWgbGltQA1986PfXf3Gtc7LfdRO4J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTvt30SAk4cFTRsLSGLN8+NxOfZdFNIAfFxmlO6aFP9DwI+av7PH8ZS/LYUL4IFmM
	 PmpY/Qa5DwHiLO3ztDF5535u6MPjkZNt5pH9NFRqmMmeAcC4bK3Df8DtRECs5HXwUk
	 zJPJm7I2n/TpODj5BQNSPGAwJsmTzo2zJsA9ZcCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Chauvet <kwizart@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.14 090/145] ALSA: usb-audio: Add sample rate quirk for Microdia JP001 USB Camera
Date: Tue, 20 May 2025 15:51:00 +0200
Message-ID: <20250520125814.096115107@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
References: <20250520125810.535475500@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Chauvet <kwizart@gmail.com>

commit 7b9938a14460e8ec7649ca2e80ac0aae9815bf02 upstream.

Microdia JP001 does not support reading the sample rate which leads to
many lines of "cannot get freq at ep 0x84".
This patch adds the USB ID to quirks.c and avoids those error messages.

usb 7-4: New USB device found, idVendor=0c45, idProduct=636b, bcdDevice= 1.00
usb 7-4: New USB device strings: Mfr=2, Product=1, SerialNumber=3
usb 7-4: Product: JP001
usb 7-4: Manufacturer: JP001
usb 7-4: SerialNumber: JP001
usb 7-4: 3:1: cannot get freq at ep 0x84

Cc: <stable@vger.kernel.org>
Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
Link: https://patch.msgid.link/20250515102132.73062-1-kwizart@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2240,6 +2240,8 @@ static const struct usb_audio_quirk_flag
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */



