Return-Path: <stable+bounces-201161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC8CC1FA0
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1894E303EBA2
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4B30F928;
	Tue, 16 Dec 2025 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tKtJ3azP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2232D7388
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881122; cv=none; b=P6M3ZjdNYjRDzvxdIHeq9A6Wla2kLrHpcgqz4EnOffsArON1U8cGsVDoGx5+qZ8XJAI0Jbv45jBanT/25du2ufbPEMrI2MAD4o0w4vz7eJB41sgF0s/Ap9x7xYXMyUahGULFGIDWaG2FXSHpgda30JBx++G8tlL6NwA9KMjDAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881122; c=relaxed/simple;
	bh=ar+UNQ6a0BkRVxp8eQTRAXg6mPkr1wzmnO/fVYI+VxM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FX0ebzoDCXBnMhzXSIhQSsIfhEwPvTfs+gCv2qJxnAcJXcgKkb/VH0f/uo1SuJC7vWgDGkTgBmRN7CSnJUtaviPesWd5v3cev8pDvb9PREB/aoTZ1eBamIlAI9RjpPm17F4TZJvPPa3irchcGBYTrpUNkfbrAXBdA0eWRXDy8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tKtJ3azP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CAEC4CEF1;
	Tue, 16 Dec 2025 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765881122;
	bh=ar+UNQ6a0BkRVxp8eQTRAXg6mPkr1wzmnO/fVYI+VxM=;
	h=Subject:To:Cc:From:Date:From;
	b=tKtJ3azPXowN4w/jGfBeOumedayaoNu65dm9zEXCh+0aLYeuiq/1bkEAN2JuPlKGQ
	 3yhFqvcQ5c/rT7lWEHg7YxDXJvJguZSrEzm6fHQWaoyQ31WlTWiE0c9IH1V+RsKd4J
	 uzjNet6JkCGkRLwp2zoxuEYXr750srnkMKSumITU=
Subject: FAILED: patch "[PATCH] ALSA: wavefront: Clear substream pointers on close" failed to apply to 6.17-stable tree
To: moonafterrain@outlook.com,danisjiang@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Dec 2025 11:31:59 +0100
Message-ID: <2025121659-feline-king-9be3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x e11c5c13ce0ab2325d38fe63500be1dd88b81e38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025121659-feline-king-9be3@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e11c5c13ce0ab2325d38fe63500be1dd88b81e38 Mon Sep 17 00:00:00 2001
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 6 Nov 2025 10:24:57 +0800
Subject: [PATCH] ALSA: wavefront: Clear substream pointers on close

Clear substream pointers in close functions to avoid leaving dangling
pointers, helping to improve code safety and
prevents potential issues.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB7881DF762CAB45EE42F6D812AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index 1250ecba659a..69d87c4cafae 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -278,6 +278,7 @@ static int snd_wavefront_midi_input_close(struct snd_rawmidi_substream *substrea
 	        return -EIO;
 
 	guard(spinlock_irqsave)(&midi->open);
+	midi->substream_input[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_INPUT;
 
 	return 0;
@@ -300,6 +301,7 @@ static int snd_wavefront_midi_output_close(struct snd_rawmidi_substream *substre
 	        return -EIO;
 
 	guard(spinlock_irqsave)(&midi->open);
+	midi->substream_output[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_OUTPUT;
 	return 0;
 }


