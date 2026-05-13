Return-Path: <stable+bounces-246942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFPRLU6yBGoQNQIAu9opvQ
	(envelope-from <stable+bounces-246942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:18:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD77537E2C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A365325AA45
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFEA4C77A9;
	Wed, 13 May 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSAEeGKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39035839C
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690790; cv=none; b=WfpJBwecaXRZFeW+cCOm2IjBBWeGTdCbWHA5QYIaxyMM1w7qkTT2WyzvuYWD7TovEAcDWYIPoe6SnqwD0aP+YVwW/xrdG5g7nf+RRwQVLcR1GAGm00HafEzPHgabDlBCahw1npfpq0GlUjh9wzv9hcNovuRjXfS0xSXchrrLK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690790; c=relaxed/simple;
	bh=b+4KQs7gl/zu4ynZobTCTqo8SzqANKKuYG/asWKjLuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STTuLKcUHGOJJiDVIqMjjvo5nhUuYOGoCbVnN8Pdm9aWdz+Iw3wPgCbQqWaOuxoPlHa6OW97BajqR0mcCfvVkqxqlwwSoRqtcLbZwpgDRQAoErKMltiqV6BMWwLpveKtQSS6RxCtZMsfUhqZqgWpM/hxFq3WYMdvWXgF5AP9hZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSAEeGKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD1AC19425;
	Wed, 13 May 2026 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778690790;
	bh=b+4KQs7gl/zu4ynZobTCTqo8SzqANKKuYG/asWKjLuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSAEeGKo4VpbTJ66HTlX5BL16VatUdzcn4hhKoZlImkkJn/eoprzT2JYSlmR2goHP
	 4wB5t5FYeQekvrR36vhvSQzSzcqfeIaHSf3FOgX7NREpAIE5kFAdX7b2TSi1aPm82I
	 Nb+R6Ahrvr8bJepn0qKlRwU1b7D6hQsrG1FnlPpJQCoE3hNJ8pd4ygD1WRh4lq+LPB
	 Tzdr9sXaMW53cyePDbLfbKCGDI3gRi5X7YSFLxHJHvC8kWnqnQq6pjp5527TYy0J3x
	 7unf5BtrvuO988JfkSybfiawgL0Gmhs9A9TpXqsRAiX9vg3dooLXdqJ8Q2PXF7bHHM
	 2tC/nFw8MxjSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: core: Serialize deferred fasync state checks
Date: Wed, 13 May 2026 12:46:26 -0400
Message-ID: <20260513164626.3816356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051257-shopping-sitcom-fcf1@gregkh>
References: <2026051257-shopping-sitcom-fcf1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDD77537E2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246942-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 5337213381df578058e2e41da93cbd0e4639935f ]

snd_fasync_helper() updates fasync->on under snd_fasync_lock, and
snd_fasync_work_fn() now also evaluates fasync->on under the same
lock. snd_kill_fasync() still tests the flag before taking the lock,
leaving an unsynchronized read against FASYNC enable/disable updates.

Move the enabled-state check into the locked section.

Also clear fasync->on under snd_fasync_lock in snd_fasync_free()
before unlinking the pending entry. Together with the locked sender-side
check, this publishes teardown before flushing the deferred work and
prevents a racing sender from requeueing the entry after free has
started.

Fixes: ef34a0ae7a26 ("ALSA: core: Add async signal helpers")
Fixes: 8146cd333d23 ("ALSA: core: Fix potential data race at fasync handling")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260506-alsa-core-fasync-on-lock-v1-1-ea48c77d6ca4@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ converted upstream guard()/scoped_guard() to explicit spin_lock_irqsave/spin_lock_irq and dropped the list_del_init() from a missing prerequisite ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/misc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/core/misc.c b/sound/core/misc.c
index c3f3d94b51970..51f175b2f9c8e 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -219,9 +219,13 @@ void snd_kill_fasync(struct snd_fasync *fasync, int signal, int poll)
 {
 	unsigned long flags;
 
-	if (!fasync || !fasync->on)
+	if (!fasync)
 		return;
 	spin_lock_irqsave(&snd_fasync_lock, flags);
+	if (!fasync->on) {
+		spin_unlock_irqrestore(&snd_fasync_lock, flags);
+		return;
+	}
 	fasync->signal = signal;
 	fasync->poll = poll;
 	list_move(&fasync->list, &snd_fasync_list);
@@ -234,7 +238,9 @@ void snd_fasync_free(struct snd_fasync *fasync)
 {
 	if (!fasync)
 		return;
+	spin_lock_irq(&snd_fasync_lock);
 	fasync->on = 0;
+	spin_unlock_irq(&snd_fasync_lock);
 	flush_work(&snd_fasync_work);
 	kfree(fasync);
 }
-- 
2.53.0


