Return-Path: <stable+bounces-145289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643A9ABDB25
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2332F4C5A36
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F82246327;
	Tue, 20 May 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zKvVtxas"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3222DF87;
	Tue, 20 May 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749733; cv=none; b=FsvpCA5WFuGCd5Kr3ZYSNTHeEx4724mETrSfksUPllf5fk7jG1oweZqH0IAmrP2R/2RQEueourB33R+k+qj4Jh9YLnj2fi8LP+K+UiBm2NIVgqODCMinmfIgHZ6jWQrT707uXWWpkoPE9numnpf3xDwhcl/53Zq+0hwE0z4dhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749733; c=relaxed/simple;
	bh=K9kFIOtiEXm/tlxZD6NjFpoblG+/4B4oQLTiGNwWInc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INA5xdtcMXazq+uRD4JnSygUvZHysaD842e21RI+pXKGoPF9CwYUkHbQxu787GFYg8IkNTdN1zwAryUIDOMhnuIZirQqHPN6o00FmAPTNOdPEz0EzubN8Cm9k4K/4vJAFa+FpKKYdmIpAhp/7n70GhW7tmleH0t4rWYglLdabjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zKvVtxas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D259C4CEEB;
	Tue, 20 May 2025 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749733;
	bh=K9kFIOtiEXm/tlxZD6NjFpoblG+/4B4oQLTiGNwWInc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zKvVtxas1mkC8UkKr2mkrp8j1SY7UcDS2yaCaqmf1bCNbDo1t20PhSzI6ptoCIB3y
	 wp3eA0M/ZLcZM2JnHRQYzKzbApA7PBvQbXZc/LXlT6dgXDchyL4VUnrmwqrhj+KIKL
	 KIZ6V2My2IoRTUYZ3OleWBOcAattKm0CPb3q+H7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 042/117] ALSA: seq: Fix delivery of UMP events to group ports
Date: Tue, 20 May 2025 15:50:07 +0200
Message-ID: <20250520125805.658248834@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit ff7b190aef6cccdb6f14d20c5753081fe6420e0b ]

When an event with UMP message is sent to a UMP client, the EP port
receives always no matter where the event is sent to, as it's a
catch-all port.  OTOH, if an event is sent to EP port, and if the
event has a certain UMP Group, it should have been delivered to the
associated UMP Group port, too, but this was ignored, so far.

This patch addresses the behavior.  Now a UMP event sent to the
Endpoint port will be delivered to the subscribers of the UMP group
port the event is associated with.

The patch also does a bit of refactoring to simplify the code about
__deliver_to_subscribers().

