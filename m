Return-Path: <stable+bounces-214089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ErvCHVmg2nUmQMAu9opvQ
	(envelope-from <stable+bounces-214089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:32:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDCFE8CCF
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 903D6307690E
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13EE421A0F;
	Wed,  4 Feb 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F2q5hyiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571B421A06;
	Wed,  4 Feb 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218526; cv=none; b=Wil8wFzVvLHLSG+m+RgxJIuMnS6dIb+RZrwnD8BzH/5Fx9bJyW1S7Ow6/DnvCqlnfSl6tQnJiUgjy8dDdkmlPp1NtvOTU62dFhJgUcL+WEZ2p8rAwDeFc4tF1GuHK9D2/qvGCQEPg1HNf4WksHBxE/AGsqOYIfla7yH/qmB9qWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218526; c=relaxed/simple;
	bh=kgM2oe8L6Dta0MRHJ+Ahk12m3yT4X8o60zIXJ8P8z78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qcd8p4J/Jr/60FyJWYBKD7rEBVOhPjTzLf9wQhWmLFqtFwAtjTlVdKi3PSUy7+rDKMpzajGxr+isYcmmIefax8NrN65Y5BeZcJ9bZPyIkyqrNAkY8kdrsnDEvj8ZuwpR0kUh8r2Mv76w08LZY86vsj1Zu4HaCkQqQbu8ZG3Nhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F2q5hyiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74E2C116C6;
	Wed,  4 Feb 2026 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218526;
	bh=kgM2oe8L6Dta0MRHJ+Ahk12m3yT4X8o60zIXJ8P8z78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2q5hyiKkfmbP2DC8uGIZCGTKs+OvVtJXB3nJQI+i2HThrxS2/HG9B4RCjrKDHBzQ
	 oad6StTbHf7iZp8jSe2TqsmQ10BW5FyVXz5TVlPnINHO5okZZFDlyACqLwGRMgZ6I3
	 UX9N3b4oOEobpLGBt9HTXFyoTTByFb6Tqv7lxJgs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Machek <pavel@denx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 57/72] ALSA: usb-audio: Fix missing unlock at error path of maxpacksize check
Date: Wed,  4 Feb 2026 15:41:00 +0100
Message-ID: <20260204143847.700383707@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
References: <20260204143845.603454952@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214089-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,uniontech.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,denx.de:email]
X-Rspamd-Queue-Id: ADDCFE8CCF
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit fdf0dc82eb60091772ecea73cbc5a8fb7562fc45 upstream.

The recent backport of the upstream commit 05a1fc5efdd8 ("ALSA:
usb-audio: Fix potential overflow of PCM transfer buffer") on the
older stable kernels like 6.12.y was broken since it doesn't consider
the mutex unlock, where the upstream code manages with guard().
In the older code, we still need an explicit unlock.

This is a fix that corrects the error path, applied only on old stable
trees.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/aSWtH0AZH5+aeb+a@duo.ucw.cz
Fixes: 98e9d5e33bda ("ALSA: usb-audio: Fix potential overflow of PCM transfer buffer")
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/endpoint.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1386,7 +1386,8 @@ int snd_usb_endpoint_set_params(struct s
 	if (ep->packsize[1] > ep->maxpacksize) {
 		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
 			      ep->maxpacksize, ep->cur_rate, ep->pps);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	/* calculate the frequency in 16.16 format */



