Return-Path: <stable+bounces-218256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEkTFzFSnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0448C18F271
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D102D3182B5B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEABE251795;
	Wed, 25 Feb 2026 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GAM+XCor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFD2BAF7;
	Wed, 25 Feb 2026 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983054; cv=none; b=Wgb3tOPFB+K6+YZXJ8naASiynCydMhxuuyzIvJmQSx8keUyPCMMfOBKdqDRNg3yA5VvVVAgvdHe0ethUlq8v6/XylzMB0LmlZjiBBNcQIhpN2ZZBSwKuEvU0o+SzSanGD7KY0TYJmeFhKaQPx3seYDFuzhTcED8BwxrzODPKyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983054; c=relaxed/simple;
	bh=N453ZaxdIelFPvIge0qr6foa5Z2L1vDDkDUgQQJiqhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFzUz/ONPMKEzLKWDzG+ImQ2DTsFnED8irbzMOw1ciF1n8UPFMf/ByOYTfZBg7PVeXtqcKpVJHNAoDVpopoGXQJJj6tnq9L3SlOnMJ+4t+to5DwdhniCAaDoVo2r8JIfWKWbvrNROaiRDgte1Y1QkzIBOd712k0EZPnoK5GIjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GAM+XCor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3358CC116D0;
	Wed, 25 Feb 2026 01:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983054;
	bh=N453ZaxdIelFPvIge0qr6foa5Z2L1vDDkDUgQQJiqhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GAM+XCorHx07DSKr1o+h+XSywF5tcT2qqwWEzw1oJTKhTi9NDrElkXwCm3YfgBthO
	 UPgcYZxarqgh8w9R6lttE2kOrdVpDuXzTZPA8TgCr2O8hhJn9Gk7GnjOQt1Bh3eajK
	 OANF92wnQwa2NR4PhVExYv4slJZMaOa9WiP0YDJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 219/781] ALSA: timer: Relax __free() variable declarations
Date: Tue, 24 Feb 2026 17:15:28 -0800
Message-ID: <20260225012405.087280700@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218256-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email]
X-Rspamd-Queue-Id: 0448C18F271
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b1bf8ac5319010e0f73183bdb78c1daf5552c8cb ]

We used to have a variable declaration with __free() initialized with
NULL.  This was to keep the old coding style rule, but recently it's
relaxed and rather recommends to follow the new rule to declare in
place of use for __free() -- which avoids potential deadlocks or UAFs
with nested cleanups.

Although the current code has no bug, per se, let's follow the new
standard and move the declaration to the place of assignment (or
directly assign the allocated result) instead of NULL initializations.

Fixes: ed96f6394e1b ("ALSA: timer: Use automatic cleanup of kfree()")
Fixes: 37745918e0e7 ("ALSA: timer: Introduce virtual userspace-driven timers")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20251216140634.171890-8-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index d9fff5c87613e..9a4a1748ff80b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1614,12 +1614,12 @@ static int snd_timer_user_next_device(struct snd_timer_id __user *_tid)
 static int snd_timer_user_ginfo(struct file *file,
 				struct snd_timer_ginfo __user *_ginfo)
 {
-	struct snd_timer_ginfo *ginfo __free(kfree) = NULL;
 	struct snd_timer_id tid;
 	struct snd_timer *t;
 	struct list_head *p;
+	struct snd_timer_ginfo *ginfo __free(kfree) =
+		memdup_user(_ginfo, sizeof(*ginfo));
 
-	ginfo = memdup_user(_ginfo, sizeof(*ginfo));
 	if (IS_ERR(ginfo))
 		return PTR_ERR(ginfo);
 
@@ -1756,7 +1756,6 @@ static int snd_timer_user_info(struct file *file,
 			       struct snd_timer_info __user *_info)
 {
 	struct snd_timer_user *tu;
-	struct snd_timer_info *info __free(kfree) = NULL;
 	struct snd_timer *t;
 
 	tu = file->private_data;
@@ -1766,7 +1765,8 @@ static int snd_timer_user_info(struct file *file,
 	if (!t)
 		return -EBADFD;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	struct snd_timer_info *info __free(kfree) =
+		kzalloc(sizeof(*info), GFP_KERNEL);
 	if (! info)
 		return -ENOMEM;
 	info->card = t->card ? t->card->number : -1;
@@ -2192,10 +2192,10 @@ static int snd_utimer_ioctl_create(struct file *file,
 				   struct snd_timer_uinfo __user *_utimer_info)
 {
 	struct snd_utimer *utimer;
-	struct snd_timer_uinfo *utimer_info __free(kfree) = NULL;
 	int err, timer_fd;
+	struct snd_timer_uinfo *utimer_info __free(kfree) =
+		memdup_user(_utimer_info, sizeof(*utimer_info));
 
-	utimer_info = memdup_user(_utimer_info, sizeof(*utimer_info));
 	if (IS_ERR(utimer_info))
 		return PTR_ERR(utimer_info);
 
-- 
2.51.0




