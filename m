Return-Path: <stable+bounces-224662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCnKKgwzsWm0rwIAu9opvQ
	(envelope-from <stable+bounces-224662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:17:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508526023B
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3372303E683
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BC43BF671;
	Wed, 11 Mar 2026 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PyljCFGB"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198F3C5529;
	Wed, 11 Mar 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220546; cv=none; b=lNcx4lXm7Fr9MFyz/fat1btfrsLTj0rYNCkmmujVksq13jjKZzTqFXYRaXH4+f3vTI+f/8tf0vC56Ywj88HNxBf2h5xtsx+n1AECEKsdPrKuUjBxlM5cRrSaDg27+Mce7+aKLNLvtJPXconx5dU3i8OeItgGnLE7mxm4eXvdJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220546; c=relaxed/simple;
	bh=FK89pOaFAMnCdx1USHLPGPqlFLXxs2xhiM3WFS+Geic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2y3xBfKvYYui3sW6UkUIQVuhXiJlm9z0hkGMop1EGYNJ45C49peqr7DmN8B3oWI+j6mB6KlZlnjIAwGRfEBbygUlWgvdn4yB1g1v0V7RkqmbA9HZmONQhVG4PUPeiW0lfsjzezTn/xfrq2hUpHp7gPyxosY9186W26lzCVQ0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PyljCFGB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CFD1F981;
	Wed, 11 Mar 2026 10:14:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773220461;
	bh=FK89pOaFAMnCdx1USHLPGPqlFLXxs2xhiM3WFS+Geic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PyljCFGBEfaoDHTntkIC8krem8ZFFkY7kCs/7sYkE+8ai7+C+gEUYvP7UOdh6FL3p
	 cfX4O48KY2UcFV/4fAWlArpMbYFezryOD/umf6JhyH5FI3n1X5t/shhUUKdA6KGYqH
	 FS3FYSYRIJ0eP7cjilwkNsX5dDnv51wtAhXmrZqs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 11 Mar 2026 11:14:44 +0200
Subject: [PATCH v2 2/2] drm/tidss: Fix missing drm_bridge_add() call
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-tidss-minor-fixes-v2-2-cb4479784458@ideasonboard.com>
References: <20260311-tidss-minor-fixes-v2-0-cb4479784458@ideasonboard.com>
In-Reply-To: <20260311-tidss-minor-fixes-v2-0-cb4479784458@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2518;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=FK89pOaFAMnCdx1USHLPGPqlFLXxs2xhiM3WFS+Geic=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpsTKta2KS2BnqNS/cahxVcpraq+OxMhz0502r0
 FQOP/KL1jWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCabEyrQAKCRD6PaqMvJYe
 9QlCD/9cijyL+ssoamfzXYS8YPdeEEX+jeJ+RV7Zgpkrkey4UPXWXUXTYHb/zBFsaD9hcpINoMI
 IB0viFjIf8kC6sXwcWjUqtdl9tAsCgU4DZi4R5wWW28SiIDAEcZxXMHeY1/LAc12dq2CsOGNowA
 1Sq7VZxJ43LqSZaAm5wPg5/jIwJoIFwP07ey/AUXlOzPEoYViT2F2Osl8F/E+PSd2xEDfqE435A
 DUz58MwKVjaF6jGvl69Kf15qghUgR1O9CxAXgxRVfSWpoDKjSC6Xo9312q5n/vzHcKlymA61zzp
 pfhS7k2BrDhcsj0vPyf21z20IRJ/MlGSvdNAf/IhX/eUuHjftlEfEE80Hx/Z7dVIGJ67iYsbTg4
 pt0KfRqBs+CYDDMCpF7Gm2718HzTHeC1Q2ZA4l5qSaTeIv4k7DwAyOxUYr0RJMPsSBL9+eVAVDV
 aipG2v6gCfvvU8WXv7Rh7eT6U3d9rylIoJ+2BZKMPeALTBakUJpw+5/AYG+dAR06HGq3n0p1d2e
 bBCwCvZnZhcO9x2p91GBL1aRT/Jtg6+UnD8hZ6iObFwOocURDn+/maIpsxcEI4quxT3+YM1l+Mu
 mOs25y7hgMbKMm1LIDEBy6DXGIezNpMzAu4F+wimsJV0wIngU0z9nN0Lzz7cHER+Rf+Vwhr34HU
 6TCj34AyH0ZPbSw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Rspamd-Queue-Id: 5508526023B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[iki.fi,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org,redhat.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224662-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomi.valkeinen@ideasonboard.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:dkim,ideasonboard.com:email,ideasonboard.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

tidss encoder-bridge is not added with drm_bridge_add() call, which
leads to:

[drm] Missing drm_bridge_add() before attach

Add the missing call, using devm_drm_bridge_add() variant to get the
drm_bridge_remove() handled automatically.

The commit marked with the Fixes tag (from v6.6) is the commit that
added the encoder bridge without drm_bridge_add(). However, this fix is
not directly applicable there as devm_drm_bridge_alloc() was not used to
alloc the bridge, so using devm version for drm_bridge_add() wouldn't be
safe. Instead, drm_bridge_add() and drm_bridge_remove() would be needed
there, but that would require new plumbing code as we don't have a
separate cleanup function in the tidss_encoder.c, not in the tidss_kms.c
from which the encoder is created.

Also, there has been no reported bugs caused by the missing
drm_bridge_add(). The drm_bridge_add() initializes the bridge's
hpd_mutex, but HPD is not used for the encoder bridge. drm_bridge_add()
also adds the bridge to the global bridge_list, which is only used in
of_drm_find_bridge(), and again that is not used for the encoder bridge.

Thus, while the original commit is not right, there should be no bugs
caused by it, and for the time being I'm not sending a patch for the
stable kernels for the original commit.

This fix applies on top of commit 66cdf05f8548 ("drm/tidss: encoder:
convert to devm_drm_bridge_alloc()"), which changes the tidss_encoder.c
to use the devm variant (added in v6.17). The warning print was added in
v6.19, so applying this fix to v6.17+ gets rid of the warning for all
kernel versions.

Cc: stable@vger.kernel.org # v6.17+
Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 81a04f767770..db467bbcdb77 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -106,6 +106,8 @@ int tidss_encoder_create(struct tidss_device *tidss,
 	enc = &t_enc->encoder;
 	enc->possible_crtcs = possible_crtcs;
 
+	devm_drm_bridge_add(tidss->dev, &t_enc->bridge);
+
 	/* Attaching first bridge to the encoder */
 	ret = drm_bridge_attach(enc, &t_enc->bridge, NULL,
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);

-- 
2.43.0


