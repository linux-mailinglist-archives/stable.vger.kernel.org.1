Return-Path: <stable+bounces-100700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F739ED502
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACE5284E38
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C6237FCC;
	Wed, 11 Dec 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il/pQ6uE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488D211A14;
	Wed, 11 Dec 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943047; cv=none; b=pwdz4GNYfR4zxDkHKkedXfenSSDxmcPXXFsEiHAnsvBQ124eLLxzxD4I85oYDMzFkES4hVsP2CEquJH37jSJiEv+m7fltFunJ6Fi2g4Bj1pfKGRx+rlxj/3j6n5hPSwfyGUtsa2MTKWQhtrxmx/phFrsLHANRL/hNeGFHn0h49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943047; c=relaxed/simple;
	bh=DrVZCtgLMVC9cL/ZKhC3Nq42lW4JPYLsrddLkDtJXxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB+6KHWGtAk6Jj1AiEZcPVPXsLvCHyX5vM6eoH6jw6odp27269f3X0C5a7ASCFkKtfthdv4gc011LlcyYSD+V3ofrjyYGLSbo3uZAitJrorOPjqIirpuyZhESf7Sl8RlSYBhcDcKuSpVMW1BL+ZO6C7rqvV3zXKWV9iCEIyNEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il/pQ6uE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4B5C4CED2;
	Wed, 11 Dec 2024 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943047;
	bh=DrVZCtgLMVC9cL/ZKhC3Nq42lW4JPYLsrddLkDtJXxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Il/pQ6uEZPgzlba68mKpTJw9a7WlCPs2BnrVqFBWlE/TrwRk/5k7f09DGtRVM4bcr
	 dFmQINk5VA36Ir1eOa6oRNogBUyXqlXwLm2AC/IabFaymM2OyOkm5fpWsNALf+PGXR
	 Za4N6bpgdWw6bNzzUIdn+e97lE9Ngh97fUm7Mw++zSd1nFMWUXCGGyHmbuJbXPHKVp
	 Nc27LFjnHFVJ/d/6PzE6Wz+LDM4Uj3hdRyWYpmTmeIUzszK9YvfAVBU1Qa/J2KWXsF
	 s6hev4xAzyTfoPIhpZSIj6cB9yo6sKxscEE4qobzQh/F9uz7AzCY5hPLTE0Y/nd6bc
	 IczRVMpZPbwgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	zhangjiao2@cmss.chinamobile.com,
	andriy.shevchenko@linux.intel.com,
	luoyifan@cmss.chinamobile.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 10/36] ALSA: ump: Don't open legacy substream for an inactive group
Date: Wed, 11 Dec 2024 13:49:26 -0500
Message-ID: <20241211185028.3841047-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 3978d53df7236f0a517c2abeb43ddf6ac162cdd8 ]

When a UMP Group is inactive, we shouldn't allow users to access it
via the legacy MIDI access.  Add the group active flag check and
return -ENODEV if it's inactive.

Link: https://patch.msgid.link/20241129094546.32119-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/ump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index 8d37f237f83b2..0ade67d6b0896 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -1087,6 +1087,8 @@ static int snd_ump_legacy_open(struct snd_rawmidi_substream *substream)
 	guard(mutex)(&ump->open_mutex);
 	if (ump->legacy_substreams[dir][group])
 		return -EBUSY;
+	if (!ump->groups[group].active)
+		return -ENODEV;
 	if (dir == SNDRV_RAWMIDI_STREAM_OUTPUT) {
 		if (!ump->legacy_out_opens) {
 			err = snd_rawmidi_kernel_open(&ump->core, 0,
-- 
2.43.0


