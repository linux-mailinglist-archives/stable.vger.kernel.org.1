Return-Path: <stable+bounces-267402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sgdzGi1LNWpfrgYAu9opvQ
	(envelope-from <stable+bounces-267402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:59:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBCD6A6394
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:59:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LVbmKnVy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i1TNEJiz;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LVbmKnVy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i1TNEJiz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267402-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267402-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2160302F71F
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE62FA0C4;
	Fri, 19 Jun 2026 13:58:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56032857FA
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:58:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877534; cv=none; b=nMcHFCAn9usUPhCHB8IK4shOvt+Ce0e5xWtQBF9qJB9qMEmeIyWVCE8+jx3sKE3/v3q57j9JxH7DLC7zMM5ZxSbpcD4fLm0wvnCeDVYC2K4w8jRgmBF0NajhmGpcsZdzl4K+eHRvo/tcfM2d2j9X7Gm5IwB+XLYNbbAiCe1/M+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877534; c=relaxed/simple;
	bh=44+OeX8EVKg4uBX+uvGDFfevKVZNh/84Muhlb95wgRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpXV8rJvbiJE5kNEkkjN/X+N/bjE+HlZkOu1VpF73NgnFwVoCgr+Yc1xGIPTYT/GsnokKR8vgEN2auki/Pdn+uiT/dPDo+YyG3mDTov98u8wEmkv5HJ6x2mj/VfwQ54/PxmkXVkWA/OdQZbYqoLKSIEYrnjRU7vFfkVxlo0oE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LVbmKnVy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i1TNEJiz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LVbmKnVy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i1TNEJiz; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 521CD75C75;
	Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkdvrlHS3lnYj9qgqGygKFUVpGPS9nGNplKOGnyvVJE=;
	b=LVbmKnVy+H5L4f6ZoZiThOcXym//ySP2v1pWmN65EV5lCwcmX5sNExM5xdVMTGIBmiliRm
	H3rEbt4Not0zEHwHIusmeYHUH7z+pZrtmTK4/Jx0AWkx3TuaO3FdCvE+Z/Cv6qOoNg1y0n
	H88iIMc/Pe34L2Z1488hRgQp+GxBHuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781877531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkdvrlHS3lnYj9qgqGygKFUVpGPS9nGNplKOGnyvVJE=;
	b=i1TNEJiz1AP8HCdE+p+K9t6FrfS+45rB/jxLjpBvdYYZ3P69yZMjMkk15lpkE/47UyU5sU
	FHmJEj0jFOxVTjBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkdvrlHS3lnYj9qgqGygKFUVpGPS9nGNplKOGnyvVJE=;
	b=LVbmKnVy+H5L4f6ZoZiThOcXym//ySP2v1pWmN65EV5lCwcmX5sNExM5xdVMTGIBmiliRm
	H3rEbt4Not0zEHwHIusmeYHUH7z+pZrtmTK4/Jx0AWkx3TuaO3FdCvE+Z/Cv6qOoNg1y0n
	H88iIMc/Pe34L2Z1488hRgQp+GxBHuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781877531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkdvrlHS3lnYj9qgqGygKFUVpGPS9nGNplKOGnyvVJE=;
	b=i1TNEJiz1AP8HCdE+p+K9t6FrfS+45rB/jxLjpBvdYYZ3P69yZMjMkk15lpkE/47UyU5sU
	FHmJEj0jFOxVTjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D7D779AB;
	Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFovAxtLNWpvfwAAD6G6ig
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
Subject: [PATCH 1/3] drm/sysfb: simpledrm: Improve framebuffer-size validation
Date: Fri, 19 Jun 2026 15:56:34 +0200
Message-ID: <20260619135847.309664-2-tzimmermann@suse.de>
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
	TAGGED_FROM(0.00)[bounces-267402-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 7BBCD6A6394

Validate the framebuffer size from the firmware against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail probing on errors.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Cc: <stable@vger.kernel.org> # v5.14+
---
 drivers/gpu/drm/sysfb/simpledrm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index fc168920f2c6..03bd19fadccd 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -88,14 +88,14 @@ static int
 simplefb_get_width_pd(struct drm_device *dev,
 		      const struct simplefb_platform_data *pd)
 {
-	return simplefb_get_validated_int0(dev, "width", pd->width);
+	return drm_sysfb_get_validated_int0(dev, "width", pd->width, U16_MAX);
 }
 
 static int
 simplefb_get_height_pd(struct drm_device *dev,
 		       const struct simplefb_platform_data *pd)
 {
-	return simplefb_get_validated_int0(dev, "height", pd->height);
+	return drm_sysfb_get_validated_int0(dev, "height", pd->height, U16_MAX);
 }
 
 static int
@@ -144,7 +144,7 @@ simplefb_get_width_of(struct drm_device *dev, struct device_node *of_node)
 
 	if (ret)
 		return ret;
-	return simplefb_get_validated_int0(dev, "width", width);
+	return drm_sysfb_get_validated_int0(dev, "width", width, U16_MAX);
 }
 
 static int
@@ -155,7 +155,7 @@ simplefb_get_height_of(struct drm_device *dev, struct device_node *of_node)
 
 	if (ret)
 		return ret;
-	return simplefb_get_validated_int0(dev, "height", height);
+	return drm_sysfb_get_validated_int0(dev, "height", height, U16_MAX);
 }
 
 static int
-- 
2.54.0


