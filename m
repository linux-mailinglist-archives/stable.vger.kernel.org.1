Return-Path: <stable+bounces-225622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI/ZKqM0uGnXaQEAu9opvQ
	(envelope-from <stable+bounces-225622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:49:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D94829DA37
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C193099EAF
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04B53CD8A3;
	Mon, 16 Mar 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXHS041j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1B3CD8A0
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679503; cv=none; b=A875CsyAl8t1BMDh+rW1B94MVe6rn2wSEGWWaW4TBMW6BHtUX36acKQHjLIRIwpreBSmaDUNTjKxJBig2mS8Y31QGISDBOPafWmNbvJ7mOZVHDM6SeSldxF9+TjQGSCMLVNkuGf7ugkq0+mrI5ytfHh74rj2MVQxtacfWnPDpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679503; c=relaxed/simple;
	bh=b1nTBcxi5s9Ki0nbvQ1INnIT8vhYytwdDfuVEOlFzZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6Z5MTWx6kFLBkSFEvcFQx9XNLud806qA8DYB+pJg3hB7xWn3EsAS05WjXzEGMdnEd1pVEY6dcUOtuwEspGu7QimL15WjIsMZPyC6k1pYcllyFuU5uOK9KgGp5mXqi1b2QUWUOAQs+DlWZZu1yk3Nsbzgcf3YDYymxC+PLZJ+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXHS041j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0621C19425;
	Mon, 16 Mar 2026 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773679503;
	bh=b1nTBcxi5s9Ki0nbvQ1INnIT8vhYytwdDfuVEOlFzZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXHS041j8589xlDxW+ww+LwBq6XIsNIYK1f5zn8ZoTIGmlxinmWh/D09SlZiylCYl
	 GYvcTHtiJy21mhjSwEEc/XqdDc9N3W8yWr/Lz6jeKRbXo+lnx2rUrEfopZ/kl6tkr2
	 s+c/G7d1NbOVeqUvEdDfPuIstHjtDIUoBhGwDPizgKevfQrXeYtO6BcB0dGJeoOoiS
	 rSEOb3UQ1kUian8+Up7fpCjt59rmGEjZBupVFuMULIpTDs5hHqzOzFibeQRGb7qhAS
	 AXeEb2b+ibg+69Kii9PjmOVE4IV40PA/8cd1ticrqSNix+Gf19HhVw4IyY1jeixtIs
	 pGcNkF1J4Kp/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ALSA: pcm: fix wait_time calculations
Date: Mon, 16 Mar 2026 12:44:58 -0400
Message-ID: <20260316164459.944343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031626-glowworm-observant-79df@gregkh>
References: <2026031626-glowworm-observant-79df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,suse.de,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225622-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email,suse.de:email]
X-Rspamd-Queue-Id: 2D94829DA37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

[ Upstream commit 3ed2b549b39f57239aad50a255ece353997183fd ]

... in wait_for_avail() and snd_pcm_drain().

t was calculated in seconds, so it would be pretty much always zero, to
be subsequently de-facto ignored due to being max(t, 10)'d. And then it
(i.e., 10) would be treated as secs, which doesn't seem right.

However, fixing it to properly calculate msecs would potentially cause
timeouts when using twice the period size for the default timeout (which
seems reasonable to me), so instead use the buffer size plus 10 percent
to be on the safe side ... but that still seems insufficient, presumably
because the hardware typically needs a moment to fire up. To compensate
for this, we up the minimal timeout to 100ms, which is still two orders
of magnitude less than the bogus minimum.

substream->wait_time was also misinterpreted as jiffies, despite being
documented as being in msecs. Only the soc/sof driver sets it - to 500,
which looks very much like msecs were intended.

Speaking of which, shouldn't snd_pcm_drain() also use substream->
wait_time?

As a drive-by, make the debug messages on timeout less confusing.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Link: https://lore.kernel.org/r/20230405201219.2197774-1-oswald.buddenhagen@gmx.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 9b1dbd69ba6f ("ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_lib.c    | 11 +++++------
 sound/core/pcm_native.c |  8 ++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index f319e4298b874..38671c4737f51 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1877,15 +1877,14 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 		if (substream->wait_time) {
 			wait_time = substream->wait_time;
 		} else {
-			wait_time = 10;
+			wait_time = 100;
 
 			if (runtime->rate) {
-				long t = runtime->period_size * 2 /
-					 runtime->rate;
+				long t = runtime->buffer_size * 1100 / runtime->rate;
 				wait_time = max(t, wait_time);
 			}
-			wait_time = msecs_to_jiffies(wait_time * 1000);
 		}
+		wait_time = msecs_to_jiffies(wait_time);
 	}
 
 	for (;;) {
@@ -1933,8 +1932,8 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 		}
 		if (!tout) {
 			pcm_dbg(substream->pcm,
-				"%s write error (DMA or IRQ trouble?)\n",
-				is_playback ? "playback" : "capture");
+				"%s timeout (DMA or IRQ trouble?)\n",
+				is_playback ? "playback write" : "capture read");
 			err = -EIO;
 			break;
 		}
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 297d15383bded..f55f476b0a148 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2170,12 +2170,12 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		if (runtime->no_period_wakeup)
 			tout = MAX_SCHEDULE_TIMEOUT;
 		else {
-			tout = 10;
+			tout = 100;
 			if (runtime->rate) {
-				long t = runtime->period_size * 2 / runtime->rate;
+				long t = runtime->buffer_size * 1100 / runtime->rate;
 				tout = max(t, tout);
 			}
-			tout = msecs_to_jiffies(tout * 1000);
+			tout = msecs_to_jiffies(tout);
 		}
 		tout = schedule_timeout(tout);
 
@@ -2198,7 +2198,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 				result = -ESTRPIPE;
 			else {
 				dev_dbg(substream->pcm->card->dev,
-					"playback drain error (DMA or IRQ trouble?)\n");
+					"playback drain timeout (DMA or IRQ trouble?)\n");
 				snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 				result = -EIO;
 			}
-- 
2.51.0


