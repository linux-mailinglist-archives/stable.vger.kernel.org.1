Return-Path: <stable+bounces-251516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKRRLJUbDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:37:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A821599DA9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E795E33165E9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD833D75C7;
	Wed, 20 May 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Zw1KCLl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72A29D26E;
	Wed, 20 May 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298185; cv=none; b=h2tzPHAQo4tEvQENVReEQOCjKkQ1qkVPX5YLxWgkH3xB5DIEOyooTML1qW7Ft13nAFUprcy06IK540D/7NSDFuibqG2RORbKIi2b30/MSqEeQfHdhlBjLlu3bIWTBoJnDTq1qzHhTSvHhfiir5ZsLEfDqAnO6aDanMZt4RJcN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298185; c=relaxed/simple;
	bh=qMJZBoEZ+LafxwIWzKzI81MufHUQOBdQnDNVSnbdnYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/v/RXPXfV20ZEjiHz2GqRixBXu9yubLA9oQg9Q2HLCIehORY03x2xXkuV73mt6Y5lOMy/+Gs7bCTiBBAgBHe1uZ00YB3X1xSwnvhtD1zqE6QvtdhnlYihepLeeX4oDbHOuXvLAqg8IOeXakR7X8czefPpoAPmjbCwQ6w53sasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Zw1KCLl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395901F000E9;
	Wed, 20 May 2026 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298183;
	bh=uupKQtp8ZmD20gGLI9ki2eFFi6mp0jMJOikuoD7Sufw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0Zw1KCLlTp0qJl3w71k44LcGu4xxNrF8g2y5ZcMXo/LeoDxGKN2NRr8uPOuHPUbJa
	 neQl9ODKKoLyPNy1RBNOaUmBToGxWTuMMzCzv93facAgWVd7Upmb1lB7kojkGZ6TPf
	 FYjpj+VKfHjOvZ5HVOCwSKWNmfvgakLG2Ednwbg0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 315/957] ASoC: SOF: compress: return the configured codec from get_params
Date: Wed, 20 May 2026 18:13:18 +0200
Message-ID: <20260520162141.364020782@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251516-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1A821599DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 2c4fdd055f92a2fc8602dcd88bcea08c374b7e8b ]

The SOF compressed offload path accepts codec parameters in
sof_compr_set_params() and forwards them to firmware as
extended data in the SOF IPC stream params message.

However, sof_compr_get_params() still returns success without
filling the snd_codec structure. Since the compress core allocates
that structure zeroed and copies it back to userspace on success,
SNDRV_COMPRESS_GET_PARAMS returns an all-zero codec description
even after the stream has been configured successfully.

The stale TODO in this callback conflates get_params() with capability
discovery. Supported codec enumeration belongs in get_caps() and
get_codec_caps(). get_params() should report the current codec settings.

Cache the codec accepted by sof_compr_set_params() in the per-stream SOF
compress state and return it from sof_compr_get_params().

Fixes: 6324cf901e14 ("ASoC: SOF: compr: Add compress ops implementation")
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260325-sof-compr-get-params-v1-1-0758815f13c7@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/compress.c | 8 +++++---
 sound/soc/sof/sof-priv.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 593b8c7474846..31455ebb0f5bb 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -247,6 +247,7 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 	sstream->sampling_rate = params->codec.sample_rate;
 	sstream->channels = params->codec.ch_out;
 	sstream->sample_container_bytes = pcm->params.sample_container_bytes;
+	sstream->codec_params = params->codec;
 
 	spcm->prepared[cstream->direction] = true;
 
@@ -259,9 +260,10 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 static int sof_compr_get_params(struct snd_soc_component *component,
 				struct snd_compr_stream *cstream, struct snd_codec *params)
 {
-	/* TODO: we don't query the supported codecs for now, if the
-	 * application asks for an unsupported codec the set_params() will fail.
-	 */
+	struct sof_compr_stream *sstream = cstream->runtime->private_data;
+
+	*params = sstream->codec_params;
+
 	return 0;
 }
 
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 0f624d8cde201..985284a7b4ec9 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -17,6 +17,7 @@
 #include <sound/sof/info.h>
 #include <sound/sof/pm.h>
 #include <sound/sof/trace.h>
+#include <sound/compress_params.h>
 #include <uapi/sound/sof/fw.h>
 #include <sound/sof/ext_manifest.h>
 
@@ -111,6 +112,7 @@ struct sof_compr_stream {
 	u32 sampling_rate;
 	u16 channels;
 	u16 sample_container_bytes;
+	struct snd_codec codec_params;
 	size_t posn_offset;
 };
 
-- 
2.53.0




