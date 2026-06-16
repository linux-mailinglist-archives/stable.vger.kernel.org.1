Return-Path: <stable+bounces-265397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OpDpJnyJMWr2lwUAu9opvQ
	(envelope-from <stable+bounces-265397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:35:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CA26934B9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Vzng1JH8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265397-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265397-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80B713042F35
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E43BFE5B;
	Tue, 16 Jun 2026 17:29:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1A21C16A;
	Tue, 16 Jun 2026 17:29:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630991; cv=none; b=DZpTMjRIryVkOnKdFjZkO4q5y1z4IoQdlK0Rv3XKoeg4uF8UheyeDGmrZ+tlTILQ8BX/Ce9wWDROLldL1KkUv3w+No9xBLDkphIM0bvemWk4VNDYI33b4NU16/f7hG2vFihbnyQVSL6PFCAwbr0J5s6CzsVXSJXKnHBS2038v3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630991; c=relaxed/simple;
	bh=QLVnKg8tNe9bs5op6vEh36as3pncakk0RCwCUKs7Wc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei4IWxHBg4RaKxqCcQHonQzn8jseP+XggZ2lp3Lzb3tY7aLc5vjd4VUDlSnAGFlsvKI7DNsNSNFK8O3N0iAv07Zd8/wiKVjb8CGKh2NZGhRx3IJgX8mZpSmhosMOr089JpcZlkMeYVI/abtiGzM9teHiJJXT9h8PEd9j9N3WQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vzng1JH8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969B51F000E9;
	Tue, 16 Jun 2026 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630990;
	bh=71hsCm88KSMTU+WVgLijdxPpH+kQojSqhqTO6OdJ7wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vzng1JH83O7ph0xzp2YJ6LyS0YY8VG9hpdmbbalR8paQv4ShpOTC3zRz37hHQaQ8k
	 +HU0+WErmTaoRFhdfTkNdDycLMyBd3MtbxYBm+hx2VG7VpPz01++w/EBRdKQKJodny
	 HTYWglC/PNmSU27c63veyC/xQ8qGWmAHDOTa3h3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 134/522] ASoC: qcom: q6asm-dai: close stream only when running
Date: Tue, 16 Jun 2026 20:24:41 +0530
Message-ID: <20260616145132.376863803@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265397-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:Stable@vger.kernel.org,m:srinivas.kandagatla@oss.qualcomm.com,m:broonie@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2CA26934B9

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

commit 048c540ee76ded666bda74f9dae1ca3254e0633c upstream.

q6asm_dai_close() and q6asm_dai_compr_free() currently issue CMD_CLOSE
whenever prtd->state is non-zero.

After prepare() closes an existing stream, the state is updated to
Q6ASM_STREAM_STOPPED. Since this state is also non-zero, the close and
free paths can send CMD_CLOSE again for a stream that has already been
closed.

Restrict CMD_CLOSE to the Q6ASM_STREAM_RUNNING state so the command is
sent only when the ASM stream is still active.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260518092347.3446946-3-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -456,12 +456,12 @@ static int q6asm_dai_close(struct snd_so
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state)
+		if (prtd->state == Q6ASM_STREAM_RUNNING) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
-
-		q6asm_unmap_memory_regions(substream->stream,
+			q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
+		}
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 	}
@@ -678,7 +678,7 @@ static int q6asm_dai_compr_free(struct s
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state) {
+		if (prtd->state == Q6ASM_STREAM_RUNNING) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
 			if (prtd->next_track_stream_id) {
@@ -686,11 +686,11 @@ static int q6asm_dai_compr_free(struct s
 					  prtd->next_track_stream_id,
 					  CMD_CLOSE);
 			}
-		}
 
-		snd_dma_free_pages(&prtd->dma_buffer);
-		q6asm_unmap_memory_regions(stream->direction,
+			q6asm_unmap_memory_regions(stream->direction,
 					   prtd->audio_client);
+		}
+		snd_dma_free_pages(&prtd->dma_buffer);
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 	}



