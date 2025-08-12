Return-Path: <stable+bounces-167589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112EB230BD
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2645670FA
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C3A2FDC2F;
	Tue, 12 Aug 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LUx5drGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF92F83CB;
	Tue, 12 Aug 2025 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021325; cv=none; b=o3OY8XjBKUNRvBsFLymlzQjmJWJaH2gkmFfs4SaVKXbO0DQih/HxXa1ISLVrrL+GAqVFAF4yg8onO4gBCJz2shTjY8osasZGixeP/7sn86U3FFo5t9QhCga6IH5pCMDdaV6MAY1RXifCDaMu1eVBqwZTbwLCIg860zN/E0v5mTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021325; c=relaxed/simple;
	bh=XnFMDGfGjS8olGNo9gv3/ki5FXxesjS3G1Vk0TkDPVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umSLgK2YuAAex8/lQv18BS14Vz6PXroBO7xzyEWapA7NrzX8qxEWSgH0iJmPLFNXxG/EtnNZtu7vKAaBNG6ylq9pySviM3IAiMaEIFcDdR/W2RbgEH+V+lyPzctUsneQ9Dwp9uozHEzhyOYuN8PzzpANKg+hC5ruXTbMeBhhxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LUx5drGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D127C4CEF1;
	Tue, 12 Aug 2025 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021325;
	bh=XnFMDGfGjS8olGNo9gv3/ki5FXxesjS3G1Vk0TkDPVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUx5drGmVNVm+M3v8Mmg3CB3R+biL4OH+RQOWK037GxZdJLiCQAAnmcgs2Nnk9bJi
	 up3jI4KkwoEXbrz2NA6qHCJbYsOAPHv0vLo4Rne8qhN/RZv/IqEUZxWEsvelifhrrK
	 hd4TB4qUJmKS6183NeCQJT+jaMYMFw7sGH5XOHsA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 248/253] ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()
Date: Tue, 12 Aug 2025 19:30:36 +0200
Message-ID: <20250812172959.415879410@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1766,7 +1766,7 @@ static int __hdmi_lpe_audio_probe(struct
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strscpy(pcm->name, card->shortname, strlen(card->shortname));
+		strscpy(pcm->name, card->shortname, sizeof(pcm->name));
 		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 



