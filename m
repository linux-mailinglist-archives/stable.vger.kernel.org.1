Return-Path: <stable+bounces-249730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPEXJMYlDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:08:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B765870D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A08E304DD97
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE2331A6E;
	Wed, 20 May 2026 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="WaefjkZJ"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67855331A4C;
	Wed, 20 May 2026 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246527; cv=none; b=jrwkQkubnrX1HB10l7HoaQA397gDdvgpD2olC/+FYPPdny8zcNYRMAt0JoP6I7qsXu6/b9ZNjPzU726QjvsPtQaCwqTxiWwbcNJSEJ2iLd668GQnSgP48KOpn1Qt0JhRUwmMKT48F+jaTeEIRxOPIoT9vchbgtx8VOdVuATVFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246527; c=relaxed/simple;
	bh=8lZH6Io+93I8eJjeCV2gt7fXmqWTX59LFGuAJpFXFjM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UueObdBajv5/ZV7Ow5U2x8/YxzvLO4FHoxe49ivCQOkl8HnNIYItcP4D33kljETKgRon+qJBT2shzYL9iMjHAnGd27pZPU/LUVk4zX3Qs/LWXqO2kAK0PkEPIZkS2lAdSwRFd5pTjDt+HJBnGtcz/O8QgjAxB1xqG1hIDp0vJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=WaefjkZJ; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779246516;
	bh=FfDIS4CLiVbqmNq94CwPYj0XCqEj7kuC3jdXU2WyOXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WaefjkZJQVFmPYpE7TPx+SelhO0zh3qxiXOXXQuqBomiYMIt3pRVs9SdW7KGQUPvy
	 rtMbNfv8Sjvfa7pBbeeI4FIRamz5t5SBYRWAzT3rv6DBvMSvH/5E78rlCKDmgXha5N
	 xC1PcrhuJ8Ci1E7/NkNZ/m8qIq5KyopeWOaDxtro=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 215A5014; Wed, 20 May 2026 11:08:21 +0800
X-QQ-mid: xmsmtpt1779246511tqkoea5a2
Message-ID: <tencent_D6188B064F5AA59AB28F5649416B799C1007@qq.com>
X-QQ-XMAILINFO: MF2s0TKt0BDQgoZYV7/JLiOaTfLwj/7Q4tkjIpUkGtRz8NhC8vaSwXNbkB1wNu
	 J1E357g1d6Z37XwDBAhOomSIEWYOhRoo1iY8xBJDV9pJ8rtfXLyX2WWWElSfhM8vaJNRpjbjRd5G
	 klbCyuRsxJn8ShRrGkDBwlnZwqzPdIBMQdQtKOrWWsMKdIgejF9dZf6Mdi8gg9k5We+aDoQ/be7e
	 OAnJWGHlSkt049iIQVASIUkXoU0/uQY3HdPT+kzpy643Jt5wdBqCUnW/RKxtG9jZwsh/Vwgd8Qeu
	 LbC+l7sp0y0kB55rJJ1OAmeaIX5OF+UUWKGO2Yppsh98DrKlfKw22lMNz48Ah2ShMltdmUHfosKV
	 KJ0grNmK3n9VEINpRbVNz7RJj6gTivJugCFsuRnq2YPpDOZduYpy5+g/yh78NJDk4/1og1sXV2Vq
	 fmtABz3/JMRvk3diw4D7kS0Wj5nsryOT8rfzm3SOvGobMivv/M0Y3UVE/Eq3XC/hk7rCvyOmDc8E
	 UuPHHQ9BWhINeyEojIdWu6YgpAfTkcoeNhmFMqTY4fT8TeCVgkH4UFefzKB8tUZ11kz3o1FIrD98
	 3udFfP7QRoc2iXsgr7zVURUqwiJcmMHm+4TT57u6qb7904op6e6NTci6Y79KmCdTbsovEW7Xle7f
	 TZHUU67x6X/kuxrU7gVxln3QiXRI+rY7X4ubATQqCFU5vRIl4ohr65pxc4fVVqeloPeQfcZlSJ6Y
	 OlZMKR+my8CcPSWq73SCaFy/kx1YBqVFHCWU/FqanjXvKETKH1nNqy8KJBOStJyNXylS+M81c9l8
	 Z34n+EF/K7UkMxhwEwvBS5zN8bHDFKfmrN9higJ52ifivq1qW9/T2FrWgIDQ9gRwoq2bDu8Y5sbd
	 rdU1BidrDwp64gYxQ8P+ODQP/4kZy71fwUlDOiN12bL+JoxRhsNzCTQJIVNh3M9k3yWWgQgtOB35
	 rx3APUVwfGFphDzqfIWvUpg9JsNqNXKgNMUskwMd9Z+K1rZUhAsyoJIqYxKZ/t8JKWN33NS+vU2L
	 86j+fpsU1SKSAaK/qsmPWQEvdtvXSlcJLGkQNpc2uMjvltiExN
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
Subject: [PATCH 6.6.y v2 1/3] ASoC: SOF: Intel: hda-dai: remove dspless special case
Date: Wed, 20 May 2026 11:08:00 +0800
X-OQ-MSGID: <20260520030802.27966-2-alvalan9@foxmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249730-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,qq.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 64B765870D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit daa09d0615ce9c781777802874cffa4380f883c3 ]

The existing code forces a parameter to be NULL but that parameter is
not used yet. Remove the special case in preparation for additional
changes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://msgid.link/r/20240213101247.28887-9-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 sound/soc/sof/intel/hda-dai.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 19ec1a45737e..f5bfa17bf650 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -83,12 +83,8 @@ hda_dai_get_ops(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai
 
 	sdev = widget_to_sdev(w);
 
-	/*
-	 * The swidget parameter of hda_select_dai_widget_ops() is ignored in
-	 * case of DSPless mode
-	 */
 	if (sdev->dspless_mode_selected)
-		return hda_select_dai_widget_ops(sdev, NULL);
+		return hda_select_dai_widget_ops(sdev, swidget);
 
 	sdai = swidget->private;
 
-- 
2.43.0


