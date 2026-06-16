Return-Path: <stable+bounces-264407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dLh+Mqh3MWpRkAUAu9opvQ
	(envelope-from <stable+bounces-264407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:19:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02013691F1B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:19:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=vVDEBqxr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264407-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264407-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87C4D307F537
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF39450917;
	Tue, 16 Jun 2026 16:02:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E4322C88;
	Tue, 16 Jun 2026 16:02:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625724; cv=none; b=cSfzCzApcyTrcddFhkGrQAxmhKQzTuvYKly/+9PR0Jai7c2l5XDIwzg1VOs+agoRC2yzapjh09utgPmekfBfV+zh8undT0lP9bvN3+PrZ0v9b8k+0NNQiDy6UC4LuorZ0RQlpXBR20wHQ3OeOKgZqdU9zq9MJaDzIken/ayeJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625724; c=relaxed/simple;
	bh=sni57CpH2TzqRCpigMlAOJwYGfM2Gm8EUZTNWVV9muw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObbeRaeXtdO3WcYjSFNOrg0yoR74rpb4mxyTIYPrc9a9a7+thj5dVr9h8j9njAskmA2SskAR7Ly87Nbt+CwhYuPeQqIzP1A4dIM1QWr660pHvi4XYMbqStGDDEFfdQvua9Rw6LIi01A2X/JtgtBod7xalbrS0rr2hIOh/nXp5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vVDEBqxr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFA81F000E9;
	Tue, 16 Jun 2026 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625723;
	bh=MbNWVKujtUYbz09pk6oX5Ru1cCc5HYjuCVT/oNx9lsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vVDEBqxrAtVh+qhevruKFQSWf41zYRBGaa2lSa3T4pFq5RdLOTHZK4Z2CAG8fu7R/
	 djME3+N39vWwxKR8nyZtCOthN/UYXgT/dTU810MQQpIxYhygvbgPz9WBByGYgV5/gn
	 8RgLnaRwAgVk7P0uer0A8GcKMNhLWYH3HscAZAUI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Zeng <kylebot@openai.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 178/325] ALSA: timer: Forcibly close timer instances at closing
Date: Tue, 16 Jun 2026 20:29:34 +0530
Message-ID: <20260616145106.741145719@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264407-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kylebot@openai.com,m:tiwai@suse.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,openai.com:email,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02013691F1B

6.18-stable review patch.  If anyone has any objections, please let me know.

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



