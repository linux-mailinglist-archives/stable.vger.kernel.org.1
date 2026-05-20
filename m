Return-Path: <stable+bounces-252973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHfGIogqDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:41:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93859B348
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C859E37B27DA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B456933DEE5;
	Wed, 20 May 2026 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S/J7VA83"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471130DEAC;
	Wed, 20 May 2026 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302073; cv=none; b=bvoMivNDhMqZ1D2s/hWL0lq80dRN05mLJzl8T/84FELaQV4KnV2ysNMrxhGkEWXbX8knpgM65jtStMBiPjFsolqmZqqA1LDVddy6Ec+SS13ObYoK+v/Uo4kNW/sizK0kvKv9ZNoO6k/8ZYCalPS2PVhySreMJ+hOWDx3O9/b1OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302073; c=relaxed/simple;
	bh=P6KHpKWfxr0jdV4wzJ8dnwvOldgFGk2K4vkBDH5CwdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYha7P9cjqX2oviv4v4RsI/eBTb9GwQAUDJVA/CXDLNcsitjvi4B2M5hL/xk5MTLCC9y/1/a8NijuC64PmY+0uLnEJQkRD0VJZA0GKzACxfvvP4gByBznp4DdIEmVEWNtrepxnanDWiuJx8dSIh6e6RjGxLfxcZbmecb7h+5ycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/J7VA83; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A01F000E9;
	Wed, 20 May 2026 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302072;
	bh=TR3Q5dS/IHqh0nu7re2WNZBHhd5y9yQthYZ3LL19aMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/J7VA83GXjOHxpU1OcXsbNNMpT1GvCk7NnyO8rsey5K/zYlp5iMBhMvhU4hirIy0
	 LLRWfDwOYZW4BZy4J8xmY2h9C0tu3OtHH5oL1XAbUq0//hcqT/1Jw22rS19T/mQ+dX
	 OlBAg6MCZ1UpZkAd4202hfWkD4GBqm1niYwUqwyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 121/508] ALSA: core: Validate compress device numbers without dynamic minors
Date: Wed, 20 May 2026 18:19:04 +0200
Message-ID: <20260520162101.251343649@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252973-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,suse.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CD93859B348
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 796e119e9b14763be905ad0d023c71a14bc2e931 ]

Without CONFIG_SND_DYNAMIC_MINORS, ALSA reserves only two fixed minors
for compress devices on each card: comprD0 and comprD1.

snd_find_free_minor() currently computes the compress minor as
type + dev without validating dev first, so device numbers greater than
1 spill into the HWDEP minor range instead of failing registration.

ASoC passes rtd->id to snd_compress_new(), so this can happen on real
non-dynamic-minor builds.

Add a dedicated fixed-minor check for SNDRV_DEVICE_TYPE_COMPRESS in
snd_find_free_minor() and reject out-of-range device numbers with
-EINVAL before constructing the minor.

Also remove the stale TODO in compress_offload.c that still claims
multiple compress nodes are missing.

Fixes: 3eafc959b32f ("ALSA: core: add support for compressed devices")
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260325-alsa-compress-static-minors-v1-1-0628573bee1c@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 7 -------
 sound/core/sound.c            | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 619371aa9964d..8545c7bbc58e3 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -40,13 +40,6 @@
 #define COMPR_CODEC_CAPS_OVERFLOW
 #endif
 
-/* TODO:
- * - add substream support for multiple devices in case of
- *	SND_DYNAMIC_MINORS is not used
- * - Multiple node representation
- *	driver should be able to register multiple nodes
- */
-
 struct snd_compr_file {
 	unsigned long caps;
 	struct snd_compr_stream stream;
diff --git a/sound/core/sound.c b/sound/core/sound.c
index df5571d986295..f3bb0adf37cce 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -219,9 +219,16 @@ static int snd_find_free_minor(int type, struct snd_card *card, int dev)
 	case SNDRV_DEVICE_TYPE_RAWMIDI:
 	case SNDRV_DEVICE_TYPE_PCM_PLAYBACK:
 	case SNDRV_DEVICE_TYPE_PCM_CAPTURE:
+		if (snd_BUG_ON(!card))
+			return -EINVAL;
+		minor = SNDRV_MINOR(card->number, type + dev);
+		break;
 	case SNDRV_DEVICE_TYPE_COMPRESS:
 		if (snd_BUG_ON(!card))
 			return -EINVAL;
+		if (dev < 0 ||
+		    dev >= SNDRV_MINOR_HWDEP - SNDRV_MINOR_COMPRESS)
+			return -EINVAL;
 		minor = SNDRV_MINOR(card->number, type + dev);
 		break;
 	default:
-- 
2.53.0




