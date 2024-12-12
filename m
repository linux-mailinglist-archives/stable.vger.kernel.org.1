Return-Path: <stable+bounces-101543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B39EECD1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66010284425
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8814218587;
	Thu, 12 Dec 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7PEKIvL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966446F2FE;
	Thu, 12 Dec 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017925; cv=none; b=GaCRSJ9VhQLlH041pZcMCifEEnGus92CRTUN/LcUUOUGomewFjTcslmnKE7tccWJk8DmuM+C0D1esp+h7N5tx4bMavPSNJaaJdf4j1dZRhDWBdyuQfCoWnzNz0ipw+rxUYRkHAZQ8wMG8hpp8wsyXDdbu36fDWjhwSB7i0vhXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017925; c=relaxed/simple;
	bh=Oh352ycYsNt1goPioD7gzNCqoi2G3T3Ktte5B3zj0rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJKmeC6CnxdfF6T+ZtEVpiVrBrp7o9Q/0vIBDFExmSVahT9euaGJvD1nvEhzA83wOz7YshgGkurcEwu1fNyYLeH/fAvJUrazfqN7d+3CpSDkhPpJfeFnkee1HIxyDOfkmV+ZKsTi/CwjjC+nmnHGQxAYj1Uf2PIaBaL8dIASYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l7PEKIvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03702C4CED0;
	Thu, 12 Dec 2024 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017925;
	bh=Oh352ycYsNt1goPioD7gzNCqoi2G3T3Ktte5B3zj0rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7PEKIvLwOHA2Ygd447X57PJYWPnjlw1SmMUZSxDd0cE7VvRh3PPs1umpquD+DRSc
	 hkBTc5ACksnfw1KTRGrmjcUXQ9omwiwiLf0LKg2heXAqDwQRvVEOrSfUMLKuFr2yMK
	 AppkiS7EZ4cXi0nG6ozlig0oTx2+PHrjCRvkSaGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marie Ramlow <me@nycode.dev>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 149/356] ALSA: usb-audio: add mixer mapping for Corsair HS80
Date: Thu, 12 Dec 2024 15:57:48 +0100
Message-ID: <20241212144250.527915968@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marie Ramlow <me@nycode.dev>

commit a7de2b873f3dbcda02d504536f1ec6dc50e3f6c4 upstream.

The Corsair HS80 RGB Wireless is a USB headset with a mic and a sidetone
feature. It has the same quirk as the Virtuoso series.
This labels the mixers appropriately, so applications don't
move the sidetone volume when they actually intend to move the main
headset volume.

Signed-off-by: Marie Ramlow <me@nycode.dev>
cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20241130165240.17838-1-me@nycode.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer_maps.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -621,6 +621,16 @@ static const struct usbmix_ctl_map usbmi
 		.id = USB_ID(0x1b1c, 0x0a42),
 		.map = corsair_virtuoso_map,
 	},
+	{
+		/* Corsair HS80 RGB Wireless (wired mode) */
+		.id = USB_ID(0x1b1c, 0x0a6a),
+		.map = corsair_virtuoso_map,
+	},
+	{
+		/* Corsair HS80 RGB Wireless (wireless mode) */
+		.id = USB_ID(0x1b1c, 0x0a6b),
+		.map = corsair_virtuoso_map,
+	},
 	{	/* Gigabyte TRX40 Aorus Master (rear panel + front mic) */
 		.id = USB_ID(0x0414, 0xa001),
 		.map = aorus_master_alc1220vb_map,



