Return-Path: <stable+bounces-270232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bG+mJIdcRWrV+woAu9opvQ
	(envelope-from <stable+bounces-270232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 20:29:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D56F096C
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 20:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eSYDrO+8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270232-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270232-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 619993058123
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8EC4C9016;
	Wed,  1 Jul 2026 18:29:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABC4C9002
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 18:29:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930563; cv=none; b=ggfECzg2OVBnfQvwz4IuFyd0e+71sUAmDXxPz1qRkp0o8MDcTgGBOxNyXeFaChQsIolgupy5aaOoRBuz8Br9Dy+XuHyZzcexS2dVilQ0pB3DlR8nm9c2Z5gNnbcNXC2vEcfPXEkh7LRug2sQF4w72WEdCEyjXxUW/wZlHcxyXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930563; c=relaxed/simple;
	bh=Nm2GRIFNEPuy5W/WAA190Aa6/Zqx1BulE8MsgAATRXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8Daz+hyRYpeOU5ROAOpygYvg+dyMTLFtd7OVt0j32x56gnRxPLur6u0Og4qpPJGUi7t9sfSx4knru5o/agAdGlApHbkVk5s5E1fU0bxDABFGdM+8JmSse71T4WN2xY0UFKBgS7xFMTw3KPks0/HQAjBwgjGk4BD+BnE3OPO6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSYDrO+8; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782930561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zw+yxHJkPLDJzuuhT36OrRKDnTGX+7WWEu0wvYE6r6k=;
	b=eSYDrO+8Cj9Yke/30bJI1QBypJ7IBnhh2lWR8mLqbnFxk5pBpVV9yt8euXF1TsFBziYMUB
	HgpGP5iSTDibLZ0AozQPI138qSfPGG45LLvIMNuItjZDrTOYAYdnS3urFOyGU67Nd9ZesW
	4Yfd7ZoQ/VMko51p2Ljgd7tELezrG6E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-hvADoyWyOhqU9c3AUPJFbg-1; Wed,
 01 Jul 2026 14:29:18 -0400
X-MC-Unique: hvADoyWyOhqU9c3AUPJFbg-1
X-Mimecast-MFC-AGG-ID: hvADoyWyOhqU9c3AUPJFbg_1782930555
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AD7C1933EAE;
	Wed,  1 Jul 2026 18:29:15 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.89.127])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8AE21800599;
	Wed,  1 Jul 2026 18:29:12 +0000 (UTC)
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
Subject: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
Date: Wed,  1 Jul 2026 14:17:34 -0400
Message-ID: <20260701182857.190713-3-lyude@redhat.com>
In-Reply-To: <20260701182857.190713-1-lyude@redhat.com>
References: <20260701182857.190713-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270232-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com,suse.de,darkrefraction.com];
	FORGED_SENDER(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:nouveau@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ttabi@nvidia.com,m:airlied@redhat.com,m:andriy.shevchenko@linux.intel.com,m:maarten.lankhorst@linux.intel.com,m:bskeggs@nvidia.com,m:kees@kernel.org,m:simona@ffwll.ch,m:airlied@gmail.com,m:tzimmermann@suse.de,m:mripard@kernel.org,m:mhenning@darkrefraction.com,m:dakr@kernel.org,m:lyude@redhat.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A6D56F096C

It turns out that the only reason our previous fixes looked like they
worked for this was because we would occasionally set the Gcoff state to 0
in the normal S3 path, which fixed suspend/resume on desktops - but not on
machines using runtime suspend.

The proper fix is to just never set this flag. Our current guess for the
reasoning behind this is that Gcoff likely coincides with GC6, and not
literally power off.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
index 2945d5b4e5707..af5aa5065c3dd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
@@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size)
 	ctrl->hClient = gsp->internal.client.object.handle;
 	ctrl->hSysMem = memlist.handle;
 	ctrl->sysmemAddrOfSuspendResumeData = gsp->sr.meta.addr;
-	ctrl->bEnteringGcoffState = 1;
+	ctrl->bEnteringGcoffState = 0;
 
 	ret = nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 	if (ret)
-- 
2.54.0


