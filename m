Return-Path: <stable+bounces-253317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N+jFGIHDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:11:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D6597E80
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A42A320A050
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A602B403EBA;
	Wed, 20 May 2026 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P56i1nru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0678403EAE;
	Wed, 20 May 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302965; cv=none; b=R1nTQqI3PjnCTR988iXen8v6NcrJY7G3E24frUkyIMFvKXPSc6YhNtMQf7/rvZU/ZFX3mE2teDGHYxpox8s4zWnq2d/v2HPHLcM2VKnDwEgd7Wr5QzqLFi8q/vdlkzd7kx/nJrWKsN1z5LpCP6EEKVGiR5hGz5nrfinjwx/i/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302965; c=relaxed/simple;
	bh=yw8Tr7JfZknYcnyypW7rjEI3+vHNiNrr9kOrw17m0Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLmSxKJ073hquCXZI74JBz2jbFSc6291lv0d0bSwVLZsWNyXIGoHQjjqvm2Fj4fB4Rarb7f7n+wrbcxN2MBA+j4vWZ/QDrW1KD6WXDOtrA6t/6XgKg0sAMTOGK1d+7WYzxYkbUiGKr/G+z7PZvtUfShGw4J0ZJ7RKzZyZJdd65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P56i1nru; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2841F000E9;
	Wed, 20 May 2026 18:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302961;
	bh=HOTlXKMnAyYHrsqcBNyI3hndbQBLGYijb3HwToAELTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P56i1nrul+I3DjD5mgBuZU08rstYIZTdzGq6mcOE24tbpwMU2bQ2GQeYWdpln1nSW
	 vRM94Xx2EHKTl775/a0N8C+BiXVXn0z6lPC5on7aLsuYd3CTYnWjMQsAflk7GHydVK
	 61QxbGeV67/xBB7yZPE6SdGM3BRKUFR38soNBtGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mateusz Redzynia <mateuszx.redzynia@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 465/508] ASoC: SOF: Intel: hda: Fix NULL pointer dereference
Date: Wed, 20 May 2026 18:24:48 +0200
Message-ID: <20260520162108.673580537@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253317-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,intel.com,kernel.org,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,foxmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C92D6597E80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 16c589567a956d46a7c1363af3f64de3d420af20 ]

If there's a mismatch between the DAI links in the machine driver and
the topology, it is possible that the playback/capture widget is not
set, especially in the case of loopback capture for echo reference
where we use the dummy DAI link. Return the error when the widget is not
set to avoid a null pointer dereference like below when the topology is
broken.

RIP: 0010:hda_dai_get_ops.isra.0+0x14/0xa0 [snd_sof_intel_hda_common]

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Mateusz Redzynia <mateuszx.redzynia@intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20260204081833.16630-10-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-dai.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 1fe7cce160913..a3d0b6d721aaf 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -77,12 +77,22 @@ static const struct hda_dai_widget_dma_ops *
 hda_dai_get_ops(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai)
 {
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(cpu_dai, substream->stream);
-	struct snd_sof_widget *swidget = w->dobj.private;
+	struct snd_sof_widget *swidget;
 	struct snd_sof_dev *sdev;
 	struct snd_sof_dai *sdai;
 
-	sdev = widget_to_sdev(w);
+	/*
+	 * this is unlikely if the topology and the machine driver DAI links match.
+	 * But if there's a missing DAI link in topology, this will prevent a NULL pointer
+	 * dereference later on.
+	 */
+	if (!w) {
+		dev_err(cpu_dai->dev, "%s: widget is NULL\n", __func__);
+		return NULL;
+	}
 
+	sdev = widget_to_sdev(w);
+	swidget = w->dobj.private;
 	if (!swidget) {
 		dev_err(sdev->dev, "%s: swidget is NULL\n", __func__);
 		return NULL;
-- 
2.53.0




