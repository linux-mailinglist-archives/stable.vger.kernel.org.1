Return-Path: <stable+bounces-244774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B8TEXH3/WlilQAAu9opvQ
	(envelope-from <stable+bounces-244774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:47:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D274F80B9
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF317305DF69
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB8237CD50;
	Fri,  8 May 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tISLuLba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E313F54B3;
	Fri,  8 May 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251590; cv=none; b=gpscM3VC1zh05pnAzOgM2MPK4/4zEmN4/iF54TIYyoZ80/OIc/5Zq77keCQo0Kxrngm459JjxJOKnPvpn1/D1ghRzxnpXzpkC/JOAmBBUL+oNg3HgF2OdbbleAro79/kpxo4GuVauzd2fAD4LXi5lXYSK6cdmWtw7gqdLxwKVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251590; c=relaxed/simple;
	bh=G4Fkw46u7ywzQfjBZWK+OQ4pewgSnJib5ODBo6YmLF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay6TeA1kj4IN1o8VMBKP+ilSk21x8ERnDd2Z9U/0LFz+gnqgPIAOiNPEVzeMOVyXxqLdqHouAyat6YZwxL23/zOSzjidXt0fwmR9hAzrGs8iXERo69Rhb8Q2toFXF0+H0MxfvlNU0Zt39/HlGqg/fxLflTFVEQSHtB02SYqfgj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tISLuLba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519CBC2BCC9;
	Fri,  8 May 2026 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778251589;
	bh=G4Fkw46u7ywzQfjBZWK+OQ4pewgSnJib5ODBo6YmLF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tISLuLbaQBDLelBEdX7IcdYPbIse/VEP3PQk32s/c9Sp8ATUJGHrIvuKl/e8u5NrP
	 jo6assX84Y8cCs/Dm/Vj3xGPLdT71Yv009DeM5TLVpmq1X02Qn/1DvNeq4+zEEuprH
	 CL/nNO2/aCS4sRMZvjrK6WUDWfiJJkEAAPxyfJvu/sPxqPfPB/k+lwtm17SG5TZSxC
	 Q/VP/oC4ACaYBbcIglHgsR+HdagqlDWPoLrrzg5llqbbqUOF5aWSjk9UGGfDZ7heH3
	 aAyc4QbLW7qA3QsnXPZxpWiF5XepUvNyb3oBD8pz2gCAb23AMIK6EaN088KBrd+uer
	 VlndpYkC4pz7g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLMTC-00000000FZ7-2kkp;
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
Subject: [PATCH 3/3] drm/gma500/oaktrail_lvds: fix i2c adapter leaks on init
Date: Fri,  8 May 2026 16:44:46 +0200
Message-ID: <20260508144446.59722-4-johan@kernel.org>
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
X-Rspamd-Queue-Id: D7D274F80B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244774-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

Make sure to drop the references taken by i2c_get_adapter() when falling
back to allocating an adapter as well as on late errors to allow the
looked up adapter to be deregistered.

Fixes: 1b082ccf5901 ("gma500: Add Oaktrail support")
Cc: stable@vger.kernel.org	# 3.3
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/gma500/oaktrail_lvds.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index 983cc60a1e69..e194d0cce067 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -367,6 +367,8 @@ void oaktrail_lvds_init(struct drm_device *dev,
 	if (edid == NULL && dev_priv->lpc_gpio_base) {
 		ddc_bus = oaktrail_lvds_i2c_init(dev);
 		if (!IS_ERR(ddc_bus)) {
+			if (i2c_adap)
+				i2c_put_adapter(i2c_adap);
 			i2c_adap = &ddc_bus->base;
 			edid = drm_get_edid(connector, i2c_adap);
 		}
@@ -423,6 +425,8 @@ void oaktrail_lvds_init(struct drm_device *dev,
 	mutex_unlock(&dev->mode_config.mutex);
 	if (!IS_ERR_OR_NULL(ddc_bus))
 		gma_i2c_destroy(ddc_bus);
+	else if (i2c_adap)
+		i2c_put_adapter(i2c_adap);
 	drm_encoder_cleanup(encoder);
 err_connector_cleanup:
 	drm_connector_cleanup(connector);
-- 
2.53.0


