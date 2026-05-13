Return-Path: <stable+bounces-246939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFxkEYavBGrENAIAu9opvQ
	(envelope-from <stable+bounces-246939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:06:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D25537AAD
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D0531A0CAA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637584CA265;
	Wed, 13 May 2026 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvwiQVf3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453E4C9579
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690068; cv=none; b=ARLjZTDLCnFJ0WfHBDOqObkCdY19NPFhObR8mRT7FWsJ+k/gdo/3vaWsm2Dy1xvmxdT6i2MUUumK1fMpUpYMRSCmH3HUPy+zVrMVBkETDk2N2KPjPNdUBLuD+d4/9htfWplUVQjNTs+NwH75IkDWI7xMTgxN/D09jIZKIW7+Fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690068; c=relaxed/simple;
	bh=1bMm1S5i2O7vB4LtzcYX0gRb+I30GRPnNWKsUzrOzsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfKQzzj9EiE+IbsyPlmREpBm8XnRTqJuJmCAkGsbcGnM4OQNoCAV34pnjIx4sZfys0/uLHiIWSKke6FCQ+Mg/I3EBB3maXEuDLj82Q6kHbpaDiTqkxXmCKtXoyijWd79BiKnTYiNWJ4ReCcZBSRrbLoEinNrpGdMe8x/tzCRr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvwiQVf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A15DC2BCF7;
	Wed, 13 May 2026 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778690067;
	bh=1bMm1S5i2O7vB4LtzcYX0gRb+I30GRPnNWKsUzrOzsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvwiQVf3pTc4zbOVF9C/snJZ5dKwM3rIXbVgHCcJYzpINtSn5WpGuke7ASBIo3YNA
	 3IB3TpzxjUh39zoyQHtuRv9lcYbGMVwdmsBCAqLfIrOMyA8psuSw+6okDTh6UEHxvT
	 Aj3PbKdw6oW5NW95vlwXP/Y8U0krTswQoV/89yxjzHDpIw7PFmekSXjkvYTTjueiv7
	 hp7/9CUEIl89Vxw+cjjVUeIsf+0qw2ssiw5cZbIzDumsFXH02gDq5el0lNoFG4JLNy
	 JQWotH8gVu14x6C9Q/hD2Fh5DqdMT8LoB39EhFtcY1TOyXDlAM8cXmm/pbpUV+cjro
	 QF9Bhwhn53hMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: core: Serialize deferred fasync state checks
Date: Wed, 13 May 2026 12:34:25 -0400
Message-ID: <20260513163425.3808876-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051255-pushup-cheek-6781@gregkh>
References: <2026051255-pushup-cheek-6781@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6D25537AAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246939-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,msgid.link:url]
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
index d32a19976a2b9..40dd3a23dac02 100644
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


