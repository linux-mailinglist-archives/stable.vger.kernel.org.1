Return-Path: <stable+bounces-269838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ls+JN3r1Qmq4KAoAu9opvQ
	(envelope-from <stable+bounces-269838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 00:45:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E639B6DF157
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 00:45:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hFU2biuK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269838-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269838-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1130D300B82A
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DC73CC7CD;
	Mon, 29 Jun 2026 22:44:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F803CB8E5
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 22:44:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773091; cv=none; b=RLCMa5APQzowsxRakNyqiRjAwOx3yt8uRwOtroDLzRIYjbw9YYmDgf8iYi0sTpzzeKiBF8S9I2J0ZbIhhdWVJvDo0L/tvH5t2iHDYkFq4qZSCxGEgrqGI2ZsF8mfv0GTqxox3VLmzbNIQGaAvUXzSb49ZvarrTsDxDBY3XG7KAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773091; c=relaxed/simple;
	bh=N5x0Nh75cu4+IqDps8Kdjw8TIB2SiJNdPgwgNbOpBMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKVdqlks4L2rPIPfC6c+d+iqYYjOfI3PO6smNP0ixfC/KN4AXRkWYlzNyLRFRqHLZdfkFmtM37Wi+D2/3msGhlKxwwdW8tCnZHAMG5wiWkPEm6kLz0IG8bPF64FO287voyGQvOERAJ5n3r3fbHx4mMXPOVRmgf9bFv6UlwFSn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFU2biuK; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782773089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkXT6NSCsXj0i3X2uHiUABcB9Jzld6noTRsAXR1p7vA=;
	b=hFU2biuKohmaXzpsFv+yJ1GP+DDXmXPJIXw7RgXrj9hqyw3zrhK10aFuYUzAgFmwj9jBe9
	a3adqIqYSqlrOjJmYFN9pLedo4QfZJXPnai/A5JqxtWL3aknS02u0yD24Bw28mbUIFOG6K
	7GSg7aR7ri/ek5x2QtoQtSt/HuWBd34=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-oTPzkahzMjK9kh3AL_vaSQ-1; Mon,
 29 Jun 2026 18:44:43 -0400
X-MC-Unique: oTPzkahzMjK9kh3AL_vaSQ-1
X-Mimecast-MFC-AGG-ID: oTPzkahzMjK9kh3AL_vaSQ_1782773081
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FC39180AD57;
	Mon, 29 Jun 2026 22:44:41 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.59])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 297B53691D;
	Mon, 29 Jun 2026 22:44:39 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	"Timur Tabi" <ttabi@nvidia.com>,
	"Dave Airlie" <airlied@redhat.com>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Ben Skeggs" <bskeggs@nvidia.com>,
	"Kees Cook" <kees@kernel.org>,
	"Simona Vetter" <simona@ffwll.ch>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Mel Henning" <mhenning@darkrefraction.com>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 3/4] drm/nouveau/gsp/r570: Set oldLevel correctly in GSP resume arguments
Date: Mon, 29 Jun 2026 18:42:35 -0400
Message-ID: <20260629224350.2870201-4-lyude@redhat.com>
In-Reply-To: <20260629224350.2870201-1-lyude@redhat.com>
References: <20260629224350.2870201-1-lyude@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com,suse.de,darkrefraction.com];
	TAGGED_FROM(0.00)[bounces-269838-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nouveau@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ttabi@nvidia.com,m:airlied@redhat.com,m:andriy.shevchenko@linux.intel.com,m:maarten.lankhorst@linux.intel.com,m:bskeggs@nvidia.com,m:kees@kernel.org,m:simona@ffwll.ch,m:airlied@gmail.com,m:tzimmermann@suse.de,m:mripard@kernel.org,m:mhenning@darkrefraction.com,m:dakr@kernel.org,m:lyude@redhat.com,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E639B6DF157

The way that OpenRM handles this is a bit funky. By default, OpenRM passes
through NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3 as the supposed power
level that the GPU is entering. This is misleading though - because as far
as I can tell, that argument is never actually provided to GSP and appears
to be used mostly for internal state tracking by the driver.

What actually happens, is that on resume - OpenRM tells GSP that it's
resuming the GPU from LEVEL_4.

This is one part of getting runtime PM to be genuinely reliable with GSP
firmware.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c      | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index 996941c668ba9..00158697bd77a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -197,7 +197,7 @@ r570_gsp_set_rmargs(struct nvkm_gsp *gsp, bool resume)
 		args->srInitArguments.flags = 0;
 		args->srInitArguments.bInPMTransition = 0;
 	} else {
-		args->srInitArguments.oldLevel = NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3;
+		args->srInitArguments.oldLevel = NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_4;
 		args->srInitArguments.flags = 0;
 		args->srInitArguments.bInPMTransition = 1;
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
index b6075021e74f5..1904305b69624 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
@@ -521,7 +521,7 @@ typedef struct
     } profilerArgs;
 } GSP_ARGUMENTS_CACHED;
 
-#define NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3            (0x00000003U)
+#define NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_4            (0x00000004U)
 
 typedef struct
 {
-- 
2.54.0


