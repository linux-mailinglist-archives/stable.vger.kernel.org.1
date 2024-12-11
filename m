Return-Path: <stable+bounces-100702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210279ED505
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C8016199C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C192D238E11;
	Wed, 11 Dec 2024 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACD6DMW/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F15236951;
	Wed, 11 Dec 2024 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943053; cv=none; b=Hb6z1ewc0r2aBYmkbGOmi57JH3D4rHZIDk50Cdf032Phpk8+AxYoabFokQ5hTBMHG1wAI6v46D9nlW9MwhsqNkohjOIul3XpZdIQ0H9014c/mcKSoiJsTirtbkPhNUxMoUJenr/Np4d0S2oJvwwqLyDRuk0YjYlGCkt8ISq6Lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943053; c=relaxed/simple;
	bh=JYYzGQzQJfaB5psvOluDG1yjLJg2kVQ5zuEMeaD79mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNLbW2UtQDdKPlUuIvOZb/QN8gENstGcPekuiijXGl7+7glmdxmF74SRVUvB4Zo3O8sfLWH20UtE5ohQIDLA83DQ3scnhAwHseiZ+KFeOP8sWJLzsR49MXtNHo3b2ibwO+HVBWxH8e67vBFqhgVW+n5Lx2fQUFgBVFVLUFOIvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACD6DMW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA210C4CEDD;
	Wed, 11 Dec 2024 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943053;
	bh=JYYzGQzQJfaB5psvOluDG1yjLJg2kVQ5zuEMeaD79mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACD6DMW/PCYvpdSbew5e6etcRZIicOQMDFe99mRLaSTDCTqtAohboXbXJRbXMtYMI
	 P0fmafVsQ+/IgTOqomwF7J/uypGzPU6PjK0FH+4GDBe5auJD+2+CS7As7X1T2NYSCy
	 Ww8XTbMpiaH3MPsNmttSBsFDrXIBtRGS5GJ7RqViezyVaT3GuD9BCrxPxpCPjlP5vT
	 wLm+OuOCoro1zWiUqRb8rvN5b2sKbI3dj8IGu8ooaGXd57Cq92B+OfbfA4wM6YhqA2
	 5yXPSnLFMZ4h5WN7tNudlzOtnryPnwwG8TruD/SIwJVON5YOw/O5TFqBMLMmucanhP
	 6Viz0g3i7wn+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	andriy.shevchenko@linux.intel.com,
	zhangjiao2@cmss.chinamobile.com,
	luoyifan@cmss.chinamobile.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/36] ALSA: ump: Update legacy substream names upon FB info update
Date: Wed, 11 Dec 2024 13:49:28 -0500
Message-ID: <20241211185028.3841047-12-sashal@kernel.org>
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

[ Upstream commit edad3f9519fcacb926d0e3f3217aecaf628a593f ]

The legacy rawmidi substreams should be updated when UMP FB Info or
UMP FB Name are received, too.

Link: https://patch.msgid.link/20241129094546.32119-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/ump.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index 55d5d8af5e441..24f7d65ce49cb 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -37,6 +37,7 @@ static int process_legacy_output(struct snd_ump_endpoint *ump,
 				 u32 *buffer, int count);
 static void process_legacy_input(struct snd_ump_endpoint *ump, const u32 *src,
 				 int words);
+static void update_legacy_names(struct snd_ump_endpoint *ump);
 #else
 static inline int process_legacy_output(struct snd_ump_endpoint *ump,
 					u32 *buffer, int count)
@@ -47,6 +48,9 @@ static inline void process_legacy_input(struct snd_ump_endpoint *ump,
 					const u32 *src, int words)
 {
 }
+static inline void update_legacy_names(struct snd_ump_endpoint *ump)
+{
+}
 #endif
 
 static const struct snd_rawmidi_global_ops snd_ump_rawmidi_ops = {
@@ -861,6 +865,7 @@ static int ump_handle_fb_info_msg(struct snd_ump_endpoint *ump,
 		fill_fb_info(ump, &fb->info, buf);
 		if (ump->parsed) {
 			snd_ump_update_group_attrs(ump);
+			update_legacy_names(ump);
 			seq_notify_fb_change(ump, fb);
 		}
 	}
@@ -893,6 +898,7 @@ static int ump_handle_fb_name_msg(struct snd_ump_endpoint *ump,
 	/* notify the FB name update to sequencer, too */
 	if (ret > 0 && ump->parsed) {
 		snd_ump_update_group_attrs(ump);
+		update_legacy_names(ump);
 		seq_notify_fb_change(ump, fb);
 	}
 	return ret;
@@ -1262,6 +1268,14 @@ static void fill_substream_names(struct snd_ump_endpoint *ump,
 	}
 }
 
+static void update_legacy_names(struct snd_ump_endpoint *ump)
+{
+	struct snd_rawmidi *rmidi = ump->legacy_rmidi;
+
+	fill_substream_names(ump, rmidi, SNDRV_RAWMIDI_STREAM_INPUT);
+	fill_substream_names(ump, rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT);
+}
+
 int snd_ump_attach_legacy_rawmidi(struct snd_ump_endpoint *ump,
 				  char *id, int device)
 {
@@ -1298,10 +1312,7 @@ int snd_ump_attach_legacy_rawmidi(struct snd_ump_endpoint *ump,
 	rmidi->ops = &snd_ump_legacy_ops;
 	rmidi->private_data = ump;
 	ump->legacy_rmidi = rmidi;
-	if (input)
-		fill_substream_names(ump, rmidi, SNDRV_RAWMIDI_STREAM_INPUT);
-	if (output)
-		fill_substream_names(ump, rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT);
+	update_legacy_names(ump);
 
 	ump_dbg(ump, "Created a legacy rawmidi #%d (%s)\n", device, id);
 	return 0;
-- 
2.43.0


