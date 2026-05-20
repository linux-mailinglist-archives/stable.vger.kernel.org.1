Return-Path: <stable+bounces-249731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEqnC3UmDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:11:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907E587159
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D66306BA80
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E4331213;
	Wed, 20 May 2026 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ABvjfNzn"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A063314C4;
	Wed, 20 May 2026 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246527; cv=none; b=JWM9UGy1ONm5SS0MvQuQNxoRBFgjMA/B/QDxMw0p4F5wrFLUVYzh8nqWiNfQ/L3/AUiNV7KlWNtCdr7Z/VIoF+EKOca7fK90uVukEkoHqzNYk5FCtiWmdd/G9ZEspheHGcr1ctDPDOrAzZCMlmop+nDhUy6iu3KyCEPTABg6I1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246527; c=relaxed/simple;
	bh=+A/8UfCVuc3HoGvfWb5xerd6zASwUyz7LVr3ZM+0VYs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vcipi+er0DdFqKg84OFmvDTD+4Q2NF+SBUz6rzNaoUCZ6Tim/lE6M73TJCLYR28I145xd6C122OpNi4ZhhoaEUp8O/AWej7Y8C2jG8KBkjAUZt8C8n3na7th9Wec+HyIcvvp1HUn1/tZ3vsZ+g3EhS6NCzgiPwScWA9auogRhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ABvjfNzn; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779246518;
	bh=FBdO2ZdKG0UjUgimMPOfcquoq9sYhN3rdeOPDHj8bgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ABvjfNzn0Y+p3fvs/DnPvLXVUDObJ468fg8tIUvwwKH71BFiaQZo6NmL5mam/dcN5
	 dPXK81+61O1+zGnAPcO6trDjZnZaID1VjmJf/Pp34JYvEOUHTGJJwnoiM5iYSwFafN
	 7plIB7sdWC7gV4a2EvVarFWwRSFPkUm0in8ZZPdQ=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 215A5014; Wed, 20 May 2026 11:08:21 +0800
X-QQ-mid: xmsmtpt1779246514tfa8ebmp4
Message-ID: <tencent_5E3E7C2497AD95717A608A1A26694B6B7A09@qq.com>
X-QQ-XMAILINFO: Oayzr6Bt9/qspB6roIxZROqMW7jUE374uNXZUMkyTmixn35XZJhMig7ykSy4ZP
	 DwYhp/LkeDBaESi6y+/yVm+PJZNDso+9lGNvxLe3Ae1n+YjHkWRJKVOo3GeQLq4gdvwRoVCODMIs
	 kzRNaMlDcIWeFW8Ct0RL3c5idnx442O3F+03pK2xo0EG3bpMEHOqtDHknmsr3O5gq+KLYfIm+VxC
	 HqWHau5+KNDDjdT3RadVtSWJUGvv5Mx4s8Y94RI/hsemxTrPBlATRKWdXWP1s8o3P+N+Vw5YOfQZ
	 1Q3oqfwP8eaPOZ2emNNu7rJvMg1e/JNZeaoY/NcEzY3+MMRWFUDzeoKUJW3p/GfymVunngwTXRj/
	 NJjb8IFS6zTfvVdi2j2bUrnetuLXUjAtF4+3jiCvobXIrY90I8b2VDf+K2cZoWiAegqYcWvT7nob
	 Mn2Dwf4pLcuj4NUO3gFWI4DEh4Gv3Cjbpp/9MIwbPk2cTFYKHcBI3zcj2A9YRRkvOAMl+9YkGd4A
	 sFsDv9CbsuNQuHf8rluB+o9raohHVV8Y9KSgQVTvnXV5gpnZ7DVRKvClFBw8I8aD4HiIMrzQjwcX
	 ZytGUn7OrF7Nl2YT7g/4Eyr2jcPrfSO43DBUNkvn5bQnAGiIC/u0e1MXxNSqvcqU9Tn9Gqutye9H
	 tqdDD2dLZQ0Q5qYVAFzabuqW5nLjJXAW9p5caUSrtzNdTVe7nk2VVkqELOVrYQtwoaK9032jxIar
	 zSygAzcLhxPbO3TXlONelBUdCqiUCFb0UQh7iilDf9YWgEZeZgUD/2mSeHfvlWfEGnOdk/Ahrh9x
	 QOZa0z+OQYe0MIcg+M810Aow7hqnLsmFPdNrAaB3p9ttC/m2AZAP/dCFxYsxDBkULEYD6Ebsi0uw
	 UK2tNX1EqdzUpGwV3SCzBXML447baevHXdSfujTT9xqTYPS/t1bgr/AJaC21ODOnw0n+NkUHQCoY
	 bjfdtN2MZf00SLiUwaauxII8G4XBBEm87n6Vr0SXQTNAMsvQjykgDAmUyRsL5VkgaOy6j4ztYCX7
	 Vxz2rYLrgqAR+6/i93eTTnn+EL/nENa1RKdffhQHdLtIqfbPuptk2OOfluvfM=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org,
	alvalan9@foxmail.com,
	ranjani.sridharan@linux.intel.com,
	liam.r.girdwood@intel.com,
	mateuszx.redzynia@intel.com
Subject: [PATCH 6.6.y v2 2/3] ASoC: SOF: Intel: hda-dai: add support for dspless mode beyond HDAudio
Date: Wed, 20 May 2026 11:08:01 +0800
X-OQ-MSGID: <20260520030802.27966-3-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520030802.27966-1-alvalan9@foxmail.com>
References: <20260520030802.27966-1-alvalan9@foxmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249731-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,foxmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,foxmail.com:email,foxmail.com:dkim,qq.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 8907E587159
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 2065610b5ddd5b58eed1dc3b3c3db27a26ebd4b6 ]

For SoundWire/ALH, we need to have a dai configured, but we don't want
to send a DMA_TLV to firmware. Add additional code branches.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://msgid.link/r/20240213101247.28887-16-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 sound/soc/sof/intel/hda-dai.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index f5bfa17bf650..1fe7cce16091 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -83,6 +83,11 @@ hda_dai_get_ops(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai
 
 	sdev = widget_to_sdev(w);
 
+	if (!swidget) {
+		dev_err(sdev->dev, "%s: swidget is NULL\n", __func__);
+		return NULL;
+	}
+
 	if (sdev->dspless_mode_selected)
 		return hda_select_dai_widget_ops(sdev, swidget);
 
@@ -364,8 +369,11 @@ static int non_hda_dai_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* get stream_id */
 	sdev = widget_to_sdev(w);
+	if (sdev->dspless_mode_selected)
+		goto skip_tlv;
+
+	/* get stream_id */
 	hext_stream = ops->get_hext_stream(sdev, cpu_dai, substream);
 
 	if (!hext_stream) {
@@ -398,6 +406,7 @@ static int non_hda_dai_hw_params(struct snd_pcm_substream *substream,
 	dma_config->dma_stream_channel_map.device_count = 0; /* mapping not used */
 	dma_config->dma_priv_config_size = 0;
 
+skip_tlv:
 	return 0;
 }
 
-- 
2.43.0


