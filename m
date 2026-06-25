Return-Path: <stable+bounces-268323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vigANtT4PGrnvAgAu9opvQ
	(envelope-from <stable+bounces-268323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:45:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF126C45D5
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Q2WCYEI/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o9wbuV4M;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Q2WCYEI/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o9wbuV4M;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268323-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268323-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ED4B3033005
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7093AA1A1;
	Thu, 25 Jun 2026 09:45:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99F3921D5
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:45:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380727; cv=none; b=KrEDVC1YQJwyBDHUsEfb94iFmKzGXEz2W0WUQKEQnWhfjqp9n64sgKMkHHP03tcsgeWx9O0w0E4d6eGnAJT+bI/wNWjlimkPIThK/ozGIBaIeFjDwSmLKP8XzX7bpQeUNEN7JexSky/wWA+2W8ba3j6xZmtNNLzyjyRLFtsAAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380727; c=relaxed/simple;
	bh=34QlVZAkLeWmD5Lak/d4sbQjQrvlQPg7pnVx9U0JqPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVrb4GH9N+kinZKIbiBr80hld+C8t+mMAEJjPZi484fYfBtzUHAgBB3PDfNiVd+L3PPbKo9J//19JDBvX6xDtRwmsdrcAF+n+OnyvaO1mEi/efrJdzpxa3yY0uSqTBzU1mg6a2dhfSzY/AqQKUTeEh2R8DMwhBR5ZXQMvsOcFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q2WCYEI/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o9wbuV4M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q2WCYEI/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o9wbuV4M; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEDFE75CC0;
	Thu, 25 Jun 2026 09:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782380718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pME0/UJzDD+k7AVEXyx7XuINJiPWaM3pjS9stY8AB80=;
	b=Q2WCYEI/QrsAmEbb5lkA7TP1dVyc0zDRTtvooYh1oDUADdf2GOZL+G6o2rWvzKai+OAW5m
	7HHPKUJxvNpUwvxKi0Alakroyasle6pEX4tbnrN0UCma7iRYd2nq5FS/yS/LMZ5F0++FcG
	vMpZgS6KGGwIqbxoJjVzgZWcxyZU4Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782380718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pME0/UJzDD+k7AVEXyx7XuINJiPWaM3pjS9stY8AB80=;
	b=o9wbuV4MFfzd/ySF2+OW6CT6GzGa7y2/ag7hDMABZ7cUUvMNRJMGklyiywSIY0wfyvE/KU
	obucYwC3NaCxG0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782380718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pME0/UJzDD+k7AVEXyx7XuINJiPWaM3pjS9stY8AB80=;
	b=Q2WCYEI/QrsAmEbb5lkA7TP1dVyc0zDRTtvooYh1oDUADdf2GOZL+G6o2rWvzKai+OAW5m
	7HHPKUJxvNpUwvxKi0Alakroyasle6pEX4tbnrN0UCma7iRYd2nq5FS/yS/LMZ5F0++FcG
	vMpZgS6KGGwIqbxoJjVzgZWcxyZU4Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782380718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pME0/UJzDD+k7AVEXyx7XuINJiPWaM3pjS9stY8AB80=;
	b=o9wbuV4MFfzd/ySF2+OW6CT6GzGa7y2/ag7hDMABZ7cUUvMNRJMGklyiywSIY0wfyvE/KU
	obucYwC3NaCxG0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AECC779A8;
	Thu, 25 Jun 2026 09:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CArzGK74PGqaBQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 25 Jun 2026 09:45:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	treding@nvidia.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	neil.armstrong@linaro.org,
	jesszhan0024@gmail.com,
	rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/7] drm/sysfb: simpledrm: Improve panel-size validation
Date: Thu, 25 Jun 2026 11:39:34 +0200
Message-ID: <20260625094509.157581-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625094509.157581-1-tzimmermann@suse.de>
References: <20260625094509.157581-1-tzimmermann@suse.de>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-268323-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javierm@redhat.com,m:treding@nvidia.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:neil.armstrong@linaro.org,m:jesszhan0024@gmail.com,m:rayyan@ansari.sh,m:dri-devel@lists.freedesktop.org,m:sashiko-reviews@lists.linux.dev,m:tzimmermann@suse.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[redhat.com,nvidia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,linaro.org,ansari.sh];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EF126C45D5

Validate the panel size from the device-tree node against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail transparently on errors; do not warn.

v3:
- move comments to a more prominent place (Thierry)
v2:
- only use initialized values in debugging output (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Fixes: 2a6d731a8f16 ("drm/simpledrm: Allow physical width and height configuration via panel node")
Cc: Rayyan Ansari <rayyan@ansari.sh>
Cc: <stable@vger.kernel.org> # v6.4+
---
 drivers/gpu/drm/sysfb/simpledrm.c | 49 +++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 15dcafa9d524..6bbe779ec870 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -193,6 +193,39 @@ simplefb_get_memory_of(struct drm_device *dev, struct device_node *of_node)
 	return res;
 }
 
+static int __simplefb_get_panel_size_mm_of(struct drm_device *dev,
+					   struct device_node *of_panel_node,
+					   const char *name)
+{
+	int ret;
+	u32 value;
+
+	ret = of_property_read_u32(of_panel_node, name, &value);
+	if (ret) {
+		drm_dbg(dev, "simplefb: cannot parse panel %s: error %d\n",
+			name, ret);
+		return ret;
+	} else if (value > U16_MAX) {
+		drm_dbg(dev, "simplefb: panel %s of %u exceeds maximum value\n",
+			name, value);
+		return -EINVAL;
+	}
+
+	return value;
+}
+
+static int simplefb_get_panel_width_mm_of(struct drm_device *dev,
+					  struct device_node *of_panel_node)
+{
+	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "width-mm");
+}
+
+static int simplefb_get_panel_height_mm_of(struct drm_device *dev,
+					   struct device_node *of_panel_node)
+{
+	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
+}
+
 /*
  * Simple Framebuffer device
  */
@@ -594,7 +627,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	struct drm_sysfb_device *sysfb;
 	struct drm_device *dev;
 	int width, height, stride;
-	int width_mm = 0, height_mm = 0;
+	u16 width_mm = 0, height_mm = 0;
 	struct device_node *panel_node;
 	const struct drm_format_info *format;
 	struct resource *res, *mem = NULL;
@@ -658,8 +691,18 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 			return ERR_CAST(mem);
 		panel_node = of_parse_phandle(of_node, "panel", 0);
 		if (panel_node) {
-			simplefb_read_u32_of(dev, panel_node, "width-mm", &width_mm);
-			simplefb_read_u32_of(dev, panel_node, "height-mm", &height_mm);
+			/*
+			 * Ignore errors from parsing the physical panel
+			 * size. Using the pre-initialized sizes of 0 will
+			 * make drm_sysfb_mode() calculate a default physical
+			 * size based on a resolution of 96 dpi.
+			 */
+			ret = simplefb_get_panel_width_mm_of(dev, panel_node);
+			if (ret > 0)
+				width_mm = ret;
+			ret = simplefb_get_panel_height_mm_of(dev, panel_node);
+			if (ret > 0)
+				height_mm = ret;
 			of_node_put(panel_node);
 		}
 	} else {
-- 
2.54.0


