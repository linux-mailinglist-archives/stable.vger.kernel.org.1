Return-Path: <stable+bounces-111348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED083A22EA4
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F363A91AE
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A91EC011;
	Thu, 30 Jan 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iD2nD0xH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661C1EC009;
	Thu, 30 Jan 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245749; cv=none; b=YF5E9CqlORY1LMX8nCQEOFAIpstc7x1it+PUqvg0BiXb0jtw1h0EDID1NBXG7tFTQp/30btJ3XEmF43e1PPiXyv21kROMyiV4gOHfSZ4Rlqm2Rw5GDfwpMmX2oVGNM0rLvj463k8izi66w7vyGi02LKhX6unZXdvU9ogCWyITWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245749; c=relaxed/simple;
	bh=2K7Cs8qw8sD0AnU7ngSArArJhyeW0wP5Yvk01quJhBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC3EBdzm7CxEBTkqkV6MptbLgyqw+V7uAo/q0eOJysM5jVksVuqIaArHWCl1iVy0THbzcUqZD1OToDHv8CkJ7bxNPR8ABnUmk6xfwpXOo/Oq90A5dAYRjOKzFwjDpaqCz/CPUx3g8OvgAlYqjIr7Uc/u53bsYbLrJuYxE6d3XQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iD2nD0xH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9939AC4CEE7;
	Thu, 30 Jan 2025 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738245749;
	bh=2K7Cs8qw8sD0AnU7ngSArArJhyeW0wP5Yvk01quJhBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD2nD0xHcT+wG+7GkVAOVnOSN8fw7Vl2mU5MOGnJ6LaG1J6wcKqduNS9N8/2MFi4f
	 RtCz9ByqkdOj4Mn5fXw8OfjrKKqiEQoD1601rUK1eWnMzcg7MafWVNPHMX+yrW+TUv
	 9eK16QXHD8UY9cfNohTTgbFo760kgtWOJ7yrydRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lianqin Hu <hulianqin@vivo.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 31/40] ALSA: usb-audio: Add delay quirk for USB Audio Device
Date: Thu, 30 Jan 2025 14:59:31 +0100
Message-ID: <20250130133500.954041230@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133459.700273275@linuxfoundation.org>
References: <20250130133459.700273275@linuxfoundation.org>
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

From: Lianqin Hu <hulianqin@vivo.com>

commit ad5b205f9e022b407d91f952faddd05718be2866 upstream.

Audio control requests that sets sampling frequency sometimes fail on
this card. Adding delay between control messages eliminates that problem.

usb 1-1: New USB device found, idVendor=0d8c, idProduct=0014
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: USB Audio Device
usb 1-1: Manufacturer: C-Media Electronics Inc.

Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/TYUPR06MB6217E94D922B9BF422A73F32D2192@TYUPR06MB6217.apcprd06.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2239,6 +2239,8 @@ static const struct usb_audio_quirk_flag
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */



