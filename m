Return-Path: <stable+bounces-248048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LbVM2lGB2qgvwIAu9opvQ
	(envelope-from <stable+bounces-248048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:14:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 823EC552DEB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 601BE30E41DD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE793305674;
	Fri, 15 May 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r1ClYVoK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF73FF1D5;
	Fri, 15 May 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860735; cv=none; b=NWikKEG9F1dHZOhc27ANukeiC6ApKeB4WFJZU5Aonpw4PBtWmVISRp8uUinl5QN5WHWlygireC5hEzMzrAUjHu0FxeqZXH6241U0OwKzTOg4HzyuJau2W26+z3uzSAtP4hbRvROGn6GTdtl33dImtkV769lbNu0H85rBZJFm9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860735; c=relaxed/simple;
	bh=1lZgyaoN1pbsWe0t4JSzxHLYnm8tapYO4IUfRk9yXqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB/Rv4s09SdliDDXEx0fG/UiIz+HRIbK4c/UhzfDZ+6zU/xoOalbLZc+kLXJvLVL8JiqV0SnGXCWMRmHuAPbf6WKF3I9WnEtqjH6KW8Xm8dSGbNwtwE4u0S/6CNj2W4SwY4vkVyr2FaeLIy0mjNvlUnUZzo8glEdWrSI4fJCNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r1ClYVoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3738CC2BCC7;
	Fri, 15 May 2026 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860735;
	bh=1lZgyaoN1pbsWe0t4JSzxHLYnm8tapYO4IUfRk9yXqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1ClYVoKPEF7dxIZMf4BfYVZmNTg5uTCRCetzC3WWjtdjF6eQVS9ZbBlQE35Tt9cL
	 1wviHO/vji313vK4w/UKR1cr0HJLTr0p+rEqvFR/CN0hUKEiwfK7lItYmxrdoZthpa
	 eAHRHbUI6qmNKr42dEniGtlwVm+oPxehkhzHjWdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jake Lamberson <lamberson.jake@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 058/474] ALSA: core: Fix potential data race at fasync handling
Date: Fri, 15 May 2026 17:42:47 +0200
Message-ID: <20260515154716.300062538@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 823EC552DEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-248048-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8146cd333d235ed32d48bb803fdf743472d7c783 upstream.

In snd_fasync_work_fn(), which is the offload work for traversing and
processing the pending fasync list, the call of kill_fasync() is done
outside the snd_fasync_lock for avoiding deadlocks.  The problem is
that its the references of fasync->on, fasync->signal and fasync->poll
are done there also outside the lock.  Since these may be modified by
snd_kill_fasync() call concurrently from other process, inconsistent
values might be passed to kill_fasync().  Although there shouldn't be
critical UAF, it's still better to be addressed.

This patch moves the kill_fasync() argument evaluations inside the
snd_fasync_lock for avoiding the data races above.  The handling in
fasync->on flag is optimized in the loop to skip directly.

Also, for more clarity, snd_fasync_free() takes the lock and unlink
the pending entry more directly instead of clearing fasync->on flag.

Reported-by: Jake Lamberson <lamberson.jake@gmail.com>
Fixes: ef34a0ae7a26 ("ALSA: core: Add async signal helpers")
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260420061721.3253644-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/misc.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -171,14 +171,18 @@ static LIST_HEAD(snd_fasync_list);
 static void snd_fasync_work_fn(struct work_struct *work)
 {
 	struct snd_fasync *fasync;
+	int signal, poll;
 
 	spin_lock_irq(&snd_fasync_lock);
 	while (!list_empty(&snd_fasync_list)) {
 		fasync = list_first_entry(&snd_fasync_list, struct snd_fasync, list);
 		list_del_init(&fasync->list);
+		if (!fasync->on)
+			continue;
+		signal = fasync->signal;
+		poll = fasync->poll;
 		spin_unlock_irq(&snd_fasync_lock);
-		if (fasync->on)
-			kill_fasync(&fasync->fasync, fasync->signal, fasync->poll);
+		kill_fasync(&fasync->fasync, signal, poll);
 		spin_lock_irq(&snd_fasync_lock);
 	}
 	spin_unlock_irq(&snd_fasync_lock);
@@ -234,7 +238,10 @@ void snd_fasync_free(struct snd_fasync *
 {
 	if (!fasync)
 		return;
-	fasync->on = 0;
+
+	scoped_guard(spinlock_irq, &snd_fasync_lock)
+		list_del_init(&fasync->list);
+
 	flush_work(&snd_fasync_work);
 	kfree(fasync);
 }



