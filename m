Return-Path: <stable+bounces-58796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208892C0A9
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170B0B23E60
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16591B3F14;
	Tue,  9 Jul 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En+UeVU+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31E1B3F09;
	Tue,  9 Jul 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542082; cv=none; b=tTyteSOsnlizzPNNWC71QUq0V5WeJJ8eY22c/On/AYperb4Xr5VAu4yIRH6yCp2HYzwFXw3Iz5e54brzgqxLQhY9hHXNdq1951aMwTPvIbQxcGnjVCuOrIU+QGq2/rHi70JazQZtR/oEczb29cocZPxjHqmrWSwpW8eqfCAo7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542082; c=relaxed/simple;
	bh=7ZTmdZIxEkt68x28ZDAeO2juKQN2DAtqN8vga4AGEQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVQMSMmDrlOSqte6dAIyEnq9aPBrBhPkyTiet4weTicawIyYFrvZQB+m+0IdjjoKPe/UQqJ9DPPkpcWpBzq4hPDKi12dT6aq8PDd6+hU/UsQ49A1zkYf3zfVIfchSJPEjjgpyh65n7ysXDjxD41pyR2wUi3q0TVBjTJwYKBWHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En+UeVU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1743DC32782;
	Tue,  9 Jul 2024 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542082;
	bh=7ZTmdZIxEkt68x28ZDAeO2juKQN2DAtqN8vga4AGEQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=En+UeVU+adm8P1xGAHK9WVU/S0s6W+xaVeoSAINjhNT5uEp6ptDqlfy1ICIAk1ZH3
	 ACVY1J92au+C2o3koWAulihs1mW7lykMMBJsy981SQLl9YhZT+FgXdKLLO69hlhl4R
	 EYuIdF71hIju9Lw2cgaZja9GDHA31R9UORoGJG9fpdHKOLwVgIhyMJB/xJi+WrPj96
	 i3qCzu2koOvjzPVGjDvO0pv+4H39Fpe21NgKOfMeGtqD1fucYyizWNBza4Ym/D3gMb
	 DPtLzW7iuBZ9KqmZloLxAHKsxkd5exg4pTrEHX+PczUFLrfOb1284aPx2nTwAKl4qY
	 VXVPKj3H/Cikw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	pavel.hofman@ivitera.com,
	dhowells@redhat.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 34/40] ALSA: PCM: Allow resume only for suspended streams
Date: Tue,  9 Jul 2024 12:19:14 -0400
Message-ID: <20240709162007.30160-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 1225675ca74c746f09211528588e83b3def1ff6a ]

snd_pcm_resume() should bail out if the stream isn't in a suspended
state.  Otherwise it'd allow doubly resume.

Link: https://patch.msgid.link/20240624125443.27808-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0b76e76823d28..353ecd960a1f5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1775,6 +1775,8 @@ static int snd_pcm_pre_resume(struct snd_pcm_substream *substream,
 			      snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	if (runtime->state != SNDRV_PCM_STATE_SUSPENDED)
+		return -EBADFD;
 	if (!(runtime->info & SNDRV_PCM_INFO_RESUME))
 		return -ENOSYS;
 	runtime->trigger_master = substream;
-- 
2.43.0


