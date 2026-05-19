Return-Path: <stable+bounces-249553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCJSCkBHDGp/cwUAu9opvQ
	(envelope-from <stable+bounces-249553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:19:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1E57D67D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 505F032F157A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BCB369D46;
	Tue, 19 May 2026 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="FNmSM6Nc"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F76369D40;
	Tue, 19 May 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187488; cv=none; b=A7IqlGl25TI2iBGlGtvbQHGXndcTL09jhHJy9G+qXFJAqhLaaQtZmXKWwPCuUOQ+tCguF2JrM5MtAlqqhmpDWFHQnmJsqCjer/m6MANoUsScUZCuvJLxs+/1y+nutnm0dpPrdFwcDZ1YG5oYqGM3i4kWx1U2/RHmSZrCiUQJc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187488; c=relaxed/simple;
	bh=tx2ZclnV4EPZ+VJtxhntBs96c9zQNEWBg4khpvyjAO0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dSi0TuA8OYdBp99TVEdO1hZu0D8kCDOs6oByl357fDZEtnDkDy8lohCO3tJCvbg2XXAQjx2TNM9qN3t4LxuE4YQFs7Hfa6sERVDrSZDN9BosLMQoQ/PL/iFkeJQsvdkFFCT7LbbpykGgS7ynFUrIbFSB9f/k8u9ZCRhPy+UrFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=FNmSM6Nc; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779187476;
	bh=jzFTY/L2kuYchY4V/fwL3uh+pr257shoI2myjkUjbeY=;
	h=From:To:Cc:Subject:Date;
	b=FNmSM6Nclr3utu/nSXDTkLzco10uFZQ4TDYkSEtinRqBp15JOqnmIZqhH0Z0Qz2w1
	 kDVz2n7r/BW5yMbuGjyWZ39RSjlTTv3a0Jc1+caXQwCN5WFXkKJblaxXsbtBgqYsxZ
	 5Od9ujjmjnnH4gCmBkPPgfvGPxjxra84oc+yVxN8=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B1FA2094; Tue, 19 May 2026 18:44:31 +0800
X-QQ-mid: xmsmtpt1779187471t825qb08u
Message-ID: <tencent_D2D615381730920DE9B46435691FBD92C708@qq.com>
X-QQ-XMAILINFO: N7qqMxIPUfzloYjVzXl1LffpChSCjW3WuC2iwD+/6ICOYVEcgY7KyHVVT7N1rg
	 S00hHaHKkHalLF8c/FXOgEzAq9RhuagG2ByZY7VkIX57fKoziHLrOqI4ujjgf127/0qw7zYiMqFQ
	 ws/hk493229AqerHtlYrk/6AOyakHd4YMTAQMKcwhGf2dpPbak+GXkhcFdOP41McgjrEthqR8lYz
	 PR9/SMtHmojC+IWxV9gR7STUhXc5VvCsB/wTPe7i3ZVo65Qi+2bN8nmkjE9JdSz/LEZGoh3nmohB
	 jQIwD98XGg7zrkfAG+Xw33ANG0DvOVkrtWFhL+OWTTNj+YfkTmISaU2TAVKqkEx1SIX/GnOb+XMU
	 fQ37vc0C1zyQNsbAZT4h4w4T6tzpZJaB+D6WCXNxPy0LwvEMI3Dy9o6/20a4mjy/tl4jdRd0uiLx
	 IQ/gD+Em6Za+0lfvN4Udx1goLZ9PouV8qpqbEz7Xd51B3JrddSliQrhlV/IDAq7TyhM4shc5dbPf
	 n6XfXN46v6kHKIGvBr3UbX5mGq81sRBpgUneZHnsro9nRk+oPEBJKWwusW59g8wChkKrAau/GWuZ
	 qyOu+8896Kcr2BMvC/9g+ez4Tu40qrqirNkmysjK6sxvvp88XQg+NdJ1S65uoHCKHYP86bZFTy1H
	 b+gYUfCK814DGhxAvqh9luJhhIFi6p6Qfh3T7nPKUmsbrbwLqLY5Zs/krKKhHSvvoMLwSizlenSN
	 2C5gol2qIkYhmTNz4A7bM2QXv0lfjxUdObqSJXE/Ns6dmW7ukDw42t45AEAAzWKN4NdR0YPsPweG
	 erz+cpVMSEmQ+GBzup3YP7fVHBwYE+UkZoJQKzd9JwuBJKS51s842S0SGTAZFQ0ZM/cobb7/QLcK
	 olXX9dwKc31NA7NLaGC4YaFP6JmaaB51f+otnt65Twoe7tRmbKeJODL+oV3QoygfjaZcGccv6PET
	 F/hINze0PuzO0Oi/UejkexKg4xq67p+elxjgZ75n+jiNC0uQV30OLOfZNrSjEd/Sc43wOPNno8v4
	 7yzJzPaKCg7v6WrxQuCS1JqKxiITc+6ZRw7F1CxCW+cIF9dEB2
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mateusz Redzynia <mateuszx.redzynia@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] ASoC: SOF: Intel: hda: Fix NULL pointer dereference
Date: Tue, 19 May 2026 18:44:10 +0800
X-OQ-MSGID: <20260519104410.25396-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249553-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,intel.com,kernel.org,foxmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,qq.com:mid]
X-Rspamd-Queue-Id: 77B1E57D67D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
[ Minor context conflict resolved. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 sound/soc/sof/intel/hda-dai.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 19ec1a45737e..097bcc7822a7 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -77,11 +77,22 @@ static const struct hda_dai_widget_dma_ops *
 hda_dai_get_ops(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai)
 {
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(cpu_dai, substream->stream);
-	struct snd_sof_widget *swidget = w->dobj.private;
+	struct snd_sof_widget *swidget;
 	struct snd_sof_dev *sdev;
 	struct snd_sof_dai *sdai;
 
+	/*
+	 * this is unlikely if the topology and the machine driver DAI links match.
+	 * But if there's a missing DAI link in topology, this will prevent a NULL pointer
+	 * dereference later on.
+	 */
+	if (!w) {
+		dev_err(cpu_dai->dev, "%s: widget is NULL\n", __func__);
+		return NULL;
+	}
+
 	sdev = widget_to_sdev(w);
+	swidget = w->dobj.private;
 
 	/*
 	 * The swidget parameter of hda_select_dai_widget_ops() is ignored in
-- 
2.43.0


