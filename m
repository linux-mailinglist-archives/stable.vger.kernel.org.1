Return-Path: <stable+bounces-100514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F20B9EC27E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFC5188B12D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 02:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB391FBE87;
	Wed, 11 Dec 2024 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yq1ooxp8"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D181FCFF7
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885426; cv=none; b=WI1EFXTLpCzTlvrFSRYtLAUqWIr9ckWpyX+cM6BqSxtb1MYE/VVr2s3zUvVXPTDZn+sQonf+GkWj8eTp5oDRwNnaf6NAyJEbmDl6IohMXgi0AdLQd0W9FDIHIxTJL0fDtrR3vDj0t0pWFo5GVuyrIXIiuyXdWUTPaoZneTE3QUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885426; c=relaxed/simple;
	bh=Jltp9bnlx2+n18ClWB5oOsVvGL80S3zLfY6neFVpMps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RZfXE+91MS3g28CcaEJnkmIASqtQg2dQk6gxq+DCRay0hCLsUxcvnS0NOIlVosW87fdbjaTogIn1lYyreWHjgjnto03VjeRm9zCtXHj0pjZBxDTQTiZitkqtux0ja0pvw9MjYcY1tOSLgj16MYULf3gsb9mGS6EW+3OkBoAa3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yq1ooxp8; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=G8bXT
	8guXuEHe3zwPNQ59rUUL4Ht2a1ZJXky8kfhCQA=; b=Yq1ooxp86aX1wk+sPAkvd
	ZfBdnfnAMWJN05sqDTahndfKWaIuOyWKI+AqF8t/NhTLLDTiuoPG426OD4KbjPSG
	hKZ+Mlh6c0LO8aNfwNlXrSHr9kAK+rzi5bE02pOFeEF2Xc8eP04CNmG6JBpmqmsB
	s85Dxq0EU5LWiiLesN8VH4=
Received: from localhost.localdomain (unknown [36.112.3.223])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnNjHb_VhnpODjFA--.64849S4;
	Wed, 11 Dec 2024 10:50:19 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: lhx2018202148@ruc.edu.cn
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/komeda: Add check for komeda_get_layer_fourcc_list()
Date: Wed, 11 Dec 2024 10:50:01 +0800
Message-Id: <20241211025001.823863-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCnNjHb_VhnpODjFA--.64849S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDtFyrtry3ZrW3tFykGrg_yoWDKrXEkF
	1UJr1UXr4UCF9rZw12kw1fX34I9w4ayF4kJr1SqrySvr1xCrsFv3yxXwn8u3WUuay7XF4q
	k3Z8GF1UA3yxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_yCG7UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0hmybmdY+pR91AAAsv

Add check for the return value of komeda_get_layer_fourcc_list()
to catch the potential exception.

Fixes: 5d51f6c0da1b ("drm/komeda: Add writeback support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index ebccb74306a7..f30b3d5eeca5 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -160,6 +160,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
 					       kwb_conn->wb_layer->layer_type,
 					       &n_formats);
+	if (!formats) {
+		kfree(kwb_conn);
+		return -ENOMEM;
+	}
 
 	err = drm_writeback_connector_init(&kms->base, wb_conn,
 					   &komeda_wb_connector_funcs,
-- 
2.25.1


