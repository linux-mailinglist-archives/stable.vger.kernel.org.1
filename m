Return-Path: <stable+bounces-107697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7DA02D17
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9D11882E33
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D68E145A03;
	Mon,  6 Jan 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vByPSDS+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A111DC9AD;
	Mon,  6 Jan 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179252; cv=none; b=IjSnjYikdoO46C5fa8OUTHgCF3Rpq4Z+V9G4edEj6hvLd4AApbt/aIy/pU2O5lqAYSQrbE1Ye1AjOnCwZkoc/IZzn+Ruy8yYAZPCzSl+WeJK6gfqzlzFFbMO10wsIjs4FMHMxCV5Uuld87ZNauG7GD7syUCaD9U2ba6ny5cCpTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179252; c=relaxed/simple;
	bh=6ExPja9xjAAO43dvHJYU+yzvrvUJxs/Ga+MPv6SmRj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIh0Z64fclQKjKHDH7C2vIURzx67b4EcWksi/HEiS18FKoC5KQ9TcBQwp+xVwiVns08Q5Vz04+9Hs7rPBStmiLHpBOqtckH7fT00OuRFvpyjnqMhQV4iIsnIDPmk3XyRUd3gH3ckb70ArawvoZKIwlwp9hnQgYp91OfMScrara0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vByPSDS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B187EC4CEE1;
	Mon,  6 Jan 2025 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736179252;
	bh=6ExPja9xjAAO43dvHJYU+yzvrvUJxs/Ga+MPv6SmRj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vByPSDS+Ddv5JIVOVsR9rqQtBlA0h4+thMck2XvaPCzmNnsRWQrrWsOePWzWc1CeI
	 e/1gFJ9l252AZmzjfgKGYLsGenC6cH/DmggTyl7KRrJS6S1OLC8T3N8uFnGM4cbGgc
	 DQtY1ybRGdK+soF+C7rhJFZrZjJDEuwXPfgjZMXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 76/93] ALSA: usb-audio: US16x08: Initialize array before use
Date: Mon,  6 Jan 2025 16:17:52 +0100
Message-ID: <20250106151131.574445041@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151128.686130933@linuxfoundation.org>
References: <20250106151128.686130933@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

[ Upstream commit b06a6187ef983f501e93faa56209169752d3bde3 ]

Initialize meter_urb array before use in mixer_us16x08.c.

CID 1410197: (#1 of 1): Uninitialized scalar variable (UNINIT)
uninit_use_in_call: Using uninitialized value *meter_urb when
calling get_meter_levels_from_urb.

Coverity Link:
https://scan7.scan.coverity.com/#/project-view/52849/11354?selectedIssue=1410197

Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Link: https://patch.msgid.link/20241229060240.1642-1-tanyaagarwal25699@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index c6c834ac83ac..eb59a59dcdbf 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -687,7 +687,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	struct usb_mixer_elem_info *elem = kcontrol->private_data;
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_meter_store *store = elem->private_data;
-	u8 meter_urb[64];
+	u8 meter_urb[64] = {0};
 
 	switch (kcontrol->private_value) {
 	case 0: {
-- 
2.39.5




