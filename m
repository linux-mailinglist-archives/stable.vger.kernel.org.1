Return-Path: <stable+bounces-48164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657228FCD2B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EF41C21194
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D81C538B;
	Wed,  5 Jun 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQd5zlLv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139A1C5380;
	Wed,  5 Jun 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589024; cv=none; b=PDZwVvgV6JVVNuYEJijEUGCejFLk+2wCU4YFxvkMMas81rZVh/9jvQfpAC7n/0O11cB5uXHnGHSwoxGcmukvzt5pHfKw4evqrpANQmBpwx7DDPsRh6yKIbzIlnWotf2bOmsk3S+VpJ+sUgAU8tSXsHHQeLqpDyUp1ke3suZqtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589024; c=relaxed/simple;
	bh=qsLzNN4PkdBpxXGX3dj2iINcyEeFq3uwDLAkA5pLkGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj2cxSR3041QrzNjBIXV4cpIwcKF1MV0PAjF9b7CeuppicflwKRodBb7Qa8YXxOpD7YTzdjWoF9yCksKDDO98BqoQ6UOvQVu9WfVnRVzf3LfFTmmFHiPHUkxnPOrPzJpus3X04tkpWdrYfugRYJZPOmSwEYAcHCBLOqSFBl+Tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQd5zlLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7881C32786;
	Wed,  5 Jun 2024 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589023;
	bh=qsLzNN4PkdBpxXGX3dj2iINcyEeFq3uwDLAkA5pLkGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQd5zlLvWs6MLDL/B1w/bheT8zeYyAv6R/C4yWJ5T/r2Nj9O1xMquI4K9lbEVJvxm
	 /aimk6i05ze2dxh6zHZFzvxsYK/IrHHFyfHvBxvHKSaX7dWFD9vxOqGVebGf7Yf7YN
	 DwnYDYHwfbd88Yv3WV4jgzNVWI4EePGQSb9odXpc8DdnL8LBcVlazSdCQEMzgYdVPl
	 8WX0+mbR45WIg6Cz03/DKS+g3iH8TiAJiAVVjoFiwjd8ka4kzNpkm+L8wWq6BEtQN3
	 WIiPyAUMXf20xcDNuaO/cRWytbEzSI1595q+6LtUVYx02uAXUGXrErYHD3ICBVvye7
	 M9ZrA56+STBQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cujomalainey@chromium.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 14/18] ALSA: ump: Set default protocol when not given explicitly
Date: Wed,  5 Jun 2024 08:03:04 -0400
Message-ID: <20240605120319.2966627-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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


