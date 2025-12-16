Return-Path: <stable+bounces-201165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C00CC1F8E
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D28D1301CD1C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B9310635;
	Tue, 16 Dec 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BwhK5rhz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D5A2F12BF
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881141; cv=none; b=O7FU13YFOLnuig735pMP2yJZS6iOfBWy2KrITQSsSV2mRb7oR6tLiXPp8OQNuQqrvDJRjAraXSM+AGvxzDmCyJIaaqOHoI459GYNBbn4nxzXV23tRxZ13fn0mHp9IdLyJZJ4ysyKrrDwtX0EBwckv0OszKgL4n0whUkJAlHgZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881141; c=relaxed/simple;
	bh=iNbbDqiHogw5UcnYl+c3xZLivvvYh12WHRowu/wyM90=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CGbjUFd7I4gdhLSE/CytpacaPWMfB0rGikkKGUOJaMRVPZ2/dVE2P8p31afsfmOfW+2dOJMeDgqcf/6LKT4m2QgA+4lQl9ZeubaZASgdzdN/TBtyhrh15x76MxBI11Jf8GN/c8nKzAJVYodnOmN5YnfOYy8kXj3BAxcchoo7wig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BwhK5rhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951FDC4CEFB;
	Tue, 16 Dec 2025 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765881140;
	bh=iNbbDqiHogw5UcnYl+c3xZLivvvYh12WHRowu/wyM90=;
	h=Subject:To:Cc:From:Date:From;
	b=BwhK5rhzvIRoWyhzmFFrtzJyVnqpCUXiKK521eHH1/7B+nNwBmBwMFxCa/oKoI59K
	 6F5QQPi7DRPiwpJg2V3Khs3XzRGfb/bZvou5OjP7NsGy+YC1hoKBlBrQ52FezDMX+x
	 PHiVYu7tIuyO5idzxhzCodjVvvJZkTuUk1w5Xhiw=
Subject: FAILED: patch "[PATCH] ALSA: wavefront: Clear substream pointers on close" failed to apply to 5.10-stable tree
To: moonafterrain@outlook.com,danisjiang@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Dec 2025 11:32:01 +0100
Message-ID: <2025121601-suffrage-senate-99ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e11c5c13ce0ab2325d38fe63500be1dd88b81e38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025121601-suffrage-senate-99ab@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


