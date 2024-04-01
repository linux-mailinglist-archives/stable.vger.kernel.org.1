Return-Path: <stable+bounces-34764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56668940BA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C02834A5
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54038DE5;
	Mon,  1 Apr 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zaZKz+TY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FF1C0DE7;
	Mon,  1 Apr 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989218; cv=none; b=USE8HhFITr6bFyQDOnn9r51qtIMB5eoQqh1UF0yipfBtDblB+xr8EmUH3YDRk8hZfOXTVDpbh2+ThREUx8mkC/sqdftwC5XNbz7Eybm30WHzacxg6MvRoXc+F3rnKH7fR7ilJ+jyIUvM+3D0jNQy4nOfYqnlh8imbf8P0yrYiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989218; c=relaxed/simple;
	bh=f6C6VNuMO//8qRli0RCOmjLsM5AwwQfwsfrP1Xw1BuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIdQbeMOpypx1hOxjMnYAaBUt85MLvjPNimypSVEI0gPXvS53x/uNb5qkKH0BuCo0hNfj2e6VjTFOzNFXepy6qm2Lr3jSig8cZ8uR0+jxA2U1aS4RWbBKC43Z66Zq/Aq6cHlhYsVC7zNR0/QPkx+V7OFmiXc3nk5/VZ9LoC9jtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zaZKz+TY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B473C433C7;
	Mon,  1 Apr 2024 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989217;
	bh=f6C6VNuMO//8qRli0RCOmjLsM5AwwQfwsfrP1Xw1BuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zaZKz+TYzH+uhqAd8XcZjeug45JukxH9r0QpCdC3n3FXBUAD1B72/eZjTDawwoUuG
	 rRe+/5YK4kk7+JO5WxRhEIKSRXiBq+XOVF4skL6EfsWyQ2oHSmhz/LuFqoXfefJsEd
	 JCrBK6BUNSmp/oEx1QXiEH/DxE1T5Zui2XAf/CDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH 6.7 388/432] ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs
Date: Mon,  1 Apr 2024 17:46:15 +0200
Message-ID: <20240401152604.890440732@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

commit 051e0840ffa8ab25554d6b14b62c9ab9e4901457 upstream.

The dreamcastcard->timer could schedule the spu_dma_work and the
spu_dma_work could also arm the dreamcastcard->timer.

When the snd_pcm_substream is closing, the aica_channel will be
deallocated. But it could still be dereferenced in the worker
thread. The reason is that del_timer() will return directly
regardless of whether the timer handler is running or not and
the worker could be rescheduled in the timer handler. As a result,
the UAF bug will happen. The racy situation is shown below:

      (Thread 1)                 |      (Thread 2)
snd_aicapcm_pcm_close()          |
 ...                             |  run_spu_dma() //worker
                                 |    mod_timer()
  flush_work()                   |
  del_timer()                    |  aica_period_elapsed() //timer
  kfree(dreamcastcard->channel)  |    schedule_work()
                                 |  run_spu_dma() //worker
  ...                            |    dreamcastcard->channel-> //USE

In order to mitigate this bug and other possible corner cases,
call mod_timer() conditionally in run_spu_dma(), then implement
PCM sync_stop op to cancel both the timer and worker. The sync_stop
op will be called from PCM core appropriately when needed.

Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Message-ID: <20240326094238.95442-1-duoming@zju.edu.cn>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/sh/aica.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -278,7 +278,8 @@ static void run_spu_dma(struct work_stru
 		dreamcastcard->clicks++;
 		if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
 			dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
-		mod_timer(&dreamcastcard->timer, jiffies + 1);
+		if (snd_pcm_running(dreamcastcard->substream))
+			mod_timer(&dreamcastcard->timer, jiffies + 1);
 	}
 }
 
@@ -290,6 +291,8 @@ static void aica_period_elapsed(struct t
 	/*timer function - so cannot sleep */
 	int play_period;
 	struct snd_pcm_runtime *runtime;
+	if (!snd_pcm_running(substream))
+		return;
 	runtime = substream->runtime;
 	dreamcastcard = substream->pcm->private_data;
 	/* Have we played out an additional period? */
@@ -350,12 +353,19 @@ static int snd_aicapcm_pcm_open(struct s
 	return 0;
 }
 
+static int snd_aicapcm_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+
+	del_timer_sync(&dreamcastcard->timer);
+	cancel_work_sync(&dreamcastcard->spu_dma_work);
+	return 0;
+}
+
 static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 				 *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
-	flush_work(&(dreamcastcard->spu_dma_work));
-	del_timer(&dreamcastcard->timer);
 	dreamcastcard->substream = NULL;
 	kfree(dreamcastcard->channel);
 	spu_disable();
@@ -401,6 +411,7 @@ static const struct snd_pcm_ops snd_aica
 	.prepare = snd_aicapcm_pcm_prepare,
 	.trigger = snd_aicapcm_pcm_trigger,
 	.pointer = snd_aicapcm_pcm_pointer,
+	.sync_stop = snd_aicapcm_pcm_sync_stop,
 };
 
 /* TO DO: set up to handle more than one pcm instance */



