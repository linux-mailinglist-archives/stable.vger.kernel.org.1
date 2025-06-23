Return-Path: <stable+bounces-156584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC16AE502B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC66A4A0670
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996A21EFFA6;
	Mon, 23 Jun 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DtDirrNA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58178219E0;
	Mon, 23 Jun 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713771; cv=none; b=Ce65DZq987tnUdJPa6BY5ONMamaIRr3i+DWnsSrXWDZ1mjeu1IaaIk7pR5XzS1pg57wT+dgerjYYY7OY9vpGcc/8WckXi1JSktcIqfUZbSwJDSGpWvbjSdEhSKm2Oa0gN+m0bhm98pRpdcJRrsEbiSd4n93S7CQE5ocERz4HdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713771; c=relaxed/simple;
	bh=L3SciUFHFghTX/sZwwCXwJfG09FUF6WOhfHWlzFBbuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfSimRH2khhcRHfHy1AUlpkzPaQ2UsUCK4XcGvLN0KCOv6VeEMOTDUvtpH6AtyBx/Bnnz/y8vYahrDSJ4as5emuK3QPINM5hnpzpVJDZR1gQ/fn7EdV/kypZcsGohIV8xO6fonGTyqgxxSy7wbELQgKoCmm15hu/EHMJG0xIC7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DtDirrNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EA0C4CEEA;
	Mon, 23 Jun 2025 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713771;
	bh=L3SciUFHFghTX/sZwwCXwJfG09FUF6WOhfHWlzFBbuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtDirrNAsZ6CQq9egmLzf165++ISAn5/58eMyGYm8bowXfDmG1zN0CLYDix0RWpaM
	 Z5ttLDhcg6syo5LUIvMrjROfYAgUXAfobYo04yEyzE5xlAmgGpk7xztudT5nOSQMLq
	 rUdXRxlwMuSLP2eMsYQMhNyVjTgDYkLxZv8ZiqPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Heimann <d@dmeh.net>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 166/411] ALSA: usb-audio: Add implicit feedback quirk for RODE AI-1
Date: Mon, 23 Jun 2025 15:05:10 +0200
Message-ID: <20250623130637.872987747@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Heimann <d@dmeh.net>

commit 6a3439a417b910e662c666993798e0691bc81147 upstream.

The RODE AI-1 audio interface requires implicit feedback sync between
playback endpoint 0x03 and feedback endpoint 0x84 on interface 3, but
doesn't advertise this in its USB descriptors.

Without this quirk, the device receives audio data but produces no output.

Signed-off-by: David Heimann <d@dmeh.net>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/084dc88c-1193-4a94-a002-5599adff936c@app.fastmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/implicit.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -57,6 +57,7 @@ static const struct snd_usb_implicit_fb_
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0002, 0x81, 2), /* Solid State Logic SSL2+ */
 	IMPLICIT_FB_FIXED_DEV(0x0499, 0x172f, 0x81, 2), /* Steinberg UR22C */
 	IMPLICIT_FB_FIXED_DEV(0x0d9a, 0x00df, 0x81, 2), /* RTX6001 */
+	IMPLICIT_FB_FIXED_DEV(0x19f7, 0x000a, 0x84, 3), /* RODE AI-1 */
 	IMPLICIT_FB_FIXED_DEV(0x22f0, 0x0006, 0x81, 3), /* Allen&Heath Qu-16 */
 	IMPLICIT_FB_FIXED_DEV(0x1686, 0xf029, 0x82, 2), /* Zoom UAC-2 */
 	IMPLICIT_FB_FIXED_DEV(0x2466, 0x8003, 0x86, 2), /* Fractal Audio Axe-Fx II */



