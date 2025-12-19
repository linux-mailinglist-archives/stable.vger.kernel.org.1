Return-Path: <stable+bounces-203118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3126ECD210E
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 22:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B4423063422
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092622EF65C;
	Fri, 19 Dec 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcANGnv4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B32D837B
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181239; cv=none; b=HMjHH4P8+EyN9hTlSYLUXipjJ4AuuzwH1KA75W4XLBuIoqkTernPCJhyuOAz4dR8f2XWpI9nfrW4DMH0Yk849vUD2NtQs+MPpqDdPdgTi0C/v9TU4PLWPM/e/4xUuuMOdmZ/IsODY3Ii5JKC2YJZZlaHlvz3e6jHkQ+eziC4v0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181239; c=relaxed/simple;
	bh=zHHV/SBHViEmW+aXytGNRmUvK/Izxv4tzbqOR8GsqLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puZhvzqWFPtwjs8Nkk3OamlE5xDf/PPrgd+YDvOwascMscroR+z7Op2DApVXyQgZCh9ARaa2ZGWOBFUH87ujvpqRxOqAVuZhCpEgLw8ya5IZJ3fY86fXU7/JLP600gV7KKiPdRLdT6Y9A6I6moTatBYFCjTt7hDbtJ4yCZbAMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcANGnv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766181237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkXEdzkbRQECKf+aADUpL9UrjM7M5Y0Z71t+7qrFeC4=;
	b=HcANGnv4JK6N2WTz+bO9xOy3LL7A+azm/UEXe+q0zWM/Xn/VBlVdtFxrLwRlo3Nd9VwIQ3
	MHP/BokNK5PgT+GSWuY3asiotyEATakaCOqJHj3tIc3xsh5+92WzEFp1RKC+8T4pI/fdwQ
	Qa3fcAmrtef7HmEjbxnxINSyiYLi4uo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-LGR_lSpcPTmR4GwMKFkHxA-1; Fri,
 19 Dec 2025 16:53:53 -0500
X-MC-Unique: LGR_lSpcPTmR4GwMKFkHxA-1
X-Mimecast-MFC-AGG-ID: LGR_lSpcPTmR4GwMKFkHxA_1766181232
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D72D21956094;
	Fri, 19 Dec 2025 21:53:51 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.166])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B027730001A2;
	Fri, 19 Dec 2025 21:53:49 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	"Timur Tabi" <ttabi@nvidia.com>,
	"Dave Airlie" <airlied@redhat.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Ben Skeggs" <bskeggs@nvidia.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Ben Skeggs" <bskeggs@redhat.com>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 1/2] drm/nouveau/disp/nv50-: Set lock_core in curs507a_prepare
Date: Fri, 19 Dec 2025 16:52:02 -0500
Message-ID: <20251219215344.170852-2-lyude@redhat.com>
In-Reply-To: <20251219215344.170852-1-lyude@redhat.com>
References: <20251219215344.170852-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

For a while, I've been seeing a strange issue where some (usually not all)
of the display DMA channels will suddenly hang, particularly when there is
a visible cursor on the screen that is being frequently updated, and
especially when said cursor happens to go between two screens. While this
brings back lovely memories of fixing Intel Skylake bugs, I would quite
like to fix it :).

It turns out the problem that's happening here is that we're managing to
reach nv50_head_flush_set() in our atomic commit path without actually
holding nv50_disp->mutex. This means that cursor updates happening in
parallel (along with any other atomic updates that need to use the core
channel) will race with eachother, which eventually causes us to corrupt
the pushbuffer - leading to a plethora of various GSP errors, usually:

  nouveau 0000:c1:00.0: gsp: Xid:56 CMDre 00000000 00000218 00102680 00000004 00800003
  nouveau 0000:c1:00.0: gsp: Xid:56 CMDre 00000000 0000021c 00040509 00000004 00000001
  nouveau 0000:c1:00.0: gsp: Xid:56 CMDre 00000000 00000000 00000000 00000001 00000001

The reason this is happening is because generally we check whether we need
to set nv50_atom->lock_core at the end of nv50_head_atomic_check().
However, curs507a_prepare is called from the fb_prepare callback, which
happens after the atomic check phase. As a result, this can lead to commits
that both touch the core channel but also don't grab nv50_disp->mutex.

So, fix this by making sure that we set nv50_atom->lock_core in
cus507a_prepare().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 1590700d94ac ("drm/nouveau/kms/nv50-: split each resource type into their own source files")
Cc: <stable@vger.kernel.org> # v4.18+
---
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/curs507a.c b/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
index a95ee5dcc2e39..1a889139cb053 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
@@ -84,6 +84,7 @@ curs507a_prepare(struct nv50_wndw *wndw, struct nv50_head_atom *asyh,
 		asyh->curs.handle = handle;
 		asyh->curs.offset = offset;
 		asyh->set.curs = asyh->curs.visible;
+		nv50_atom(asyh->state.state)->lock_core = true;
 	}
 }
 
-- 
2.52.0


