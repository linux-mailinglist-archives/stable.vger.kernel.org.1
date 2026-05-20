Return-Path: <stable+bounces-251998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBpmBwEhDmqj6QUAu9opvQ
	(envelope-from <stable+bounces-251998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:00:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5959A612
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E286339FBCA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF93F39C9;
	Wed, 20 May 2026 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CC6f1uR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF62F83A0;
	Wed, 20 May 2026 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299478; cv=none; b=glmWtWpmIugKgOInwyLzO98q5EuSdlTU9K72oPW5n5R0CsHB2LtA2RDvZMz4ATVT0wbnwuyK+B8b0bonJ1Wyc9CzBv2Qh60wMGMfr3ypuV2lzdcDS+tfvccr3u1W1PITjYPZ8RNLkZW/OKX8evnW773ixnbABC0GSZCkG8LBiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299478; c=relaxed/simple;
	bh=6+Ka9C7IxwFXLI9pzZjtky5ISToueGTl3lOOKFfW5QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrkVCT2KYHKWkOxu5UgX/CLOdTonyVywXVZA4LkmX5Z6zZqiba01J8QMJoFMaUJzjGhceO+jtq7qDrumahBTBiTCWSNSBZvK2hwKaG1jntANY93stRy+gEzfPw+qI7Rt9wkUZiQqRiXjxvz/3KxHM3B7G67obUjkz6hzvKeQSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CC6f1uR/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436BF1F00893;
	Wed, 20 May 2026 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299476;
	bh=aEdc/IeDlTmNR+SvjUcC6FXTLDizLXC1DuCN29miEII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CC6f1uR/zi1LK4Q6Y91yID6V5cmg5fwBzlLzAE+p99raae9jiPWH7sn4YEP9ZjieN
	 94Gn5If1G/rUv30ctnAK6TueHhzQ+rgoeU5JPCXOV4z0oYtkLu/rPEeSJCVwAhVT7f
	 B496sz0TgQA+b0/G+GQTo9LNz+ui5md2MDJUo3zc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 786/957] ALSA: usb-audio: Fix potential leak of pd at parsing UAC3 streams
Date: Wed, 20 May 2026 18:21:09 +0200
Message-ID: <20260520162151.607320959@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251998-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email]
X-Rspamd-Queue-Id: 7BA5959A612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c39f0bc03f84ba64c9144c95714df1dc36150f6d ]

At parsing UAC3 streams, we allocate a PD object at each time, and
either assign or free it.  But there is a case where the PD object may
be leaked; namely, in __snd_usb_parse_audio_interface() loop, when an
audioformat shares the same endpoint with others, it's put to a link
and returns from snd_usb_add_audio_stream(), but the PD is forgotten
afterwards.  Overall, the treatment of PD object in the parser code is
a bit flaky, and we should be more careful about the object ownership.

This patch tries to fix the above case and improve the code a bit.
The pd object is now managed with the auto-cleanup in the loop, and
the ownership is updated when the pd object gets assigned to the
stream, which guarantees the release of the leftover object.

