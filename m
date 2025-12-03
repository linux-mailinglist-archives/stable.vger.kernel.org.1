Return-Path: <stable+bounces-198460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9EC9FAB2
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7FD6307476B
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982B42FD69C;
	Wed,  3 Dec 2025 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fSfJC3Wo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50209244665;
	Wed,  3 Dec 2025 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776618; cv=none; b=ZEFZfTpSdUhH+vbfGVBx8BoUyaQ4Z1LX6ZtcyAvgIpwxgPNxAFGU7XQlUYcO5IAlWC8EpYZ1eFB10e6J43i56RuhWg6p166iTHmSeUz0XdL4WNLP08O+Xrellx/2kMQ2bC8Vt3oI7Tc59hIbSk64kyvL/ki6MFxNVGvPNU/YdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776618; c=relaxed/simple;
	bh=+rC7xQPHj7SAmuTj3RFxMDYWX3IufEaQyyB7y7JIGyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEFps0jcN7jQG0irrYLZXucayykevWnlqEFTPLFSAa4u+Qizp7LZf8h/nduApTnIyTa4wz8MVAUMSrIFYd+FsmaYY+bzzodzrCACwgYNQvNuI2CSwUULxR9JKiccBTlPhF21QdJAxUrX1WsRmH5hzx/GtvyCHxVUDNgAF4F5cZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fSfJC3Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEC8C4CEF5;
	Wed,  3 Dec 2025 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776617;
	bh=+rC7xQPHj7SAmuTj3RFxMDYWX3IufEaQyyB7y7JIGyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSfJC3WoDmXqWRegcjoLSRuztM6ibClU9+PGcZ3iemsspzDqAJn8du28H75bQvU3Y
	 c5dQOjM2RL8cru4EXkdAi0NJQtVt3pazEAmyw7THGFy2vQPYeyUI6APq0aT3FeYOCt
	 ktBoh6xo0znZkB/Vwk61+fhAUhhlO6nHlUs5X76I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 235/300] ALSA: usb-audio: fix uac2 clock source at terminal parser
Date: Wed,  3 Dec 2025 16:27:19 +0100
Message-ID: <20251203152409.332500103@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: René Rebe <rene@exactco.de>

[ Upstream commit d26e9f669cc0a6a85cf17180c09a6686db9f4002 ]

Since 8b3a087f7f65 ("ALSA: usb-audio: Unify virtual type units type to
UAC3 values") usb-audio is using UAC3_CLOCK_SOURCE instead of
bDescriptorSubtype, later refactored with e0ccdef9265 ("ALSA: usb-audio:
Clean up check_input_term()") into parse_term_uac2_clock_source().

This breaks the clock source selection for at least my
1397:0003 BEHRINGER International GmbH FCA610 Pro.

Fix by using UAC2_CLOCK_SOURCE in parse_term_uac2_clock_source().

Fixes: 8b3a087f7f65 ("ALSA: usb-audio: Unify virtual type units type to UAC3 values")
Signed-off-by: René Rebe <rene@exactco.de>
Link: https://patch.msgid.link/20251125.154149.1121389544970412061.rene@exactco.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6b9a472ea43cb..949b171377267 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -925,7 +925,7 @@ static int parse_term_uac2_clock_source(struct mixer_build *state,
 {
 	struct uac_clock_source_descriptor *d = p1;
 
-	term->type = UAC3_CLOCK_SOURCE << 16; /* virtual type */
+	term->type = UAC2_CLOCK_SOURCE << 16; /* virtual type */
 	term->id = id;
 	term->name = d->iClockSource;
 	return 0;
-- 
2.51.0




