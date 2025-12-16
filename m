Return-Path: <stable+bounces-201174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F143CC207D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 482D630216BC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384B6314D10;
	Tue, 16 Dec 2025 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qkp0Bbc9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A02BCF6C
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882442; cv=none; b=BAOuqU2C7GR4dxGuZtSKgsRP641upDj78NitPsNVd6R1dOSDjRMytEELemQoz0LBuNKotDFrnMKvc7Tzoyct1m+P7XoiuvvrVmUWRVXRTSahD7Emzbx3gO0dK/W2PgDj1XBo7sqkN3nQPiDCOOmvuti4PwdjcIt/CRqjEp+EGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882442; c=relaxed/simple;
	bh=EIAtoZN5sYi7+CDxj7CSyEozT5nI+2zEQhW8O/2fu1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fErGU8auceO+iIFbJLgXfXnmMLaHwle+Iw8me5efGrDGT4+/p6RGaqlPwD4eRnctjU0lRWaw0lEnM+R1RjMzlFQxTqR91UM/3JCivZ+9rI9B14QpLLap745rAfVSODFthZqdR2Wc6nJSMs1grJwBuOt2Z14zMkJ+JzSub7vUhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qkp0Bbc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B97C4CEF1;
	Tue, 16 Dec 2025 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765882441;
	bh=EIAtoZN5sYi7+CDxj7CSyEozT5nI+2zEQhW8O/2fu1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qkp0Bbc94v2WnajUK0a3hdH6WCeI7BEz2jRxeaV4yHMmVKShzm/7wotO7m/hgm/HE
	 /BzxdxNXcxyL9svRTTgY8+1xKmero8fq62XfrqayF4IeJF4ucs/4pwVOlGCgkJsN8L
	 3fvAYtMQvgen7E/vPjmrL1qIlZawvUGEe11hk0qM/ElQ+lrw0e33ByRDvz3GQIb5pf
	 YM+nzC6brbAUuLdunTXhIEEDxhWmhuvI1ATDWRMAbSnkQh1dM4VP2UVR/q8BfV5nV6
	 Zq1ebQzwWus26NI1OAT69TqwrXAqpcKcXSz0Q/zAA3AW1a0hAwY0gczw7uKPnJwIlT
	 l7Rjr+I43oqag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] ALSA: wavefront: Use guard() for spin locks
Date: Tue, 16 Dec 2025 05:53:44 -0500
Message-ID: <20251216105345.2748607-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025121659-feline-king-9be3@gregkh>
References: <2025121659-feline-king-9be3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 4b97f8e614ba46a50bd181d40b5a1424411a211a ]

Clean up the code using guard() for spin locks.

Merely code refactoring, and no behavior change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250829145300.5460-19-tiwai@suse.de
Stable-dep-of: e11c5c13ce0a ("ALSA: wavefront: Clear substream pointers on close")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/wavefront/wavefront_midi.c  | 131 ++++++++++----------------
 sound/isa/wavefront/wavefront_synth.c |  18 ++--
 2 files changed, 61 insertions(+), 88 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index 494b21be665c8..1250ecba659a0 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -113,7 +113,6 @@ static void snd_wavefront_midi_output_write(snd_wavefront_card_t *card)
 {
 	snd_wavefront_midi_t *midi = &card->wavefront.midi;
 	snd_wavefront_mpu_id  mpu;
-	unsigned long flags;
 	unsigned char midi_byte;
 	int max = 256, mask = 1;
 	int timeout;
@@ -142,11 +141,9 @@ static void snd_wavefront_midi_output_write(snd_wavefront_card_t *card)
 				break;
 		}
 	
-		spin_lock_irqsave (&midi->virtual, flags);
-		if ((midi->mode[midi->output_mpu] & MPU401_MODE_OUTPUT) == 0) {
-			spin_unlock_irqrestore (&midi->virtual, flags);
+		guard(spinlock_irqsave)(&midi->virtual);
+		if ((midi->mode[midi->output_mpu] & MPU401_MODE_OUTPUT) == 0)
 			goto __second;
-		}
 		if (output_ready (midi)) {
 			if (snd_rawmidi_transmit(midi->substream_output[midi->output_mpu], &midi_byte, 1) == 1) {
 				if (!midi->isvirtual ||
@@ -160,14 +157,11 @@ static void snd_wavefront_midi_output_write(snd_wavefront_card_t *card)
 						timer_delete(&midi->timer);
 				}
 				midi->mode[midi->output_mpu] &= ~MPU401_MODE_OUTPUT_TRIGGER;
-				spin_unlock_irqrestore (&midi->virtual, flags);
 				goto __second;
 			}
 		} else {
-			spin_unlock_irqrestore (&midi->virtual, flags);
 			return;
 		}
