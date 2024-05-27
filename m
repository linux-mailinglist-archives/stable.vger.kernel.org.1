Return-Path: <stable+bounces-46273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F98CF905
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 08:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C3BB22308
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 06:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D60FC02;
	Mon, 27 May 2024 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GhWoXAwo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ph6qVJUc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hPN4amEH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cMgBJJ/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7F17BA7
	for <stable@vger.kernel.org>; Mon, 27 May 2024 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791059; cv=none; b=S3jEeOLqkWYdkVhf0erQi/uUq+WTUMhYRWSW7CBWXCS1jFfrsddZ/ex3SGjibFcquvJ5KiU/3MfxQAcM+7TBDY1M2HBR4iOfVl39d8dM3h0AoLvFt73gG26ZGSAva1DNS9pE/vXtsK5GB3WZrjmf/+fUMcipLuK5bxEEQYGc2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791059; c=relaxed/simple;
	bh=wF6+EC8PhYvjKQ1+HjslPsPyswH6suZJD8bRz1IoYNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWKIi96D7wddpBMJl1OjJpkBp+KEwuhO5ucihRr2I+MrEMwvEWaRSx3yMh9bzPT4x+/c+sEh32LOBKIZP8QCCi9mEZvKUJ4H3OJrMEvFvfsxXTtslxzWgWcG38C7Y9QjyKfk80JZeJlHIyKR1e/4rUz/p6pDKMGCJTV+mfMSpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GhWoXAwo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ph6qVJUc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hPN4amEH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cMgBJJ/8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB4A21FB5D;
	Mon, 27 May 2024 06:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716791056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/VseddizVUvx5Qi4wPMpuJ+nfgVMQY16tpKbMP9xlus=;
	b=GhWoXAwoG7AF13WkAgxNy64nJvCFSxjDYx94eNeSnDXaq3pYeNkB2/Q5fnsHYnzsDESB+E
	1XlwmYYA7zCedyMJA6vtih4IN1KKj6UPcQQYHtBp69XZIXbluelI5apqLkp2ohlljtemHH
	gA/vT7Ekla21z+HibHZIayEifYbmWEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716791056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/VseddizVUvx5Qi4wPMpuJ+nfgVMQY16tpKbMP9xlus=;
	b=ph6qVJUc9yrj0zPPcDvsvl6Uj5cKGZ1KDNXgiLfQF1hwfBz7gIRDswsgpPMpkxLZESVm4p
	IAgVeUFqvEWw1WCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716791055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/VseddizVUvx5Qi4wPMpuJ+nfgVMQY16tpKbMP9xlus=;
	b=hPN4amEHuA/a0jgMgKeORkGFAxKXFFRrFAxe+wtjRV50YLRy4843gmq5lW2Jp8CmbLNBs0
	kDjfePaEKyisfLso62hjOpV/AHOgjNUG3m5+fLK2awQw2Cc77XVRh6MNKT0aPGk/hvQk90
	qawLirj73lC6IhjJFQ9vvMLfyRCMC0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716791055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/VseddizVUvx5Qi4wPMpuJ+nfgVMQY16tpKbMP9xlus=;
	b=cMgBJJ/8wUymN5zja4NWHiiVwDylDr7qtwpGnvxop3ymvMU4e8X8eBDxwLl/L7xVF9eHPj
	1GiOBbpYjrV890CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC18713A56;
	Mon, 27 May 2024 06:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qnyPMA8nVGZFYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 May 2024 06:24:15 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: [PATCH 6.8.y-and-older] ALSA: timer: Set lower bound of start tick time
Date: Mon, 27 May 2024 08:23:59 +0200
Message-ID: <20240527062431.18709-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

commit 4a63bd179fa8d3fcc44a0d9d71d941ddd62f0c4e upstream.

Currently ALSA timer doesn't have the lower limit of the start tick
time, and it allows a very small size, e.g. 1 tick with 1ns resolution
for hrtimer.  Such a situation may lead to an unexpected RCU stall,
where  the callback repeatedly queuing the expire update, as reported
by fuzzer.

This patch introduces a sanity check of the timer start tick time, so
that the system returns an error when a too small start size is set.
As of this patch, the lower limit is hard-coded to 100us, which is
small enough but can still work somehow.

[ backport note: the error handling is changed, as the original commit
  is based on the recent cleanup with guard() in commit beb45974dd49
  -- tiwai ]

Reported-by: syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/000000000000fa00a1061740ab6d@google.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240514182745.4015-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Greg, this is an alternative fix to the original cherry-pick; apply
to 6.8.y and older stable kernels.  Thanks!


 sound/core/timer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index e6e551d4a29e..a0b515981ee9 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -553,6 +553,16 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 		goto unlock;
 	}
 
+	/* check the actual time for the start tick;
+	 * bail out as error if it's way too low (< 100us)
+	 */
+	if (start) {
+		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
+			result = -EINVAL;
+			goto unlock;
+		}
+	}
+
 	if (start)
 		timeri->ticks = timeri->cticks = ticks;
 	else if (!timeri->cticks)
-- 
2.43.0


