Return-Path: <stable+bounces-249732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFiCLdklDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:09:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A2E5870E7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3958530265D6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0B2330B3F;
	Wed, 20 May 2026 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="FoDSxdc8"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158DD17BED0;
	Wed, 20 May 2026 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246534; cv=none; b=ERAvcUVXiJdGFnNXheGKsSV/GXImd5wgIUeJ7AYCPGqfPbtJmxbUGEbN1/0QnU1lXcvkEikRWvGrxmt4DwUThNeOlPW+wTc833nWe5LTfrMTpPHb587cM1+dJYxzQvsGXIMBkoOdQ3Z6OtoCJ34ppIp+Q8V7HBWYQsPYPidHzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246534; c=relaxed/simple;
	bh=LdDhmOvmUK4UpAL1mrmyxmYA4mZlMGY+44KcyoqnGvQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=vAgOMfBIHRVMoLpidsqoeM8rhs4v8xZIcEqHFoB3WBqG6oLUMo70gm+8Mas66aB/Vl17o+gW1cjBBSaBBw1Cu8pxr7G1Oy0kurtWFzOzrXNl45tqge5vLaSgPrEHSiYJ0skPxAapPB8tdsDfcaLM/8VxiN64/cg68wHglUZLptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=FoDSxdc8; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779246521;
	bh=S6Um5vx+97M1tb2FlAGE4WpL2f1PWoO7RwTruyfUEIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FoDSxdc8xkl8uJ46mkPy5nLgF7KwlbYNzTCnCh3mjqyFlEG2UsL74SwDdtO9p6sqn
	 wvhFIXRXdDoMZdX7D8/Ygip/qP49NZ89SWWVvAh1AHgR6RMzkmBKVefBMFHTBQVzMb
	 H7hrPah2EToXDToB4/9idKEHmTFs3K03wfU1+RFA=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 215A5014; Wed, 20 May 2026 11:08:21 +0800
X-QQ-mid: xmsmtpt1779246517trbu94x03
Message-ID: <tencent_2404270F46BFE18496AE06FA835C32CA5A05@qq.com>
X-QQ-XMAILINFO: M/M2SMd6THQP8kZr40nJD2+jfSAxcxKFp74o50Ak7iuQSxAjyRv0zWLHnfqlse
	 UGZUl2Fa82p9V8syOyDRF5Yznuee3pnN3bx1ShMu6+4KShtBk0JeqjZXCrk8VsIe3OfcmvUIrCNp
	 E134FDFz1OzGbl+w86VeYq92nP3CHCdKaotm1gis5EP6n3bicLcNx+8o93Vjfv0gxomIXWk5wxKS
	 fEV56nQPV+4prB9rw1bJYs2tRgAEz5ok6fRECZpZ6EV8n2tW44TzpF0cvqm4K4qvILwW1uPU/Gq5
	 zIYyAmG8kLZZY70l55dAg6EU5tZ2YbRgR77Jghjyn8jhvtnVtf7SgOwJmigv696qUIEc1R7FPqKS
	 gCeMzC07Jh8buWXhxxDy/vOZytEnRUxGRep2vUIxrVASQ9z69z0UFetCSt0oq0BUTm99T3nnmq+Y
	 7Ch/Ku5+OoExBjLPPRSA8Qx8c6MyIge2wQOWHFkd4NQRM7jjYKsGc87Lt+B8MQX81qRx8N1qae/0
	 RV8VZT1Gou+NXMSuptadFWHz88Zf1WF5aYhr5vcymMg6TN5INPim9/E88HL8Ib35e7FiOIAISO78
	 vxx9wc5hyi2wX9eu9xR7EI8nxLbGssvRMU2UPZ+A7bTaD6k96LgnxN+I6nM2TAetXhT4vtCd8+5J
	 XtjLvR71LGQL2IylYFujahgXv/JvU+/6hR9tw2tE85MHfeRSA+IwFLN0ugaz4Jw47QeTW/gSboDx
	 fQYPWOQej6uDF3eEazblthLV2phL82ZpqXcCCz5K18REck/cLQzBQ5cc7oKycCSrNDhYcEXWFZ9g
	 R0lTnEpWpB2HM44q/TpwTYbYyaOxnUFUoD/psSAawxqBJoHgtaSD7ZvXLtjP/9TN7I3DfTDQ3vpN
	 DpAv0uBBOl7Vvg3+pLkXro+t+EsdXz0buanmqrFW4GYRxS2sXZc2yWslpF7L0E+9YRvaAt79+otF
	 AyJsB3MojIHuVq1CnKyXHQx40wh5rY9nJpljCnMx303OcE81lntRUEwIZDwsAz6CS5VrHl632yDw
	 4GwHUzy0D66nIQu2CiEbctPAiSmhonVXAyJQSNYOFYEnUtYiKk/T75yr8y4cWBnQ/mRSf5DM+Now
	 MrRLDWDvAeWc1LicE4Xpf190DckA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
Subject: [PATCH 6.6.y v2 3/3] ASoC: SOF: Intel: hda: Fix NULL pointer dereference
Date: Wed, 20 May 2026 11:08:02 +0800
X-OQ-MSGID: <20260520030802.27966-4-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520030802.27966-1-alvalan9@foxmail.com>
References: <20260520030802.27966-1-alvalan9@foxmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-249732-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,foxmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,foxmail.com:email,foxmail.com:dkim]
X-Rspamd-Queue-Id: B8A2E5870E7
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
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 sound/soc/sof/intel/hda-dai.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 1fe7cce16091..a3d0b6d721aa 100644
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
2.43.0


