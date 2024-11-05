Return-Path: <stable+bounces-89833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D0F9BCE18
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED762835CC
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE341D86C0;
	Tue,  5 Nov 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nOuwBvL5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8cUUe5jS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nOuwBvL5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8cUUe5jS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284241D7E46
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813937; cv=none; b=C4gwp1AV0fNwSn+DWY6tWj6hUPUuy87LTAEWZmmo5c/d2dGYfFlQZvAfU5CiX9PUSqWv/HZPCzs4liuaUN7CHfQ51r7SNWQtH8l5tjqWoqZ1vgJScp+1umkdccSNhzH15kwyH0YKyGBW6ebcmATAw3NFHwXjjtVT757LFpjeOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813937; c=relaxed/simple;
	bh=co2yjsek7uSCrxtBBWJwOiDDab0Pj7XiUZJstlKTF1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JKCS9lU5U9xl62eEsGFHiod+RAzk8otu5NE/lHf6RGlGnJm2rTG8/6y0adwCwCgFN4lRP4DGafAwMYtchy9K8oUPzm5EbOxc5tnjmkpTaSat/nKiF+UE0j6X1Bz2fYNimq7jkxOt/SXM5zxgoVVIYyczSf99g6WfMtsmQNgtzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nOuwBvL5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8cUUe5jS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nOuwBvL5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8cUUe5jS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D3621FBB7;
	Tue,  5 Nov 2024 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730813933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jDTbP3fOcL51JRwWKzuxSqaxfANeDb0GcrNEPDR3wvk=;
	b=nOuwBvL5K/lCDQnI/N1/mRbLRzzhXWQgb5qAwOeEznFiYqssnz3sJYjP8pB/2ZJbzI0Mw8
	ub1PS+e2pktR/zrDZKDC1CUJ7M3i3ACQEhtTedIS0UP9MW+s1gaaZYc4KAgi7L9nPQGdVG
	yA7zgD9MXR21iPh+6ntx7SA/OFAXFwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730813933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jDTbP3fOcL51JRwWKzuxSqaxfANeDb0GcrNEPDR3wvk=;
	b=8cUUe5jSnqRzmRedg+YtmtB63W+fe91HG+PCahBKHkNSXve8vY3mP4rIVS+LmRPR1Fleu2
	M0vnLYsCggVYFLAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730813933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jDTbP3fOcL51JRwWKzuxSqaxfANeDb0GcrNEPDR3wvk=;
	b=nOuwBvL5K/lCDQnI/N1/mRbLRzzhXWQgb5qAwOeEznFiYqssnz3sJYjP8pB/2ZJbzI0Mw8
	ub1PS+e2pktR/zrDZKDC1CUJ7M3i3ACQEhtTedIS0UP9MW+s1gaaZYc4KAgi7L9nPQGdVG
	yA7zgD9MXR21iPh+6ntx7SA/OFAXFwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730813933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jDTbP3fOcL51JRwWKzuxSqaxfANeDb0GcrNEPDR3wvk=;
	b=8cUUe5jSnqRzmRedg+YtmtB63W+fe91HG+PCahBKHkNSXve8vY3mP4rIVS+LmRPR1Fleu2
	M0vnLYsCggVYFLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC5BF1394A;
	Tue,  5 Nov 2024 13:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C/ubKOwfKmcuEQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Nov 2024 13:38:52 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	groeck@chromium.org,
	zyw@rock-chips.com
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] drm/rockchip: cdn-dp: Use drm_connector_helper_hpd_irq_event()
Date: Tue,  5 Nov 2024 14:38:16 +0100
Message-ID: <20241105133848.480407-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[rock-chips.com,sntech.de,linux.intel.com,kernel.org,gmail.com,ffwll.ch,chromium.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

The code for detecting and updating the connector status in
cdn_dp_pd_event_work() has a number of problems.

- It does not aquire the locks to call the detect helper and update
the connector status. These are struct drm_mode_config.connection_mutex
and struct drm_mode_config.mutex.

- It does not use drm_helper_probe_detect(), which helps with the
details of locking and detection.

- It uses the connector's status field to determine a change to
the connector status. The epoch_counter field is the correct one. The
field signals a change even if the connector status' value did not
change.

Replace the code with a call to drm_connector_helper_hpd_irq_event(),
which fixes all these problems.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 81632df69772 ("drm/rockchip: cdn-dp: do not use drm_helper_hpd_irq_event")
Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: <stable@vger.kernel.org> # v4.11+
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index b04538907f95..f576b1aa86d1 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -947,9 +947,6 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
-	struct drm_connector *connector = &dp->connector;
-	enum drm_connector_status old_status;
-
 	int ret;
 
 	mutex_lock(&dp->lock);
@@ -1009,11 +1006,7 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 out:
 	mutex_unlock(&dp->lock);
-
-	old_status = connector->status;
-	connector->status = connector->funcs->detect(connector, false);
-	if (old_status != connector->status)
-		drm_kms_helper_hotplug_event(dp->drm_dev);
+	drm_connector_helper_hpd_irq_event(&dp->connector);
 }
 
 static int cdn_dp_pd_event(struct notifier_block *nb,
-- 
2.47.0


