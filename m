Return-Path: <stable+bounces-203358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E55CDBB53
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9761301D5A4
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560030F805;
	Wed, 24 Dec 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N3XSXeci"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688871A00F0
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566630; cv=none; b=qd5D2DFv3OdWu11Igg7jxD489elOIwS3bDcucMmXDDbenMhmLZ4GnbpvfCzYyjkiK7eCfNsC865BKfMuvNA3y7nNrecoyyIi91SlQ1uMlBSz1+9opT0PqI0/qBzLez/o96pliHI/4tGn/eyBNUIYeD0UJ1jJDRuolFwNTn+MokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566630; c=relaxed/simple;
	bh=eBjQ0IUA9s919dbAoDwhWCvJJuKBm8IKcD5ysjybSgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KIziTRT5ctTX7s2H1r9vil4wFsaqs1wE1ggcoOtVQpygh3YOdawSBa/2HptfH9GwRobv0OrxmCwE3kGF7I0Tp8ZW39pXJVJEqheHwQ73vIae7ZMKYoun66haEdyds8DTLey5HtiLA8iwpbZ92I32xG3nuv5dJAxJKfLErVg7o5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N3XSXeci; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-94121102a54so3565568241.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 00:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766566627; x=1767171427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VerAfBullZiHp/WWvzSGqbTxnUFTnHi0CQ8Rn/jBT1o=;
        b=WHFf2fodapTaHYVG1rsiRiYzus24izsQfAcIO4cb8mPKltujmWAgFICMzn975fj1zF
         FZ8vmYl7NjT6qtok+0zeG3TxHzjirZ+0mMqp//YNf4XZamQZ1iVzvYExaofY6bKpeEoS
         OCK3TIAIUF3dhc5FrbUfjfBvRVmlA/CkGJCzBEJPdfRtb2aWrbvF9fY+3oYpXy8EW7jJ
         7HobgaJAEHAK0ykX1MnOphcSkvASzm1HVfh7geWBYk0PRF54U0shUneMS8NDjRBimuRP
         9YF4ELD0+N1ud5S7VGMjsuHQnlO7CTzveSvQ9PmewwoWcPaw1V9rG0/77bzifckGM740
         qf5A==
X-Gm-Message-State: AOJu0YzNAEI/KJBaXHvBFxGDt2aw9rhUey9rOsZcE/QyYJI0EO45z0de
	1/8+gsHvYTK5UUINzoXjMWrz2OigdLZQM0xVi926VpwI5bzMkvV16yPCOM9j1MsILXPAQtQxQO/
	QjDT8vQSFp27Dwnsctzf8+28GXmL8CSpQTDIjqXz8f7O1RV4EACixlz7SJE+pVDMCkuC/DAXf+0
	dXRJY5hrw+JX8odU5vwprg9pRBIo0EIfRVdCUEU7cWBKCQCHICc1MAJ7GTGMbQQ0A0Zk87c7YKH
	ErMMuaIdoxGpu73mw==
X-Gm-Gg: AY/fxX46vspGCnLhpfk6xlDgj/y0Z+JfVCElCWjnS8Fh+bvVoQKi0Uc5ZRJ8lXqBx0h
	9tIfIIf0CxfiaevTk0ZGvZOthCfpaWjoXYMWX9N1g/eWfvaNG9f5sYA3tyKQ/k7oqikTAvuoz2r
	UsciGJr2M4nXaDuCWZzRfLlU3nuozlMUtE3uMZBBzwlClzdo+O6W34GK/cHvWNlXcRaodqWI3zp
	rlWQ9IA3vDSy3T2YrBuebZAE1DjZRFFIjJVvg7APlPeA6q2k8wYcrgTK+XbRqfXivqIDDDnhmka
	4wkJb0m8vCYe+Yxl0isMlrz23yjuo+R3Nx7ahfTg9VW+bZWEC9Um7JdTwGPgdgjH9tzZj1YMwhM
	fTMLShMGzWP+pyESlFH2wi/XhQHmGV2kSyAiApttISm7m9hhr5qaCOv3XEImwiZFwwGTQrPKWfq
	HGVi0GABzvFZUjXXvASSz4v/+4abrRYeqpZ4vwvJopVrCjog==
