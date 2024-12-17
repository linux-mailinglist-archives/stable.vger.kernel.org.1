Return-Path: <stable+bounces-104421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5C9F4157
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 04:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68187A2B30
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C5412CD96;
	Tue, 17 Dec 2024 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cn5USNwK"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4453FD4;
	Tue, 17 Dec 2024 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407739; cv=none; b=Kw4Qz66h01wf3rVKYQox3xKSvSvJDHm5dzGnn4Lvey7gGLiKdWz+106y3FfT+Y7FdCar/3Yf77dfwYjeP4yzCLrPy6DpiVcC28aDuzmUPmAeh9iFdVh6iVOgDWApgfqA9rR0y1Hu6BzVXDphA92B1d76nOflClQd/dfBOOZl2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407739; c=relaxed/simple;
	bh=PBIqoh0+ItZyIgHirEJhgwbzuTx438a3eeqecHpANFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oih+frTd64Eul9nX91jEAZOgAPe/0xPHNaJggbLPLxTDzCT/sGBKyhZv63TrZMK0nwwm+C5degXuGnSJcU85UQn8VPBph7XQt55N3FwFU/WJGYKFjpAWNncblq0H28jHtDxYLRuSeHDZ0cM/GiGzLQ4OUSiIZBwhTnGO1QcVF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cn5USNwK; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ap3cS
	3JlynQ5mnXUthOMr7ekp9nV+5QCIucFh5o9xqw=; b=cn5USNwK+JTQUrMSOojQt
	SsJkf9GD+MdjrB2jnTGq9IJeCf5UoH/OY0hJ7yJfxXaGOsYjparv8S4Ku9BJb3WF
	nhB4mzox+yw9kGGy+CD6IKJMmnqgPKQIJcgI7LPS8L1q9APm1X+z6WsWa9EjJVuP
	xg4v/A/gHBv1lL02oWTQIg=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3l_P89WBnqKpaBA--.3706S4;
	Tue, 17 Dec 2024 11:54:39 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	arnd@arndb.de,
	viresh.kumar@linaro.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtio: fix reference leak in register_virtio_device()
Date: Tue, 17 Dec 2024 11:54:32 +0800
Message-Id: <20241217035432.2892059-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l_P89WBnqKpaBA--.3706S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWxCF1rXr47Ar43Zr4kCrg_yoW3urgEka
	109rZ2qF1UGF40yrW5Ar4Svrnaka4qqFs5ZF45tFyfA343ArsrXr17Xrn8WF15uw17Cr4D
	AFs5Krs5Zw1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMbyCDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBXw24C2dg7nnCZQAAsW

When device_add(&dev->dev) failed, calling put_device() to explicitly
release dev->dev. Otherwise, it could cause double free problem.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
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