-		spin_unlock_irqrestore (&midi->virtual, flags);
 	}
 
       __second:
@@ -185,15 +179,13 @@ static void snd_wavefront_midi_output_write(snd_wavefront_card_t *card)
 				break;
 		}
 	
-		spin_lock_irqsave (&midi->virtual, flags);
+		guard(spinlock_irqsave)(&midi->virtual);
 		if (!midi->isvirtual)
 			mask = 0;
 		mpu = midi->output_mpu ^ mask;
 		mask = 0;	/* don't invert the value from now */
-		if ((midi->mode[mpu] & MPU401_MODE_OUTPUT) == 0) {
-			spin_unlock_irqrestore (&midi->virtual, flags);
+		if ((midi->mode[mpu] & MPU401_MODE_OUTPUT) == 0)
 			return;
-		}
 		if (snd_rawmidi_transmit_empty(midi->substream_output[mpu]))
 			goto __timer;
 		if (output_ready (midi)) {
@@ -215,20 +207,16 @@ static void snd_wavefront_midi_output_write(snd_wavefront_card_t *card)
 						timer_delete(&midi->timer);
 				}
 				midi->mode[mpu] &= ~MPU401_MODE_OUTPUT_TRIGGER;
-				spin_unlock_irqrestore (&midi->virtual, flags);
 				return;
 			}
 		} else {
-			spin_unlock_irqrestore (&midi->virtual, flags);
 			return;
 		}
