Return-Path: <stable+bounces-168144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A9B233AB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3235418999EA
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA82EE5E8;
	Tue, 12 Aug 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M11Bgs6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15861FFE;
	Tue, 12 Aug 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023192; cv=none; b=RC01gfe4iuAE6lSWLLmsP+JKMvMgrsbQ6ILBAxdlLCRGsW0QGPVXKAnmb0mSe5O2hSksVTXWs3GVEfTYi2yT08ZneKa3Gx3/E5Gzx+xN5rEKi1VR61dJ7b5j4bWnKCDnwGz1CUkOkagw6oEWdxHwEwtA8FoFg4hLXqEvkdpFWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023192; c=relaxed/simple;
	bh=22SC/39ChKKre+qGjLcGbmI9t7CSNiQ9dx1qK2RBtgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUMcaH7U0MWiu6PQwgjqThR1WrbxVHS4wTpzOFeMZQQ/JgKmUQ/j6+I9/MmAn4UmBnELIeQgr54+PN+Rr2iJDdYZOm0ZXUbOEgZ8xz1xOA+KneaJxhiunVnmGvCrclVkwHA2+tPnuE8+ZAGvH5gzPPoHVSLN8JV6I9hkj8aRdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M11Bgs6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA63C4CEF0;
	Tue, 12 Aug 2025 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023192;
	bh=22SC/39ChKKre+qGjLcGbmI9t7CSNiQ9dx1qK2RBtgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M11Bgs6lk3Q9JegHDZq545/jSQ5plzV9aRVIIfBTCTM4W0kRVFn9PZ8g46AUFwnkn
	 d4XW4ffa/reFd/aafYMSTV74qkmg5L8VceEa/NH0okeN3Iri2d56A1CV+KLlF9yeW/
	 1MbdPq4Irs30ZJGhrzwDi+bnzK+ynbe/4bOlG1jk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 353/369] ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()
Date: Tue, 12 Aug 2025 19:30:50 +0200
Message-ID: <20250812173029.972479360@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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
@@ -1767,7 +1767,7 @@ static int __hdmi_lpe_audio_probe(struct
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strscpy(pcm->name, card->shortname, strlen(card->shortname));
+		strscpy(pcm->name, card->shortname, sizeof(pcm->name));
 		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 



