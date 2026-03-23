Return-Path: <stable+bounces-228461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJDwHmxTwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:51:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E152F54EA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C90FC31A5A1E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C473B19D8;
	Mon, 23 Mar 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SeTw+eLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1663B19CD;
	Mon, 23 Mar 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275201; cv=none; b=QSFVRnPvBGbXCq55cgvaQEyuFpTOapPscVZoGCWZrhBoDemNJraYMDhX4FcGjfbvVqP63WADatwr5s4+Z9+vFQ1ZidAzItISPraWO0V92TFjLQgJzd/OccS6kPlmGZeTkSl4hDvnvPGE+U/KRQvL10/mBjuvcW+mOdGR8CrlHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275201; c=relaxed/simple;
	bh=Ixnh3lCdv9+50M4EWU1/BwvMdTFp/Bh9d305QOmj75k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUEc/ABfRYs5k2caK7/fwFK986oRwP+HQZxBy2DT2CNqleIfK5YOag0ppjiyFT43IyL1hQ6JcDzSMCW5Vy7n37GZJN3uB8WAso4sP/IcvBS0B7SrnOJd2VKOGbC4XZBwJsiZyBZsNPr95jwcjEN/z26b5+os4WAnatfvnFu+9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SeTw+eLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFC5C2BCB6;
	Mon, 23 Mar 2026 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275201;
	bh=Ixnh3lCdv9+50M4EWU1/BwvMdTFp/Bh9d305QOmj75k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeTw+eLEGNLF5oBFtr0RSiofB9az++/6gFaptdmXcWx/EfLaQqpZiObTA2JIeNr40
	 N5zWko7hy7T2bMldvk0aKcQLyUY3JP6i44z0ApIf7svM/SyH6DhEivU7Y+Pe2CKsq2
	 CfxnfDjXxOs6oJEVIzBzF3nVJVF9n5wkY0Cxv8O0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 011/567] ALSA: usb-audio: Use inclusive terms
Date: Mon, 23 Mar 2026 14:38:51 +0100
Message-ID: <20260323134534.038633265@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228461-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 10E152F54EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 4e9113c533acee2ba1f72fd68ee6ecd36b64484e ]

Replace the remaining with inclusive terms; it's only this function
name we overlooked at the previous conversion.

Fixes: 53837b4ac2bd ("ALSA: usb-audio: Replace slave/master terms")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260225085233.316306-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index d035b25f67b64..806755a65fc05 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -160,8 +160,8 @@ int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep)
  * This won't be used for implicit feedback which takes the packet size
  * returned from the sync source
  */
-static int slave_next_packet_size(struct snd_usb_endpoint *ep,
-				  unsigned int avail)
+static int synced_next_packet_size(struct snd_usb_endpoint *ep,
+				   unsigned int avail)
 {
 	unsigned long flags;
 	unsigned int phase;
@@ -230,7 +230,7 @@ int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep,
 	}
 
 	if (ep->sync_source)
-		return slave_next_packet_size(ep, avail);
+		return synced_next_packet_size(ep, avail);
 	else
 		return next_packet_size(ep, avail);
 }
-- 
2.51.0




