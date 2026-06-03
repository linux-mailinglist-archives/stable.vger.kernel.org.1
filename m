Return-Path: <stable+bounces-260004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QIxaKYzuH2pfsgAAu9opvQ
	(envelope-from <stable+bounces-260004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:06:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E467635FDB
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=JFsxQYCq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260004-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260004-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E50310FC5E
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB2376A13;
	Wed,  3 Jun 2026 09:00:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC05370D5D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:00:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477243; cv=none; b=S4skc0dGvCkErHwac7Az3Q6qrmI5m9ejhaYgO5chLCE3cnWUOj865wMGhcB3HoY0/yitB1e8Rx20FpDZWY6LelX6DVY11/Z5wQVBcqtQwLPjbSOPgsCL9Sgw9ph01cwlPzwomwk0zALQZ3M7pErF7fka4KySq7JF+jzFtKpp8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477243; c=relaxed/simple;
	bh=C+G5Uf/2i+LZcXERuus3LfCyP+sYSn+cml0wSXoCCzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfHDqCnOZ5Y1YeHtwSC69GF2c32AaiVf4CCa7wrrrAixS474rVPL4NScD1EywISM7h6WflTn6CqZMOE4O+KpDfYJjAuifp6Vm3O9poI5HSST+NASN7rFObi9AIdPThQIpAlFH1hXiUKl7WpMiNmSS7UAe/RCpe8TCLe2OFF1URA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JFsxQYCq; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4C4311A37D4;
	Wed,  3 Jun 2026 09:00:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0DF245FD24;
	Wed,  3 Jun 2026 09:00:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1866E10888CC6;
	Wed,  3 Jun 2026 11:00:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780477235; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r/NN9pViPdyj5cuEJSEypzO3N+Y1PCVc8NIitOG1U6o=;
	b=JFsxQYCqBNmAgsmCbRMq5hbFW3Zvu2lp5Q57fsRA/fLYBenc9qdcsG4zUSzi/cvYXRotXp
	sL1AfhNzTOQMIzErLXMeeaH9LNetB3kxdwlCwT0CvL1zZPRWXJ23sKUHSZ8ml3A7TJTvB1
	eXe32XGGsl1q+TTD3RjTjA0RY4F4szkDqyaAftTK9uMrV39JlU62AfST0SmDcHxL1BFhUs
	oBC+SNT0U/mlOyANf56JUIY23WAv1XDC70Lgo8CN7++qWJWeA6YRtZ1SwPWyv50uigb5sQ
	SdlFvUcWBkvFHeUcTOWTZX9q4JsNGBk3Vs5pS6p7WNWjsMbtX+rY8CQ1n/NfYw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 03 Jun 2026 10:59:53 +0200
Subject: [PATCH 2/3] drm/i915/display/intel_lvds: Drop redundant manual
 cleanup on init failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-fix_i915-v1-2-7479ff64e705@bootlin.com>
References: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
In-Reply-To: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.0
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,chris-wilson.co.uk,anholt.net,redhat.com,virtuousgeek.org];
	FORGED_RECIPIENTS(0.00)[m:jani.nikula@linux.intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:airlied@gmail.com,m:simona@ffwll.ch,m:chris@chris-wilson.co.uk,m:eric@anholt.net,m:airlied@redhat.com,m:jbarnes@virtuousgeek.org,m:thomas.petazzoni@bootlin.com,m:louis.chauvet@bootlin.com,m:markyacoub@google.com,m:seanpaul@google.com,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:simona.vetter@ffwll.ch,m:kory.maincent@bootlin.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kory.maincent@bootlin.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260004-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:from_mime,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E467635FDB

intel_lvds_init() had a goto-based error path that manually called
drm_connector_cleanup(), drm_encoder_cleanup(), kfree() and
intel_connector_free() when no LVDS panel mode could be found.

Once drm_connector_init_with_ddc() and drm_encoder_init() have been
called, the DRM core takes ownership of these objects and will invoke
their .destroy callbacks (intel_connector_destroy and
intel_encoder_destroy) during device teardown. The manual cleanup in
the failed: label is therefore redundant.

Remove it and replace the goto with a simple early return.

Cc: stable@vger.kernel.org
Fixes: 79e539453b34e ("DRM: i915: add mode setting support")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Not tested as I don't have such hardware.
---
 drivers/gpu/drm/i915/display/intel_lvds.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lvds.c b/drivers/gpu/drm/i915/display/intel_lvds.c
index c8098104d853a..2a1301eda5fe5 100644
--- a/drivers/gpu/drm/i915/display/intel_lvds.c
+++ b/drivers/gpu/drm/i915/display/intel_lvds.c
@@ -990,8 +990,10 @@ void intel_lvds_init(struct intel_display *display)
 	mutex_unlock(&display->drm->mode_config.mutex);
 
 	/* If we still don't have a mode after all that, give up. */
-	if (!intel_panel_preferred_fixed_mode(connector))
-		goto failed;
+	if (!intel_panel_preferred_fixed_mode(connector)) {
+		drm_dbg_kms(display->drm, "No LVDS modes found, disabling.\n");
+		return;
+	}
 
 	intel_panel_init(connector, drm_edid);
 
@@ -1004,12 +1006,4 @@ void intel_lvds_init(struct intel_display *display)
 	lvds_encoder->a3_power = lvds & LVDS_A3_POWER_MASK;
 
 	return;
-
-failed:
-	drm_dbg_kms(display->drm, "No LVDS modes found, disabling.\n");
-	drm_connector_cleanup(&connector->base);
-	drm_encoder_cleanup(&encoder->base);
-	kfree(lvds_encoder);
-	intel_connector_free(connector);
-	return;
 }

-- 
2.43.0


