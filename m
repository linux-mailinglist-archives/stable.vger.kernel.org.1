Return-Path: <stable+bounces-225641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIzUEOxAuGnSawEAu9opvQ
	(envelope-from <stable+bounces-225641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:42:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A333029E6E1
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C48D430F98CC
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1117330B2E;
	Mon, 16 Mar 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="fA/2ALAz"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBB327BFC
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682607; cv=none; b=T183Zj+PJNdmz6YelRZlPxIlDICAZdzSRSbWeAdJsjLriY1fRXIFY9a94WVLVDvyS/9YbRCL7Wbl5lF0VYw0OGYMxVRwgSnrPYWEvryi3aFFM7Tegn8XTbTSqG5jT83ExKxobJeJdQuKjR4LSr/wJ/aN6q/DDkqCRSKvlMkJ+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682607; c=relaxed/simple;
	bh=nRk+BqLXO6nRR7vlha6s+jbOBge8/EBwlJRvGcfgEEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LuiRr7UHdPTDrvOe5cUumRnNWCvRbF6R1DYDHteQZMdfgYo39Ml/hwDziH8PiNzVOp4y2Vvr4xXRiw/QBDipCcmBIFzIP+74KIOJf5aZ9s/ZCGyMpHX8uWfyfuklIQvlF+4ZH1fBYJPhrJM9h+BmOVTivQ9/Fc9XK0fb1lm9IWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=fA/2ALAz; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 072BF1C0F86
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:26:41 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1773682000; x=
	1774546001; bh=nRk+BqLXO6nRR7vlha6s+jbOBge8/EBwlJRvGcfgEEc=; b=f
	A/2ALAzi53HWhfoRxwlqH82smSSgcSC7+Kj6rdkDTCiRAT0Fdo6EkfYop/Nbx3Bt
	0658XSlW3qYjR8TG25dtUm4vL7BVwBGONDGugb9wHH4HaLg2W82gcxyueYP60DaH
	n0nkH/WgaSh24u4nrFn49hv49870J8Dfjm4P9IG9Bw=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PgJIaOT0ctg0 for <stable@vger.kernel.org>;
	Mon, 16 Mar 2026 20:26:40 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 12A001C0EE6;
	Mon, 16 Mar 2026 20:26:35 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Lyude Paul <lyude@redhat.com>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/disp: Fix potential NULL pointer dereference in nouveau_dp_irq
Date: Mon, 16 Mar 2026 17:26:17 +0000
Message-ID: <20260316172631.82304-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nppct.ru:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-225641-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nppct.ru,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,lists.freedesktop.org,vger.kernel.org,linuxtesting.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[nppct.ru];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdl@nppct.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nppct.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A333029E6E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nouveau_dp_irq() dereferences the encoder pointer before verifying
that it is valid. The drm pointer is initialized using
outp->base.base.dev prior to the NULL check:

  struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);

If no encoder is associated with the connector, this leads to a
NULL pointer dereference.

Move the drm initialization after the NULL check.

Fixes: 773eb04d14a1 ("drm/nouveau/disp: expose conn event class")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 55691ec44aba..738802358d85 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -486,7 +486,7 @@ nouveau_dp_irq(struct work_struct *work)
 		container_of(work, typeof(*nv_connector), irq_work);
 	struct drm_connector *connector = &nv_connector->base;
 	struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
-	struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);
+	struct nouveau_drm *drm;
 	struct nv50_mstm *mstm;
 	u64 hpd = 0;
 	int ret;
@@ -494,6 +494,8 @@ nouveau_dp_irq(struct work_struct *work)
 	if (!outp)
 		return;
 
+	drm = nouveau_drm(outp->base.base.dev);
+
 	mstm = outp->dp.mstm;
 	NV_DEBUG(drm, "service %s\n", connector->name);
 
-- 
2.43.0


