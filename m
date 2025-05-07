Return-Path: <stable+bounces-142483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBAAAEACB
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A49D9C7F63
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3316289823;
	Wed,  7 May 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h/RKmnbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139F1482F5;
	Wed,  7 May 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644392; cv=none; b=scnBgDU3HJ+0IdWktKSO4PDU4sWl69qimZw68CAERPGWNUYUfbpds17FAYqSsaQn1YOZQQ4dk651foSoGZG7guqfb5uUf7pdNV4OIoEh/+UmeXo2YtdVAg1MHLLvjHqOo6CxWaK1d0PWyKrUdON5CjMiSn4STgXDJ86eyqpLVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644392; c=relaxed/simple;
	bh=l8K6iVZKA9L4/aykGfxK+qrcq/320R/G1+MTTQqza+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifTNLrljNhxlppJZSfYB60qcyHgsAgWXzZ6daeCyrXwRXC0+RTD1JZp1Q5LrGNtRlrhomEcb0PT4nrKqD37nlIvDL3TudzkA+UdS71AA4FtDG7qzVNxR1G1GFJWwiA+T29Zxyo7U+zEslkhipjEA1ZeGYmm2qT13Jwuw6KAlFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h/RKmnbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8366C4CEE2;
	Wed,  7 May 2025 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644392;
	bh=l8K6iVZKA9L4/aykGfxK+qrcq/320R/G1+MTTQqza+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/RKmnbJ52F2+/ncNd203YX28UmWPAdGkK4mX8DDy3whnYrH4ZI8doL4n/ndkylFl
	 6omWfOLkDjlngpRzjP1AX2xsrnr2Xz9CQsBDxnM8Y0pTtrcHStpQT7e7PVF/ja6WGW
	 bJrz8B3JqFA8yTDt23Sboyw3QQ3UqLNrXz214pvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joachim Priesner <joachim.priesner@web.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 009/164] ALSA: usb-audio: Add second USB ID for Jabra Evolve 65 headset
Date: Wed,  7 May 2025 20:38:14 +0200
Message-ID: <20250507183821.207948971@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
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

From: Joachim Priesner <joachim.priesner@web.de>

commit 1149719442d28c96dc63cad432b5a6db7c300e1a upstream.

There seem to be multiple USB device IDs used for these;
the one I have reports as 0b0e:030c when powered on.
(When powered off, it reports as 0b0e:0311.)

Signed-off-by: Joachim Priesner <joachim.priesner@web.de>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250428053606.9237-1-joachim.priesner@web.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/format.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -260,7 +260,8 @@ static int parse_audio_format_rates_v1(s
 	}
 
 	/* Jabra Evolve 65 headset */
-	if (chip->usb_id == USB_ID(0x0b0e, 0x030b)) {
+	if (chip->usb_id == USB_ID(0x0b0e, 0x030b) ||
+	    chip->usb_id == USB_ID(0x0b0e, 0x030c)) {
 		/* only 48kHz for playback while keeping 16kHz for capture */
 		if (fp->nr_rates != 1)
 			return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);



