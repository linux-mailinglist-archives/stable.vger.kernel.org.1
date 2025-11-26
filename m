Return-Path: <stable+bounces-196992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F74DC8930E
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CA78345BFD
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB87A2F9DAB;
	Wed, 26 Nov 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kpn6ypAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KLN1gvlu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kpn6ypAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KLN1gvlu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF02FD69F
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151737; cv=none; b=udt756KUp8CREdjDQFrs264FZkzPyzTNkVQptSx1uUoy9DIxrjnzEWAKLpkLHvJ5IGgIs8AjD2lfTyS24KAwOyiApq2TY5FNEQoa8hF7JDpdVb99Ey6c2+9VYr2/nxDCIVB5ULsS0sXfI0+YGBqBVk+EF/vdUxFziMEmGg5q+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151737; c=relaxed/simple;
	bh=jZ6VwBIDdMIZjZbYR+jM7yukNe05MXMiylSAhAU5VLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHQOIRbvIOLxy9tZU4B5FzKWqrhWrJvoCQUWLHPjXUHC7yn4kMCOZIbx/mbEQl8cH1ixcymitsj/+EIoiglWgyes3smxqFlUK7vb4zoMlun8UNvWaG11tQ2pUt/b4ffdLQZpoPsbzOrN9oVyBI59L9k0pkf8t1dUwsHqoRKOM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kpn6ypAK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KLN1gvlu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kpn6ypAK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KLN1gvlu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83B8222DA2;
	Wed, 26 Nov 2025 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764151730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1X6yMNziAsd94i5zdYCwMwAsL7jwzLlDMldzGNu+hdc=;
	b=kpn6ypAKguQRVrulH48QChYXESm9yoXfLz85LyvtQPK6DW0pZb+qYdbblWD4iYHdzOq7pR
	ow2qmaTbdAkJ5UlcMX79SiMhZaXxRn4AY0pKrzVRHe1RvDkTaLhUEOuwpWzIZhCYfWtiVH
	7RYoPHCNHj+GMDRpSLmtsgckTDwHuC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764151730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1X6yMNziAsd94i5zdYCwMwAsL7jwzLlDMldzGNu+hdc=;
	b=KLN1gvlusVImpO16iJh+lI2iTca5KCsHvzBBuTtkeNsyQvPRCKga+kGJ7XscurqfGF+gmd
	76O7+TbmPBnjRkAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764151730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1X6yMNziAsd94i5zdYCwMwAsL7jwzLlDMldzGNu+hdc=;
	b=kpn6ypAKguQRVrulH48QChYXESm9yoXfLz85LyvtQPK6DW0pZb+qYdbblWD4iYHdzOq7pR
	ow2qmaTbdAkJ5UlcMX79SiMhZaXxRn4AY0pKrzVRHe1RvDkTaLhUEOuwpWzIZhCYfWtiVH
	7RYoPHCNHj+GMDRpSLmtsgckTDwHuC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764151730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1X6yMNziAsd94i5zdYCwMwAsL7jwzLlDMldzGNu+hdc=;
	b=KLN1gvlusVImpO16iJh+lI2iTca5KCsHvzBBuTtkeNsyQvPRCKga+kGJ7XscurqfGF+gmd
	76O7+TbmPBnjRkAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6405B3EA63;
	Wed, 26 Nov 2025 10:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 53UOF7LRJmmnOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Nov 2025 10:08:50 +0000
From: Takashi Iwai <tiwai@suse.de>
To: stable@vger.kernel.org
Cc: linux-kernel@ver.kernel.org,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH v6.12.y] ALSA: usb-audio: Fix missing unlock at error path of maxpacksize check
Date: Wed, 26 Nov 2025 11:08:31 +0100
Message-ID: <20251126100839.42855-1-tiwai@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The recent backport of the upstream commit 05a1fc5efdd8 ("ALSA:
usb-audio: Fix potential overflow of PCM transfer buffer") on the
older stable kernels like 6.12.y was broken since it doesn't consider
the mutex unlock, where the upstream code manages with guard().
In the older code, we still need an explicit unlock.

This is a fix that corrects the error path, applied only on old stable
trees.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/aSWtH0AZH5+aeb+a@duo.ucw.cz
Fixes: 98e9d5e33bda ("ALSA: usb-audio: Fix potential overflow of PCM transfer buffer")
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 7238f65cbcff..aa201e4744bf 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1389,7 +1389,8 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	if (ep->packsize[1] > ep->maxpacksize) {
 		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
 			      ep->maxpacksize, ep->cur_rate, ep->pps);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	/* calculate the frequency in 16.16 format */
-- 
2.52.0


