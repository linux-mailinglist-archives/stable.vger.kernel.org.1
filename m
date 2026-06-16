Return-Path: <stable+bounces-264696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ChjIwl8MWoukgUAu9opvQ
	(envelope-from <stable+bounces-264696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:38:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 061436924A9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:38:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DngJBl9Y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264696-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264696-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670503202496
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE347466B57;
	Tue, 16 Jun 2026 16:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8244E037;
	Tue, 16 Jun 2026 16:29:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627349; cv=none; b=HDHBZSWh9jtzdUnLmQoPgCSBSI+ifR/28ykVTCSCtxESq34U2HiSJbHKaes9nm8FQq2N5ct1CWAShRCTYyeXCVPvQpJ9sVWuJNqBhxT1PwVfObku+K4/dgf9vs215hIjMDPQi8YNmbcCq67E8szJWMuvlOLBXfBRG4XR7buwMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627349; c=relaxed/simple;
	bh=qAWZDt6Q5Z4fHTeOFCf50GwOOpVfXV0LR2s2sJZngaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2Kgu5d2MBa59JoziKFmxhzV+2ka1SCG1n0MpKCRFqgDTblkAywJ5uOiI4/O48si3Le2AsUhbTnydynbWWwVOL2+lYkyi11znvahgG9H5WY/z5OMUEJp8sJe2oFia1QDLUJeUXBoPgi7Cs8TMqkngbv32jkr6m/2P8KBDORgjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DngJBl9Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B198D1F000E9;
	Tue, 16 Jun 2026 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627348;
	bh=ZhTWTS4o3qa8eMuOk8gzdsbkhOG3JcX2v4R43saIWz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DngJBl9YYAJjXWHUas746pcGdOGB4W14q9ajjJi9wRZ5oxwM6gDgn6DoZpCbhMnFG
	 SPXlKm2592PpEG+4a/oh5RwnP14/5tggCxgiOgpnSfZlSBNAStYzhDepSro9AHZD15
	 AbjoAR39Np7BVobkW+rpD8G7m7WXayMsoQu+QlE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Zeng <kylebot@openai.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 143/261] ALSA: timer: Forcibly close timer instances at closing
Date: Tue, 16 Jun 2026 20:29:41 +0530
Message-ID: <20260616145051.707335208@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264696-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kylebot@openai.com,m:tiwai@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,suse.de:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 061436924A9

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit da3039e91d1f835874ed6e9a33ea19ee80c2cb92 upstream.

When snd_timer object is freed via snd_timer_free() and still pending
snd_timer_instance objects are assigned to the timer object, it tries
to unlink all instances and just set NULL to each ti->timer, then
releases the resources immediately.  The problem is, however, when
there are slave timer instances that are associated with a master
instance linked to this timer: namely, those slave instances still
point to the freed timer object although the master instance is
unlinked, which may lead to user-after-free.  The bug can be easily
triggered particularly when a new userspace-driven timers
(CONFIG_SND_UTIMER) is involved, since it can create and delete the
timer object via a simple file open/close, while the other
applications may keep accessing to that timer.

This patch is an attempt to paper over the problem above: now instead
of just unlinking, call snd_timer_close[_locked]() forcibly for each
pending timer instance, so that all assigned slave timer instances are
properly detached, too.  Since snd_timer_close() might be called later
by the driver that created that instance, the check of
SNDRV_TIMER_IFLG_DEAD is added at the beginning, too.

Reported-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Kyle Zeng <kylebot@openai.com>
Fixes: 37745918e0e7 ("ALSA: timer: Introduce virtual userspace-driven timers")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260606161145.1933447-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/timer.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -422,6 +422,8 @@ static void snd_timer_close_locked(struc
 
 	if (timer) {
 		guard(spinlock_irq)(&timer->lock);
+		if (timeri->flags & SNDRV_TIMER_IFLG_DEAD)
+			return; /* already closed */
 		timeri->flags |= SNDRV_TIMER_IFLG_DEAD;
 	}
 
@@ -964,18 +966,18 @@ EXPORT_SYMBOL(snd_timer_new);
 
 static int snd_timer_free(struct snd_timer *timer)
 {
+	struct snd_timer_instance *ti, *n;
+
 	if (!timer)
 		return 0;
 
 	guard(mutex)(&register_mutex);
 	if (! list_empty(&timer->open_list_head)) {
-		struct list_head *p, *n;
-		struct snd_timer_instance *ti;
-		pr_warn("ALSA: timer %p is busy?\n", timer);
-		list_for_each_safe(p, n, &timer->open_list_head) {
-			list_del_init(p);
-			ti = list_entry(p, struct snd_timer_instance, open_list);
-			ti->timer = NULL;
+		list_for_each_entry_safe(ti, n, &timer->open_list_head, open_list) {
+			struct device *card_dev_to_put = NULL;
+
+			snd_timer_close_locked(ti, &card_dev_to_put);
+			put_device(card_dev_to_put);
 		}
 	}
 	list_del(&timer->device_list);