-		spin_unlock_irqrestore (&midi->virtual, flags);
 	}
 }
 
 static int snd_wavefront_midi_input_open(struct snd_rawmidi_substream *substream)
 {
-	unsigned long flags;
 	snd_wavefront_midi_t *midi;
 	snd_wavefront_mpu_id mpu;
 
@@ -243,17 +231,15 @@ static int snd_wavefront_midi_input_open(struct snd_rawmidi_substream *substream
 	if (!midi)
 	        return -EIO;
 
-	spin_lock_irqsave (&midi->open, flags);
+	guard(spinlock_irqsave)(&midi->open);
 	midi->mode[mpu] |= MPU401_MODE_INPUT;
 	midi->substream_input[mpu] = substream;
-	spin_unlock_irqrestore (&midi->open, flags);
 
 	return 0;
 }
 
 static int snd_wavefront_midi_output_open(struct snd_rawmidi_substream *substream)
 {
-	unsigned long flags;
 	snd_wavefront_midi_t *midi;
 	snd_wavefront_mpu_id mpu;
 
@@ -268,17 +254,15 @@ static int snd_wavefront_midi_output_open(struct snd_rawmidi_substream *substrea
 	if (!midi)
 	        return -EIO;
 
-	spin_lock_irqsave (&midi->open, flags);
+	guard(spinlock_irqsave)(&midi->open);
 	midi->mode[mpu] |= MPU401_MODE_OUTPUT;
 	midi->substream_output[mpu] = substream;
-	spin_unlock_irqrestore (&midi->open, flags);
 
 	return 0;
 }
 
 static int snd_wavefront_midi_input_close(struct snd_rawmidi_substream *substream)
 {
-	unsigned long flags;
 	snd_wavefront_midi_t *midi;
 	snd_wavefront_mpu_id mpu;
 
@@ -293,16 +277,14 @@ static int snd_wavefront_midi_input_close(struct snd_rawmidi_substream *substrea
 	if (!midi)
 	        return -EIO;
 
-	spin_lock_irqsave (&midi->open, flags);
+	guard(spinlock_irqsave)(&midi->open);
 	midi->mode[mpu] &= ~MPU401_MODE_INPUT;
-	spin_unlock_irqrestore (&midi->open, flags);
 
 	return 0;
 }
 
 static int snd_wavefront_midi_output_close(struct snd_rawmidi_substream *substream)
 {
-	unsigned long flags;
 	snd_wavefront_midi_t *midi;
 	snd_wavefront_mpu_id mpu;
 
@@ -317,15 +299,13 @@ static int snd_wavefront_midi_output_close(struct snd_rawmidi_substream *substre
 	if (!midi)
 	        return -EIO;
 
-	spin_lock_irqsave (&midi->open, flags);
+	guard(spinlock_irqsave)(&midi->open);
 	midi->mode[mpu] &= ~MPU401_MODE_OUTPUT;
-	spin_unlock_irqrestore (&midi->open, flags);
 	return 0;
 }
 
 static void snd_wavefront_midi_input_trigger(struct snd_rawmidi_substream *substream, int up)
 {
-	unsigned long flags;
 	snd_wavefront_midi_t *midi;
 	snd_wavefront_mpu_id mpu;
 
@@ -341,30 +321,27 @@ static void snd_wavefront_midi_input_trigger(struct snd_rawmidi_substream *subst
 	if (!midi)
 		return;
 
-	spin_lock_irqsave (&midi->virtual, flags);
+	guard(spinlock_irqsave)(&midi->virtual);
 	if (up) {
 		midi->mode[mpu] |= MPU401_MODE_INPUT_TRIGGER;
 	} else {
 		midi->mode[mpu] &= ~MPU401_MODE_INPUT_TRIGGER;
 	}
-	spin_unlock_irqrestore (&midi->virtual, flags);
 }
 
 static void snd_wavefront_midi_output_timer(struct timer_list *t)
 {
 	snd_wavefront_midi_t *midi = timer_container_of(midi, t, timer);
 	snd_wavefront_card_t *card = midi->timer_card;
-	unsigned long flags;
 	
-	spin_lock_irqsave (&midi->virtual, flags);
-	mod_timer(&midi->timer, 1 + jiffies);
-	spin_unlock_irqrestore (&midi->virtual, flags);
+	scoped_guard(spinlock_irqsave, &midi->virtual) {
+		mod_timer(&midi->timer, 1 + jiffies);
+	}
 	snd_wavefront_midi_output_write(card);
 }
 
 static void snd_wavefront_midi_output_trigger(struct snd_rawmidi_substream *substream, int up)
 {
-	unsigned long flags;
 	snd_wavefront_midi_t *midi;
 	snd_wavefront_mpu_id mpu;
 
@@ -380,22 +357,22 @@ static void snd_wavefront_midi_output_trigger(struct snd_rawmidi_substream *subs
 	if (!midi)
 		return;
 
-	spin_lock_irqsave (&midi->virtual, flags);
-	if (up) {
-		if ((midi->mode[mpu] & MPU401_MODE_OUTPUT_TRIGGER) == 0) {
-			if (!midi->istimer) {
-				timer_setup(&midi->timer,
-					    snd_wavefront_midi_output_timer,
-					    0);
-				mod_timer(&midi->timer, 1 + jiffies);
+	scoped_guard(spinlock_irqsave, &midi->virtual) {
+		if (up) {
+			if ((midi->mode[mpu] & MPU401_MODE_OUTPUT_TRIGGER) == 0) {
+				if (!midi->istimer) {
+					timer_setup(&midi->timer,
+						    snd_wavefront_midi_output_timer,
+						    0);
+					mod_timer(&midi->timer, 1 + jiffies);
+				}
+				midi->istimer++;
+				midi->mode[mpu] |= MPU401_MODE_OUTPUT_TRIGGER;
 			}
-			midi->istimer++;
-			midi->mode[mpu] |= MPU401_MODE_OUTPUT_TRIGGER;
+		} else {
+			midi->mode[mpu] &= ~MPU401_MODE_OUTPUT_TRIGGER;
 		}
-	} else {
-		midi->mode[mpu] &= ~MPU401_MODE_OUTPUT_TRIGGER;
 	}
-	spin_unlock_irqrestore (&midi->virtual, flags);
 
 	if (up)
 		snd_wavefront_midi_output_write((snd_wavefront_card_t *)substream->rmidi->card->private_data);
@@ -405,7 +382,6 @@ void
 snd_wavefront_midi_interrupt (snd_wavefront_card_t *card)
 
 {
-	unsigned long flags;
 	snd_wavefront_midi_t *midi;
 	static struct snd_rawmidi_substream *substream = NULL;
 	static int mpu = external_mpu; 
@@ -419,37 +395,37 @@ snd_wavefront_midi_interrupt (snd_wavefront_card_t *card)
 		return;
 	}
 
-	spin_lock_irqsave (&midi->virtual, flags);
-	while (--max) {
-
-		if (input_avail (midi)) {
-			byte = read_data (midi);
-
-			if (midi->isvirtual) {				
-				if (byte == WF_EXTERNAL_SWITCH) {
-					substream = midi->substream_input[external_mpu];
-					mpu = external_mpu;
-				} else if (byte == WF_INTERNAL_SWITCH) { 
-					substream = midi->substream_output[internal_mpu];
+	scoped_guard(spinlock_irqsave, &midi->virtual) {
+		while (--max) {
+
+			if (input_avail(midi)) {
+				byte = read_data(midi);
+
+				if (midi->isvirtual) {
+					if (byte == WF_EXTERNAL_SWITCH) {
+						substream = midi->substream_input[external_mpu];
+						mpu = external_mpu;
+					} else if (byte == WF_INTERNAL_SWITCH) {
+						substream = midi->substream_output[internal_mpu];
+						mpu = internal_mpu;
+					} /* else just leave it as it is */
+				} else {
+					substream = midi->substream_input[internal_mpu];
 					mpu = internal_mpu;
-				} /* else just leave it as it is */
-			} else {
-				substream = midi->substream_input[internal_mpu];
-				mpu = internal_mpu;
-			}
+				}
 
-			if (substream == NULL) {
-				continue;
-			}
+				if (substream == NULL) {
+					continue;
+				}
 
-			if (midi->mode[mpu] & MPU401_MODE_INPUT_TRIGGER) {
-				snd_rawmidi_receive(substream, &byte, 1);
+				if (midi->mode[mpu] & MPU401_MODE_INPUT_TRIGGER) {
+					snd_rawmidi_receive(substream, &byte, 1);
+				}
+			} else {
+				break;
 			}
-		} else {
-			break;
 		}
-	} 
-	spin_unlock_irqrestore (&midi->virtual, flags);
+	}
 
 	snd_wavefront_midi_output_write(card);
 }
@@ -471,13 +447,10 @@ void
 snd_wavefront_midi_disable_virtual (snd_wavefront_card_t *card)
 
 {
-	unsigned long flags;
-
-	spin_lock_irqsave (&card->wavefront.midi.virtual, flags);
+	guard(spinlock_irqsave)(&card->wavefront.midi.virtual);
 	// snd_wavefront_midi_input_close (card->ics2115_external_rmidi);
 	// snd_wavefront_midi_output_close (card->ics2115_external_rmidi);
 	card->wavefront.midi.isvirtual = 0;
-	spin_unlock_irqrestore (&card->wavefront.midi.virtual, flags);
 }
 
 int
diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index bd679e2da154e..cd5c177943aa0 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -1741,10 +1741,10 @@ snd_wavefront_internal_interrupt (snd_wavefront_card_t *card)
 		return;
 	}
 
-	spin_lock(&dev->irq_lock);
-	dev->irq_ok = 1;
-	dev->irq_cnt++;
-	spin_unlock(&dev->irq_lock);
+	scoped_guard(spinlock, &dev->irq_lock) {
+		dev->irq_ok = 1;
+		dev->irq_cnt++;
+	}
 	wake_up(&dev->interrupt_sleeper);
 }
 
@@ -1796,11 +1796,11 @@ wavefront_should_cause_interrupt (snd_wavefront_t *dev,
 	wait_queue_entry_t wait;
 
 	init_waitqueue_entry(&wait, current);
-	spin_lock_irq(&dev->irq_lock);
-	add_wait_queue(&dev->interrupt_sleeper, &wait);
-	dev->irq_ok = 0;
-	outb (val,port);
-	spin_unlock_irq(&dev->irq_lock);
+	scoped_guard(spinlock_irq, &dev->irq_lock) {
+		add_wait_queue(&dev->interrupt_sleeper, &wait);
+		dev->irq_ok = 0;
+		outb(val, port);
+	}
 	while (!dev->irq_ok && time_before(jiffies, timeout)) {
 		schedule_timeout_uninterruptible(1);
 		barrier();
-- 
2.51.0


