Return-Path: <stable+bounces-100516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509499EC2A0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C65282F95
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 02:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A81FCCF7;
	Wed, 11 Dec 2024 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="If7iQc4S"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573141FC104;
	Wed, 11 Dec 2024 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885890; cv=none; b=l5rTJMA+pwGMZezh8NRcvQ6tlUiRVZ4kMBhywc+5kwMI99UWwYIetaurUgXa6TWEnXJvfjBRVPK1Mz8cCOrJB813atGnQiFRoFWQ+bAPVIIcvxCkMikrLmVpiOZuGmqZcJKsBdnVH+am6zBbSnLPd2d/Svuq3NkOp/JJBKqjFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885890; c=relaxed/simple;
	bh=Jltp9bnlx2+n18ClWB5oOsVvGL80S3zLfY6neFVpMps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bB9IZlq1rsjle+4jLDM3FRoKIHCAG2WvhRQ/bz4Cdq1SicJ56dzoBYDfWabhvwcPrvjO8ZSJuJrQOoKR+Zp3aVZT+nMQKUN7OMo+xQXIPzOwFWpyb/dW7WUwXIN0I3nhi1SQFLCNKF1EtLYn3Gw0809H44vyrndlSgCLlrpigUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=If7iQc4S; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=G8bXT
	8guXuEHe3zwPNQ59rUUL4Ht2a1ZJXky8kfhCQA=; b=If7iQc4SNWZOftbp6+ZLg
	7znREEBvYFUS5Sc/8KeXsfcSzbYbvT4eifhadtog7gdVLISPbaXMEwaTCTNwjKb3
	HB38bL4DRH7jfWRaO0G1rOlEafS2X8s4tCaHYfyLo48cCuwT4Si/mMmmv8WlPSFo
	fWTdMSanK7XONetgmPG5Bk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn6lCK_1hnW695AA--.9130S4;
	Wed, 11 Dec 2024 10:57:31 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	ayan.halder@arm.com,
	james.qian.wang@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/komeda: Add check for komeda_get_layer_fourcc_list()
Date: Wed, 11 Dec 2024 10:57:12 +0800
Message-Id: <20241211025712.824391-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn6lCK_1hnW695AA--.9130S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDtFyrtry3ZrW3tFykGrg_yoWDKrXEkF
	1UJr1UXr4UCF9rZw12kw1fX34I9w4ayF4kJr1SqrySvr1xCrsFv3yxXwn8u3WUuay7XF4q
	k3Z8GF1UA3yxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUT7K3UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqQ6ybmdY+gDRqgAAsF

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


