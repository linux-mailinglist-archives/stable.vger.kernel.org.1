Return-Path: <stable+bounces-43620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AD78C4135
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20353B2389C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD014F9FF;
	Mon, 13 May 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pNPq1W+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b9TCIcq1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pNPq1W+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b9TCIcq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5BB1474BC
	for <stable@vger.kernel.org>; Mon, 13 May 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604993; cv=none; b=Rmx+f7ObPGd5DpFmWGBhGYMNSkpDM95nxsrmcYe313195irveiy/gQJtLOr4IjYz1zuA4rdLWpF8Mcn4HBN35v69+nl8/LdaRRiTFWP70lNwYrd0KBxTb6zERIH+bfMevrugHP5ArpcdyY+GGf7sl6MH/loLz5oL/PdDEyfYMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604993; c=relaxed/simple;
	bh=BzNmfhk60pI6MbecvRfqkrMAWZPYXimwv9nEfXiaD3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWGQz5quc1InmWIknQozWlG+xkrH/gPgezAuRySz26h9mpN0ioA5PdCZTF0zhEK1DgzDfQ9yvlUWbtB1/ARtO8QoMbh9HoDKAAk0h603822X+Yg895640SmSBZIHIb2JOP/VB4xnmm+CUUbA/A8V1BcDYrFVVSRAUwcvNs8WM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pNPq1W+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b9TCIcq1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pNPq1W+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b9TCIcq1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 537D7347BC;
	Mon, 13 May 2024 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715604988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVnusAxTA818RfDATVk+LtJnO2ZehJJf4jOwzj2IJQA=;
	b=pNPq1W+Bv225k9n1lzwojUf6c4MwYVuJws86tUjNWfs6om1Dxdtg/iOwNN2nhrHW53cCFO
	GMwgciYYuk7U4fqaJ/B0BrLiXpPMKZaGsJ8cUdkEQ4hEGl7Q3tgXBEb8K2+O1mfy21D5Tu
	yvRQXnycqo6Ng2OhjG+HqXozk4Kv8v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715604988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVnusAxTA818RfDATVk+LtJnO2ZehJJf4jOwzj2IJQA=;
	b=b9TCIcq1b/vO/lXqMi5NLYxhPb+MPm2m5F1E+NmD3xqafxL79jnk8NxOjLJj02N09q4I7Y
	K571fWG0AaqoSKBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715604988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVnusAxTA818RfDATVk+LtJnO2ZehJJf4jOwzj2IJQA=;
	b=pNPq1W+Bv225k9n1lzwojUf6c4MwYVuJws86tUjNWfs6om1Dxdtg/iOwNN2nhrHW53cCFO
	GMwgciYYuk7U4fqaJ/B0BrLiXpPMKZaGsJ8cUdkEQ4hEGl7Q3tgXBEb8K2+O1mfy21D5Tu
	yvRQXnycqo6Ng2OhjG+HqXozk4Kv8v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715604988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVnusAxTA818RfDATVk+LtJnO2ZehJJf4jOwzj2IJQA=;
	b=b9TCIcq1b/vO/lXqMi5NLYxhPb+MPm2m5F1E+NmD3xqafxL79jnk8NxOjLJj02N09q4I7Y
	K571fWG0AaqoSKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1664313A52;
	Mon, 13 May 2024 12:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ICZCBPwNQmZpfwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 13 May 2024 12:56:28 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	airlied@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	jani.nikula@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 02/10] drm/mgag200: Bind I2C lifetime to DRM device
Date: Mon, 13 May 2024 14:51:07 +0200
Message-ID: <20240513125620.6337-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513125620.6337-1-tzimmermann@suse.de>
References: <20240513125620.6337-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

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
2.45.0


