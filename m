Return-Path: <stable+bounces-81734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7884299490E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218371F25CC5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE331DE2CD;
	Tue,  8 Oct 2024 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msDtcMcb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09633981;
	Tue,  8 Oct 2024 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389955; cv=none; b=ceTrxQrhTVnDQ64080/qw2j1mP/ycF/YeVA9UR7p7t6ex9Zuoec0oR+JTP7BakfX7kYnTeorWAi8NA7wT+nxVFelUjR+wM3/rYVXjP+ic+68Q/IYYki29XYhc7OGe5ocqr3RURoCF404ynGXzsFQJ0MahP3FB6Us1t6h+yelaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389955; c=relaxed/simple;
	bh=O1MTM4ROIVRksv8CUIkCdSZfRrsQxqjxP76JZELPIwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXZrTQ7NgF+Cjmwcl/GMAE9d2yO7N6F5bxIPTih5w16hZQYEbDwimfxCKsur5lPu2+D4wZrV//nn3LQ1N+PxCiTlZpZVR7vEyTzpJtN7CG/Ybq3195nBRypkfhG8Er5hl1he0Ch83ncPTa80Jj7FYHQc/GoEXYV8+mrKsEJZFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msDtcMcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712EEC4CEC7;
	Tue,  8 Oct 2024 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389954;
	bh=O1MTM4ROIVRksv8CUIkCdSZfRrsQxqjxP76JZELPIwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msDtcMcbkayKN5bLLdUGGhiGmzj6bk6yJt2kj6z/1iZmRnHm67+11HQpzwMRh9C5P
	 TzfQlneGjK1xR4Svp7R2j/pge64gZm8a3wh9FHBy4Y/+AaDCRBXRxfYNRtBIf/ey7E
	 3m0X5oQhfBK5t/+mG8DQA5Sz5pd9E4v6ubwyryCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Pius <joshuapius@chromium.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 146/482] ALSA: usb-audio: Add logitech Audio profile quirk
Date: Tue,  8 Oct 2024 14:03:29 +0200
Message-ID: <20241008115654.053013041@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Pius <joshuapius@chromium.org>

[ Upstream commit a51c925c11d7b855167e64b63eb4378e5adfc11d ]

Specify shortnames for the following Logitech Devices: Rally bar, Rally
bar mini, Tap, MeetUp and Huddle.

Signed-off-by: Joshua Pius <joshuapius@chromium.org>
Link: https://patch.msgid.link/20240912152635.1859737-1-joshuapius@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 778de9244f1e7..9c411b82a218d 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -384,6 +384,12 @@ static const struct usb_audio_device_name usb_audio_names[] = {
 	/* Creative/Toshiba Multimedia Center SB-0500 */
 	DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),
 
+	/* Logitech Audio Devices */
+	DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
+	DEVICE_NAME(0x046d, 0x0874, "Logitech, Inc.", "Logi-Tap-Audio"),
+	DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),
+	DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"),
+	DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio"),
 	DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
 
 	DEVICE_NAME(0x05e1, 0x0408, "Syntek", "STK1160"),
-- 
2.43.0




