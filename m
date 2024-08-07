Return-Path: <stable+bounces-65905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CE494AC74
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5736F1C2257D
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AAC84A27;
	Wed,  7 Aug 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z9f/h3E4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC379945;
	Wed,  7 Aug 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043719; cv=none; b=TkgJrCJubh/Y7rrTAeeS9ZK1qAg5Q+qQ7Qy5GVIyhSYTQHhFnBy4PsEm0/9ylIMbDaXL8LcJLc+lYawKFLjEIv/3JNVU2LxIvg2Jl67Io9LcBfUpUHMkSAucV8RdFNF/36FxxIhgFA+WvRHiYUvwPAguu+U7/2GHUPHRfSTMli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043719; c=relaxed/simple;
	bh=1iEJYeXnxxmgy9DATYeHYaQ1PXu/DvbYcKVDIR0/2dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UudvB9OohU4qtGwHNw7DKWnW4zwsdC3Ed/c7/33frjD8cGrKnRlxlrjR/BG+WWNmkVZJKf8cxd0JXEfzKNa+iwJs9q/7WgOq0A4fuhcrMUVrea6P+Iz4si1rFDBtd3JI1SgkvVzkhF9+y5ebI/Q0YNy83bC52bbCzKqzSaZ9wGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z9f/h3E4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE5AC32781;
	Wed,  7 Aug 2024 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043719;
	bh=1iEJYeXnxxmgy9DATYeHYaQ1PXu/DvbYcKVDIR0/2dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z9f/h3E4YwM6w+4DejUlpv+0tFKUoZhrbWmWJmpcz/1W6Y7EphuhniQLl3NM5qGq6
	 Z/R2YxuVcroS+o6biDdFCS2mP7hL6gJT+9tX1dYv98qZk+Vip7wnIRd6pzqF28xDPX
	 OHdC9jCcRsbuYAmtuGuL2dN09Ujn94YQLm2Azmko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edmund Raile <edmund.raile@protonmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 74/86] Revert "ALSA: firewire-lib: obsolete workqueue for period update"
Date: Wed,  7 Aug 2024 17:00:53 +0200
Message-ID: <20240807150041.728816987@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150039.247123516@linuxfoundation.org>
References: <20240807150039.247123516@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edmund Raile <edmund.raile@protonmail.com>

commit 6ccf9984d6be3c2f804087b736db05c2ec42664b upstream.

prepare resolution of AB/BA deadlock competition for substream lock:
restore workqueue previously used for process context:

revert commit b5b519965c4c ("ALSA: firewire-lib: obsolete workqueue
for period update")

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hzeo4simnl@jn3eo7pe642q/
Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20240730195318.869840-2-edmund.raile@protonmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/firewire/amdtp-stream.c |   15 +++++++++++++++
 sound/firewire/amdtp-stream.h |    1 +
 2 files changed, 16 insertions(+)

--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -77,6 +77,8 @@
 // overrun. Actual device can skip more, then this module stops the packet streaming.
 #define IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES	5
 
+static void pcm_period_work(struct work_struct *work);
+
 /**
  * amdtp_stream_init - initialize an AMDTP stream structure
  * @s: the AMDTP stream to initialize
@@ -105,6 +107,7 @@ int amdtp_stream_init(struct amdtp_strea
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
 	mutex_init(&s->mutex);
+	INIT_WORK(&s->period_work, pcm_period_work);
 	s->packet_index = 0;
 
 	init_waitqueue_head(&s->ready_wait);
@@ -343,6 +346,7 @@ EXPORT_SYMBOL(amdtp_stream_get_max_paylo
  */
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 {
+	cancel_work_sync(&s->period_work);
 	s->pcm_buffer_pointer = 0;
 	s->pcm_period_pointer = 0;
 }
@@ -622,6 +626,16 @@ static void update_pcm_pointers(struct a
 	}
 }
 
+static void pcm_period_work(struct work_struct *work)
+{
+	struct amdtp_stream *s = container_of(work, struct amdtp_stream,
+					      period_work);
+	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
+
+	if (pcm)
+		snd_pcm_period_elapsed(pcm);
+}
+
 static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params,
 			bool sched_irq)
 {
@@ -1798,6 +1812,7 @@ static void amdtp_stream_stop(struct amd
 		return;
 	}
 
+	cancel_work_sync(&s->period_work);
 	fw_iso_context_stop(s->context);
 	fw_iso_context_destroy(s->context);
 	s->context = ERR_PTR(-1);
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -190,6 +190,7 @@ struct amdtp_stream {
 
 	/* For a PCM substream processing. */
 	struct snd_pcm_substream *pcm;
+	struct work_struct period_work;
 	snd_pcm_uframes_t pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 



