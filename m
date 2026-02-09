Return-Path: <stable+bounces-215054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOZNG5XxiWnyEgAAu9opvQ
	(envelope-from <stable+bounces-215054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:39:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B884B1109F9
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EB4B3045C24
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BDA37998A;
	Mon,  9 Feb 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I5SSXfBX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78A2222B2;
	Mon,  9 Feb 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647521; cv=none; b=jyuUjHICaNBA67jYEOSX9LlKUbgdGAJSqDhjndP5ACC8QsN9Us9zEe3fxZnIxVQXSF3ZGBCm+VIFzeYiDRuDK3bvp5V1TBIp1q8F8fzns8glZ3aJUFppX+XCAuK8DBbLF0tv1W6Za81KPdT8gDQ2UUAX1VSGh5etiWObEJN8ATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647521; c=relaxed/simple;
	bh=R0V81tf7cke0ClPtU+8LOVnnlOnIaTtFUiLRO02Fl/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4q41/lllM0gSNIwBatfqLFaBddEl9MN5zAuxXZCmd0IEZu1dH5Tjqd9NfrRcK4N1nOj5k5tc0s6F3WZNae+my6v+5DCPOPfBD23AJ8p0+A3NFAlZDoRaWoDj8hHrHaJajuwnp7jL5HUA+2sOLxH1E244qgPhduG5iiP+2HoF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I5SSXfBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC194C19423;
	Mon,  9 Feb 2026 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647521;
	bh=R0V81tf7cke0ClPtU+8LOVnnlOnIaTtFUiLRO02Fl/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5SSXfBXYcXpr2XSHyI8DNNEYRRSZ0sfDQRsUZksDWyO8VxAX08JxT6dJS8RTxJy9
	 S60FG5WIOWH+aFqztVPSqpNRUQObBQBayomiz3QcBAmTw6+UQSnDpElHdJMwKP6Mex
	 5DFe+lbMLrnyrcaVTBMLT+LqNk7+y/73hk8B5oL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+6db0415d6d5c635f72cb@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 090/175] ALSA: usb-audio: Prevent excessive number of frames
Date: Mon,  9 Feb 2026 15:22:43 +0100
Message-ID: <20260209142323.669977815@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,qq.com,suse.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215054-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,6db0415d6d5c635f72cb];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,msgid.link:url,qq.com:email,suse.de:email]
X-Rspamd-Queue-Id: B884B1109F9
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit ef5749ef8b307bf8717945701b1b79d036af0a15 ]

In this case, the user constructed the parameters with maxpacksize 40
for rate 22050 / pps 1000, and packsize[0] 22 packsize[1] 23. The buffer
size for each data URB is maxpacksize * packets, which in this example
is 40 * 6 = 240; When the user performs a write operation to send audio
data into the ALSA PCM playback stream, the calculated number of frames
is packsize[0] * packets = 264, which exceeds the allocated URB buffer
size, triggering the out-of-bounds (OOB) issue reported by syzbot [1].

Added a check for the number of single data URB frames when calculating
the number of frames to prevent [1].

[1]
BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
Write of size 264 at addr ffff88804337e800 by task syz.0.17/5506
Call Trace:
 copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
 prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
 prepare_outbound_urb+0x377/0xc50 sound/usb/endpoint.c:333

Reported-by: syzbot+6db0415d6d5c635f72cb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6db0415d6d5c635f72cb
Tested-by: syzbot+6db0415d6d5c635f72cb@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Link: https://patch.msgid.link/tencent_9AECE6CD2C7A826D902D696C289724E8120A@qq.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 54d01dfd820fa..263abb36bb2d1 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1553,7 +1553,7 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 
 		for (i = 0; i < ctx->packets; i++) {
 			counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
-			if (counts < 0)
+			if (counts < 0 || frames + counts >= ep->max_urb_frames)
 				break;
 			/* set up descriptor */
 			urb->iso_frame_desc[i].offset = frames * stride;
-- 
2.51.0




