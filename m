Return-Path: <stable+bounces-242597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NMuBYXq9WmqQQIAu9opvQ
	(envelope-from <stable+bounces-242597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 14:13:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B824B1E1E
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F38AF3004615
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F433438F;
	Sat,  2 May 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KH3+Iwab"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF81ACEDE
	for <stable@vger.kernel.org>; Sat,  2 May 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777724029; cv=none; b=lzeWK2wc2TUdBdRCk3Djvy/kNI29XrGf6+2Ha6h1WNwOkmDyPgbfs1qSmev4QJ9fRApYjDILkKwx0Qb4Ma1mTANoN0rJKhdot7QRsD0t2J2yufNiNFwBqjNTbwqe1aBlzGkjzjAi/Ne+IVVUmQYymmbjlqwoZTDRRVSG4SQvZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777724029; c=relaxed/simple;
	bh=XGytLSpCy9xgPusgWlXyFNDJcqnNgBnFVfmi4WwGiUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iK26TUYHwAgGCYaSGO2AeDT9iPWmBcjKH2Eh/jtm778oxZLgiZpYpknMIdY4nmk42hevZsO+57nhrtaDZbPIbpePnFsmEasYEC+GqfKZTNQgVDkjG4sUOOmUpM6FFrk3Xld0mkCGAdKzI1ef0ds6ZGGCpjYmFiHELAhfeghmHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KH3+Iwab; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777724024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Fv9ANxoEXrJtQ42FBdd7xju+ouJmyQSyIcqfR7al/c=;
	b=KH3+IwabzQKYT0Bo9H+H3OSvvlqon/GATLmavjjC1jtoD69F+b11yP7Y0V7kYt8/aPvhGJ
	J42OKHRhEOQDrziuEcc8t1L7yDbcrodfjIHV3CAE3otKQvtpmm+85dUxpZGdLX17LvsElj
	FnBS+HcwxOp7UU7sccDL6lFz/6ve7o4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Eric Anholt <eric@anholt.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: fix NULL dereference in vc4_hvs_unbind
Date: Sat,  2 May 2026 14:12:53 +0200
Message-ID: <20260502121251.39206-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=thorsten.blum@linux.dev; h=from:subject; bh=XGytLSpCy9xgPusgWlXyFNDJcqnNgBnFVfmi4WwGiUQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJlfXzlH2FxsyOraNNE86c+LeJdUwfPfqwr4VKayegXul X6/yIKjo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYy5wYjQ9+Tjq2bGKvErzEU BDg//Jdz4OyKxA+L/17h5/D5XrhLoYbhf0CF8Frm1Xd4/MUenb+3Z53CqlfbHp5vmFmhGqO9Npu fhQMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 00B824B1E1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242597-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,raspberrypi.com,igalia.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,anholt.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

With 'dtoverlay=vc4-kms-v3d,noaudio' and 'hdmi=off' on Raspberry Pi,
unloading the vc4 module calls vc4_hvs_unbind() with
dev_get_drvdata(master) returning NULL.

Return early when 'drm' is NULL before converting it to 'vc4' and before
dereferencing 'vc4->hvs', preventing a kernel oops.

Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index ee8d0738501b..9cb66f696fc7 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -1753,10 +1753,16 @@ static void vc4_hvs_unbind(struct device *dev, struct device *master,
 			   void *data)
 {
 	struct drm_device *drm = dev_get_drvdata(master);
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
-	struct vc4_hvs *hvs = vc4->hvs;
+	struct vc4_dev *vc4;
+	struct vc4_hvs *hvs;
 	struct drm_mm_node *node, *next;
 
+	if (!drm)
+		return;
+
+	vc4 = to_vc4_dev(drm);
+	hvs = vc4->hvs;
+
 	if (drm_mm_node_allocated(&vc4->hvs->mitchell_netravali_filter))
 		drm_mm_remove_node(&vc4->hvs->mitchell_netravali_filter);
 

