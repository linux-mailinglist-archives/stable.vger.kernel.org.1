Return-Path: <stable+bounces-200203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFECA9645
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 22:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C00E30EC09D
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5AA23E35F;
	Fri,  5 Dec 2025 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKazOrxz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8B19922D
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764970352; cv=none; b=R5VQ6WCQQ5aJ2ETV5mcmt6SG7mEuxCptXTD/Ny30gyKf/hp34crzpB3xyXNaSEwFcWOOahflJUpxMFAq3z3pEu54a1FOPnbB6ccF/sQi140HzE22TBBkpi8hcsxCmerTEyf2i8tjVAq047TDaOaJzVNg2bfYcT6V7IrdDp0LR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764970352; c=relaxed/simple;
	bh=IaiBrvAi+CP+EqjoOTrAQtLut/KItU+Sbxv+OlUrDZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnFKVF9E3ax07Igh1KTQrAK2ejPR8MdIExCVGf5NE5wNO0JnV8CUKYDjXhDtaz4BJM0ZFKsiPzkLTDT+FfYiitHfKCLqV0Ra75YtwdkZ+I203KuJaG0d/f/kmVbee0zTHyXan/cimW10BZ22Tuots3lDfaA/KmYV8Mfpx6Tve+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKazOrxz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764970347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kxmueX5biLhJ2TR2gDtyWx7oPUcxnAg7QJk2s9ppvBo=;
	b=XKazOrxzUJIDZkHtOJS62dKfFLbAAU/Rl6sD+4y4gvHt9lmEtFwLfb+kpleCpVT45bE+6t
	2pqhdIHT/9voBZCfVwZ6h1WfzSUkL7/HCPFI43OWoQe7Ol4OEcGGnQQBzCxraOpoos7cAm
	3o3tgNcedxGysQIewTIpfk6eG7sYluk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-XHl9Sl5aOy2ePqdoMvtIvw-1; Fri,
 05 Dec 2025 16:32:22 -0500
X-MC-Unique: XHl9Sl5aOy2ePqdoMvtIvw-1
X-Mimecast-MFC-AGG-ID: XHl9Sl5aOy2ePqdoMvtIvw_1764970340
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC2E119560B3;
	Fri,  5 Dec 2025 21:32:19 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.64.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 565F51953986;
	Fri,  5 Dec 2025 21:32:15 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	"Faith Ekstrand" <faith.ekstrand@collabora.com>,
	"Dave Airlie" <airlied@redhat.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Ben Skeggs" <bskeggs@nvidia.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"James Jones" <jajones@nvidia.com>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH] drm/nouveau/dispnv50: Don't call drm_atomic_get_crtc_state() in prepare_fb
Date: Fri,  5 Dec 2025 16:31:53 -0500
Message-ID: <20251205213156.2847867-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since we recently started warning about uses of this function after the
atomic check phase completes, we've started getting warnings about this in
nouveau. It appears a misplaced drm_atomic_get_crtc_state() call has been
hiding in our .prepare_fb callback for a while.

So, fix this by adding a new nv50_head_atom_get_new() function and use that
in our .prepare_fb callback instead.

Signed-off-by: Lyude Paul <lyude@redhat.com>

Fixes: 1590700d94ac ("drm/nouveau/kms/nv50-: split each resource type into their own source files")
Cc: <stable@vger.kernel.org> # v4.18+
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/atom.h | 13 +++++++++++++
 drivers/gpu/drm/nouveau/dispnv50/wndw.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/atom.h b/drivers/gpu/drm/nouveau/dispnv50/atom.h
index 93f8f4f645784..85b7cf70d13c4 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/atom.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/atom.h
@@ -152,8 +152,21 @@ static inline struct nv50_head_atom *
 nv50_head_atom_get(struct drm_atomic_state *state, struct drm_crtc *crtc)
 {
 	struct drm_crtc_state *statec = drm_atomic_get_crtc_state(state, crtc);
+
 	if (IS_ERR(statec))
 		return (void *)statec;
+
+	return nv50_head_atom(statec);
+}
+
+static inline struct nv50_head_atom *
+nv50_head_atom_get_new(struct drm_atomic_state *state, struct drm_crtc *crtc)
+{
+	struct drm_crtc_state *statec = drm_atomic_get_new_crtc_state(state, crtc);
+
+	if (IS_ERR(statec))
+		return (void*)statec;
+
 	return nv50_head_atom(statec);
 }
 
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index ef9e410babbfb..9a2c20fce0f3e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -583,7 +583,7 @@ nv50_wndw_prepare_fb(struct drm_plane *plane, struct drm_plane_state *state)
 	asyw->image.offset[0] = nvbo->offset;
 
 	if (wndw->func->prepare) {
-		asyh = nv50_head_atom_get(asyw->state.state, asyw->state.crtc);
+		asyh = nv50_head_atom_get_new(asyw->state.state, asyw->state.crtc);
 		if (IS_ERR(asyh))
 			return PTR_ERR(asyh);
 
-- 
2.52.0


