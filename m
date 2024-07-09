Return-Path: <stable+bounces-58830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1E92C082
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46E51F22CD3
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F791CF3E3;
	Tue,  9 Jul 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrYE/ySk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852F1A0713;
	Tue,  9 Jul 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542206; cv=none; b=kYYeJjviXjzOKWPpcuqHLozrJvfLlrPphuwBxlx2Xapug8eqyO0cnmCCiJOtQhawEutt+KafIv4iaCTqrzcxE6DsJRxsH2viiMA80PFYfQM5kzytkcmnehqth8HDq0FrOfkZtz8ERkl7fSA1xJ9SIoEpIeL+Q+p/ZFQdLbdTffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542206; c=relaxed/simple;
	bh=OShLEkdTi2EvCSdk2rFvuaZhfFf72o7h9XN8W5BjG40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXO0AyQLCd1M2UawK+MzrJoO8N+OKqOhfXo71HgA2Mc6QAHOtQ7Dt0ZHqNKSxd4WeJF7TYRR1hvTb1yAYZ8HWxTnb8XZHUD8sxlXbMrojiGsaPV443n7a56s4OhUbrYCCIo6FChI6TRdad+mtvZM5Ix7PFG3pTF/Fu1aqLzG0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrYE/ySk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EBCC3277B;
	Tue,  9 Jul 2024 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542205;
	bh=OShLEkdTi2EvCSdk2rFvuaZhfFf72o7h9XN8W5BjG40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrYE/ySk7oRHJGDIxT+StiaSz1+Oi0anXb9JgZcNTX3NbtjIdu1hBaeuBxjexChkk
	 /UFA8hdXIegqhXcIYtFci0WTdraUY7l41VpYCuNagmiYS5NrvxdRZZD/yr/Kzq693E
	 xHE7QnI9CBXkzBUa0tYs+89L0Z44ohVz+bf9zz27ZZunTB9nSXOpRtxnI8vr+cMnfT
	 lMlI+3HKmOXUfvxzK977dWlcMPqmX2vr17FDiO7FrNR1yQrlYTe3P5A+QKZxLnmsZ9
	 yG40SBSPvO6De0fawNH58tBg0qIZwIfF7Bm83LLI9+PfwA/o/akC/NEHCS6QGvlwma
	 M7vkZXdBHyGHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pavel.hofman@ivitera.com,
	dhowells@redhat.com,
	cezary.rojewski@intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 28/33] ALSA: PCM: Allow resume only for suspended streams
Date: Tue,  9 Jul 2024 12:21:54 -0400
Message-ID: <20240709162224.31148-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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
index bd9ddf412b465..cc21c483c4a57 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1783,6 +1783,8 @@ static int snd_pcm_pre_resume(struct snd_pcm_substream *substream,
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


