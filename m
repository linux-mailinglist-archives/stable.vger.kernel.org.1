Return-Path: <stable+bounces-246370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIFGEOpyA2q55wEAu9opvQ
	(envelope-from <stable+bounces-246370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B09527D17
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3403830B65BC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BD3EDE51;
	Tue, 12 May 2026 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LBd+YRJZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC33EDE55;
	Tue, 12 May 2026 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609051; cv=none; b=iyHKu3xzSKcoeSWOTAuLOPTq97JbpTSMqDH794tD22uFtD+vE53AX559UXQ/ElAjzxImzrXidzPKXPyjFcG2iTZzOjTJQKDxMljSLeAv+ebKaRVtPByi4KzvOurok7of7LCu43Zu0w7wCU9nBn+sH/wkcgS3DET883pRJYmCEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609051; c=relaxed/simple;
	bh=hiBcLHuRfog9NnOitKtjV0HA0BAlVnHJXnX8b555ACA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFjcjjIQFwClrOf17tzHFufQQPfqfzvYWhDs13v1kT5/LIQmEC5U5txHPAvbwQXptPCw3/O551mZHjOItEd1vGMmCtMTeriaQA0BkzUVBhA17gki+N6Wo9zb5pZE5c9guG8wPqAQukVWgTzB5R7AD2atjrB9HbXbTGE18Fr/Jb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LBd+YRJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC1FC2BCB0;
	Tue, 12 May 2026 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609051;
	bh=hiBcLHuRfog9NnOitKtjV0HA0BAlVnHJXnX8b555ACA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBd+YRJZXv+7WSEDFkWI3O+SdLCKxRH7d+zCCCKKFYsw0zXJgjtbnBg7AfIXu3xR9
	 jNNgbORtnXPHjxzkvNpFGCevCHjBjlAR3YECiO55mSYHakJ8bh2NVf4RJjj3WIJ+DO
	 o75T82Ol5vLXlW221kApd7INPUf4Jt7WZSvpZixY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: [PATCH 7.0 046/307] ALSA: pcm: oss: Fix data race at accessing runtime.oss.trigger
Date: Tue, 12 May 2026 19:37:21 +0200
Message-ID: <20260512173941.096247876@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A7B09527D17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246370-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,msgid.link:url]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 901ac0ff15edf9503162e2cf6579bd11a30f1ed4 upstream.

Currently the runtime.oss.trigger field may be accessed concurrently
without protection, which may lead to the data race.  And, in this
case, it may lead to more severe problem because it's a bit field; as
writing the data, it may overwrite other bit fields as well, which
confuses the operation completely, as spotted by fuzzing.

Fix it by covering runtime.oss.trigger bit fled also with the existing
params_lock mutex in both snd_pcm_oss_get_trigger() and
snd_pcm_oss_poll().

Reported-and-tested-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Closes: https://lore.kernel.org/20260423145330.210035-1-jjy600901@snu.ac.kr
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260424112205.123703-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/oss/pcm_oss.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2149,10 +2149,16 @@ static int snd_pcm_oss_get_trigger(struc
 
 	psubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	csubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
-	if (psubstream && psubstream->runtime && psubstream->runtime->oss.trigger)
-		result |= PCM_ENABLE_OUTPUT;
-	if (csubstream && csubstream->runtime && csubstream->runtime->oss.trigger)
-		result |= PCM_ENABLE_INPUT;
+	if (psubstream && psubstream->runtime) {
+		guard(mutex)(&psubstream->runtime->oss.params_lock);
+		if (psubstream->runtime->oss.trigger)
+			result |= PCM_ENABLE_OUTPUT;
+	}
+	if (csubstream && csubstream->runtime) {
+		guard(mutex)(&csubstream->runtime->oss.params_lock);
+		if (csubstream->runtime->oss.trigger)
+			result |= PCM_ENABLE_INPUT;
+	}
 	return result;
 }
 
@@ -2826,6 +2832,17 @@ static int snd_pcm_oss_capture_ready(str
 						runtime->oss.period_frames;
 }
 
+static bool need_input_retrigger(struct snd_pcm_runtime *runtime)
+{
+	bool ret;
+
+	guard(mutex)(&runtime->oss.params_lock);
+	ret = runtime->oss.trigger;
+	if (ret)
+		runtime->oss.trigger = 0;
+	return ret;
+}
+
 static __poll_t snd_pcm_oss_poll(struct file *file, poll_table * wait)
 {
 	struct snd_pcm_oss_file *pcm_oss_file;
@@ -2858,11 +2875,11 @@ static __poll_t snd_pcm_oss_poll(struct
 			    snd_pcm_oss_capture_ready(csubstream))
 				mask |= EPOLLIN | EPOLLRDNORM;
 		}
-		if (ostate != SNDRV_PCM_STATE_RUNNING && runtime->oss.trigger) {
+		if (ostate != SNDRV_PCM_STATE_RUNNING &&
+		    need_input_retrigger(runtime)) {
 			struct snd_pcm_oss_file ofile;
 			memset(&ofile, 0, sizeof(ofile));
 			ofile.streams[SNDRV_PCM_STREAM_CAPTURE] = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
-			runtime->oss.trigger = 0;
 			snd_pcm_oss_set_trigger(&ofile, PCM_ENABLE_INPUT);
 		}
 	}



