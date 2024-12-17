Return-Path: <stable+bounces-104438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178D9F44EC
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB7188DCCC
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2615D5B6;
	Tue, 17 Dec 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="asPjhEeB"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B676815A843;
	Tue, 17 Dec 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419875; cv=none; b=H58pVhVAR1Ksi7Jfxd1J2pgj9svNeaIiYxAmQxO5ssYgpyw47sjGzNg4hFYzJltOhXINcZixSL+yg/9PIgsc3zVGVi3EwaXRAxE7TenGIWpmDm+e9wAD3hGWnwaB0bcxY9OpYAixe7dqxQQbIB4pS851Vl0CkEvhJYGIaLDA8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419875; c=relaxed/simple;
	bh=Zrlk6LLf2G5/XLvrn/OJXQH8CFlPncDWlcWImq8hu8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XpWfBIevEKgXnyL+HboABBZKrg8gsgJwE38E6hk19KPzwZLE9gjEcxrYG1BLkB4adY70PzsnPRS1z68pMTc6abkNBG65qNNoVNCf57GzyC8jVWw4AeRJarsbUzP8TIGSmYIONYaUmqxeEvgKjr5swvXmLT6s/L5VqWPpNeBUx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=asPjhEeB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B9qCC
	0utvM1hgVi7MOI0Z5r71VmyBlYIOULJl+wWQvs=; b=asPjhEeBKiDpIgGIXIBNO
	sOztCx5+mGHy/WMH5pIMOorDgedFdGNbUnven2JIBIWfLgd1Y/BpjA5BECGiNpG3
	ELobMjAtl5hVDwqCdYKPGyQchQhjWXCYp4jvWGlQYLXZ/C2AkifY75NCu3XIB7PP
	CW8sGoUkru/xHS8MkXn9Ik=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXDzR1JWFnhCKOBA--.64228S4;
	Tue, 17 Dec 2024 15:17:25 +0800 (CST)
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
Date: Tue, 17 Dec 2024 15:17:08 +0800
Message-Id: <20241217071708.2905142-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXDzR1JWFnhCKOBA--.64228S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15GF4DCrW8try7Gw47CFg_yoWDJwbEgw
	1v9r93Xr48GF40yrW5Ar4rZrnayasrtan3Xr45tF93J3y2vF4DXrnrXrn8tF1Uu347Cr4D
	AF45Krs5Zw1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNyxRDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQO4C2dhI2AwpwAAs3

The reference count of the device incremented in device_initialize() is
not decremented when device_add() fails. Add a put_device() call before
returning from the function.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: f2b44cde7e16 ("virtio: split device_register into device_initialize and device_add")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the fixes tag according to suggestions;
- modified the bug description.
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