Fixes: 177ccf811df4 ("ALSA: seq: Support MIDI 2.0 UMP Endpoint port")
Link: https://patch.msgid.link/20250511134528.6314-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_clientmgr.c   | 52 ++++++++++++++++++++------------
 sound/core/seq/seq_ump_convert.c | 18 +++++++++++
 sound/core/seq/seq_ump_convert.h |  1 +
 3 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 6195fe9dda179..49f6763c3250d 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -736,15 +736,21 @@ static int snd_seq_deliver_single_event(struct snd_seq_client *client,
  */
 static int __deliver_to_subscribers(struct snd_seq_client *client,
 				    struct snd_seq_event *event,
-				    struct snd_seq_client_port *src_port,
-				    int atomic, int hop)
+				    int port, int atomic, int hop)
 {
+	struct snd_seq_client_port *src_port;
 	struct snd_seq_subscribers *subs;
 	int err, result = 0, num_ev = 0;
 	union __snd_seq_event event_saved;
 	size_t saved_size;
 	struct snd_seq_port_subs_info *grp;
 
+	if (port < 0)
+		return 0;
+	src_port = snd_seq_port_use_ptr(client, port);
+	if (!src_port)
+		return 0;
+
 	/* save original event record */
 	saved_size = snd_seq_event_packet_size(event);
 	memcpy(&event_saved, event, saved_size);
@@ -780,6 +786,7 @@ static int __deliver_to_subscribers(struct snd_seq_client *client,
 		read_unlock(&grp->list_lock);
 	else
 		up_read(&grp->list_mutex);
+	snd_seq_port_unlock(src_port);
 	memcpy(event, &event_saved, saved_size);
 	return (result < 0) ? result : num_ev;
 }
@@ -788,25 +795,32 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 				  struct snd_seq_event *event,
 				  int atomic, int hop)
 {
-	struct snd_seq_client_port *src_port;
-	int ret = 0, ret2;
-
-	src_port = snd_seq_port_use_ptr(client, event->source.port);
-	if (src_port) {
-		ret = __deliver_to_subscribers(client, event, src_port, atomic, hop);
-		snd_seq_port_unlock(src_port);
-	}
-
-	if (client->ump_endpoint_port < 0 ||
-	    event->source.port == client->ump_endpoint_port)
-		return ret;
+	int ret;
+#if IS_ENABLED(CONFIG_SND_SEQ_UMP)
+	int ret2;
+#endif
 
-	src_port = snd_seq_port_use_ptr(client, client->ump_endpoint_port);
-	if (!src_port)
+	ret = __deliver_to_subscribers(client, event,
+				       event->source.port, atomic, hop);
+#if IS_ENABLED(CONFIG_SND_SEQ_UMP)
+	if (!snd_seq_client_is_ump(client) || client->ump_endpoint_port < 0)
 		return ret;
-	ret2 = __deliver_to_subscribers(client, event, src_port, atomic, hop);
-	snd_seq_port_unlock(src_port);
-	return ret2 < 0 ? ret2 : ret;
+	/* If it's an event from EP port (and with a UMP group),
+	 * deliver to subscribers of the corresponding UMP group port, too.
+	 * Or, if it's from non-EP port, deliver to subscribers of EP port, too.
+	 */
+	if (event->source.port == client->ump_endpoint_port)
+		ret2 = __deliver_to_subscribers(client, event,
+						snd_seq_ump_group_port(event),
+						atomic, hop);
+	else
+		ret2 = __deliver_to_subscribers(client, event,
+						client->ump_endpoint_port,
+						atomic, hop);
+	if (ret2 < 0)
+		return ret2;
+#endif
+	return ret;
 }
 
 /* deliver an event to the destination port(s).
diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index 4dd540cbb1cbb..83a27362b7a06 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -1284,3 +1284,21 @@ int snd_seq_deliver_to_ump(struct snd_seq_client *source,
 	else
 		return cvt_to_ump_midi1(dest, dest_port, event, atomic, hop);
 }
+
+/* return the UMP group-port number of the event;
+ * return -1 if groupless or non-UMP event
+ */
+int snd_seq_ump_group_port(const struct snd_seq_event *event)
+{
+	const struct snd_seq_ump_event *ump_ev =
+		(const struct snd_seq_ump_event *)event;
+	unsigned char type;
+
+	if (!snd_seq_ev_is_ump(event))
+		return -1;
+	type = ump_message_type(ump_ev->ump[0]);
+	if (ump_is_groupless_msg(type))
+		return -1;
+	/* group-port number starts from 1 */
+	return ump_message_group(ump_ev->ump[0]) + 1;
+}
diff --git a/sound/core/seq/seq_ump_convert.h b/sound/core/seq/seq_ump_convert.h
index 6c146d8032804..4abf0a7637d70 100644
--- a/sound/core/seq/seq_ump_convert.h
+++ b/sound/core/seq/seq_ump_convert.h
@@ -18,5 +18,6 @@ int snd_seq_deliver_to_ump(struct snd_seq_client *source,
 			   struct snd_seq_client_port *dest_port,
 			   struct snd_seq_event *event,
 			   int atomic, int hop);
+int snd_seq_ump_group_port(const struct snd_seq_event *event);
 
 #endif /* __SEQ_UMP_CONVERT_H */
-- 
2.39.5




