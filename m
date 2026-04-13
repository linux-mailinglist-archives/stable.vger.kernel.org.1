Return-Path: <stable+bounces-236617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHDwFb4Y3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:24:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7223EED42
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F31693024906
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0D30BB80;
	Mon, 13 Apr 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TKC3kmh+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332F2F6931;
	Mon, 13 Apr 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097368; cv=none; b=dxDxkmHLD1NSdeesn4XvppUf+52/YkrxtItTuhDACUBTM6kec+/iok2ntPFqgKsDlfGG1r/r0pVWCLTZWJ3DcWjoN7zhyNtbyUGXrwhzKIK5FUPt/T6Zndqxrktn8sxtXMbNawEuW37ba2U5jGLM/vw/H9xZp5Q7LQLrE28pPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097368; c=relaxed/simple;
	bh=zsVL5YrMp+pScFIVaq+Mtr2xxbVvGHcIY6c0FrrlPng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOq1oaW1qklGfA+5XWJXFv/wcOkIve6rCpcwgbkkO//8JB1Qn0+6ymtR5QBp7z2P4h49DK6bYYbzc1Ec7WomE98VPo7Uj4WNGbxIZtTT5NUL7fpi6+GUmErCfc9eyBeHLhQF3ThJFj50Caa2ECcV+4oDkh+5YJFF7ztbJortmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TKC3kmh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA9C2BCAF;
	Mon, 13 Apr 2026 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097368;
	bh=zsVL5YrMp+pScFIVaq+Mtr2xxbVvGHcIY6c0FrrlPng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKC3kmh+0JQKGeE9khWvbSsIa27IfYYUBHCpoSTmfPeSucsy3jviqiUamBOUxYnJy
	 tZc0/AmL+VCnPncra+a6Ob4WpYJCoVfUzGRE1K+SyPiFhOl7L06e3m8/sXKcAuh/60
	 I8DlA4uU0DoQkU6xKY6B18Wu1fGDqyor32ViMozs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 109/570] ASoC: core: Do not call link_exit() on uninitialized rtd objects
Date: Mon, 13 Apr 2026 17:54:00 +0200
Message-ID: <20260413155834.526710938@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236617-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C7223EED42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit dd9f9cc1e6b9391140afa5cf27bb47c9e2a08d02 ]

On init we have sequence:

	for_each_card_prelinks(card, i, dai_link) {
		ret = snd_soc_add_pcm_runtime(card, dai_link);

	ret = init_some_other_things(...);
	if (ret)
		goto probe_end:

	for_each_card_rtds(card, rtd) {
		ret = soc_init_pcm_runtime(card, rtd);

probe_end:

while on exit:
	for_each_card_rtds(card, rtd)
		snd_soc_link_exit(rtd);

If init_some_other_things() step fails due to error we end up with
not fully setup rtds and try to call snd_soc_link_exit on them, which
depending on contents on .link_exit handler, can end up dereferencing
NULL pointer.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230929103243.705433-2-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 95bc5c225513 ("ASoC: soc-core: flush delayed work before removing DAIs and widgets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 42358dbc19b8c..3986b8ea6ccfc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1082,6 +1082,8 @@ struct snd_soc_pcm_runtime {
 	unsigned int pop_wait:1;
 	unsigned int fe_compr:1; /* for Dynamic PCM */
 
+	bool initialized;
+
 	int num_components;
 	struct snd_soc_component *components[]; /* CPU/Codec/Platform */
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 286bdc33274ba..a555fe0a837d5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1290,7 +1290,7 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 	snd_soc_runtime_get_dai_fmt(rtd);
 	ret = snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
 	if (ret)
-		return ret;
+		goto err;
 
 	/* add DPCM sysfs entries */
 	soc_dpcm_debugfs_add(rtd);
@@ -1315,17 +1315,26 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 	/* create compress_device if possible */
 	ret = snd_soc_dai_compress_new(cpu_dai, rtd, num);
 	if (ret != -ENOTSUPP)
-		return ret;
+		goto err;
 
 	/* create the pcm */
 	ret = soc_new_pcm(rtd, num);
 	if (ret < 0) {
 		dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
 			dai_link->stream_name, ret);
-		return ret;
+		goto err;
 	}
 
-	return snd_soc_pcm_dai_new(rtd);
+	ret = snd_soc_pcm_dai_new(rtd);
+	if (ret < 0)
+		goto err;
+
+	rtd->initialized = true;
+
+	return 0;
+err:
+	snd_soc_link_exit(rtd);
+	return ret;
 }
 
 static void soc_set_name_prefix(struct snd_soc_card *card,
@@ -1922,7 +1931,8 @@ static void soc_cleanup_card_resources(struct snd_soc_card *card)
 
 	/* release machine specific resources */
 	for_each_card_rtds(card, rtd)
-		snd_soc_link_exit(rtd);
+		if (rtd->initialized)
+			snd_soc_link_exit(rtd);
 	/* remove and free each DAI */
 	soc_remove_link_dais(card);
 	soc_remove_link_components(card);
-- 
2.51.0