X-Google-Smtp-Source: AGHT+IFRLkwE2GjJmOWZlvFVfJUfCclgI5QVGrKFipkrj8JM04z7O3aAmcpLffr1lbRMSM3XBY3XLXgbi6Ez
X-Received: by 2002:a05:6102:e0e:b0:5dd:87d8:b4d0 with SMTP id ada2fe7eead31-5eb1a8275camr6053299137.36.1766566627228;
        Wed, 24 Dec 2025 00:57:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5eb1ac7de89sm2408455137.5.2025.12.24.00.57.06
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Dec 2025 00:57:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso5736022a12.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 00:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766566625; x=1767171425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VerAfBullZiHp/WWvzSGqbTxnUFTnHi0CQ8Rn/jBT1o=;
        b=N3XSXecihR7J9ScQSHqF45ZWrwq+8ftAYHBD2g4tfugScamxdBI92I8DPG6isq2PwI
         bg1qGkh6qHAMQ/K4bk1ISdnwLfpMUwxoq7lNdDiQVo8qxW3LNAPr94x6I7QBc+4thP11
         h7kZCwJ4oa0drOow11Axm5vWgN9Wbb+1c1qSU=
X-Received: by 2002:a05:693c:809a:b0:2b0:5609:a593 with SMTP id 5a478bee46e88-2b05ebd0cd4mr16134871eec.16.1766566625510;
        Wed, 24 Dec 2025 00:57:05 -0800 (PST)
X-Received: by 2002:a05:693c:809a:b0:2b0:5609:a593 with SMTP id 5a478bee46e88-2b05ebd0cd4mr16134846eec.16.1766566624413;
        Wed, 24 Dec 2025 00:57:04 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b06a046e99sm43516490eec.6.2025.12.24.00.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 00:57:04 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	airlied@gmail.com,
	brianp@vmware.com,
	dtor@vmware.com,
	airlied@redhat.com,
	thellstrom@vmware.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuzey Arda Bulut <kuzeyardabulut@gmail.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10-v6.1] drm/vmwgfx: Fix a null-ptr access in the cursor snooper
Date: Wed, 24 Dec 2025 00:36:52 -0800
Message-Id: <20251224083652.614902-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Zack Rusin <zack.rusin@broadcom.com>

[ Upstream commit 5ac2c0279053a2c5265d46903432fb26ae2d0da2 ]

Check that the resource which is converted to a surface exists before
trying to use the cursor snooper on it.

vmw_cmd_res_check allows explicit invalid (SVGA3D_INVALID_ID) identifiers
because some svga commands accept SVGA3D_INVALID_ID to mean "no surface",
unfortunately functions that accept the actual surfaces as objects might
(and in case of the cursor snooper, do not) be able to handle null
objects. Make sure that we validate not only the identifier (via the
vmw_cmd_res_check) but also check that the actual resource exists before
trying to do something with it.

Fixes unchecked null-ptr reference in the snooping code.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: c0951b797e7d ("drm/vmwgfx: Refactor resource management")
Reported-by: Kuzey Arda Bulut <kuzeyardabulut@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>
Link: https://lore.kernel.org/r/20250917153655.1968583-1-zack.rusin@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v5.10.y-v6.1.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 0d12d6af6..5d3827b5d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1507,6 +1507,7 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 		       SVGA3dCmdHeader *header)
 {
 	struct vmw_buffer_object *vmw_bo = NULL;
+	struct vmw_resource *res;
 	struct vmw_surface *srf = NULL;
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdSurfaceDMA);
 	int ret;
@@ -1542,18 +1543,24 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 
 	dirty = (cmd->body.transfer == SVGA3D_WRITE_HOST_VRAM) ?
 		VMW_RES_DIRTY_SET : 0;
-	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
-				dirty, user_surface_converter,
-				&cmd->body.host.sid, NULL);
+	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface, dirty,
+				user_surface_converter, &cmd->body.host.sid,
+				NULL);
 	if (unlikely(ret != 0)) {
 		if (unlikely(ret != -ERESTARTSYS))
 			VMW_DEBUG_USER("could not find surface for DMA.\n");
 		return ret;
 	}
 
-	srf = vmw_res_to_srf(sw_context->res_cache[vmw_res_surface].res);
+	res = sw_context->res_cache[vmw_res_surface].res;
+	if (!res) {
+		VMW_DEBUG_USER("Invalid DMA surface.\n");
+		return -EINVAL;
+	}
 
-	vmw_kms_cursor_snoop(srf, sw_context->fp->tfile, &vmw_bo->base, header);
+	srf = vmw_res_to_srf(res);
+	vmw_kms_cursor_snoop(srf, sw_context->fp->tfile, &vmw_bo->base,
+			     header);
 
 	return 0;
 }
-- 
2.40.4


