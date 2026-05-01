Return-Path: <stable+bounces-242487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMBtIsTy9Gl+FwIAu9opvQ
	(envelope-from <stable+bounces-242487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:36:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13F4AEDE1
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7530430078CF
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 18:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65D2D8DC2;
	Fri,  1 May 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU4WL1aL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2C2D0C7B
	for <stable@vger.kernel.org>; Fri,  1 May 2026 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660562; cv=none; b=di89ig5cZvu/+QDmYqSl0ImByr8FQ/ziHlaf8ulIS4ILuHqVRAE8uVo7HBbwpQS8N9ZfzZxJJBsD6BHwgfQVpW0yEx1VEzKQuCqpm3GvgUYVeexdubEKDwb4qGOLZSxx63QCJ+1RltRDjEXbBHYR7dIRVbEYwV8qo+5oNZEwciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660562; c=relaxed/simple;
	bh=FoAi3//zlDQQqco+9JIIy0SkUFF/xVU8DRZ/6p1kWC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqNDzr9p/AxIZq1TxFANYiJ5zObPJK/6pj7vveE1wIa5lEUt0DvfoB5+OvkjHwL7ik0gbF8YITnuWznSnC/6yDeV4fEjaZdRIS8HHt1P3N5JI0sY3njA9bYfZ/HQgx3cN4scCIW124Zdrh1WAeWRog1wevkn6iws6amaX5JAeCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU4WL1aL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F57C2BCB9;
	Fri,  1 May 2026 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777660562;
	bh=FoAi3//zlDQQqco+9JIIy0SkUFF/xVU8DRZ/6p1kWC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JU4WL1aLZRAEAo/59QBotZi7hFlLU5lw2oN8JOAJO9FxfK8Xst8eDkZY+UFjgCWAg
	 hoWS6cz3Xg0b5afBgWNnF3uQGZs80PlcNjA6rQicx1G5dI14pLmlwA/z2w3bKaupew
	 Wy2M2GKeCEQMCH27e+8B2vJwdwc+H4HtRhvNpeewpqor1FSs/8F0rCTY/uGP82Mktg
	 ptHyjVFCWgIss5iIOklWiw8ApcNCGinMsSL1E2eyayUT/tfNczGQT0Yow3TuItK2S0
	 BZSAEBJyIHckON4Z1+he6MaJsvsB2rE0LgddwK0n/mb9RXXKmlNNliXzHZX1rBjKW8
	 ccWLO4TArzdUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
Date: Fri,  1 May 2026 14:35:58 -0400
Message-ID: <20260501183559.3910873-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501183559.3910873-1-sashal@kernel.org>
References: <2026050121-washing-epidermal-d74f@gregkh>
 <20260501183559.3910873-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC13F4AEDE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242487-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit fd7df93013c5118812e63a52635dc6c3a805a1de ]

In i2sbus_resume(), skip devices with an empty codec list, which avoids
using an uninitialized 'sysclock_factor' in the 32-bit format path in
i2sbus_pcm_prepare().

In i2sbus_pcm_prepare(), replace two list_for_each_entry() loops with a
single list_first_entry() now that the codec list is guaranteed to be
non-empty by all callers.

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260310102921.210109-3-thorsten.blum@linux.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/aoa/soundbus/i2sbus/core.c |  3 +++
 sound/aoa/soundbus/i2sbus/pcm.c  | 16 +++++-----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 51ed2f34b276d..d877718dda947 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -408,6 +408,9 @@ static int i2sbus_resume(struct macio_dev* dev)
 	int err, ret = 0;
 
 	list_for_each_entry(i2sdev, &control->list, item) {
+		if (list_empty(&i2sdev->sound.codec_list))
+			continue;
+
 		/* reset i2s bus format etc. */
 		i2sbus_pcm_prepare_both(i2sdev);
 
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 086c49d457c34..59cba5cb29434 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -383,6 +383,9 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	/* set stop command */
 	command->command = cpu_to_le16(DBDMA_STOP);
 
+	cii = list_first_entry(&i2sdev->sound.codec_list,
+			       struct codec_info_item, list);
+
 	/* ok, let's set the serial format and stuff */
 	switch (runtime->format) {
 	/* 16 bit formats */
@@ -390,13 +393,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	case SNDRV_PCM_FORMAT_U16_BE:
 		/* FIXME: if we add different bus factors we need to
 		 * do more here!! */
-		bi.bus_factor = 0;
-		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
-			bi.bus_factor = cii->codec->bus_factor;
-			break;
-		}
-		if (!bi.bus_factor)
-			return -ENODEV;
+		bi.bus_factor = cii->codec->bus_factor;
 		input_16bit = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S32_BE:
@@ -410,10 +407,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		return -EINVAL;
 	}
 	/* we assume all sysclocks are the same! */
-	list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
-		bi.sysclock_factor = cii->codec->sysclock_factor;
-		break;
-	}
+	bi.sysclock_factor = cii->codec->sysclock_factor;
 
 	if (clock_and_divisors(bi.sysclock_factor,
 			       bi.bus_factor,
-- 
2.53.0


