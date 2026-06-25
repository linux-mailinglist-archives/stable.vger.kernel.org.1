Return-Path: <stable+bounces-268682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g5XbHce2PWqe5wgAu9opvQ
	(envelope-from <stable+bounces-268682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 01:16:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B76C91DB
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 01:16:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=C97TdmMY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268682-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268682-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81CD8304D250
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 23:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3692F25E4;
	Thu, 25 Jun 2026 23:16:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006491C2324
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:16:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782429365; cv=none; b=qg5WS3eCzgRgQJQ36qH7mVNF65Ht+E631gPoAShBDsxafQI4eA4/9ri8PlKIzWkyXdTFYpgMKwjtObyqjP1vSIC+i3qPxp526xJYxoV19ptO/TdHR3qBOtEgGVNdoxY3j7kIXlwE5drnyMHWxHpsoJpYvHJdFvYWstNGbhKDhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782429365; c=relaxed/simple;
	bh=0WHH7Col3y9IOV0d83OQ3IQQGAI8GaK9/S5woTmkW14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edP63Cd+PArPYx0JBPLdJCz0VxUDGEGOOIWZiIcMdQsOyM6PIPzvae2Lhu325AUyAN5GXwbYbcOSjWlctQRQKJaUIdCeV72hfI2bZkrmTCiOkRCsqY11S9/uuo8GL7K/54L2Mhloiqirdum//h6EzVxdvDS10fxviCoGwpYW3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C97TdmMY; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782429363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xl3px75Nvxza7EusKK6+TYAla9vsm3zzqhoL4GNe8rU=;
	b=C97TdmMYznDgcypcL94uvsP8Ivjq7Vb/IO83iYwah5QqiyGuiRTipDF1BLGHL9cn3ORURi
	/iS2EoyMrFytapEukrDDrzzX3JTNX9t38jyoqeZsWg/vKcKIrhFoHxmuLGFbCp6Lb3qHwK
	Rm/Rl3c/suiYHalhLeHDK5te1epcJTA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-l5U9TBKqNyGGF88jnBKy8w-1; Thu,
 25 Jun 2026 19:15:56 -0400
X-MC-Unique: l5U9TBKqNyGGF88jnBKy8w-1
X-Mimecast-MFC-AGG-ID: l5U9TBKqNyGGF88jnBKy8w_1782429354
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B449419540F1;
	Thu, 25 Jun 2026 23:15:53 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.18])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E51F30A8;
	Thu, 25 Jun 2026 23:15:51 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Timur Tabi <ttabi@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mel Henning <mhenning@darkrefraction.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 1/2] Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
Date: Thu, 25 Jun 2026 19:10:54 -0400
Message-ID: <20260625231252.89684-2-lyude@redhat.com>
In-Reply-To: <20260625231252.89684-1-lyude@redhat.com>
References: <20260625231252.89684-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268682-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,nvidia.com,linux.intel.com,darkrefraction.com,ffwll.ch,gmail.com,suse.de];
	FORGED_SENDER(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:nouveau@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:airlied@redhat.com,m:kees@kernel.org,m:dakr@kernel.org,m:ttabi@nvidia.com,m:bskeggs@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:mhenning@darkrefraction.com,m:maarten.lankhorst@linux.intel.com,m:simona@ffwll.ch,m:airlied@gmail.com,m:tzimmermann@suse.de,m:mripard@kernel.org,m:lyude@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C67B76C91DB

This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.

It turns out this looked like the right fix on some systems, but it's not -
as this causes runtime PM to actually fail on many a laptop.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")
Cc: <stable@vger.kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Ben Skeggs <bskeggs@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mel Henning <mhenning@darkrefraction.com>
Cc: <stable@vger.kernel.org> # v6.19+
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 8 ++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
index 700cea5def357..035b575722db7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
@@ -208,7 +208,7 @@ r535_fbsr_resume(struct nvkm_gsp *gsp)
 }
 
 static int
-r535_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
+r535_fbsr_suspend(struct nvkm_gsp *gsp)
 {
 	struct nvkm_subdev *subdev = &gsp->subdev;
 	struct nvkm_device *device = subdev->device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index f544afa12b6bb..4a3b771ded255 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1749,7 +1749,7 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_suspend_state suspend)
 		sr->sysmemAddrOfSuspendResumeData = gsp->sr.radix3.lvl0.addr;
 		sr->sizeOfSuspendResumeData = len;
 
-		ret = rm->api->fbsr->suspend(gsp, suspend == NVKM_RUNTIME_SUSPEND);
+		ret = rm->api->fbsr->suspend(gsp);
 		if (ret) {
 			nvkm_gsp_mem_dtor(&gsp->sr.meta);
 			nvkm_gsp_radix3_dtor(gsp, &gsp->sr.radix3);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
index 8ef8b4f655883..2945d5b4e5707 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
@@ -62,7 +62,7 @@ r570_fbsr_resume(struct nvkm_gsp *gsp)
 }
 
 static int
-r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtime)
+r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size)
 {
 	NV2080_CTRL_INTERNAL_FBSR_INIT_PARAMS *ctrl;
 	struct nvkm_gsp_object memlist;
@@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtim
 	ctrl->hClient = gsp->internal.client.object.handle;
 	ctrl->hSysMem = memlist.handle;
 	ctrl->sysmemAddrOfSuspendResumeData = gsp->sr.meta.addr;
-	ctrl->bEnteringGcoffState = runtime ? 1 : 0;
+	ctrl->bEnteringGcoffState = 1;
 
 	ret = nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 	if (ret)
@@ -92,7 +92,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtim
 }
 
 static int
-r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
+r570_fbsr_suspend(struct nvkm_gsp *gsp)
 {
 	struct nvkm_subdev *subdev = &gsp->subdev;
 	struct nvkm_device *device = subdev->device;
@@ -133,7 +133,7 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
 		return ret;
 
 	/* Initialise FBSR on RM. */
-	ret = r570_fbsr_init(gsp, &gsp->sr.fbsr, size, runtime);
+	ret = r570_fbsr_init(gsp, &gsp->sr.fbsr, size);
 	if (ret) {
 		nvkm_gsp_sg_free(device, &gsp->sr.fbsr);
 		return ret;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
index a9af94adf9efc..0fb0e67406c67 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
@@ -78,7 +78,7 @@ struct nvkm_rm_api {
 	} *device;
 
 	const struct nvkm_rm_api_fbsr {
-		int (*suspend)(struct nvkm_gsp *, bool runtime);
+		int (*suspend)(struct nvkm_gsp *);
 		void (*resume)(struct nvkm_gsp *);
 	} *fbsr;
 
-- 
2.54.0


