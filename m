Return-Path: <stable+bounces-120070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99A9A4C3FA
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 15:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD416DE57
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9BA212FA7;
	Mon,  3 Mar 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bvoRfvuE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q5Rk4Id6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bvoRfvuE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q5Rk4Id6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC8200BB7
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013956; cv=none; b=KpKe1xGVzDKTakLE6FRrqZB1wPSiYOHo0D6R4IdTHne0TH5luDPTOBCcyAMKXIEU8s3f6mqGmsczt16H0BhirEKRfzJZIhwZOHJpvNDyDr/yJrweKcj7rQahvWZFQZ05RA4TtmZ0NueDCp1HU/fuh7RuxPFHN3VIrgym/kpxx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013956; c=relaxed/simple;
	bh=4dNVyagK8VY8du9Miy7fi8oEF8R9ziuWuKX+qEy3hkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXnD0N9VqnGEIQeU8xiQWIAXtkSj8rZyC8q9TJwZGwOPjWbSCrechPrNakX4eWDPaPm42yzK8BB/zFxJSUP2vixmBLZjA8rDQZ+NlPAk4NTt+hA5ydSBwvVTwyd1eS8ZsoNlGOlFW7Yo0CtkwdcT8wyfVJ7jZ8ZZqmEXsCAy8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bvoRfvuE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q5Rk4Id6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bvoRfvuE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q5Rk4Id6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BC1D1F441;
	Mon,  3 Mar 2025 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741013953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tftgnaYHJ96pUX7y2DceVjHnF0HhU2S9vfRntZKblAM=;
	b=bvoRfvuEMfGOsoeZgowNTX+gb8FGAHkNWjdPboHQqDdQGJfx8ZweyUiVk4KAJZZsJ2G0dh
	MWp9WXTzTHB6H2Ls+em/qi+YWVp6ktgMKckyvOx7H4jf8PMW4OmT7iobbzZl23HotsDc4e
	+rE8TWZGaqGrS70DxZSTOfnTCl+EJXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741013953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tftgnaYHJ96pUX7y2DceVjHnF0HhU2S9vfRntZKblAM=;
	b=q5Rk4Id6inrwGi0hcB7hFkG1subcgHmWsJrlA6hDugoZtag+zL69iJ2HUmZw9ujZB22BnJ
	L6Ji6wKfVGfUH3BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bvoRfvuE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q5Rk4Id6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741013953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tftgnaYHJ96pUX7y2DceVjHnF0HhU2S9vfRntZKblAM=;
	b=bvoRfvuEMfGOsoeZgowNTX+gb8FGAHkNWjdPboHQqDdQGJfx8ZweyUiVk4KAJZZsJ2G0dh
	MWp9WXTzTHB6H2Ls+em/qi+YWVp6ktgMKckyvOx7H4jf8PMW4OmT7iobbzZl23HotsDc4e
	+rE8TWZGaqGrS70DxZSTOfnTCl+EJXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741013953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tftgnaYHJ96pUX7y2DceVjHnF0HhU2S9vfRntZKblAM=;
	b=q5Rk4Id6inrwGi0hcB7hFkG1subcgHmWsJrlA6hDugoZtag+zL69iJ2HUmZw9ujZB22BnJ
	L6Ji6wKfVGfUH3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B51A613A61;
	Mon,  3 Mar 2025 14:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aDflKsDDxWeZBAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 03 Mar 2025 14:59:12 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	simona@ffwll.ch,
	jfalempe@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	sean@poorly.run
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/udl: Unregister device before cleaning up on disconnect
Date: Mon,  3 Mar 2025 15:52:56 +0100
Message-ID: <20250303145604.62962-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303145604.62962-1-tzimmermann@suse.de>
References: <20250303145604.62962-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BC1D1F441
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[redhat.com,ffwll.ch,linux.intel.com,kernel.org,gmail.com,poorly.run];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Disconnecting a DisplayLink device results in the following kernel
error messages

[   93.041748] [drm:udl_urb_completion [udl]] *ERROR* udl_urb_completion - nonzero write bulk status received: -115
[   93.055299] [drm:udl_submit_urb [udl]] *ERROR* usb_submit_urb error fffffffe
[   93.065363] [drm:udl_urb_completion [udl]] *ERROR* udl_urb_completion - nonzero write bulk status received: -115
[   93.078207] [drm:udl_submit_urb [udl]] *ERROR* usb_submit_urb error fffffffe

coming from KMS poll helpers. Shutting down poll helpers runs them
one final time when the USB device is already gone.

Run drm_dev_unplug() first in udl's USB disconnect handler. Udl's
polling code already handles disconnects gracefully if the device has
been marked as unplugged.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: b1a981bd5576 ("drm/udl: drop drm_driver.release hook")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.8+
---
 drivers/gpu/drm/udl/udl_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 05b3a152cc33..7e7d704be0c0 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -127,9 +127,9 @@ static void udl_usb_disconnect(struct usb_interface *interface)
 {
 	struct drm_device *dev = usb_get_intfdata(interface);
 
+	drm_dev_unplug(dev);
 	drm_kms_helper_poll_fini(dev);
 	udl_drop_usb(dev);
-	drm_dev_unplug(dev);
 }
 
 /*
-- 
2.48.1