Fixes: 7edf3b5e6a45 ("ALSA: usb-audio: AudioStreaming Power Domain parsing")
Link: https://patch.msgid.link/20260427151508.12544-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c |  2 +-
 sound/usb/stream.c | 58 ++++++++++++++++++----------------------------
 sound/usb/stream.h |  3 ++-
 3 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index f21e708675422..1b4cfc2b68f9d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -122,7 +122,7 @@ static int add_audio_stream_from_fixed_fmt(struct snd_usb_audio *chip,
 
 	snd_usb_audioformat_set_sync_ep(chip, fp);
 
-	err = snd_usb_add_audio_stream(chip, stream, fp);
+	err = snd_usb_add_audio_stream(chip, stream, fp, NULL);
 	if (err < 0)
 		return err;
 
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8b83092a1999e..34a50fb4e50b9 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -79,7 +79,7 @@ static void snd_usb_audio_pcm_free(struct snd_pcm *pcm)
 static void snd_usb_init_substream(struct snd_usb_stream *as,
 				   int stream,
 				   struct audioformat *fp,
-				   struct snd_usb_power_domain *pd)
+				   struct snd_usb_power_domain **pdptr)
 {
 	struct snd_usb_substream *subs = &as->substream[stream];
 
@@ -105,10 +105,11 @@ static void snd_usb_init_substream(struct snd_usb_stream *as,
 	if (fp->channels > subs->channels_max)
 		subs->channels_max = fp->channels;
 
-	if (pd) {
-		subs->str_pd = pd;
+	if (pdptr && *pdptr) {
+		subs->str_pd = *pdptr;
+		*pdptr = NULL; /* assigned */
 		/* Initialize Power Domain to idle status D1 */
-		snd_usb_power_domain_set(subs->stream->chip, pd,
+		snd_usb_power_domain_set(subs->stream->chip, subs->str_pd,
 					 UAC3_PD_STATE_D1);
 	}
 
@@ -486,11 +487,14 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
  * if not, create a new pcm stream. note, fp is added to the substream
  * fmt_list and will be freed on the chip instance release. do not free
  * fp or do remove it from the substream fmt_list to avoid double-free.
+ *
+ * pdptr is optional and can be NULL.  When it's non-NULL and the PD gets
+ * assigned to the stream, *pdptr is cleared to NULL upon return.
  */
-static int __snd_usb_add_audio_stream(struct snd_usb_audio *chip,
-				      int stream,
-				      struct audioformat *fp,
-				      struct snd_usb_power_domain *pd)
+int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
+			     int stream,
+			     struct audioformat *fp,
+			     struct snd_usb_power_domain **pdptr)
 
 {
 	struct snd_usb_stream *as;
@@ -523,7 +527,7 @@ static int __snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 		err = snd_pcm_new_stream(as->pcm, stream, 1);
 		if (err < 0)
 			return err;
-		snd_usb_init_substream(as, stream, fp, pd);
+		snd_usb_init_substream(as, stream, fp, pdptr);
 		return add_chmap(as->pcm, stream, subs);
 	}
 
@@ -552,7 +556,7 @@ static int __snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 	else
 		strscpy(pcm->name, "USB Audio");
 
-	snd_usb_init_substream(as, stream, fp, pd);
+	snd_usb_init_substream(as, stream, fp, pdptr);
 
 	/*
 	 * Keep using head insertion for M-Audio Audiophile USB (tm) which has a
@@ -570,21 +574,6 @@ static int __snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 	return add_chmap(pcm, stream, &as->substream[stream]);
 }
 
-int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
-			     int stream,
-			     struct audioformat *fp)
-{
-	return __snd_usb_add_audio_stream(chip, stream, fp, NULL);
-}
-
-static int snd_usb_add_audio_stream_v3(struct snd_usb_audio *chip,
-				       int stream,
-				       struct audioformat *fp,
-				       struct snd_usb_power_domain *pd)
-{
-	return __snd_usb_add_audio_stream(chip, stream, fp, pd);
-}
-
 static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 					 struct usb_host_interface *alts,
 					 int protocol, int iface_no)
@@ -1109,8 +1098,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 		}
 	}
 
-	if (pd)
-		*pd_out = pd;
+	*pd_out = pd;
 
 	return fp;
 }
@@ -1125,7 +1113,6 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 	struct usb_interface_descriptor *altsd;
 	int i, altno, err, stream;
 	struct audioformat *fp = NULL;
-	struct snd_usb_power_domain *pd = NULL;
 	bool set_iface_first;
 	int num, protocol;
 
@@ -1167,6 +1154,12 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 		if (snd_usb_apply_interface_quirk(chip, iface_no, altno))
 			continue;
 
+		/* pd may be allocated at snd_usb_get_audioformat_uac3() and
+		 * assigned at snd_usb_add_audio_stream(); otherwise it'll be
+		 * freed automatically by cleanup at each loop.
+		 */
+		struct snd_usb_power_domain *pd __free(kfree) = NULL;
+
 		/*
 		 * Roland audio streaming interfaces are marked with protocols
 		 * 0/1/2, but are UAC 1 compatible.
@@ -1222,23 +1215,16 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 			*has_non_pcm = true;
 		if ((fp->fmt_type == UAC_FORMAT_TYPE_I) == non_pcm) {
 			audioformat_free(fp);
-			kfree(pd);
 			fp = NULL;
-			pd = NULL;
 			continue;
 		}
 
 		snd_usb_audioformat_set_sync_ep(chip, fp);
 
 		dev_dbg(&dev->dev, "%u:%d: add audio endpoint %#x\n", iface_no, altno, fp->endpoint);
-		if (protocol == UAC_VERSION_3)
-			err = snd_usb_add_audio_stream_v3(chip, stream, fp, pd);
-		else
-			err = snd_usb_add_audio_stream(chip, stream, fp);
-
+		err = snd_usb_add_audio_stream(chip, stream, fp, &pd);
 		if (err < 0) {
 			audioformat_free(fp);
-			kfree(pd);
 			return err;
 		}
 
diff --git a/sound/usb/stream.h b/sound/usb/stream.h
index d92e18d5818fe..61b9a133da018 100644
--- a/sound/usb/stream.h
+++ b/sound/usb/stream.h
@@ -7,7 +7,8 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 
 int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 			     int stream,
-			     struct audioformat *fp);
+			     struct audioformat *fp,
+			     struct snd_usb_power_domain **pdptr);
 
 #endif /* __USBAUDIO_STREAM_H */
 
-- 
2.53.0




