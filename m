Return-Path: <stable+bounces-233070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIt2HCifzmlZpAYAu9opvQ
	(envelope-from <stable+bounces-233070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:54:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2A838C37D
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79AF930D3E4E
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CD93CF046;
	Thu,  2 Apr 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aI1lH+bW"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AE336EDA
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148184; cv=none; b=iWsCIByeZmi0PbnTZgCAkfyKFNaq9kUl3UJjIVfh2kcQZaZIOAKb3uEcMljgaIGqmhci89fLEuUxigmb+z0+6E/Vyc9oNzyyjjC9cW0GxmsGTBXzS9qifvkIclf3ktdp4haCYJYZWYEteYXQ5ubVxpw2tK1Zp6YTxtheEAcxuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148184; c=relaxed/simple;
	bh=0yorz4CxLkCvg/X29aqII5erKaUABM45cGY91XwGERE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jzNrTAZ0wzLH0ZwgtJI/cevc+Qckv3x/5rDYGPhqAIErNbKBcafVHtHQOMA9w6Zb9JGhDNbOR2HlxF//LFtTMieWgwynDUnN/Vnmj7HT2OxFrbim6qNtc2gDZub0Wj1NBWn1OuOQOUoLyzISM844GG5PGLofwVI7jyCu/zHgdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aI1lH+bW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6FBEE4E428BE;
	Thu,  2 Apr 2026 16:42:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F32D602CD;
	Thu,  2 Apr 2026 16:42:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08A2010450136;
	Thu,  2 Apr 2026 18:42:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775148171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=tklQU7AmBlgtiJ+7oB3wdNKyKDgrfZerlBF58NV2zpU=;
	b=aI1lH+bWdLYmRJTxHRR+pIdws10RauOS5winQ+NM0YLyeI13XLP7oUlcmPY/l1+bKzdLOY
	zdiKdHc3XZEz36LxEa0BZdJsMdXeZpUgt1nm4rM/VVk6oqVfDh5fDbp2taygRRsn36va87
	Rme6ewzHC+S+6FHCf8AuRh+vSWSJfHzwkZd4gBjOt5MNXhbWGVy2K5GoENMY13+bU2p7xc
	QsTm6qb0SK5tIWeiIVlczU1eSvD4bfZhuilg1V20iwtzAMfuMn7iTpXHHWWxHZgwE/nFXJ
	lVEv5vMh3c+p+0uIsecyNNmix15R5ijnioKY+Es9MWeUw8Q208UoOwbcjKk3Mg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 02 Apr 2026 18:42:20 +0200
Subject: [PATCH v2] drm/arcpgu: fix device node leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGuczmkC/42NQQ6CMBBFr0Jm7RimiZi68h6GBW2nMBFa0iLRE
 O5u5QQu38//72+QOQlnuFUbJF4lSwwF1KkCO3ShZxRXGFStLkSk0aUJu2T7+YVe3ujKxjKG6Bh
 H7p7oda2NJX/1xkCxzIlL73h4tIUHyUtMn+NwpV/6v3slJKwbpTQ767nhu4lxGSWcbZyg3ff9C
 +9vfEjQAAAA
X-Change-ID: 20251119-drm-arcgpu-fix-device-node-leak-f909bc1f7fbb
To: Simona Vetter <simona.vetter@ffwll.ch>, 
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Ray <ian.ray@gehealthcare.com>, stable@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233070-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,synopsys.com,linux.intel.com,kernel.org,suse.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: BA2A838C37D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This function gets a device_node reference via
of_graph_get_remote_port_parent() and stores it in encoder_node, but never
puts that reference. Add it.

There used to be a of_node_put(encoder_node) but it has been removed by
mistake during a rework in commit 3ea66a794fdc ("drm/arc: Inline
arcpgu_drm_hdmi_init").

Fixes: 3ea66a794fdc ("drm/arc: Inline arcpgu_drm_hdmi_init")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- fix typos in commit message
---
 drivers/gpu/drm/tiny/arcpgu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 505888497482..c93d61ac0bb7 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -250,7 +250,8 @@ DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
 static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 {
 	struct platform_device *pdev = to_platform_device(arcpgu->drm.dev);
-	struct device_node *encoder_node = NULL, *endpoint_node = NULL;
+	struct device_node *encoder_node __free(device_node) = NULL;
+	struct device_node *endpoint_node = NULL;
 	struct drm_connector *connector = NULL;
 	struct drm_device *drm = &arcpgu->drm;
 	int ret;

---
base-commit: 4b9c36c83b34f710da9573291404f6a2246251c1
change-id: 20251119-drm-arcgpu-fix-device-node-leak-f909bc1f7fbb

Best regards,
--  
Luca Ceresoli <luca.ceresoli@bootlin.com>


