Return-Path: <stable+bounces-211151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHDkBQ83cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:29:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B045D3AB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D90749101B3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BC23C00BB;
	Wed, 21 Jan 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAX4KqGY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E439E6E4
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022817; cv=none; b=snzll7BKXaX/BR2hmIP9fAEj88GfhU+R8FER2rOJxO3O32NoLKa5eyBpwriafp65FsXw7bAnyTJPCCZ5CtsQ14y7/hRu5QjpPxhgfjQivuYy0uw6NiVINi91mHxVFPzjbvohoP3S/JBZldBMHll48fwE7rxcU8uY8tcDzSBKyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022817; c=relaxed/simple;
	bh=7gMI1TsP9spLwC9HiR3XTx+iLr7v/aUUSQU73Af3yWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShIfwVi55tH9c1jL4T8fVLplcIdAAE8s6qrIm2v7IGWGswSNleHhCZOXfatAkpGqfKPGfsw3Gyy+bP7gbH9TAQfWL1KgyPyoxSqsvlYSOBrPg7xm231WufBxaGbDDUQ2Pk3U9uj54ZymR7LXIl7y/IiKTOy9YQ34ll+Cy4zosYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAX4KqGY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769022814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=49OPiVw3AsdRRD7f8ruuY3VOWZX2Ei/vee0/0X9WHUQ=;
	b=SAX4KqGYI44wZojv63dTBsJfumTp/Pou/Ct5oszqCJIHjv6VoAjpgSl9bFSDF0toTV9/og
	XusaHXj45Ycms1eECz6SaXY7diTuxnseOCDSEZYGgfhokIx0xJzYs+E5xrp/xhTvkAOZP8
	QBR9SbYBS9GVYUdzR7NB8lR9TumE6Xk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-mD4iWvf3PWi6QrpwgzgEdQ-1; Wed,
 21 Jan 2026 14:13:26 -0500
X-MC-Unique: mD4iWvf3PWi6QrpwgzgEdQ-1
X-Mimecast-MFC-AGG-ID: mD4iWvf3PWi6QrpwgzgEdQ_1769022805
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A85FC1800451;
	Wed, 21 Jan 2026 19:13:24 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.89.232])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A32CE19560AB;
	Wed, 21 Jan 2026 19:13:22 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH] drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)
Date: Wed, 21 Jan 2026 14:13:10 -0500
Message-ID: <20260121191320.210342-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-211151-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,ffwll.ch,gmail.com,suse.de,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 79B045D3AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apparently we never actually filled these in, despite the fact that we do
in fact technically support atomic modesetting.

Since not having these filled in causes us to potentially forget to disable
fbdev and friends during suspend/resume, let's fix it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 00515623a2cc7..829c2b573971c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -352,6 +352,8 @@ nouveau_user_framebuffer_create(struct drm_device *dev,
 
 static const struct drm_mode_config_funcs nouveau_mode_config_funcs = {
 	.fb_create = nouveau_user_framebuffer_create,
+	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_check = drm_atomic_helper_check,
 };
 
 

base-commit: 68b271a3a94cfd6c7695a96b6398b52feb89e2c2
-- 
2.52.0


