Return-Path: <stable+bounces-268683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1vfHMy2PWqi5wgAu9opvQ
	(envelope-from <stable+bounces-268683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 01:16:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7666C91E1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 01:16:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NDV1Pt3e;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268683-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268683-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 158D2304CFD1
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 23:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03772372EE4;
	Thu, 25 Jun 2026 23:16:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2030E84F
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:16:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782429369; cv=none; b=V5BwY3e76qf5UiDqZcmojNr8cMcL5t8F2CzYtjdtBRZKnJMr+Nfmr59lv30obae+JT184JqIZaGlDdof/zp+rgL1tk/kl6xNWUjdw49eV479fyf8NzlvbXXxuaJJb/TC5L+wwBe4E1/ePb5hr6B5AuEULeOY4ER1mFu0ewXxf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782429369; c=relaxed/simple;
	bh=BV5zcaQ8Y5o9Fb6RBkQ1aF90+h1OMXrJ5U+lcv+2SmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRUTH3lgHAbqHhuGkAgZRZe3uuMZIpVGs/EE3VhDjmVqUtPTe3emohBQQVIX7MexK1vqD0vz6zQA+P32G5QasFzOiyvHI7wbTdjNu+8Da/vMXZkEvD2hkjU8IkeHWQOJlGzgYJ3T86RHpX9wWyfy8Qf2RlAeWFxbizWEHoLjGiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDV1Pt3e; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782429367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrCphSM3KhpC5g69iDlAmJJN2Kzxjdu/a38nP3+JCPU=;
	b=NDV1Pt3eyLhQQePmQHrRgI/Ay+XndhHHR9cDR13+Pu00eG8rYr+083iml0W3gpqX3oo9eD
	9QZIfTM9H9c/ZWLoA+PrA7Sx5vC+ID5vy9ZhPjX+mOU5NK3cxuJXOPZvsmZu1XOG9/Xd0+
	LWtGJpMZDEnhxVglcW64AESwl4lzciY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-Fb5Al1OVPRu4zvq2iSnKww-1; Thu,
 25 Jun 2026 19:16:01 -0400
X-MC-Unique: Fb5Al1OVPRu4zvq2iSnKww-1
X-Mimecast-MFC-AGG-ID: Fb5Al1OVPRu4zvq2iSnKww_1782429358
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B40AC1955D99;
	Thu, 25 Jun 2026 23:15:58 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.18])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81B3630A8;
	Thu, 25 Jun 2026 23:15:56 +0000 (UTC)
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
Subject: [PATCH 2/2] drm/nouveau/gsp/r570: Never enter Gcoff state
Date: Thu, 25 Jun 2026 19:10:55 -0400
Message-ID: <20260625231252.89684-3-lyude@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268683-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB7666C91E1

It turns out that the only reason our previous fixes looked like they
worked for this was because we would occasionally set the Gcoff state to 0
in the normal S3 path, which fixed suspend/resume on desktops - but not on
machines using runtime suspend.

The proper fix is to just never set this flag. Our current guess for the
reasoning behind this is that Gcoff likely coincides with GC6, and not
literally power off.

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


