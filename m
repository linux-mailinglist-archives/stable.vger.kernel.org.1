Return-Path: <stable+bounces-251544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKyuA5zzDWoF5AUAu9opvQ
	(envelope-from <stable+bounces-251544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:47:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE05948DD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42E6F31947F4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AF2369D7E;
	Wed, 20 May 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWk7Epjq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EF2367DF;
	Wed, 20 May 2026 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298255; cv=none; b=RZfngdnIx4nW/PGsaKbDhx1S2BhI4zQKTJJyk1CcRazaWtN0QkpS11/PIMok4z2SYF9Kg+XaP/CcCmhNeXynI8mpM7DFL2BNhxefOABAWTtuKeFWiz9reIReYZvE+OcoHm0PbnbbEOLlda9fORVEyXBwN4P3hn57BxEvzXw6UAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298255; c=relaxed/simple;
	bh=/i7tCkZuTNvalD6/8WAKWeWb+CO6ql6ws3mNUzyBEA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW/e8YjWCH3VCI1fw2drYEKxZGF7go3rGPqhW0bI2OPTab8YXg0IBKbC3qyR/f39ddZjPcv+pIhbiMjQGJqhoKZ2T7JYAW2vA2b5Llu9oyKUGrny2ZZZJ61ooZs8ekUoywMp7AGHrTcXpswCOfwe4d0UbadNMU/GeAjmRerhjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWk7Epjq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FE91F000E9;
	Wed, 20 May 2026 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298254;
	bh=rszOGLVNYiHQ5Eso2zxt77IHvq/vrPEhFe031407i3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yWk7Epjqmku75ptbTVXg6JOjfsuMxYtL7EltpJREtmSdbxhKMQ0JURQBiqV8NZfP9
	 YE2o59hDfV5wd9Bt1q5LjvScsF5xuJlVjfNCJMvw9qLJR1Xl+wdTUvmn5h2YQ/+864
	 114ADeEwGwOIKud+klKsDY+fp5MHfC3TFkkrrkHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	Jeremy Bethmont <jeremy.bethmont@gmail.com>
Subject: [PATCH 6.18 340/957] ALSA: hda/realtek - fixed speaker no sound update
Date: Wed, 20 May 2026 18:13:43 +0200
Message-ID: <20260520162141.906270509@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251544-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,realtek.com,suse.de,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: B9DE05948DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 46c862f5419e0a86b60b9f9558d247f6084c99f9 ]

Fixed speaker has pop noise on Lenovo Thinkpad X11 Carbon Gen 12.

Fixes: 630fbc6e870e ("ALSA: hda/realtek - fixed speaker no sound")
Reported-and-tested-by: Jeremy Bethmont <jeremy.bethmont@gmail.com>
Closes: https://lore.kernel.org/CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com
Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index a2ecbe1412632..e14caa040fc92 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3615,22 +3615,11 @@ static void alc287_alc1318_playback_pcm_hook(struct hda_pcm_stream *hinfo,
 				   struct snd_pcm_substream *substream,
 				   int action)
 {
-	static const struct coef_fw dis_coefs[] = {
-		WRITE_COEF(0x24, 0x0013), WRITE_COEF(0x25, 0x0000), WRITE_COEF(0x26, 0xC203),
-		WRITE_COEF(0x28, 0x0004), WRITE_COEF(0x29, 0xb023),
-	}; /* Disable AMP silence detection */
-	static const struct coef_fw en_coefs[] = {
-		WRITE_COEF(0x24, 0x0013), WRITE_COEF(0x25, 0x0000), WRITE_COEF(0x26, 0xC203),
-		WRITE_COEF(0x28, 0x0084), WRITE_COEF(0x29, 0xb023),
-	}; /* Enable AMP silence detection */
-
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
-		alc_process_coef_fw(codec, dis_coefs);
 		alc_write_coefex_idx(codec, 0x5a, 0x00, 0x954f); /* write gpio3 to high */
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
-		alc_process_coef_fw(codec, en_coefs);
 		alc_write_coefex_idx(codec, 0x5a, 0x00, 0x554f); /* write gpio3 as default value */
 		break;
 	}
@@ -3653,10 +3642,15 @@ static void alc287_fixup_lenovo_thinkpad_with_alc1318(struct hda_codec *codec,
 		WRITE_COEF(0x24, 0x0013), WRITE_COEF(0x25, 0x0000), WRITE_COEF(0x26, 0xC301),
 		WRITE_COEF(0x28, 0x0001), WRITE_COEF(0x29, 0xb023),
 	};
+	static const struct coef_fw dis_coefs[] = {
+		WRITE_COEF(0x24, 0x0013), WRITE_COEF(0x25, 0x0000), WRITE_COEF(0x26, 0xC203),
+		WRITE_COEF(0x28, 0x0004), WRITE_COEF(0x29, 0xb023),
+	}; /* Disable AMP silence detection */
 
 	if (action != HDA_FIXUP_ACT_PRE_PROBE)
 		return;
 	alc_update_coef_idx(codec, 0x10, 1<<11, 1<<11);
+	alc_process_coef_fw(codec, dis_coefs);
 	alc_process_coef_fw(codec, coefs);
 	spec->power_hook = alc287_s4_power_gpio3_default;
 	spec->gen.pcm_playback_hook = alc287_alc1318_playback_pcm_hook;
-- 
2.53.0




