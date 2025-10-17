Return-Path: <stable+bounces-186293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6984CBE7CAF
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 11:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB68E56703B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82C2D948D;
	Fri, 17 Oct 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rkw+aW7A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cXKVN2f5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zNEvMPwa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3cccOi7S"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB52DAFB0
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692481; cv=none; b=DfTcw1WktfLicwAznv32Dph4QVKSYoeJkCB9h+fCw+BUMZU4+tpD6Utn/1we/rGywfVyadDaMbE5796NoPYueTWcqagAPMDRIK7N1PqrMk/VHNJJcxHV4K+JQ4CzpY+LmIthH6ow+n3Z5fQli1o1dgoWDeT9KBUvOykqFtVt/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692481; c=relaxed/simple;
	bh=bAa+mMZTmx+4SgiaonrJcxnSweykd8qU53iG4ZeZ9O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0bguZyNWwSWLFj0EjybC2mR2a4d7a7XKlsqsgysh4pzqcJoj75bKBePjDXIM4uyaWh7gX9M0M03RdhGArc8PDr47j+bSw8pe6b2dddjC/oLuL766AmYvTCqZbCD1WAzfjbEWUKf7Gt2KFw3753gzzFNfM3sEZAI5sJll17cI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rkw+aW7A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cXKVN2f5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zNEvMPwa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3cccOi7S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 778B21FDA5;
	Fri, 17 Oct 2025 09:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760692471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=egR68WOBdN0W8u3ajdVB9thBdUoNK1gk7j1Qfvg/J44=;
	b=Rkw+aW7AtXqLIlYa44B2nUpLQCY+IU73qsnlIsUrIpdVFjFOPT6xI2M8kfPbQ5iKiqA5Eo
	/R0js+i6r3GL2XGNyevKmfsiqzEGjgsV4yLs3DTB4P/K9bZQJig2XZtNqvTmcWHrBfN7yI
	dyEhULDBjpQ3lGAyuLly0g/iKCN/X5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760692471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=egR68WOBdN0W8u3ajdVB9thBdUoNK1gk7j1Qfvg/J44=;
	b=cXKVN2f5f1XP9+bn5BbImzy+O8CM1ZrwuQkbZm8AlpzdAoyj3FoPfn7gDiyKAhGmoedNwu
	dV/SmAXyKpwMz5AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zNEvMPwa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3cccOi7S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760692470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=egR68WOBdN0W8u3ajdVB9thBdUoNK1gk7j1Qfvg/J44=;
	b=zNEvMPwaTz0KYPOPx3M1/vPOBtCWODHw+fxjcl6KKR8wLDFma1KD47FmLlkIUq8xc1n2Ow
	3r07oF4yXK0ztDezcifP5YsESavko0GJsZItHEKWcCeU5EP3vPJrThUKYEdpBjvqcbF2SV
	sM5BtPtGhZWmvXs81KKJNG7h4da5cEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760692470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=egR68WOBdN0W8u3ajdVB9thBdUoNK1gk7j1Qfvg/J44=;
	b=3cccOi7S02Hi26NWpcyBMFT5vDrZCl/wkGFcmR3ycnrfzUq1v26XIU/HDs4CdYsNH/Daj+
	P7TO9diHU4gFfNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C8C713A71;
	Fri, 17 Oct 2025 09:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FXxyCfYI8mhUIQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 17 Oct 2025 09:14:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	dan.carpenter@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Melissa Wen <melissa.srw@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sysfb: Do not dereference NULL pointer in plane reset
Date: Fri, 17 Oct 2025 11:13:36 +0200
Message-ID: <20251017091407.58488-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 778B21FDA5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ffwll.ch:email,suse.de:dkim,suse.de:mid,suse.de:email,intel.com:email,lists.freedesktop.org:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.51

The plane state in __drm_gem_reset_shadow_plane) can be NULL. Do not
deref that pointer, but forward NULL to the other plane-reset helpers.
Clears plane->state to NULL.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: b71565022031 ("drm/gem: Export implementation of shadow-plane helpers")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/dri-devel/aPIDAsHIUHp_qSW4@stanley.mountain/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.15+
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index ebf305fb24f0..6fb55601252f 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -310,8 +310,12 @@ EXPORT_SYMBOL(drm_gem_destroy_shadow_plane_state);
 void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 				  struct drm_shadow_plane_state *shadow_plane_state)
 {
-	__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
-	drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
+	if (shadow_plane_state) {
+		__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
+		drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
+	} else {
+		__drm_atomic_helper_plane_reset(plane, NULL);
+	}
 }
 EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
 
-- 
2.51.0


