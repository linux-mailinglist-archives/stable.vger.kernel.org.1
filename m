Return-Path: <stable+bounces-229827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHYULkF1wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:15:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F262F9A5B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B194313CB73
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B903B775A;
	Mon, 23 Mar 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LkVuhlrW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283E3AEF5C;
	Mon, 23 Mar 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282972; cv=none; b=E5jcab2stspN5g1Z2o2IpI4VT4/vmKvjYSCDKmsnsvgS6oSXFTMg+klHZuGK7yxI7k6EUBBTs1RpPk62NV8Yeb4cUCAy1QjNG9FxmlB5TqDKJkYtVZbRRzdpNKEDKieEQj48RWDMrMvE4W6ciBtX/QEZes2J0tKKobBUuC7Abtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282972; c=relaxed/simple;
	bh=2Lol6uKFcFLIUY/CVnW8F0+zXfoblw2T3gZ6NtmBllo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1AVPxi8RZk6HJgFY0aHZMtfoduYCeRnH/TW0jcyE/ZXlwuPWsrOByZWsaN7clG3vz7+TpiIeo4rXe9EMOxPuKrcMQ6XF0PK+NzAg/KDHFEF6iBNOjVhcaghbmiZzGqEXUr3JVhh82XXYGFl3RXF6TRx5y9pFu8kn/PrEAlPv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LkVuhlrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED96C4CEF7;
	Mon, 23 Mar 2026 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282972;
	bh=2Lol6uKFcFLIUY/CVnW8F0+zXfoblw2T3gZ6NtmBllo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkVuhlrWg2zGfDDqEJYSjJQeTNHANGiJ622yUxkEde48SrOj29g1LxULoc62kaQT3
	 cuZKC3XkKY59USZS0u4OUQJrLJ9U9heyJ0GE3JIAOXSVowi6Bh+YpwrXOSNlDrgb9i
	 rDjNkYaBLDzoZbOA3b6Pzi3m7iYPaClHhNKpVRGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 327/481] ALSA: pcm: fix wait_time calculations
Date: Mon, 23 Mar 2026 14:45:09 +0100
Message-ID: <20260323134533.074024119@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229827-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmx.de,suse.de,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E7F262F9A5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/pcm_lib.c    |   11 +++++------
 sound/core/pcm_native.c |    8 ++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1878,15 +1878,14 @@ static int wait_for_avail(struct snd_pcm
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
@@ -1934,8 +1933,8 @@ static int wait_for_avail(struct snd_pcm
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
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2172,12 +2172,12 @@ static int snd_pcm_drain(struct snd_pcm_
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
 
@@ -2200,7 +2200,7 @@ static int snd_pcm_drain(struct snd_pcm_
 				result = -ESTRPIPE;
 			else {
 				dev_dbg(substream->pcm->card->dev,
-					"playback drain error (DMA or IRQ trouble?)\n");
+					"playback drain timeout (DMA or IRQ trouble?)\n");
 				snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 				result = -EIO;
 			}



