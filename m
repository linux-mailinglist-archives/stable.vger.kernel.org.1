Return-Path: <stable+bounces-48145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACED68FCCF1
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5161F2466A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904C1A1884;
	Wed,  5 Jun 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbhnoG26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1431A1863;
	Wed,  5 Jun 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588973; cv=none; b=r+aSQwHY+wMjTEQMmo0jUDeBB61LCg29KGNZMkBwO/+RVaeJB7ntiEF0X+7IXeIkFu1E+eRZfg1eELLTP/b5oPQPQNDzu/IUXn/eo5tq+o4dlRp+C2sx7+hwOMQ0f6ClsEcQ16PDp9YhAgsnY5O4ToX2PtuFtY5bjzErG2GDH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588973; c=relaxed/simple;
	bh=CJPoi8rZApWycbxEPaCbZfRjCL3ty4r2D+EZncVONVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnKgqHt6cpKU2kXysxKvXpGTFb47CYBAr2cKmWaz0ZOoIZbiF4cyIoLfXfDjBg41Ax9SlZZ2Pa6sKwNlOU9AG229y7UYauKZs53rAGKF2Pwk6B5wSD9bAVBMAao6H5YhX9GMcIE8UwUsjfqqZEA4qpO4Qv31f3tIAnabFJKc+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbhnoG26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243C3C32781;
	Wed,  5 Jun 2024 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588973;
	bh=CJPoi8rZApWycbxEPaCbZfRjCL3ty4r2D+EZncVONVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbhnoG26xu6D1kpmzIqjkFwXwyp5jOQvJ9uMvbaLc6Kg2GDiuOJUPvPyF3tcxVjws
	 XFwjAUHEdRPXUrQ5TI7L34Wpy+pWtspP+teD4SQ+pI5dxSibo7O6ct/AlI6kMNmn6Z
	 vXu5CLn2BXFE3O0wdcnFgpHzjHn+zwauYtuUzAEbr64XeoSUps3V8+fzEuvACEt7jc
	 kYDTf95uPfp8rvjkaY+/lTcX2Dg5GHRIwR8wiPcN8za2YrcUqODjwUNYzKu35XSmJh
	 ZTLxs1ijWi7TT0BJcFNihr7aApgaoqXLGNFRrb3MfJknWUEO7L1xZNFYRT1ht0Yp2s
	 s+M0dvFgQ0N0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cujomalainey@chromium.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 18/23] ALSA: ump: Set default protocol when not given explicitly
Date: Wed,  5 Jun 2024 08:02:01 -0400
Message-ID: <20240605120220.2966127-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index fd6a68a542788..65980a2f4982f 100644
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


