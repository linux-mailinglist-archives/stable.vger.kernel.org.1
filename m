Return-Path: <stable+bounces-69608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59456956F2C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40663B20BC6
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E84964D;
	Mon, 19 Aug 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t030fUHm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rVZWzeuI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QW3ZFTQd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wGC2xhot"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7241C79
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082441; cv=none; b=KWlh6XJHqpctT3GPkA/Q3/73ZK+3gGznAe5NjEsfoPjdRR+oRoUDVzXkKpy9ELPLGKSlWs6l0/VxqFY5YV2b8xTNUT015/6nSZWYvTmU/tEuEbIB4AgPsJrZBaakvbRpa/aQltvaMgitT/r6xnxY2ZX3AVYA1zclVIrWQox8RRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082441; c=relaxed/simple;
	bh=edTmazqHmrFT4C5JUwcaWePsbmcNgMZV+pNnqAJq+nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCT5TZb6SkrIItTbMZ1Z5U7uWacODOUHL/6YbEt6djxX2wcil6X/2aSrPRCtbJ4vEjrjkjtLR0hR4N1knsdT8fppPEGD/BvVxGpAlJUge4ouTYkj2wbQaa2RO0dl+3Vh78u1QAsFpxRqjD+FytNqQxwfsVmG9XWjKJynHlT2Mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t030fUHm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rVZWzeuI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QW3ZFTQd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wGC2xhot; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C80AE1FE97;
	Mon, 19 Aug 2024 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724082436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yrz/tUA5VjWv20IhlsMrAt78hvsDWh+W0WIYwtZlR7o=;
	b=t030fUHmwRWC0VdV9C6RIOlRvAER0X8sZCA4b2AwRnYZJhGoh5XyFqN1Yxq+w7PNWWNqO1
	vedJGfsBxp/6MNrBp8EpoSOxgMSG6RKR/S6nalgSinZqeiGX1WddhpxF3bH6ASv2Ezs4th
	e7Iabd1aFl4/GsvR/2K2S0oquqbwhqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724082436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yrz/tUA5VjWv20IhlsMrAt78hvsDWh+W0WIYwtZlR7o=;
	b=rVZWzeuIZBcHmYkaO7X95nli4I771SXbV1NxX5QRpRqL40OQaYZqoVTsx2ZBeDkKdA3aaz
	R5ZF2nuxUg+O9RBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724082434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yrz/tUA5VjWv20IhlsMrAt78hvsDWh+W0WIYwtZlR7o=;
	b=QW3ZFTQdzrTXWVzN3iTQgoNlOXc2B54OHyELt1FyLfPa8msp4GU/0Lqe8jSaBiZjyAwTAr
	gYRzNi7WcPrtDrAgVZ/+mOXfrr6gAqu6qm8hmgrOzUoInpEUMU69JyFVu6OX/Ljh/PQ7Qm
	AIK4GhXtBmdOYHUxjTwW8VHvrALG+mY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724082434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yrz/tUA5VjWv20IhlsMrAt78hvsDWh+W0WIYwtZlR7o=;
	b=wGC2xhotNhujwZCP3u46c9NcNzYIuMcXyF4EkMsiJoAS3LeXg8h0Kb7pgprvkeVHXzrqAw
	/zZwcUgi5m9kkUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8572137C3;
	Mon, 19 Aug 2024 15:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qrPWJwJpw2a8IwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Aug 2024 15:47:14 +0000
From: Takashi Iwai <tiwai@suse.de>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6.y] ALSA: timer: Relax start tick time check for slave timer elements
Date: Mon, 19 Aug 2024 17:47:45 +0200
Message-ID: <20240819154754.7629-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

commit ccbfcac05866ebe6eb3bc6d07b51d4ed4fcde436 upstream.

The recent addition of a sanity check for a too low start tick time
seems breaking some applications that uses aloop with a certain slave
timer setup.  They may have the initial resolution 0, hence it's
treated as if it were a too low value.

Relax and skip the check for the slave timer instance for addressing
the regression.

Fixes: 4a63bd179fa8 ("ALSA: timer: Set lower bound of start tick time")
Cc: <stable@vger.kernel.org>
Link: https://github.com/raspberrypi/linux/issues/6294
Link: https://patch.msgid.link/20240810084833.10939-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Greg, this is a backport for 6.6.y and older stable kernels that failed
to cherry-pick the original one.

 sound/core/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index a0b515981ee9..230babace502 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -556,7 +556,7 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 	/* check the actual time for the start tick;
 	 * bail out as error if it's way too low (< 100us)
 	 */
-	if (start) {
+	if (start && !(timer->hw.flags & SNDRV_TIMER_HW_SLAVE)) {
 		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
 			result = -EINVAL;
 			goto unlock;
-- 
2.43.0


