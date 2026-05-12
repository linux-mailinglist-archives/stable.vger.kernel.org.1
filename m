Return-Path: <stable+bounces-245999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NPkFUNqA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:58:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95779526619
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1712B307FB4F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF463BB117;
	Tue, 12 May 2026 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T83Ypwrh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD03BB114;
	Tue, 12 May 2026 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608098; cv=none; b=AL9eYhwWerSctNK4VC/1grG259Fn3h1W2OxHrlL6N7C+gnMd6fBiCPyOzrfSvFmGvoZFBxhLWgA/uU/SSq/cnmYaPgzjJGfz7xY5GFJXmkXmCSDdIF5OhO44U7o/35Sk91T7gAOAowK/ZscM6/ezprVmuKJlUAE8n5x07c4HuKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608098; c=relaxed/simple;
	bh=0hZ+xhB3dMhcNcF5yBCam75mTrJQrLXCDJLEZJLphF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6xvvIC9d4PS5ry9Jx8ACddqNKy/u2j+nFIMyh7JjXjx/AEtCPSv5e1BbTzrbsObk3E1muQjP3qhCJWM8GRPIjisZypFF0E4xoerjMPYsLsosFbuIR1pBUVGUDFT1iVYFzV1cDQp/2s72q7ADntLr1i78NunPhIOefebHG/D90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T83Ypwrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BA3C2BCB0;
	Tue, 12 May 2026 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608098;
	bh=0hZ+xhB3dMhcNcF5yBCam75mTrJQrLXCDJLEZJLphF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T83YpwrhlkXx26Gf2F5ZKtC5JoSDjuFvYz6kFBKq3i5cMgzyqoJ4LCAUjcNUZ4lt5
	 0pytpL9N0UOyM3XNvFT1XEBMy3GuTtAPp1GXxq48DevF+3arrLdYYzP5Qz10J6Fb+s
	 6l1w6EeR0j0V+SQpGU0yQz6/BicxAysGZyemiUCY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 111/206] ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
Date: Tue, 12 May 2026 19:39:23 +0200
Message-ID: <20260512173935.205552794@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 95779526619
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245999-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

commit cab45ab95ce7600fc0ff84585c77fd45b7b0d67c upstream.

Reset queue pointer on SNDRV_PCM_TRIGGER_STOP event to be inline
with resetting appl_ptr. Without this we will end up with a queue_ptr
out of sync and driver could try to send data that is not ready yet.

Fix this by resetting the queue_ptr.

Fixes: 3d4a4411aa8bb ("ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260402081118.348071-6-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c |    1 +
 sound/soc/qcom/qdsp6/q6apm.c     |    2 ++
 2 files changed, 3 insertions(+)

--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -322,6 +322,7 @@ static int q6apm_dai_trigger(struct snd_
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* TODO support be handled via SoftPause Module */
 		prtd->state = Q6APM_STREAM_STOPPED;
+		prtd->queue_ptr = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -225,6 +225,8 @@ int q6apm_map_memory_regions(struct q6ap
 
 	mutex_lock(&graph->lock);
 
+	data->dsp_buf = 0;
+
 	if (data->buf) {
 		mutex_unlock(&graph->lock);
 		return 0;



