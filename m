Return-Path: <stable+bounces-104668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E89F525A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0286E16F916
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F5B1F8685;
	Tue, 17 Dec 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBN8gnH9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218613DBB6;
	Tue, 17 Dec 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455743; cv=none; b=YP8kJt0Z9pDrz5NaKTHY4V7upt6DQrtk6g32bjDlBoVKb4EL4AY7YQfXkuaNFW+RgOt+D63uIWKgGdtragYpS6q1SnitvGxpIfX/ER8BEh5EH16QWltM52uxO29YmS9LfCJKQLfZW4i9D64NWOPgwHPFpD9OyJKwMijPl3APeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455743; c=relaxed/simple;
	bh=NjOHgIVrA5anYyWdN50CsUm+sg/1VYQTrwA2LL88ubM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh0LLcmZkJZG1v5A3MItL+Th1vEsIZAzpFDwCVFTxxW5KuJPHIANuSt4TMIs1H8WXEKKJeEZLNcMGTWvoB9YwcKU2iwgJE55UnoGUtNlmXD6q9Z4UdDZofgCplDnOk2Sctn+qS5f9oaM1iWWObA5aMzNsUg8/Kx7YTOOkDhN75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YBN8gnH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25971C4CED3;
	Tue, 17 Dec 2024 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455743;
	bh=NjOHgIVrA5anYyWdN50CsUm+sg/1VYQTrwA2LL88ubM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBN8gnH9sSjJwpKDqbM18vguXa1dAA518heaXaCyK4HxJv45K0RInCQfbwC53ViAL
	 ksKjdoR6TmgVv3+ZG0RHscrFUq1YY4rvcM2tUY2VcUFlyJ6HpYQ93D4RY7fik0EB5G
	 qbbSXVkBauLhTIR7jR+pBXIT3L7Ebn5niLMCg/IM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaakko Salo <jaakkos@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 05/76] ALSA: usb-audio: Add implicit feedback quirk for Yamaha THR5
Date: Tue, 17 Dec 2024 18:06:45 +0100
Message-ID: <20241217170526.468263987@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170526.232803729@linuxfoundation.org>
References: <20241217170526.232803729@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaakko Salo <jaakkos@gmail.com>

commit 82fdcf9b518b205da040046fbe7747fb3fd18657 upstream.

Use implicit feedback from the capture endpoint to fix popping
sounds during playback.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219567
Signed-off-by: Jaakko Salo <jaakkos@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20241206164448.8136-1-jaakkos@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2065,6 +2065,8 @@ static const struct usb_audio_quirk_flag
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x09a4, /* Logitech QuickCam E 3500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x0499, 0x1506, /* Yamaha THR5 */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0499, 0x1509, /* Steinberg UR22 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0499, 0x3108, /* Yamaha YIT-W12TX */



