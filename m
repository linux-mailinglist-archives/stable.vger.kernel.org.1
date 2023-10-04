Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DBE7B8957
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbjJDSZA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbjJDSZA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:25:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299F4A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72992C433C7;
        Wed,  4 Oct 2023 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443896;
        bh=YmVeb47MENJWXzyHnXR2li77b8dTzJgouek2K9x76LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMhM+aEdlcJIjUhFuwt1gs1l9Yr8DOIcuJviHmMLyjWajPMVKhXh+5tY649+OwotY
         tmAFI5DmqP7o1x3De51EYLZbWQsV7dssBKj5yPNI0W2d7Atw4FiFOB5DHWOhfBD2by
         wSIVPmHs/uqIIMNs++MeqsyIrxNlVE/tS9Rp8vuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 030/321] ALSA: seq: Avoid delivery of events for disabled UMP groups
Date:   Wed,  4 Oct 2023 19:52:55 +0200
Message-ID: <20231004175230.561888119@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 22eefaeab03fe968ab7786fb3d5c5abd203a8bab ]

ALSA sequencer core still delivers events to the disabled UMP Group,
leaving this handling to the device.  But it's rather risky and it's
easy to imagine that such an unexpected event may screw up the device
firmware.

This patch avoids the superfluous event deliveries by setting the
group_filter of the UMP client as default, and evaluate the
group_filter properly at delivery from non-UMP clients.

The grouop_filter is updated upon the dynamic UMP Function Block
updates, so that it follows the change of the disabled UMP Groups,
too.

Fixes: d2b706077792 ("ALSA: seq: Add UMP group filter")
Link: https://lore.kernel.org/r/20230912085144.32534-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_ump_client.c  | 22 ++++++++++++++++++++++
 sound/core/seq/seq_ump_convert.c |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index f26a1812dfa73..a60e3f069a80f 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -416,6 +416,25 @@ static void setup_client_midi_version(struct seq_ump_client *client)
 	snd_seq_kernel_client_put(cptr);
 }
 
+/* set up client's group_filter bitmap */
+static void setup_client_group_filter(struct seq_ump_client *client)
+{
+	struct snd_seq_client *cptr;
+	unsigned int filter;
+	int p;
+
+	cptr = snd_seq_kernel_client_get(client->seq_client);
+	if (!cptr)
+		return;
+	filter = ~(1U << 0); /* always allow groupless messages */
+	for (p = 0; p < SNDRV_UMP_MAX_GROUPS; p++) {
+		if (client->groups[p].active)
+			filter &= ~(1U << (p + 1));
+	}
+	cptr->group_filter = filter;
+	snd_seq_kernel_client_put(cptr);
+}
+
 /* UMP group change notification */
 static void handle_group_notify(struct work_struct *work)
 {
@@ -424,6 +443,7 @@ static void handle_group_notify(struct work_struct *work)
 
 	update_group_attrs(client);
 	update_port_infos(client);
+	setup_client_group_filter(client);
 }
 
 /* UMP FB change notification */
@@ -492,6 +512,8 @@ static int snd_seq_ump_probe(struct device *_dev)
 			goto error;
 	}
 
+	setup_client_group_filter(client);
+
 	err = create_ump_endpoint_port(client);
 	if (err < 0)
 		goto error;
diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index 7cc84e137999c..b141024830ecc 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -1197,6 +1197,8 @@ int snd_seq_deliver_to_ump(struct snd_seq_client *source,
 			   struct snd_seq_event *event,
 			   int atomic, int hop)
 {
+	if (dest->group_filter & (1U << dest_port->ump_group))
+		return 0; /* group filtered - skip the event */
 	if (event->type == SNDRV_SEQ_EVENT_SYSEX)
 		return cvt_sysex_to_ump(dest, dest_port, event, atomic, hop);
 	else if (snd_seq_client_is_midi2(dest))
-- 
2.40.1



