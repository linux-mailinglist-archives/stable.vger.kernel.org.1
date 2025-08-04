Return-Path: <stable+bounces-166431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD067B19A22
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 04:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A90C1895B57
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0B1EB5FD;
	Mon,  4 Aug 2025 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kyn4r5eV"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5A1D8DE1;
	Mon,  4 Aug 2025 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754274069; cv=none; b=HW5siZUktgBfS+b/Vi19L4XwhMjgaedYdNbtH7XmgwuK/xFlxyQLocuJ+G1QIlF3aM5ozwsMXMXKPRUAC+j63se1nPYoQY9CeTUzTj8HJc7URgvljuhJovT7XsZRHvfOs1YCqvxLqmgcuhRcEJ46vsWEJzsV3FAAB1LNtxDu2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754274069; c=relaxed/simple;
	bh=PV00/DQDjtl55Q2sTjNkE07OPjvHk17khO8Nu6152Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iScJZhI7fxc9COwgv7KqglO2mOsCqbqIJ0z5/SY/MlGD0nOrko7bki3H8oRAigCnvgOfuZGL4USaaA1rG46eS2fxdoT+g501X3l+G19jRKDV+yekn7CBtAoNSuszpwzMqdiM7VKP/7kT15H0OElQTSs8XsvCjeyUXIcA8rgVpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kyn4r5eV; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ly
	ROzPVWAeV9XHHucx6h5OdtaN0VcdqdCQNP2WQJkMc=; b=kyn4r5eVbMOy6B5k1q
	DuVNR1hlv1rp7VARW+hrvODZ1sh3ZipSxi72JJxnzWB2jqNfNp50oKdcttJxUt8y
	rlqqO4F49lBOcXgQcFBXbGA2UTtuiw4olOKrGp43aZjYzeFIwKf0NVAGaeC9a/ID
	wHBsI8zrvAhAeK5W8z8yB9yQY=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wA3h83nGJBocS5mJg--.9947S4;
	Mon, 04 Aug 2025 10:20:24 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm: Fix potential null pointer dereference issues in drm_managed.c
Date: Mon,  4 Aug 2025 10:20:21 +0800
Message-Id: <20250804022021.78571-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3h83nGJBocS5mJg--.9947S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrKrW5ur18KFWUWF1fCrg_yoWkXwc_u3
	W8X3s3Wr4kCF95GF4qy3W3ZryIka1DuF4vvFW7tF9ayrW5Jr10q348Zr45JryDWF1xuF9x
	u3WDAryfZrsrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt6wZUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiMwmfbmiQFKqiFwAAs4

Add check for the return value of kstrdup_const() in drm_managed.c
to prevent potential null pointer dereference.

Fixes: c6603c740e0e ("drm: add managed resources tied to drm_device")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- Modify a fix error. Thanks, Dmitry!
---
 drivers/gpu/drm/drm_managed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index cc4c463daae7..e34b8dcde48c 100644
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
+	if (!dr->node.name) {
+		kfree(dr);
+		return NULL;
+	}

 	add_dr(dev, dr);
 
-- 
2.25.1


