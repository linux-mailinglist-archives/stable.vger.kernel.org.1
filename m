Return-Path: <stable+bounces-35684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 532EF896AC2
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023DC1F2A7C8
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A3136E32;
	Wed,  3 Apr 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EDO2Q+qf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DAK0CLsj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF13136E22
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136681; cv=none; b=qHLcozQwuGx9No8ouwy3fjoshvDGimCrNEG05MxzRmnKFe+jzFS/9NK0FeNELVKyfcEUBYj0U0PJEf+3A6aq5jFMbBZQ5zwYu4jRvlwfxdXnPao3qkI4oMZTGUhVnfCFPBN+IyCr7NSOQ01QKs6qiFzKL0znXU1xT83vSNdvEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136681; c=relaxed/simple;
	bh=jcjqh3OMBwv60DGFcm/zEpv9BxUjVr2FL3SvzuhDDVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuCOGXivkqaOV3FMpk1AgLnPQfN6ccOmd9bK3UQ6aKqzxPKMkQzHaw7DFURWGQHQ7qvt8+v2mBFzJkTi+pEocZgJ9MCAtrrgX9iosHJW3su3MpI2XabazP+iS3UjxV/ZmOY5dw+fnPU+y2cXGdZc5AEtLW6SHiniItnsDe7Xvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EDO2Q+qf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DAK0CLsj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FB9C3518F;
	Wed,  3 Apr 2024 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712136678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbrLj3LFH8Njorgv+1BZ2xGqFzCpnYd05CSJMM8yUIA=;
	b=EDO2Q+qfTV+FcuwFh1O1fQQZripNWIU3rQVbFgQAgQZ1Nr0ouTdMNxM1ewJwGWLQzpPvgI
	zPAxYWdnsPlVld+aJCdRt5W5ZLEF3pjV7X5D8FYD8lzvX4xP0nSEdL7F2RSTwU9BBdMxCu
	UXDzsCB/4i+9mcMt4tZa4Ju00HU/udo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712136678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbrLj3LFH8Njorgv+1BZ2xGqFzCpnYd05CSJMM8yUIA=;
	b=DAK0CLsjGnL34cRwG9BFYUYh8fJpx8dNNXn2Rm3mvhMXyXoJXIhLYjeXdD6P4/B9WETI0B
	llErq3VIVXZF8gDQ==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EC8C513AA2;
	Wed,  3 Apr 2024 09:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IHR0OOUhDWYteQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Apr 2024 09:31:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	jfalempe@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jani.nikula@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 02/11] drm/mgag200: Bind I2C lifetime to DRM device
Date: Wed,  3 Apr 2024 11:24:39 +0200
Message-ID: <20240403093114.22163-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403093114.22163-1-tzimmermann@suse.de>
References: <20240403093114.22163-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[20.09%];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: 1.20
X-Spam-Level: *
X-Spam-Flag: NO

Managed cleanup with devm_add_action_or_reset() will release the I2C
adapter when the underlying Linux device goes away. But the connector
still refers to it, so this cleanup leaves behind a stale pointer
in struct drm_connector.ddc.

Bind the lifetime of the I2C adapter to the connector's lifetime by
using DRM's managed release. When the DRM device goes away (after
the Linux device) DRM will first clean up the connector and then
clean up the I2C adapter.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: b279df242972 ("drm/mgag200: Switch I2C code to managed cleanup")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.0+
---
 drivers/gpu/drm/mgag200/mgag200_i2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_i2c.c b/drivers/gpu/drm/mgag200/mgag200_i2c.c
index 1029fef590f9b..4caeb68f3010c 100644
--- a/drivers/gpu/drm/mgag200/mgag200_i2c.c
+++ b/drivers/gpu/drm/mgag200/mgag200_i2c.c
@@ -31,6 +31,8 @@
 #include <linux/i2c.h>
 #include <linux/pci.h>
 
+#include <drm/drm_managed.h>
+
 #include "mgag200_drv.h"
 
 static int mga_i2c_read_gpio(struct mga_device *mdev)
@@ -86,7 +88,7 @@ static int mga_gpio_getscl(void *data)
 	return (mga_i2c_read_gpio(mdev) & i2c->clock) ? 1 : 0;
 }
 
-static void mgag200_i2c_release(void *res)
+static void mgag200_i2c_release(struct drm_device *dev, void *res)
 {
 	struct mga_i2c_chan *i2c = res;
 
@@ -125,5 +127,5 @@ int mgag200_i2c_init(struct mga_device *mdev, struct mga_i2c_chan *i2c)
 	if (ret)
 		return ret;
 
-	return devm_add_action_or_reset(dev->dev, mgag200_i2c_release, i2c);
+	return drmm_add_action_or_reset(dev, mgag200_i2c_release, i2c);
 }
-- 
2.44.0


