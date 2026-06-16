Return-Path: <stable+bounces-265131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u5dfCXiEMWqzlQUAu9opvQ
	(envelope-from <stable+bounces-265131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:14:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84024692E60
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:14:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=MbA1ALly;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265131-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265131-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48E3F3124125
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E647DF8B;
	Tue, 16 Jun 2026 17:07:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D24C47B435;
	Tue, 16 Jun 2026 17:07:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629627; cv=none; b=dVUGiPWU+o8nl8vKdm/Wyy+gEF8HS529reNKAEGSUC59m3TqWmiVenlPkk4ylaY+lpFM27b3r1QavAmy8zJo3sDYzEF21xOEp1kGO/QFIY55VTPEVsL+/Ag2nLeUIIvkQgQVKqeIO+rAy2sKQEU10uIRs8u3ibgAFD0xJwPUF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629627; c=relaxed/simple;
	bh=MP7JurYpmnKh11hfQGNEh/hF+88UZIZKfmcqo64qS/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u92Fu2tADupXOfTAqTFylT1cDanMHV26StQFOFrWVKAO0iWiK2XO2Qn1BtyYu10DE3OJsp58H/J0N0AGQynQ36Y/HWyRVdA3of6jpWW9KNvKPga1RACFhOeciPOReINntfgCOKprNKlMXtLX1yP9zKabN43cxE+fMIySSg4BKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbA1ALly; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E178F1F000E9;
	Tue, 16 Jun 2026 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629625;
	bh=eEUxuUx27SrlHfCX9RDUes1bda6rDfOFfORx4jj8jZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MbA1ALlyBTAk925ULhnINGP7YQlvp/+J1Xa3Aq85U48R8oKzS9uzIkvax8ci6Doc8
	 gQVEaudHO/tJ+MNEyAgp0/h3JABI3w63+USStKggbS5ogDyTOkl12SFCBMtfA4FQge
	 4i6m1DnazrpjwRbdj67vtUYNgdd57pN0UUxzSMD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Zeng <kylebot@openai.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 304/452] ALSA: timer: Fix UAF at snd_timer_user_params()
Date: Tue, 16 Jun 2026 20:28:51 +0530
Message-ID: <20260616145133.478722558@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265131-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kylebot@openai.com,m:tiwai@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,suse.de:email,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84024692E60

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 053a401b592be424fea9d57c789f66cd5d8cec11 upstream.

At releasing a timer object, e.g. when a userspace timer
(CONFIG_SND_UTIMER) gets closed and snd_timer_free() is called, it
tries to detach the timer instances and release the resources.
However, it's still possible that other in-flight tasks are holding
the timer instance where the to-be-deleted timer object is associated,
and this may lead to racy accesses.

Fortunately, most of ioctls dealing with the timer instance list
already have the protection with register_mutex, and this also avoids
such races.  But, SNDRV_TIMER_IOCTL_PARAMS isn't protected, hence the
concurrent ioctl may lead to use-after-free.

This patch just adds the guard with register_mutex to protect
snd_timer_user_params() for covering the code path as a quick
workaround.  It's no hot-path but rather a rarely issued ioctl, so the
performance penalty doesn't matter.

Reported-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Kyle Zeng <kylebot@openai.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260606161145.1933447-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/timer.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1850,6 +1850,7 @@ static int snd_timer_user_params(struct
 	struct snd_timer *t;
 	int err;
 
+	guard(mutex)(&register_mutex);
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;



