Return-Path: <stable+bounces-267717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8cE3FjY4OWooowcAu9opvQ
	(envelope-from <stable+bounces-267717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 15:27:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC96AFD96
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 15:27:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267717-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267717-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6164F301915A
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8743C377EA4;
	Mon, 22 Jun 2026 13:24:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CB3A6F17
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:24:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134689; cv=none; b=bBDd33sIzZdqZ1okiJ7zVVHwWzdB7WlWThtHcTonOV4NOK09v0csHHfsKdBNNTLveKIt8bjsZa6KYPxPv3NYEmYJlSUxp2WCwa7XAm44ll6E2GdyhAVqMljLyLcdY8UxoHr5c7bIWq8DNcl/ySe1X6ylFcEPdkcbqKw3qMPz1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134689; c=relaxed/simple;
	bh=loNXJrgKy5QPoCKgSFkb4aKBjzG/BgvkpIVpXYbgFdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzJUQ6il8BnJUUlF+v3Vp5ky0I6z1cWV/tNN7X5fhPieOjF5rtUICyLjARp5a1EaPDeA6Jo8HnkcDv7RMO0UUKbCRFC/fuLT6kFKOk2PtZf6KQ5Sox0RCVGB13tpxEEX48Te1JfFHxLzQXFsButcjKugAyOsPZjdhubhS2+GIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57A1C75CFD;
	Mon, 22 Jun 2026 13:24:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14383779A8;
	Mon, 22 Jun 2026 13:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WM/KA5k3OWpYIQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 22 Jun 2026 13:24:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	treding@nvidia.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/6] drm/sysfb: simpledrm: Improve stride validation
Date: Mon, 22 Jun 2026 15:19:38 +0200
Message-ID: <20260622132433.722823-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622132433.722823-1-tzimmermann@suse.de>
References: <20260622132433.722823-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javierm@redhat.com,m:treding@nvidia.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:rayyan@ansari.sh,m:dri-devel@lists.freedesktop.org,m:sashiko-reviews@lists.linux.dev,m:tzimmermann@suse.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,nvidia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267717-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAEC96AFD96

Validate the computed stride against the maximum value INT_MAX.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 7bfa5c7b28d6 ("drm/simpledrm: Compute linestride with drm_format_info_min_pitch()")
Cc: <stable@vger.kernel.org> # v6.1+
---
 drivers/gpu/drm/sysfb/simpledrm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 709922ea656c..76b9a3f5c4ef 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -694,9 +694,15 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 		return ERR_PTR(-ENODEV);
 	}
 	if (!stride) {
-		stride = drm_format_info_min_pitch(format, 0, width);
-		if (drm_WARN_ON(dev, !stride))
+		u64 pitch = drm_format_info_min_pitch(format, 0, width);
+
+		if (drm_WARN_ON(dev, !pitch)) {
+			return ERR_PTR(-EINVAL); /* driver bug */
+		} else if (pitch > INT_MAX) {
+			drm_warn(dev, "stride of %llu exceeds maximum\n", pitch);
 			return ERR_PTR(-EINVAL);
+		}
+		stride = pitch;
 	}
 
 	sysfb->fb_mode = drm_sysfb_mode(width, height, width_mm, height_mm);
-- 
2.54.0


