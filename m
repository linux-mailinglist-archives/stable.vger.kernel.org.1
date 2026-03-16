Return-Path: <stable+bounces-225658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNUvOL5QuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:49:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CDB29F43C
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3339A30C16AA
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94043DF009;
	Mon, 16 Mar 2026 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="lEQhynEA"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE033E0C4A
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686578; cv=none; b=CTbbVZ+rz5jMv0khXLhUVCKb8Dgfs+zVJnXbhBDN7APL+nJU0AfeROiopFMeNLRIZZXcryXvpAefzFIJUzNE1gfUvORPHd3NF5mLMcgiYK4TvE0DUuFyiuZpbW2KlxHGYqr5JR8LWuBL3heGSN+LQ53KSAMH4sU/uIysWlzCqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686578; c=relaxed/simple;
	bh=3sBY4tW9sUTsq5I04TqNM0MDdmo2tDC1vEIhnJUCkOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ8ADcO5A8GwzWx2m95L9sv9EoMjVJSYL69x3ZhDlOKmCoj1j5vKvi6fbs0qlB6yF13bvVJZxy1wTJrdZQE5e1VUTmr6C8f0z3OoOX9Sa/bL6sCpNrfi60c1BKQM6CSQmu0J3L3dN8Fqb1cDPbgqIvt2TVyOArgLne6trXDHl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=lEQhynEA; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id AA9E31C0F79
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 21:42:51 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1773686566; x=
	1774550567; bh=3sBY4tW9sUTsq5I04TqNM0MDdmo2tDC1vEIhnJUCkOE=; b=l
	EQhynEAvuAjLAlVaGTRamznV5ieGXYp0lDyWeNtaamfLeYAsvCKD/I573iJbCI1E
	PL8BRCa3AwYhrU43zy5/Rx+f5oNT/KUcI4idI2qRM7buyGOVRv94FgVKgTakIGw3
	No3o3j6AR85bHdN8Fa7fHSL07LGifTHpOuK69LU2O8=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8WqmiXtEONrl for <stable@vger.kernel.org>;
	Mon, 16 Mar 2026 21:42:46 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 224FB1C0E83;
	Mon, 16 Mar 2026 21:41:59 +0300 (MSK)
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
Subject: [PATCH v2] drm/nouveau/disp: Fix potential NULL pointer dereference in nouveau_dp_irq
Date: Mon, 16 Mar 2026 18:41:41 +0000
Message-ID: <20260316184143.82894-1-sdl@nppct.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225658-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nppct.ru,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,lists.freedesktop.org,vger.kernel.org,linuxtesting.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nppct.ru];
	DKIM_TRACE(0.00)[nppct.ru:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdl@nppct.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63CDB29F43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The issue was discovered through static analysis after reviewing changes
introduced by commit 773eb04d14a1 ("drm/nouveau/disp: expose conn event
class"). Function nouveau_dp_irq() dereferences the encoder pointer before
verifying that it is valid. The drm pointer is initialized using
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


