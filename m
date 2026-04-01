Return-Path: <stable+bounces-232617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C+UAhNlzGnZSgYAu9opvQ
	(envelope-from <stable+bounces-232617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:21:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7406D373158
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38D5C306B39A
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFC61917CD;
	Wed,  1 Apr 2026 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQqR3Zvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3F18FDBE
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002777; cv=none; b=GV4iM8jgGKvWHKLCQo75+ehqzkOFbMoGLYJTgkpACgGxgsB/UjbkUYZIBfCOXWI6ZQMbh6KVqBygR24SrdGzmDcmquC4KpfDQf1LGFjf9Kdb+ma8hcXfDwZIzZQos8+O/0Z5pC3iD7q4R6JjDy3CitCmX+Jt4dgRFRsI/Tlamno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002777; c=relaxed/simple;
	bh=P0ytQzyeq2q9xTYL7DWtQgs2ZycFDBuqPSh1ns/Nzqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0KRs0q9ZMiYH74gUHJb1iRu6dydNFvUKDPo5eExSAviE4g3q73ebq7C9vT2lhJtE0zKE2W253I9wYL7XYBel1SQwktgEnkOQQK1XbNfYETlh2LHK0OeN32NGRw4uGo/V03l7Wxr+8dzSPw/P/18KejbCZJMwgpuQL7t7RZya7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQqR3Zvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E38C19423;
	Wed,  1 Apr 2026 00:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775002777;
	bh=P0ytQzyeq2q9xTYL7DWtQgs2ZycFDBuqPSh1ns/Nzqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQqR3ZvpfQ3YGmJymx0JG7BTr+lWF8R3rPByO5GgJ2rJTSZQF8lw8JMeoilrvfDKi
	 muiElnXFRWqFDsGS1t6SmyrxvGZaRxarKMsKy/NNlAgbJ1rAmJlzkokHkLy2/VwvMh
	 oobGJM2AyTOl5FkorUfE89jWj5giQwsZQWYD5NCPeHdWWgQH5xqlr2KtHBbmx1jxtQ
	 otUBInJ24zu8U1xgXbScfw7B2bG9d8mk3J+HuUaAaB4yv4gTu2kIihE1si/ltICWi7
	 T3owTqpWGD+3DbETOOksg72KL+Y4XdCdBjUKv++51ImwRbuCZRd5vxGKBgdKgTOxPJ
	 s6mEPWO8O+bOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Roman Li <roman.li@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Fix DCE LVDS handling
Date: Tue, 31 Mar 2026 20:19:34 -0400
Message-ID: <20260401001934.3984005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033025-autism-expanse-4891@gregkh>
References: <2026033025-autism-expanse-4891@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232617-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 7406D373158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 90d239cc53723c1a3f89ce08eac17bf3a9e9f2d4 ]

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
[ removed unrelated VGA connector block absent from stable and split combined null/bounds check into separate guard and ternary ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/resource/dce100/dce100_resource.c    |  5 +++--
 .../display/dc/resource/dce110/dce110_resource.c    |  5 +++--
 .../display/dc/resource/dce112/dce112_resource.c    |  5 +++--
 .../display/dc/resource/dce120/dce120_resource.c    |  5 +++--
 .../amd/display/dc/resource/dce60/dce60_resource.c  | 13 +++++++------
 .../amd/display/dc/resource/dce80/dce80_resource.c  |  5 +++--
 6 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index c4b4dc3ad8c9d..ef146f253577a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -624,7 +624,7 @@ static struct link_encoder *dce100_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -635,7 +635,8 @@ static struct link_encoder *dce100_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index cccde5a6f3cdf..234da1e2ae21d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -668,7 +668,7 @@ static struct link_encoder *dce110_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -679,7 +679,8 @@ static struct link_encoder *dce110_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 869a8e515fc09..2d5a5e1691971 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -629,7 +629,7 @@ static struct link_encoder *dce112_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -640,7 +640,8 @@ static struct link_encoder *dce112_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 540e04ec1e2d9..0af20d2bd8b90 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -713,7 +713,7 @@ static struct link_encoder *dce120_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -724,7 +724,8 @@ static struct link_encoder *dce120_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 
 	return &enc110->base;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index b75be6ad64f6c..f2e47f1ff4b33 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -718,18 +718,19 @@ static struct link_encoder *dce60_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
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
index 5b77697452022..8822d5818d29e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -724,7 +724,7 @@ static struct link_encoder *dce80_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -735,7 +735,8 @@ static struct link_encoder *dce80_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
-- 
2.53.0


