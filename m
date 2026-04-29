Return-Path: <stable+bounces-241805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLZkO1F28WkxhAEAu9opvQ
	(envelope-from <stable+bounces-241805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 05:09:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0948E8FA
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 05:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76C83060D5C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 03:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0F308F15;
	Wed, 29 Apr 2026 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpqfvgQm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B92DC32A
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777431871; cv=none; b=hF82b8AWPGCbK6DYqa7bFnXPTGMjOzbT8mM1ed/Jlm3sLLGViZjERySfTLVuQEz1jmRVC4+XmO86OIZgUkodUkS+H0vNAMy+W3hg39T083YuE/MJw1SgDOJ+lvrFIhVQ0UwcXTIiKguuFX8tz26e8SN+Wbo5w+oeUOGoz7xsNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777431871; c=relaxed/simple;
	bh=Q12eOtvJ+6xl4ZwrDqguILZTLzchiUz9odVa22G/aS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8gPfVYaU7+kAGkvReek73ykHmq2xEfdJRemGJaLMqWtzeFq873/ZsiRN0W+USyeVp3VwD70Ewbx6iSgxAsoQD84K50K7pXjX/2WxB5Nl7jZTad/JBqZPlx9Xcx2D86FM8/WFCQXcEmSI29qPoRitC7lmyL4JUC3X27jcX3apAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpqfvgQm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777431868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ldwwJIVF7m6VyRD35VYHAOudLjUCD6MJS07MQJZaKIw=;
	b=HpqfvgQmqP4AywWyT/GJiFzuCQQS3Zj9UwmJLludBrKUOFZudlEcxjthjaCb/W/adZHYYQ
	L6PFWu9sixQQD6InD1ATgQEIZYeLlGtr+Q0eZRqdHqpfNPOlmVH1G8k0Pql9/fnUBhn985
	mZEbu+bo7069uy3Asi87GjpabSHTipw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-OmYw-u2QM62O1aSfJHEcfQ-1; Tue,
 28 Apr 2026 23:04:24 -0400
X-MC-Unique: OmYw-u2QM62O1aSfJHEcfQ-1
X-Mimecast-MFC-AGG-ID: OmYw-u2QM62O1aSfJHEcfQ_1777431862
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94521195609F;
	Wed, 29 Apr 2026 03:04:21 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0B31180047F;
	Wed, 29 Apr 2026 03:04:17 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Ben Skeggs <bskeggs@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	James Jones <jajones@nvidia.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Zhang Enpei <zhang.enpei@zte.com.cn>,
	stable@vger.kernel.org,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Kees Cook" <kees@kernel.org>,
	"Simona Vetter" <simona@ffwll.ch>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH] drm/nouveau/disp/r535: Add scanline position support + head state support
Date: Tue, 28 Apr 2026 23:03:40 -0400
Message-ID: <20260429030348.3930866-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 73E0948E8FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,collabora.com,intel.com,gmail.com,kernel.org,zte.com.cn,vger.kernel.org,linux.intel.com,ffwll.ch,suse.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241805-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,zte.com.cn:email]

That's right! It looks like this never actually got finished, something
which I just noticed today when I saw this fun message spamming one of my
test machine's kernel logs when enabling display debug output for nouveau:

  [drm:drm_crtc_vblank_helper_get_vblank_timestamp_internal] crtc 0 : scanoutpos query failed.

So it looks like we've been falling back to DRM's core fallback for a while
now, whoops.

So, while it seems that we do have the option of doing this through GSP -
that doesn't seem like a great idea. Mainly because reading this from GSP
would involve a lot more latency then we should have for vblank handling
due to the RPC communication. So instead of implementing that, just use
gv100_head_state and gv100_head_rgpos for implementing .state and .rgpos.
It seems to work perfectly fine!

Fixes: 9e9944449023 ("drm/nouveau/disp/r535: initial support")
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Ben Skeggs <bskeggs@nvidia.com>
Cc: James Jones <jajones@nvidia.com>
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Aaron Kling <webgeek1234@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Zhang Enpei <zhang.enpei@zte.com.cn>
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c       | 4 ++--
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h        | 2 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 8 ++------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
index dbd984da75014..0608266188d3e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
@@ -253,7 +253,7 @@ gv100_head_vblank_get(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000004, 0x00000004);
 }
 
-static void
+void
 gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
 {
 	struct nvkm_device *device = head->disp->engine.subdev.device;
@@ -263,7 +263,7 @@ gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
 	*hline = nvkm_rd32(device, 0x616334 + hoff) & 0x0000ffff;
 }
 
-static void
+void
 gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
 {
 	struct nvkm_device *device = head->disp->engine.subdev.device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index 856252bf559a4..b642729c254fe 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@ -53,6 +53,8 @@ void gf119_head_rgclk(struct nvkm_head *, int);
 
 int gv100_head_cnt(struct nvkm_disp *, unsigned long *);
 int gv100_head_new(struct nvkm_disp *, int id);
+void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state);
+void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 
 #define HEAD_MSG(h,l,f,a...) do {                                              \
 	struct nvkm_head *_h = (h);                                            \
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 6e63df816d855..49a1eef9bdf14 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -625,14 +625,10 @@ r535_head_vblank_get(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
 }
 
-static void
-r535_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
-{
-}
-
 static const struct nvkm_head_func
 r535_head = {
-	.state = r535_head_state,
+	.state = gv100_head_state,
+	.rgpos = gv100_head_rgpos,
 	.vblank_get = r535_head_vblank_get,
 	.vblank_put = r535_head_vblank_put,
 };

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0


