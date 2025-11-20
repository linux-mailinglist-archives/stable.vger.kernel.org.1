Return-Path: <stable+bounces-195338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AFC75462
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C746A2BADF
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB11361DCF;
	Thu, 20 Nov 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZLikKyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B13587BD
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655288; cv=none; b=V+A/+4+rzzy/xTwLJfYgWRgouRni13gUVnPxR+dnwdyaNOV8O1hm0qH2mqT1iLlclcJxcJxKDNpbES4tzulqqGC78WKQlA9xFA86aWqogUF/U5/xxNQ+rjklFHMNUtM/80i2WEMxvDgyrIkpzz9VdmiMYnpOwv8Mh93Ta+7HJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655288; c=relaxed/simple;
	bh=EVh3juoHjHFGuYTjZzefb09ptr119BQRekhG6/9txAY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uqwwK3PaWh7fqlMhGt/FuJ1RQdmRn2eFKVBlFTg/ob7m3mzLJLmqybdmCNDhwwdDAefdwELzBpys4vLLDjbe3+Bo2M/77hr1IzgmKO1ER3gv8A2zaUda5+8BEgVjRrBCPpYIZ2BYpRV2gA45mmKYIWA7+vlmL2jCDFEaZc5xHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZLikKyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2378C4CEF1;
	Thu, 20 Nov 2025 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655288;
	bh=EVh3juoHjHFGuYTjZzefb09ptr119BQRekhG6/9txAY=;
	h=Subject:To:Cc:From:Date:From;
	b=EZLikKyNezbjZNN6qwhk0mjMBk5mkkQVIRIWN+rfPbtYHqLRkHowVd07ElJzEH7k+
	 EU7QTLKXKDSIiyKanyhMmdFPlxoyib2JfPOt/7eKazgUDq0Po4Nd2yMh8EISInu36W
	 lCQUrExjCsOcI5EBQAiMbttyFFnYf5Qdps6QeS90=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Fix potential overflow of PCM transfer" failed to apply to 5.4-stable tree
To: tiwai@suse.de,lizhi.xu@windriver.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:14:37 +0100
Message-ID: <2025112037-brick-dreadful-388a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 05a1fc5efdd8560f34a3af39c9cf1e1526cc3ddf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112037-brick-dreadful-388a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05a1fc5efdd8560f34a3af39c9cf1e1526cc3ddf Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Sun, 9 Nov 2025 10:12:07 +0100
Subject: [PATCH] ALSA: usb-audio: Fix potential overflow of PCM transfer
 buffer

The PCM stream data in USB-audio driver is transferred over USB URB
packet buffers, and each packet size is determined dynamically.  The
packet sizes are limited by some factors such as wMaxPacketSize USB
descriptor.  OTOH, in the current code, the actually used packet sizes
are determined only by the rate and the PPS, which may be bigger than
the size limit above.  This results in a buffer overflow, as reported
by syzbot.

Basically when the limit is smaller than the calculated packet size,
it implies that something is wrong, most likely a weird USB
descriptor.  So the best option would be just to return an error at
the parameter setup time before doing any further operations.

This patch introduces such a sanity check, and returns -EINVAL when
the packet size is greater than maxpacksize.  The comparison with
ep->packsize[1] alone should suffice since it's always equal or
greater than ep->packsize[0].

Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
Link: https://lore.kernel.org/690b6b46.050a0220.3d0d33.0054.GAE@google.com
Cc: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20251109091211.12739-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 880f5afcce60..cc15624ecaff 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1362,6 +1362,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	ep->sample_rem = ep->cur_rate % ep->pps;
 	ep->packsize[0] = ep->cur_rate / ep->pps;
 	ep->packsize[1] = (ep->cur_rate + (ep->pps - 1)) / ep->pps;
+	if (ep->packsize[1] > ep->maxpacksize) {
+		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
+			      ep->maxpacksize, ep->cur_rate, ep->pps);
+		return -EINVAL;
+	}
 
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;


