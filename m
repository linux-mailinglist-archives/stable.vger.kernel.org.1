Return-Path: <stable+bounces-267403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k6WaJDFLNWpirgYAu9opvQ
	(envelope-from <stable+bounces-267403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:59:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4D6A6399
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:59:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k4Myi0Za;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JIzdBTHA;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k4Myi0Za;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JIzdBTHA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267403-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267403-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F283034B28
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A302FA0C4;
	Fri, 19 Jun 2026 13:59:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F72FE59C
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:58:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877540; cv=none; b=AFPx1O12nZtB9RjyrN/IT3WCR4zIkT3/rGSzJhcAzBjHaOugpNUEEVENCbrRIW7KYSGjnouLaK/Lt4vfIkXz/cBzY3JEsbZFXTrmHD4HCrD6cmF5ZnDpm21/Xo1xLyfNV7x0u3lkY8mnOp49hE15AXXhHHJQSVHkmMkNFM7zAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877540; c=relaxed/simple;
	bh=aeOXSbeZ+sUGvFQZPqT3LNoWX8GnQZQtRoZthPBPB8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEjPN7LamF5Rp3N7ir6MIBr/PgknZ5bjreCI8xsb5fAKjI8SnGeeeyyyl5WiCbYmFT8Qec1JbOCW4PnZvzMyOeDVWvC0rh0A7+DZliugPt7W/f0rVtsRAUsN3XR50KwONUTGNhwAku1QPao9FrTLTIe5FvxEjrQuhzaD3Yl5o94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k4Myi0Za; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JIzdBTHA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k4Myi0Za; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JIzdBTHA; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EADD75D2F;
	Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpDVnK0TvHBIKhkXL855ih+LuB40KwhHQbSuYGInKMA=;
	b=k4Myi0Za8gqT0rQHGExxItBz+b3hJg/fGW16a6u/abiBcYjIHl23JoI+GE481zEYiOKSys
	8LdpalJb+HZsuuI1kMc93wlTo38p7p1fFCF31Wbtm6wxdFGnKlWAjmr69WNhupnhBsodXV
	hvCx4D/hUglcwx3axX5AQPcuBFsVHnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781877531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpDVnK0TvHBIKhkXL855ih+LuB40KwhHQbSuYGInKMA=;
	b=JIzdBTHAUw2sIqpx9TxSlCjsHs2BBU7yEjEiOvjPr0vyCG1tyOUG4nOvP8khZLtlVKdMkk
	ds+X8qZqlN/andCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpDVnK0TvHBIKhkXL855ih+LuB40KwhHQbSuYGInKMA=;
	b=k4Myi0Za8gqT0rQHGExxItBz+b3hJg/fGW16a6u/abiBcYjIHl23JoI+GE481zEYiOKSys
	8LdpalJb+HZsuuI1kMc93wlTo38p7p1fFCF31Wbtm6wxdFGnKlWAjmr69WNhupnhBsodXV
	hvCx4D/hUglcwx3axX5AQPcuBFsVHnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781877531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpDVnK0TvHBIKhkXL855ih+LuB40KwhHQbSuYGInKMA=;
	b=JIzdBTHAUw2sIqpx9TxSlCjsHs2BBU7yEjEiOvjPr0vyCG1tyOUG4nOvP8khZLtlVKdMkk
	ds+X8qZqlN/andCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5791A779A8;
	Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YGAcFBtLNWpvfwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Jun 2026 13:58:51 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] drm/sysfb: simpledrm: Improve panel-size validation
Date: Fri, 19 Jun 2026 15:56:35 +0200
Message-ID: <20260619135847.309664-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619135847.309664-1-tzimmermann@suse.de>
References: <20260619135847.309664-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267403-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:javierm@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:rayyan@ansari.sh,m:dri-devel@lists.freedesktop.org,m:sashiko-reviews@lists.linux.dev,m:tzimmermann@suse.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FD4D6A6399

Validate the panel size from the device-tree node against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail transparently on errors; do not warn.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 2a6d731a8f16 ("drm/simpledrm: Allow physical width and height configuration via panel node")
Cc: Rayyan Ansari <rayyan@ansari.sh>
Cc: <stable@vger.kernel.org> # v6.4+
---
 drivers/gpu/drm/sysfb/simpledrm.c | 35 ++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 03bd19fadccd..5c1db0785d92 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -200,6 +200,35 @@ simplefb_get_memory_of(struct drm_device *dev, struct device_node *of_node)
 	return res;
 }
 
+static u16
+__simplefb_get_panel_size_mm_of(struct drm_device *dev, struct device_node *of_panel_node,
+				const char *name)
+{
+	int ret;
+	u32 value;
+
+	ret = of_property_read_u32(of_panel_node, name, &value);
+	if (ret || value > U16_MAX) {
+		drm_dbg(dev, "simplefb: cannot parse panel %s: value %u, error %d\n",
+			name, value, ret);
+		return 0; /* not an error, simply ignore */
+	}
+
+	return value;
+}
+
+static u16
+simplefb_get_panel_width_mm_of(struct drm_device *dev, struct device_node *of_panel_node)
+{
+	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "width-mm");
+}
+
+static u16
+simplefb_get_panel_height_mm_of(struct drm_device *dev, struct device_node *of_panel_node)
+{
+	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
+}
+
 /*
  * Simple Framebuffer device
  */
@@ -601,7 +630,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	struct drm_sysfb_device *sysfb;
 	struct drm_device *dev;
 	int width, height, stride;
-	int width_mm = 0, height_mm = 0;
+	u16 width_mm = 0, height_mm = 0;
 	struct device_node *panel_node;
 	const struct drm_format_info *format;
 	struct resource *res, *mem = NULL;
@@ -665,8 +694,8 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 			return ERR_CAST(mem);
 		panel_node = of_parse_phandle(of_node, "panel", 0);
 		if (panel_node) {
-			simplefb_read_u32_of(dev, panel_node, "width-mm", &width_mm);
-			simplefb_read_u32_of(dev, panel_node, "height-mm", &height_mm);
+			width_mm = simplefb_get_panel_width_mm_of(dev, panel_node);
+			height_mm = simplefb_get_panel_height_mm_of(dev, panel_node);
 			of_node_put(panel_node);
 		}
 	} else {
-- 
2.54.0


