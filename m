Return-Path: <stable+bounces-244772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJznIWv3/WlilQAAu9opvQ
	(envelope-from <stable+bounces-244772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:47:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0572F4F80B1
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8144304339E
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874023F7898;
	Fri,  8 May 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZincF9m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6F3F6603;
	Fri,  8 May 2026 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251589; cv=none; b=XjBlBVfOaMw13Cpd/maZwvMPGmecor7vofskqDy6ha1MOyeuTUDlDGS5D7JO+TadInO664pzQJqbiraBVvvScq+xMZUG3BXx1PyRa0n2D2jTC4VZjjT3e7Bvi9zzWfabXdEJFeUh4HJNq8KpXN5M/RTnqW8lQuxQ7bCMUqOeyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251589; c=relaxed/simple;
	bh=2giSI3kqJQB//8Ul4n6V6oSBt4dteqqZbtnY9HL2lmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjXooWoQGEVRgUs+rR4v6Fraf0V8z+Yy4mKxjrH4o8pWTkkXTBIWqE6BgnQf/bKuFd0TGtXFke1VVvOOvseakm+REpXWGWyKhzIs085LKb7scB+5L5BdrF6B526529Npap+W5fI4CmkOOqJer8I78/ZH1GnNdHpCKbRFJqoHyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZincF9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC36EC2BCF4;
	Fri,  8 May 2026 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778251588;
	bh=2giSI3kqJQB//8Ul4n6V6oSBt4dteqqZbtnY9HL2lmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZincF9mC3NmZSqxHHKRkfKONNaSaR+Mm6VKQ0Wyoho14LWeLeH3BvUK7sfhcGVVK
	 6kHXC92Ptya1PcIniCqAVsrnmACAiornk/fkc15wSIc0wQWiTxrU+XhxDQqAlFbDMu
	 iCRWgyZ9ENGsmExpNIMgzxIxXob6eb47U1nufCyRtIPn6dlLio4m2a/k6CfjJsRIPV
	 z99kDT3j3zGDLCH6x1f35pJ1wJv3VsMzuMKrBmgolv9bMcT4Q4UHbDY7tT3FL58Xl5
	 ODDZmm7u2OsUnDV1LH+KW9lj9b4QfCJKkhjwTUnyHm9OCFOX8D4mL7aKScU40neoOL
	 R05oiK7wvwz2Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLMTC-00000000FZ5-2iOV;
	Fri, 08 May 2026 16:46:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] drm/gma500/oaktrail_lvds: fix hang on init failure
Date: Fri,  8 May 2026 16:44:45 +0200
Message-ID: <20260508144446.59722-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508144446.59722-1-johan@kernel.org>
References: <20260508144446.59722-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0572F4F80B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244772-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The LVDS init code looks up an I2C adapter using i2c_get_adapter() and
tries to read the EDID before falling back to allocating and registering
its own adapter.

The error handling does not separate these cases so on a late init
failure it will try to deregister and free also an adapter that had
previously been registered. Since i2c_get_adapter() takes another
reference to the adapter, deregistration hangs indefinitely while
waiting for the reference to be released.

Fix this by only destroying adapters allocated during LVDS init on
errors.

Fixes: a57ebfc0b4da ("drm/gma500: Make oaktrail lvds use ddc adapter from drm_connector")
Cc: stable@vger.kernel.org	# 6.0
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/gma500/oaktrail_lvds.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index 884d324f0044..983cc60a1e69 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -293,7 +293,7 @@ void oaktrail_lvds_init(struct drm_device *dev,
 {
 	struct gma_encoder *gma_encoder;
 	struct gma_connector *gma_connector;
-	struct gma_i2c_chan *ddc_bus;
+	struct gma_i2c_chan *ddc_bus = NULL;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
@@ -421,7 +421,8 @@ void oaktrail_lvds_init(struct drm_device *dev,
 
 err_unlock:
 	mutex_unlock(&dev->mode_config.mutex);
-	gma_i2c_destroy(to_gma_i2c_chan(connector->ddc));
+	if (!IS_ERR_OR_NULL(ddc_bus))
+		gma_i2c_destroy(ddc_bus);
 	drm_encoder_cleanup(encoder);
 err_connector_cleanup:
 	drm_connector_cleanup(connector);
-- 
2.53.0


