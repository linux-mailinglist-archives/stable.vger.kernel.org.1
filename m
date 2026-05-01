Return-Path: <stable+bounces-242537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHzbLUgi9WlEIwIAu9opvQ
	(envelope-from <stable+bounces-242537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:59:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3409D4AFE49
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A2483028E9C
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA8371898;
	Fri,  1 May 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnRVwRrh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D2EEC3
	for <stable@vger.kernel.org>; Fri,  1 May 2026 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777672754; cv=none; b=kWPGN71dnpFPzoR1upc5xLZg3Do8dtadPTbsryuHobZkP8xhXiNrc94FYl4S3P+AKGx5i1tNEPlN6Bh1xncJ80DghPgeKj5DLnR606DeOtd4X69j5YQeehDjuP45rkXE15sCTze+wmUKBpGn47liPK660QlZWz5y5vPtXnwFpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777672754; c=relaxed/simple;
	bh=m3LN0xXXm9+rBQF5Rrrqlbu8tvLR83mAQ/0wm1msF1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bv72JDxQ93mr/zE8rrj3c/WaSJ/A8/dXKyMWmjpUVyotbP3PSC2qPU5OyvmFQxNykDTw2Na/Mp6+zVwbd0KpxafW8cofooQlQhfcnHHqSalyJ93UTa5ZmTNPNMXTpNRnidWrPP9gONoAWMscMz3YIt5vKy7Lu/cltIQvOMFJxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnRVwRrh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777672751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/w4qNCZg0K61tLxc2dmtZAH4YsoauH0iGhCHk3w+L3w=;
	b=OnRVwRrh07S7bvSORPJikZuRA+EpmTX6om68LBHPypkTecNLAtCegRvoNjzewDo9mrgqgk
	IilmXCiN4R8vvmY0lp1SKzRQ/sNAEem20Jo9hyXpREMOPQK9KAThtws6kH0l4hVY5e236X
	xu7m6zLqUi0FK95piGA+xzi62HJ+1ec=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-EOEI6xEhPveiyKAC_70A7w-1; Fri,
 01 May 2026 17:59:07 -0400
X-MC-Unique: EOEI6xEhPveiyKAC_70A7w-1
X-Mimecast-MFC-AGG-ID: EOEI6xEhPveiyKAC_70A7w_1777672745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6533D1800473;
	Fri,  1 May 2026 21:59:04 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D382130001A1;
	Fri,  1 May 2026 21:59:01 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	James Jones <jajones@nvidia.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	stable@vger.kernel.org,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Ben Skeggs" <bskeggs@nvidia.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH] drm/nouveau/kms/nvd9-: Use contiguous memory for CRC notifier context
Date: Fri,  1 May 2026 17:58:55 -0400
Message-ID: <20260501215856.840898-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 3409D4AFE49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,nvidia.com,intel.com,collabora.com,vger.kernel.org,linux.intel.com,ffwll.ch,suse.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242537-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,nvidia.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

It looks like CRC read back has been slightly broken for a while now, in
particular on GPUs using GSP. On my test machines, it's worked normally
when attempting to use it from fbcon. After gnome-shell gets started
however, attempting to read /sys/kernel/debug/dri/$CARD/$CRTC/crc/data just
returns -EINVAL.

It turns out what's been happening is that since we've been using
nvif_mem_ctor_map() to both allocate and map the CRC notifier region - we
haven't actually asked for a contiguous allocation, and simply ask for
whatever type of memory allocation nouveau can find first. This doesn't
work because the CRC engine on nvidia GPUs doesn't support non-contiguous
allocations, which also causes us to fail setting up the kmsCrcNtfyCtxDma
object on pre-blackwell platforms since we don't have a single memory
address we can point nvif_object_ctor() to. Instead, ctx->mem.addr gets set
to ~0ULL.

It does however, seem to work when fbcon is running. The only reason I can
think of this is that before we start up a display environment, there is
pretty much nothing allocated in our VRAM that wasn't allocated by nouveau
itself - making it dramatically more likely that we end up finding a
contiguous allocation by default.

So, fix this by manually requesting a contiguous allocation when we
allocate our context notifiers.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 12885ecbfe62 ("drm/nouveau/kms/nvd9-: Add CRC support")
Cc: Lyude Paul <lyude@redhat.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: James Jones <jajones@nvidia.com>
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.9+
---
 drivers/gpu/drm/nouveau/dispnv50/crc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
index deb6af40ef328..5817f39934a8b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
@@ -10,6 +10,7 @@
 #include <nvif/class.h>
 #include <nvif/cl0002.h>
 #include <nvif/timer.h>
+#include <nvif/if900b.h>
 
 #include <nvhw/class/cl907d.h>
 
@@ -499,16 +500,24 @@ nv50_crc_raster_type(enum nv50_crc_source source)
  * notifier needs it's own handle
  */
 static inline int
-nv50_crc_ctx_init(struct nv50_head *head, struct nvif_mmu *mmu,
+nv50_crc_ctx_init(struct drm_device *dev, struct nv50_head *head, struct nvif_mmu *mmu,
 		  struct nv50_crc_notifier_ctx *ctx, size_t len, int idx)
 {
-	struct nv50_core *core = nv50_disp(head->base.base.dev)->core;
+	struct nv50_core *core = nv50_disp(dev)->core;
 	int ret;
 
-	ret = nvif_mem_ctor_map(mmu, "kmsCrcNtfy", NVIF_MEM_VRAM, len, &ctx->mem);
+	/* The display engine requires a contiguous region of memory for the CRC notifier context */
+	ret = nvif_mem_ctor(mmu, "kmsCrcNtfy", mmu->mem, NVIF_MEM_VRAM | NVIF_MEM_MAPPABLE, 0, len,
+			    &(struct gf100_mem_v0) {
+				.contig = true,
+			    }, sizeof(struct gf100_mem_v0), &ctx->mem);
 	if (ret)
 		return ret;
 
+	ret = nvif_object_map(&ctx->mem.object, NULL, 0);
+	if (ret)
+		goto fail_fini;
+
 	/* No CTXDMAs on Blackwell. */
 	if (core->chan.base.user.oclass >= GB202_DISP_CORE_CHANNEL_DMA)
 		return 0;
@@ -576,7 +585,7 @@ int nv50_crc_set_source(struct drm_crtc *crtc, const char *source_str)
 
 	if (source) {
 		for (i = 0; i < ARRAY_SIZE(head->crc.ctx); i++) {
-			ret = nv50_crc_ctx_init(head, mmu, &crc->ctx[i],
+			ret = nv50_crc_ctx_init(dev, head, mmu, &crc->ctx[i],
 						func->notifier_len, i);
 			if (ret)
 				goto out_ctx_fini;

base-commit: 29d6da40d0b8bf3bbc3dcd1d2198434a0e1f71b0
-- 
2.54.0


