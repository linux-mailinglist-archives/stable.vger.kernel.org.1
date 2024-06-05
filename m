Return-Path: <stable+bounces-48182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8FF8FCD6F
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21602884FF
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8FF1C95CF;
	Wed,  5 Jun 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFOBUBpq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3A1C95C7;
	Wed,  5 Jun 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589073; cv=none; b=ry9Q7v3WdRRvJJjBM2J0jIgsVCQtZf8WDu+h3nml9TwFWUvgVJxG8I36CEKYt+itoWnNAOMX9HcBsMLh7hn+U6S0mWG35VlFxKX/MppYmM9hHYFlp7j7zqA9ThWWOk4jKh21F6HdQh639bm7Ku3Yt0q70XFkt+Q5Y17aODN4vUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589073; c=relaxed/simple;
	bh=qsLzNN4PkdBpxXGX3dj2iINcyEeFq3uwDLAkA5pLkGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMPZQ/LDArunqYsS5ljpFOwt1TEE/f8tYhi105VK/6Xl/ygvq6KiJimQbdwEL5z1d2qRlU5rJN1Q1kEZJJ76R30wa3aXbXUOu+Mt++Tt0JS3DPPCUAC4+EEli5B6JiZUdoqLwyUukbd5SBCyHRBZCMZU+eg51Azzi73YyTF7yJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFOBUBpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060E6C3277B;
	Wed,  5 Jun 2024 12:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589072;
	bh=qsLzNN4PkdBpxXGX3dj2iINcyEeFq3uwDLAkA5pLkGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFOBUBpqXhIj8cEiFehV7PICbgJLur/GFONTSQw7dEGfexmfHU/sRosSKtVE/sRnA
	 A2OGePl4wEXdILNha2Lnyj8dDB2TiROPI7H41NaM76vyVGF4wa/3eeibIOawfxVUOM
	 8hEQdGEyiZEifDQ/hlqQlycoFg0Ip7lv1uJAFVUuiajK21Iimihmw8c2mNDc5INjnf
	 SnWUXbLZPSwHu4hg9patc5qFzacj3M3V0OkfsS3ZChpvHOBF9foJFzAuJmCOL4kBC/
	 8ilz+05M6/YuNIu39WiCo7P1PfVH11YzF/ePxCl3CWIwb1wkFJUX8Ko4Nw+Cu+leg0
	 wW1ET6vxsyBmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cujomalainey@chromium.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/18] ALSA: ump: Set default protocol when not given explicitly
Date: Wed,  5 Jun 2024 08:03:53 -0400
Message-ID: <20240605120409.2967044-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit bc42ca002d5d211f9c57334b9b4c25ddb0b4ec35 ]

When an inquiry of the current protocol via UMP Stream Configuration
message fails by some reason, we may leave the current protocol
undefined, which may lead to unexpected behavior.  Better to assume a
valid protocol found in the protocol capability bits instead.

For a device that doesn't support the UMP v1.2 feature, it won't reach
to this code path, and USB MIDI GTB descriptor would be used for
determining the protocol, instead.

Link: https://lore.kernel.org/r/20240529164723.18309-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/ump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index fe7911498cc43..284d7b73fefd2 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -960,6 +960,14 @@ int snd_ump_parse_endpoint(struct snd_ump_endpoint *ump)
 	if (err < 0)
 		ump_dbg(ump, "Unable to get UMP EP stream config\n");
 
+	/* If no protocol is set by some reason, assume the valid one */
+	if (!(ump->info.protocol & SNDRV_UMP_EP_INFO_PROTO_MIDI_MASK)) {
+		if (ump->info.protocol_caps & SNDRV_UMP_EP_INFO_PROTO_MIDI2)
+			ump->info.protocol |= SNDRV_UMP_EP_INFO_PROTO_MIDI2;
+		else if (ump->info.protocol_caps & SNDRV_UMP_EP_INFO_PROTO_MIDI1)
+			ump->info.protocol |= SNDRV_UMP_EP_INFO_PROTO_MIDI1;
+	}
+
 	/* Query and create blocks from Function Blocks */
 	for (blk = 0; blk < ump->info.num_blocks; blk++) {
 		err = create_block_from_fb_info(ump, blk);
-- 
2.43.0


