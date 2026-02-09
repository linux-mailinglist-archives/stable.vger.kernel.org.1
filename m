Return-Path: <stable+bounces-215103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GE5MEPyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:42:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDC110BA8
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0E9E306A500
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841FA285060;
	Mon,  9 Feb 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ms3+G8Ew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893F1AF0AF;
	Mon,  9 Feb 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647685; cv=none; b=H6DLq3iOfPdlgUKV3MLz62j+aMqUOe/7hG6TLbUIcpYZV9/ORo4qcZjhQBt4SSi62ctb87CTRhheZnV60di9GjJUFWPvVXbLY9z5gu/Y6g2e2qGsYuuI8wJGnEta5RIKrrejUlV5UyxqBF23N77eVyBmH2lCujDrEOJszB/R9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647685; c=relaxed/simple;
	bh=hR29LyBVHcxXF/YwHgakP61LjpU9vTn5lRiHVDIy3sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE4ImZoaKPOgEKU8e5WekhUjgMl4FDFagFgtjS55WWng7JwtO8Lx64mh6eRsl9ezI0hZbLdWYjXrQFDFLDMtN0HIftWiRQ+j9Xym/iFZp/uCeUct4QMEf+BgF0iJP+lQ+cW9qy4TwOwORGTdODYbvBwZc1JLKQgDfwzWN1F1V/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ms3+G8Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8083BC116C6;
	Mon,  9 Feb 2026 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647684;
	bh=hR29LyBVHcxXF/YwHgakP61LjpU9vTn5lRiHVDIy3sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ms3+G8EwZIccLNkvGXnFSco784Qv/T1FShKSZypht6dD3StueT+CWyXDRkUC79saD
	 uqXDK0BvXmb6H3VX1nMfSuDvFX8sJI8ljZcmgIDl7SE3ex3T3Kj/960YRoqInXQP93
	 4+eLR6pmDNuzJvE+gm8JnAyXt6cA4i4t3zMVjqPc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 174/175] ALSA: usb-audio: Use the right limit for PCM OOB check
Date: Mon,  9 Feb 2026 15:24:07 +0100
Message-ID: <20260209142326.735964474@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215103-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 1CEDC110BA8
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 70b4db7d258118a7464f039112a74ddb49a95b06 upstream.

The recent fix commit for addressing the OOB access of PCM URB data
buffer caused a regression on Behringer UMC2020HD device, resulting in
choppy sound.  The fix used ep->max_urb_frames for the upper limit
check, and this is no right value to be referred.

Use the actual buffer size (ctx->buffer_size) as the upper limit
instead, which also avoids the regression on the device above.

Fixes: ef5749ef8b30 ("ALSA: usb-audio: Prevent excessive number of frames")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220997
Link: https://patch.msgid.link/20260121082025.718748-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/pcm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1553,7 +1553,8 @@ static int prepare_playback_urb(struct s
 
 		for (i = 0; i < ctx->packets; i++) {
 			counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
-			if (counts < 0 || frames + counts >= ep->max_urb_frames)
+			if (counts < 0 ||
+			    (frames + counts) * stride > ctx->buffer_size)
 				break;
 			/* set up descriptor */
 			urb->iso_frame_desc[i].offset = frames * stride;



