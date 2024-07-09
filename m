Return-Path: <stable+bounces-58857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E29692C0CF
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EB528A9CD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211E180043;
	Tue,  9 Jul 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwhUs2YY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B9182A7B;
	Tue,  9 Jul 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542286; cv=none; b=W88jglwQk4QP5JMU1CEI6pKfdxW3XlzrSr9kE6lzErRBboF3KT7eAF3fCjhc8jlTXGnk4TVjMi82gMcB/N751SlzDBWsZNVlA6dhRlXUiaLzNqxclJtQsduls+uBuNo5T/HYRoMfsm8Ucq6jAGRpKHGDGXzNr8D1EAwqaXhd9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542286; c=relaxed/simple;
	bh=wSGvy5NogWf2jXcYOJz48drM/eC2LiddVQHo+pzDfV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlDnb0qCn6HKoQ13EEGsV3gCWvg6TSnlQ82/Y5dRxgoK+CFTvKS8LE8yl1Q7P1awadGoqZNW+olISbRd8fK+Ov+7rrfrROgzQ+tG5hhDgQQxym6DmRtr007IUr8bkg49YI8mhpx8I1ZxfeYhTLsiqmWfOeW55Pqaqdfrg1Hby98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwhUs2YY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14F5C32786;
	Tue,  9 Jul 2024 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542285;
	bh=wSGvy5NogWf2jXcYOJz48drM/eC2LiddVQHo+pzDfV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwhUs2YYMtLJ4NFWqczoERuQKdkcj9/fokE3d69p37BQGrsi+SfLJzsma5wziReYc
	 pFaldaO6B4cNvcixD3wWMlx/2NTvh23cKlCHzgmg/1wsbzFJdSa12ZIV5MWMCGbaKF
	 J4Auip6lOjgMbXaqU0ZzpUa8JZOBVwtX8/t315fl3OBgT3XmpHMGLTwSrDh9AHqxpF
	 9O124VeNFRPv7ltQL9JpB9Zm04JCRD/aqZpbMzJ2PnztpFh1iyUEj2Gnw/Tm9oDxea
	 7RFrcabY9RGCk0U792xfKzsZ8KI0qIx3aSw+lp1C4JpOnoko1CN2EMgv/VNvmgUV6b
	 17QxMeXOj6WHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pavel.hofman@ivitera.com,
	broonie@kernel.org,
	dhowells@redhat.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/27] ALSA: PCM: Allow resume only for suspended streams
Date: Tue,  9 Jul 2024 12:23:36 -0400
Message-ID: <20240709162401.31946-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
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
index 9238abbfb2d62..2b73518e5e314 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1781,6 +1781,8 @@ static int snd_pcm_pre_resume(struct snd_pcm_substream *substream,
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


