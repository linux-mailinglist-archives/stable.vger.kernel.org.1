Return-Path: <stable+bounces-159289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F985AF6EAA
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 11:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549BA1BC686B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68852D77F7;
	Thu,  3 Jul 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f75RPnYM"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0652AEFE;
	Thu,  3 Jul 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534953; cv=none; b=VqfWXMBOkZu0f2HYrOt2glD9W3yBAFGhcndbuAN+gH2DTaDy6QS3Nq/m2eP5t1NAJ9i5AShZXbfsc1KTCtbgj5TvS3/q1ftjb+mAkutGvV8qD5lq5S1KbnIPyl59wFtVZCcWlXqQywyEYww9yZUA3vP+8leCvzm0/0LruCW2c9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534953; c=relaxed/simple;
	bh=sSsdxWedyMHYMHmezgH2iiuFS2k6wOwmTzvWLPYO6hA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XSYPw0XYUA5XszmZabdYJI0CoUhOwMzHE/e3Xl9J49kAb9dQ9zqM1QCNrGLcqWGvD9U5wUee8FjOef9BmXdthxJpihGkhf1k/hnz4rpuEpVwV0kRAIeev1uMvyX56k9zwAUei5+d9P4VY+JkMortYry17Zyb0sSn/Hda0MJtaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f75RPnYM; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+g
	tBkV5sxWzTmS5t97Hf7Y/6Sg1riYapDeZfBHBup0Y=; b=f75RPnYMSwlRbPD9re
	yKj+tWmMMGAjPm27+UYtnZbF8y2zMEmGfZDa342nm8aqUmKM33kWmgfdkqNh7twA
	ycW2Tqbc/MY+QR/mdqGVdL0RpN5rc/qyga5+X6gvH3woqj4BNL/RiVLwOHI0dvgy
	SES2W6YheEYVGDYTSqOvD8siI=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCnLF41TWZoBEn+CA--.4429S4;
	Thu, 03 Jul 2025 17:28:22 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm: Fix potential null pointer dereference issues in drm_managed.c
Date: Thu,  3 Jul 2025 17:28:19 +0800
Message-Id: <20250703092819.2535786-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnLF41TWZoBEn+CA--.4429S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrKrW5ur18KFWUWF1fCrg_yoWDtrg_Ca
	18Xrn3Wr4kCF95GF4qyw13ZryIka1DCF4vvF47tasayry5Jrn2q34UZr45JryDWF1xuF9r
	u3WDAryfArsrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN2-eUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkAR-bmhmTAAm7wAAsO

Add check for the return value of kstrdup_const() in drm_managed.c
to prevent potential null pointer dereference.

Fixes: c6603c740e0e ("drm: add managed resources tied to drm_device")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/drm_managed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index cc4c463daae7..368763d4c24e 100644
--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -151,6 +151,11 @@ int __drmm_add_action(struct drm_device *dev,
 	}
 
 	dr->node.name = kstrdup_const(name, GFP_KERNEL);
+	if (!dr->node.name) {
+		kfree(dr);
+		return -ENOMEM;
+	}
+
 	if (data) {
 		void_ptr = (void **)&dr->data;
 		*void_ptr = data;
@@ -236,6 +241,10 @@ void *drmm_kmalloc(struct drm_device *dev, size_t size, gfp_t gfp)
 		return NULL;
 	}
 	dr->node.name = kstrdup_const("kmalloc", gfp);
+	if (dr->node.name) {
+		kfree(dr);
+		return NULL;
+	}
 
 	add_dr(dev, dr);
 
-- 
2.25.1


