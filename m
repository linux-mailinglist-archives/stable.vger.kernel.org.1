Return-Path: <stable+bounces-175055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92250B366CC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC57A5619B4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9E34DCC1;
	Tue, 26 Aug 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JmGu2WIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE634320F;
	Tue, 26 Aug 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216022; cv=none; b=ibE3rFcLYBqA/hA2R3mIMQ0UxGYrLQLThSVPxkOMT7HsUkDy4M4H6aukNjUoNnp834ZrxLnvNm8oUrPcFl1IXQHTNHR57yqD8lfihILk8loQSZ/LcCuxk7paSrhzGxfjs30NcpvkPJPKAWa+jEZ1vlwjq3W5FTtgtFa3VsCQyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216022; c=relaxed/simple;
	bh=37GQUSa3p46T7jCpvH8alaenZiQYZY6RxEba4dcHigE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdwuFH0COaSVqOGFKXoOFFEWK18lVaHaaJqdbysYpzDhuIjKJKzXObjca+DhPsvNVRHbn9Bl7nNfZIMQCsrLXh3TJbB7HCUa+bUjtG5606HP+pkGwzcpjQ2UzQbU2JGoXZxrMbr02QlPyDv9Z0iiY//fjb94S8POVvMt3zH69Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JmGu2WIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751FBC4CEF1;
	Tue, 26 Aug 2025 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216021;
	bh=37GQUSa3p46T7jCpvH8alaenZiQYZY6RxEba4dcHigE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmGu2WIB3V5YtBFwdwjiJtRakb0OYDNPfoEKPWBZt00VTDFTUDnlwXHgBMqYRpqHa
	 LVs8d4lThovWlcaMWAWzxnRv4H+0HkMWkGvnKMPP9TpTv6Y4eSxLaVUKcpcA9AC5O1
	 YljNn3YA5IXvrQVw5Rt/bAHqyCRgLtbyYJL9a1VQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 254/644] ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()
Date: Tue, 26 Aug 2025 13:05:45 +0200
Message-ID: <20250826110952.677746601@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 8cbe564974248ee980562be02f2b1912769562c7 upstream.

In __hdmi_lpe_audio_probe(), strscpy() is incorrectly called with the
length of the source string (excluding the NUL terminator) rather than
the size of the destination buffer. This results in one character less
being copied from 'card->shortname' to 'pcm->name'.

Use the destination buffer size instead to ensure the card name is
copied correctly.

Cc: stable@vger.kernel.org
Fixes: 75b1a8f9d62e ("ALSA: Convert strlcpy to strscpy when return value is unused")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20250805234156.60294-1-thorsten.blum@linux.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/x86/intel_hdmi_audio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1769,7 +1769,7 @@ static int __hdmi_lpe_audio_probe(struct
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strscpy(pcm->name, card->shortname, strlen(card->shortname));
+		strscpy(pcm->name, card->shortname, sizeof(pcm->name));
 		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 



