Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967DA79AF04
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378598AbjIKWfv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbjIKOKC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:10:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C349E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:09:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A4EC433C7;
        Mon, 11 Sep 2023 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441396;
        bh=HZGeXZvwWQT9Iy//NlhVypQSrvUwVwmrdG6CHU103qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfBEO3qq1WeeDGWrvJRpxKDr8lwoR9t7TM7LayBaQqwKAgmtlJq+PXry17CZCmfiH
         tmLQ4BY4MDLgjKIK9n4zYBQ1PEcA/V64ozHupbuipN2UvHI/3fU2kKXR3dKVvUGO8R
         EJKnmBz2w4XYNiZfiXN2hB1sfgZN1lL4ZQxdfOzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 372/739] ALSA: ump: Dont create unused substreams for static blocks
Date:   Mon, 11 Sep 2023 15:42:51 +0200
Message-ID: <20230911134701.552455475@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b2bcbd031d34d1ba1f491b9152474cf9f6d4d51b ]

When the UMP Endpoint is declared as "static", that is, no dynamic
reassignment of UMP Groups, it makes little sense to expose always all
16 groups with 16 substreams.  Many of those substreams are disabled
groups, hence they are useless, but applications don't know it and try
to open / access all those substreams unnecessarily.

This patch limits the number of UMP legacy rawmidi substreams only to
the active groups.  The behavior is changed only for the static
endpoint (i.e. devices without UMP v1.1 feature implemented or with
the static block flag is set).

Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
Link: https://lore.kernel.org/r/20230824075108.29958-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/ump.h |  1 +
 sound/core/ump.c    | 43 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/sound/ump.h b/include/sound/ump.h
index 44d2c2fd021d2..91238dabe3075 100644
--- a/include/sound/ump.h
+++ b/include/sound/ump.h
@@ -45,6 +45,7 @@ struct snd_ump_endpoint {
 	spinlock_t legacy_locks[2];
 	struct snd_rawmidi *legacy_rmidi;
 	struct snd_rawmidi_substream *legacy_substreams[2][SNDRV_UMP_MAX_GROUPS];
+	unsigned char legacy_mapping[SNDRV_UMP_MAX_GROUPS];
 
 	/* for legacy output; need to open the actual substream unlike input */
 	int legacy_out_opens;
diff --git a/sound/core/ump.c b/sound/core/ump.c
index beb439f25b09e..9d6e3e748f7e7 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -984,7 +984,7 @@ static int snd_ump_legacy_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_ump_endpoint *ump = substream->rmidi->private_data;
 	int dir = substream->stream;
-	int group = substream->number;
+	int group = ump->legacy_mapping[substream->number];
 	int err;
 
 	mutex_lock(&ump->open_mutex);
@@ -1016,7 +1016,7 @@ static int snd_ump_legacy_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_ump_endpoint *ump = substream->rmidi->private_data;
 	int dir = substream->stream;
-	int group = substream->number;
+	int group = ump->legacy_mapping[substream->number];
 
 	mutex_lock(&ump->open_mutex);
 	spin_lock_irq(&ump->legacy_locks[dir]);
@@ -1123,6 +1123,34 @@ static void process_legacy_input(struct snd_ump_endpoint *ump, const u32 *src,
 	spin_unlock_irqrestore(&ump->legacy_locks[dir], flags);
 }
 
+/* Fill ump->legacy_mapping[] for groups to be used for legacy rawmidi */
+static int fill_legacy_mapping(struct snd_ump_endpoint *ump)
+{
+	struct snd_ump_block *fb;
+	unsigned int group_maps = 0;
+	int i, num;
+
+	if (ump->info.flags & SNDRV_UMP_EP_INFO_STATIC_BLOCKS) {
+		list_for_each_entry(fb, &ump->block_list, list) {
+			for (i = 0; i < fb->info.num_groups; i++)
+				group_maps |= 1U << (fb->info.first_group + i);
+		}
+		if (!group_maps)
+			ump_info(ump, "No UMP Group is found in FB\n");
+	}
+
+	/* use all groups for non-static case */
+	if (!group_maps)
+		group_maps = (1U << SNDRV_UMP_MAX_GROUPS) - 1;
+
+	num = 0;
+	for (i = 0; i < SNDRV_UMP_MAX_GROUPS; i++)
+		if (group_maps & (1U << i))
+			ump->legacy_mapping[num++] = i;
+
+	return num;
+}
+
 static void fill_substream_names(struct snd_ump_endpoint *ump,
 				 struct snd_rawmidi *rmidi, int dir)
 {
@@ -1130,7 +1158,7 @@ static void fill_substream_names(struct snd_ump_endpoint *ump,
 
 	list_for_each_entry(s, &rmidi->streams[dir].substreams, list)
 		snprintf(s->name, sizeof(s->name), "Group %d (%s)",
-			 s->number + 1, ump->info.name);
+			 ump->legacy_mapping[s->number] + 1, ump->info.name);
 }
 
 int snd_ump_attach_legacy_rawmidi(struct snd_ump_endpoint *ump,
@@ -1138,16 +1166,19 @@ int snd_ump_attach_legacy_rawmidi(struct snd_ump_endpoint *ump,
 {
 	struct snd_rawmidi *rmidi;
 	bool input, output;
-	int err;
+	int err, num;
 
-	ump->out_cvts = kcalloc(16, sizeof(*ump->out_cvts), GFP_KERNEL);
+	ump->out_cvts = kcalloc(SNDRV_UMP_MAX_GROUPS,
+				sizeof(*ump->out_cvts), GFP_KERNEL);
 	if (!ump->out_cvts)
 		return -ENOMEM;
 
+	num = fill_legacy_mapping(ump);
+
 	input = ump->core.info_flags & SNDRV_RAWMIDI_INFO_INPUT;
 	output = ump->core.info_flags & SNDRV_RAWMIDI_INFO_OUTPUT;
 	err = snd_rawmidi_new(ump->core.card, id, device,
-			      output ? 16 : 0, input ? 16 : 0,
+			      output ? num : 0, input ? num : 0,
 			      &rmidi);
 	if (err < 0) {
 		kfree(ump->out_cvts);
-- 
2.40.1



