Return-Path: <stable+bounces-105104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379549F5D49
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 04:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F3216F073
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 03:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265513698E;
	Wed, 18 Dec 2024 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RotmdLRx"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81AA3597B;
	Wed, 18 Dec 2024 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491570; cv=none; b=CKiP+P3/uLyvKqTorPqc1xSJDszFMrBVwjcHf+CJYyBN37woPM1FawcZrzQikQEOPNzj66ib7xeHLBCJcX+mRBDZPbE2dKM1WF8I/WTO7x0qgL2X4OE9PUOD2he23VXhCih+C1Bt5zhWYQkP4SgtXSOIqo1opEFsSxrlWrHWC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491570; c=relaxed/simple;
	bh=M1YFIBnEAGL4iYun/168E/pCBZDCohC2vG8p9/Mu/wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdBKoX1Wr5ktPXszrkdWxN+ePSpMs7AjuXU62jDd/nOtuHs7dWwdrAGKRmPsSlV1o78+Woou8/bnchipsedGHvAPIGYUzD0nRvjms3u0AyOpWeShVNIGpURuQiDxuCcoEAwO8QKPallLjsVUxwrFgsTTnptB4zjkKwn7jHgWw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RotmdLRx; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jy6A0
	Cma7FA8Mc0GsrpEj8FXjIQ6ESmSb3IJInjwgPw=; b=RotmdLRxyYElWf/Wuk0di
	FLrZipjzPwj5pJP22ddXEYM2/eizy6XRDVsJTSy+V9eEBMHkL31ZU6HceyGL0c9s
	eVVwN+F4eDqTJPoQ8uW0IDMN4vEpMWkFWY0I3DRJge+QS3K4f+exDA93p5Jt0y3p
	RRNT0DpkMlqLf1NNCJgxdU=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHRwSKPWJn3r02BQ--.12880S4;
	Wed, 18 Dec 2024 11:12:24 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	zhangweiping@didichuxing.com,
	cohuck@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] virtio: fix reference leak in register_virtio_device()
Date: Wed, 18 Dec 2024 11:12:01 +0800
Message-Id: <20241218031201.2968918-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHRwSKPWJn3r02BQ--.12880S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy3ur4xKw4DWw45JryxZrb_yoWkWFg_tw
	409r92qr1UGa10yrZxAr4rZr1S9asFqFZxWr45tFykJ342vrWDXr1qqrn0qF1Uu3W7Cr4D
	JFW3Gws5Zw1fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNyxRDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizRi5C2diNI0PdgABsj

Once device_add(&dev->dev) failed, call put_device() to explicitly
release dev->dev. Or it could cause double free problem.

As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: f2b44cde7e16 ("virtio: split device_register into device_initialize and device_add")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the bug description to make it more clear;
- changed the Fixes tag.
---
 drivers/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e43b..ac721b5597e8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
 
 out_of_node_put:
 	of_node_put(dev->dev.of_node);
+	put_device(&dev->dev);
 out_ida_remove:
 	ida_free(&virtio_index_ida, dev->index);
 out:
-- 
2.25.1


