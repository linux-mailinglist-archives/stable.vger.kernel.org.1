Return-Path: <stable+bounces-224652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOtWGkglsWkOrQIAu9opvQ
	(envelope-from <stable+bounces-224652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:18:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D529025ED9F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D091305DA19
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18433359A8C;
	Wed, 11 Mar 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mt64nGmA"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF635A3A5;
	Wed, 11 Mar 2026 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217016; cv=none; b=p8OlNjSe/zIeAuNFaK6Y3LMn2GduTfI9+/9KYFAu8d4tyYjxowV709xc5xzibIYsbZCBX02rOHCqQ+K4HuQ2WJp4X6Kg4lcPg4zmSGjO6gbQlhTkR3mOiqCbcfhYdgrHIVy0Dujwd7t3FyyUA8MVsD+tKPnEIfSps19K58P902Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217016; c=relaxed/simple;
	bh=eQYvjKaHmHFpKWtxeve8uX4miV81ha81TaZeNuaTT20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tpSxEAeIrC19fwm2tlCZSpw0EVs70QZHUL+D1ljrp8EdS9GtuKZCuIVx2X2nfiZhgmHWlRV/U4qiLGy2y0gphaiF2TPAGKj81jh2o7P64ZBHz3FmoInqcruqRFzvlZyro5YrAO027eNj3d503OcpLE8fqWt9qNImapGIJs/Wrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mt64nGmA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A835981;
	Wed, 11 Mar 2026 09:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773216942;
	bh=eQYvjKaHmHFpKWtxeve8uX4miV81ha81TaZeNuaTT20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mt64nGmAq7qwRKxkHix8nUgDCa0XP9dy35UtAWlkf4hn6rOwctkL0ZQDdqW24++gA
	 VmXpxw7w6785zY+ZKh8OiLiQGltpgf8zLMWitvbKUaKWLJX0iN7YPxbqjnss1KjewF
	 tjc8VskNIsfZDF5RXTFQp4IIEfRERQfGKS4dLSb0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 11 Mar 2026 10:16:29 +0200
Subject: [PATCH 2/2] drm/tidss: Fix missing drm_bridge_attach() call
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-tidss-minor-fixes-v1-2-ee5e6e14a566@ideasonboard.com>
References: <20260311-tidss-minor-fixes-v1-0-ee5e6e14a566@ideasonboard.com>
In-Reply-To: <20260311-tidss-minor-fixes-v1-0-ee5e6e14a566@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=eQYvjKaHmHFpKWtxeve8uX4miV81ha81TaZeNuaTT20=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpsSTuP0LzIRg8wnIPlQRccTLJkgrM+DQPYMSSE
 WJ2AZE27OaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCabEk7gAKCRD6PaqMvJYe
 9ZzOD/9ec2ACKu9vUjzRo5JnTBGARKD00w8bD1UgBOmmcrZWcOof0G4Q9oLz4cq8/PNgzW19iH5
 tWqv854dy8/MICfcb1JcoBRFa+eBTlnRo13ew5PJ51MDvppNdt3Trnl+NXf66gTuM0wUBbajUMr
 JRDddl66Nl9SVZPd88b7Cm+0XPAYen9RH36o2pYS+yZN+m0+EScIarMnFplm81HKW/Qpb9NAdLj
 ekaKywTpHS9ZD3R3hxSAT+4aJ3xqPweGC3y+I4IbKUQ+gqKwpHBBCJaSdviBg1LX30Cu6EkUEUB
 zMruVRMuI3AZ1bNGIwLAdtEJOKJMf43eStZR9Y6f6nYig/svULJuI9YbSyW3/g3U0Bl81rGOQ4D
 pNGWpidVq76YOaT3WZc92CNMkhtC+uodBgrWNBR2trQ3Zbn/Qroi7gbOE0rlK7QhIewdUD4/27l
 4OXTAXX3YVMElSqdvYukU4DObHs88JpGisF2RNTVZT39125Qn5XaTatr2cF1NB2EA8hC6Mf7bHd
 yw504BGQCQHBcM/c7p0Aa9HYfBEfcCDWZSt8Day12L5BAQYkYx5scP8YIJsHLzfhcd0r7M6Bbr3
 wDlmJouSWyP4yjdQV7WRjX9YvMcIot5fu3oLvJXImMWkMP7621vMF2WWuec/p3vOZLLN0Wk1zZC
 qVXovMQ4FBkrgsA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Rspamd-Queue-Id: D529025ED9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[iki.fi,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org,redhat.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224652-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomi.valkeinen@ideasonboard.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ideasonboard.com:dkim,ideasonboard.com:email,ideasonboard.com:mid]
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

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: <stable@vger.kernel.org> # v6.17+
Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
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


