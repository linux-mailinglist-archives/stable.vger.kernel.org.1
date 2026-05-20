Return-Path: <stable+bounces-252822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACgRA5kEDmpO5gUAu9opvQ
	(envelope-from <stable+bounces-252822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:59:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E67D5978A9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B60753229D63
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4EA3F8706;
	Wed, 20 May 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b4I7OQ0+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CD368968;
	Wed, 20 May 2026 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301679; cv=none; b=nogOYjizQxmE+mDw6lt4PSccjXntvfZpx2B5C+dh6S6RnxRv6yQSQ1kwYdY74n7UTN53m54nyp0rzLT6jMKJ/3/vFYN8UC+KCflMpGH/xB+ZuOMiJnAsEMTgjlCErKWR2A3RWnFI62kofExTxAoV8d5ZPcb4rEuEfbkRkg9Zu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301679; c=relaxed/simple;
	bh=DKwoybAVTLcUEKojwUzEyUsTRH2iep95xnmKJX+9+6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wg/pXnPJI22ZevuJBEPJg19J6Y0AGOXr6eCdImvCgZStP4Bqr8jBPFW1+IZK0jzXYh/zOqlV6lcbuXizSaJaCKzAeAGKJhxGMgwdbAPrcl8PQE1irxN3r/8xNcBvH+n8iKKp5KKV5fPmOJ5LoEWN3D8hJt/Atk9X5p/06DrjRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b4I7OQ0+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8941F000E9;
	Wed, 20 May 2026 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301678;
	bh=CB27hDgeiEprPbdsZzzLgEaFi9hJ7kTIWmg0W9f7Q40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b4I7OQ0+tpOJ8ztdCb6f/iouZhpPdrJgRjoWPiBnhg9FS+78Dy/8KIxfae2JrakpL
	 ICdK4uQHNuOyhiL9+GMRvqHTzXrFpgIshmarIsDY3+httNstNc8zc9gfRDxD2vZYMi
	 LS67Lw0NkN7qeU5T5SSK0feTFJJWE/EGyMLIvo40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.12 645/666] drm/gma500/oaktrail_lvds: fix hang on init failure
Date: Wed, 20 May 2026 18:24:16 +0200
Message-ID: <20260520162125.260908381@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-252822-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5E67D5978A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 657a091ab6d01d0091b77660c75cfed573c9a53e upstream.

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
Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Link: https://patch.msgid.link/20260508144446.59722-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/gma500/oaktrail_lvds.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -292,7 +292,7 @@ void oaktrail_lvds_init(struct drm_devic
 {
 	struct gma_encoder *gma_encoder;
 	struct gma_connector *gma_connector;
-	struct gma_i2c_chan *ddc_bus;
+	struct gma_i2c_chan *ddc_bus = NULL;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
@@ -420,7 +420,8 @@ out:
 
 err_unlock:
 	mutex_unlock(&dev->mode_config.mutex);
-	gma_i2c_destroy(to_gma_i2c_chan(connector->ddc));
+	if (!IS_ERR_OR_NULL(ddc_bus))
+		gma_i2c_destroy(ddc_bus);
 	drm_encoder_cleanup(encoder);
 err_connector_cleanup:
 	drm_connector_cleanup(connector);



