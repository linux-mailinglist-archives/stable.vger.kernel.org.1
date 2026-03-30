Return-Path: <stable+bounces-231105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WICXJidHymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:49:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE3D3588C2
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A51B3305C90A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E523815C0;
	Mon, 30 Mar 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdwQ+xjm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF73372B2C
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863748; cv=none; b=NIpcHeur6c6Fhs0Yea2Qb2S8PywPVGBOZivFR0ENcSpy/npSrBlhS+x7ogUK7+2dJGrp1NLGowDCQRiO4gg2LxOjI41HBcNjnHNgb8xvzVYh8kQqCqzsiyqCOLeEPDhSKPWjAn4HTFBityO2sXbpClLrgbCAyMAcy5zWdAJ0cak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863748; c=relaxed/simple;
	bh=+gayitWG32+g2rkfMeBLHlX/izWAHRxPHWeo2qROZN4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LUI8XDLWgThBUyEU851L3Uwtyr6+65xmiygt18ejGgZe78DFsZ3huosPNdfkbthAIKCXLL1I1gm6iZvSw+MXvIrwFx5KUWNSWlWjZmxg4G8vW7Zu3RKNuXOfyEI/FS34DzHIuh366zjw1y7PiWfUU2/jWl8GhAUONkR4wNQVHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdwQ+xjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B326C4CEF7;
	Mon, 30 Mar 2026 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863748;
	bh=+gayitWG32+g2rkfMeBLHlX/izWAHRxPHWeo2qROZN4=;
	h=Subject:To:Cc:From:Date:From;
	b=cdwQ+xjmmBwbdSjSAqJwOln1k1d/yeMTd3tGFUvDUAu06zg08kZy3paOm6Oi87hLo
	 yhBAmZUZndU0hUXTwAdMHeBUeulZSwFWgpl6qV4NMecrvJU5K76/rGSEOvFF21anRP
	 XkFeQhEklKDgYFo4TF5WykVkhx7vXIus7PPWdJmY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix DCE LVDS handling" failed to apply to 6.18-stable tree
To: alexander.deucher@amd.com,roman.li@amd.com,srinivasan.shanmugam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:42:25 +0200
Message-ID: <2026033025-autism-expanse-4891@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231105-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,gitlab.freedesktop.org:url,amd.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1FE3D3588C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 90d239cc53723c1a3f89ce08eac17bf3a9e9f2d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033025-autism-expanse-4891@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90d239cc53723c1a3f89ce08eac17bf3a9e9f2d4 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Thu, 26 Feb 2026 17:12:08 -0500
Subject: [PATCH] drm/amd/display: Fix DCE LVDS handling

LVDS does not use an HPD pin so it may be invalid.  Handle
this case correctly in link encoder creation.

Fixes: 7c8fb3b8e9ba ("drm/amd/display: Add hpd_source index check for DCE60/80/100/110/112/120 link encoders")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5012
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Roman Li <roman.li@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3b5620f7ee688177fcf65cf61588c5435bce1872)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 92c123aca0c9..fdcf8db6be50 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -650,9 +650,6 @@ static struct link_encoder *dce100_link_encoder_create(
 		return &enc110->base;
 	}
 
-	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
-		return NULL;
-
 	link_regs_id =
 		map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
 
@@ -661,7 +658,8 @@ static struct link_encoder *dce100_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index 95852d277c22..ab71f645c90e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -671,7 +671,7 @@ static struct link_encoder *dce110_link_encoder_create(
 		kzalloc_obj(struct dce110_link_encoder);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -682,7 +682,8 @@ static struct link_encoder *dce110_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 58c6a00397cf..b7051bfd4326 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -632,7 +632,7 @@ static struct link_encoder *dce112_link_encoder_create(
 		kzalloc_obj(struct dce110_link_encoder);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -643,7 +643,8 @@ static struct link_encoder *dce112_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 71d76b021375..7ee70f7b3aa7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -716,7 +716,7 @@ static struct link_encoder *dce120_link_encoder_create(
 		kzalloc_obj(struct dce110_link_encoder);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -727,7 +727,8 @@ static struct link_encoder *dce120_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 
 	return &enc110->base;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index c27645708286..3d52973dd7f2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -746,18 +746,16 @@ static struct link_encoder *dce60_link_encoder_create(
 		return &enc110->base;
 	}
 
-	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
-		return NULL;
-
 	link_regs_id =
 		map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
 
 	dce60_link_encoder_construct(enc110,
-				      enc_init_data,
-				      &link_enc_feature,
-				      &link_enc_regs[link_regs_id],
-				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				     enc_init_data,
+				     &link_enc_feature,
+				     &link_enc_regs[link_regs_id],
+				     &link_enc_aux_regs[enc_init_data->channel - 1],
+				     enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				     NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index d66d8ac6d897..89927727a0d9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -752,9 +752,6 @@ static struct link_encoder *dce80_link_encoder_create(
 		return &enc110->base;
 	}
 
-	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
-		return NULL;
-
 	link_regs_id =
 		map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
 
@@ -763,7 +760,8 @@ static struct link_encoder *dce80_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 


