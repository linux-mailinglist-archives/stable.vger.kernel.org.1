Return-Path: <stable+bounces-215225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I/XLi/0iWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:50:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7381110FB
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9DE830D9775
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0171936828A;
	Mon,  9 Feb 2026 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ut98uYSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863037998B;
	Mon,  9 Feb 2026 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648092; cv=none; b=JFyO0ZwDkHOuWDG3EhFckv3WDuGwLyvRVTdibZ01CBwWvTYWmc9ZqM56ly946nit0G9FBs0Q6518W1lS9eknjNTfeo5qGrRx7NIFMeGRiFJzaNsGUKdDebfMPqIWGLCcoShEgZEa+5EfSxX4urVxXVopdzMdJlqFPdKiBJWEV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648092; c=relaxed/simple;
	bh=JeMuVL1zBz7Mv1mPrmdRhquU0ZOVFHF8tcbUIfWRJFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM7VbUl419oV8TUL74lyENnnTp1VAA0LxkbTX8jgM+CeZw9xEg6xQpWbmn6VK83XGIuFdKmkwSHJS1YY0Ma1oul4bdfQvTgbtlmhIPr2/AT/FjTZox58hvLfCoBKiKWVUWwx9RlkXIXitiXRNGzW8RUE8OrNWpxVIHD28uZ0jVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ut98uYSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E29EC16AAE;
	Mon,  9 Feb 2026 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648092;
	bh=JeMuVL1zBz7Mv1mPrmdRhquU0ZOVFHF8tcbUIfWRJFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ut98uYShpzcDZGEU70nCUZbd3dy6QmcQiMuIvDPhQ4abtjGaeizcnJHyQcZPD0sq+
	 +kBv8MAxdAA7wrDg7EtQoiS2plKnf1Y7wmm0fSWns5Sgg3EhcUhcgJJAfKFFE2YV3F
	 s09UqnCZkwSy5ZnrqBtUdehQxVUDNli+muTwkxUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Shtylyov <s.shtylyov@auroraos.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 104/113] ALSA: usb-audio: fix broken logic in snd_audigy2nx_led_update()
Date: Mon,  9 Feb 2026 15:24:13 +0100
Message-ID: <20260209142313.911878886@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215225-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2F7381110FB
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Shtylyov <s.shtylyov@auroraos.dev>

[ Upstream commit 124bdc6eccc8c5cba68fee00e01c084c116c4360 ]

When the support for the Sound Blaster X-Fi Surround 5.1 Pro was added,
the existing logic for the X-Fi Surround 5.1 in snd_audigy2nx_led_put()
was broken due to missing *else* before the added *if*: snd_usb_ctl_msg()
became incorrectly called twice and an error from first snd_usb_ctl_msg()
call ignored.  As the added snd_usb_ctl_msg() call was totally identical
to the existing one for the "plain" X-Fi Surround 5.1, just merge those
two *if* statements while fixing the broken logic...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: 7cdd8d73139e ("ALSA: usb-audio - Add support for USB X-Fi S51 Pro")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Link: https://patch.msgid.link/20260203161558.18680-1-s.shtylyov@auroraos.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index b663764644cd8..6d6308ca4fa82 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -310,13 +310,8 @@ static int snd_audigy2nx_led_update(struct usb_mixer_interface *mixer,
 	if (err < 0)
 		return err;
 
-	if (chip->usb_id == USB_ID(0x041e, 0x3042))
-		err = snd_usb_ctl_msg(chip->dev,
-				      usb_sndctrlpipe(chip->dev, 0), 0x24,
-				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-				      !value, 0, NULL, 0);
-	/* USB X-Fi S51 Pro */
-	if (chip->usb_id == USB_ID(0x041e, 0x30df))
+	if (chip->usb_id == USB_ID(0x041e, 0x3042) ||	/* USB X-Fi S51 */
+	    chip->usb_id == USB_ID(0x041e, 0x30df))	/* USB X-Fi S51 Pro */
 		err = snd_usb_ctl_msg(chip->dev,
 				      usb_sndctrlpipe(chip->dev, 0), 0x24,
 				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-- 
2.51.0




