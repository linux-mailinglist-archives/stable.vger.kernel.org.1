Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C579B85B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377840AbjIKW2w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbjIKOJd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:09:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D7CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:09:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536B8C433C7;
        Mon, 11 Sep 2023 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441368;
        bh=7NRndwjmq56dDKJMStVxFX2I1a8KyvjPxamWP+vx2wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxVLGQkC1MNgguSBDRqs4ZqnjyemKhOcdRuV7kR3uRIBujKqyv0WuHA8FEiLJ04NH
         n4U4h1CiK34r1pZu5y1KGEEp+ZFkq48VYwjIDHqLNTs3NJ4CRT1GwagiLpf7MTjJBE
         mHuSDxrk2LL/F4I2i3M69aiaJhSKOYWgbiUzPloA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 371/739] ALSA: ump: Fill group names for legacy rawmidi substreams
Date:   Mon, 11 Sep 2023 15:42:50 +0200
Message-ID: <20230911134701.523251053@linuxfoundation.org>
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

[ Upstream commit 1761f4cc114af531020ea190df6a24dd288a8221 ]

To make it clearer which legacy substream corresponds to which UMP
group, fill the subname field of each substream object with the group
number and the endpoint name, e.g. "Group 1 (My Device)".

Ideally speaking, we should have some better link information to the
derived UMP, but it's another feature extension.

Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
Link: https://lore.kernel.org/r/20230824075108.29958-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/ump.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index 2cffd36863390..beb439f25b09e 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -1123,6 +1123,16 @@ static void process_legacy_input(struct snd_ump_endpoint *ump, const u32 *src,
 	spin_unlock_irqrestore(&ump->legacy_locks[dir], flags);
 }
 
+static void fill_substream_names(struct snd_ump_endpoint *ump,
+				 struct snd_rawmidi *rmidi, int dir)
+{
+	struct snd_rawmidi_substream *s;
+
+	list_for_each_entry(s, &rmidi->streams[dir].substreams, list)
+		snprintf(s->name, sizeof(s->name), "Group %d (%s)",
+			 s->number + 1, ump->info.name);
+}
+
 int snd_ump_attach_legacy_rawmidi(struct snd_ump_endpoint *ump,
 				  char *id, int device)
 {
@@ -1156,6 +1166,11 @@ int snd_ump_attach_legacy_rawmidi(struct snd_ump_endpoint *ump,
 	rmidi->ops = &snd_ump_legacy_ops;
 	rmidi->private_data = ump;
 	ump->legacy_rmidi = rmidi;
+	if (input)
+		fill_substream_names(ump, rmidi, SNDRV_RAWMIDI_STREAM_INPUT);
+	if (output)
+		fill_substream_names(ump, rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT);
+
 	ump_dbg(ump, "Created a legacy rawmidi #%d (%s)\n", device, id);
 	return 0;
 }
-- 
2.40.1



