Return-Path: <stable+bounces-258612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPpKNBIqG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:18:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620961174E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67C1B3040CA3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B4274FDC;
	Sat, 30 May 2026 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xUncJo2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC33BE175;
	Sat, 30 May 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164936; cv=none; b=jq7+IpU4t1bTdYgZMtYt/Vswar4gXL57qxM4jNCNOvRU+ITpRnbT9MRNb9CFKsxP5WR8DYVif2mzEoDI3vDO7IyQhqOq8XgjuH5606k02L+ZHHBirfgdmk/VDlcKXg/inxXyBLkw6p1ukNteb26C7DeCjz9xmJ0Za5Onoqagcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164936; c=relaxed/simple;
	bh=/F5LDO1oJl130X+TRshRecCIhaXaGAuvfD5v8/K9nEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsnUSi/JN7fW7B0Cc8GESnDrz01Yt9Y6+K+1h5aRbgaFRGT6PsnIxFxwyjZRezHcZ2S+v2jrBFFEDJdv+yK5JH0OO5abb5Um2BCtsinnkvsH+b4/2vtrkeq8ZkjkaZ4G1iUuQ6dtpTrYOug0G0B9aUO4CYga+DeoP9dArm2JVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xUncJo2j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED4B1F00893;
	Sat, 30 May 2026 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164935;
	bh=mYrDseRq+LQwbI/bnh9grBBjT6q5V7sLrWC+czoCJJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xUncJo2j9c+iYAIbArslXEATaxuKZQcL1vqxSiNp+PjmSDI8ELjQDradlcy8bGiRl
	 HL246WLC0nArqJjZQ7sv+hsm+yJcVRsVvvQPh0UVx2D00RFrUR53zMzZiSK+bwSd42
	 QGHlSwVMQOJP2vgFjjaTVvfAzTr5wmSNl3bMEjlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julien Chauveau <chauveau.julien@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 5.15 702/776] drm/bridge: it66121: acquire reset GPIO in probe
Date: Sat, 30 May 2026 18:06:56 +0200
Message-ID: <20260530160257.983181242@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7620961174E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julien Chauveau <chauveau.julien@gmail.com>

commit e02b5262fd288cc235f14e12233ea54e78c04611 upstream.

The it66121_ctx structure has a gpio_reset field, and it66121_hw_reset()
calls gpiod_set_value() on it. However, the GPIO descriptor is never
acquired via devm_gpiod_get(), leaving gpio_reset as NULL throughout
the driver lifetime.

gpiod_set_value() silently returns when passed a NULL descriptor, so
the hardware reset sequence in it66121_hw_reset() is a no-op. This
leaves the chip in an undefined state at probe time, which can prevent
it from responding on the I2C bus.

The DT binding marks reset-gpios as a required property, so all
compliant device trees provide this GPIO. Add the missing
devm_gpiod_get() call after enabling power supplies and before the
hardware reset, so the chip is properly reset with power applied.

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Julien Chauveau <chauveau.julien@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patch.msgid.link/20260324193011.16583-1-chauveau.julien@gmail.com
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/ite-it66121.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -955,6 +955,11 @@ static int it66121_probe(struct i2c_clie
 	if (ret)
 		return ret;
 
+	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->gpio_reset))
+		return dev_err_probe(dev, PTR_ERR(ctx->gpio_reset),
+				     "Failed to get reset GPIO\n");
+
 	it66121_hw_reset(ctx);
 
 	ctx->regmap = devm_regmap_init_i2c(client, &it66121_regmap_config);



