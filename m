Return-Path: <stable+bounces-105281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C469F77EB
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E2116C0AA
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3321767F;
	Thu, 19 Dec 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Fkq8kNaT"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4E15B115;
	Thu, 19 Dec 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599032; cv=none; b=qBx4JQINy8cASJ4AfQbBmhi3f1I+xzmDaL7Fa1fouD/IkQijuC0FMNYWRmiTRDytHW9IhyWT/yGJpmyJDEOzw1t8SfM8HqCRKdXgmKkpXucTVEK9JoZLDd/ZX5leGx5OXOg5wVsAi7mAnDBRHEU6/UwcQzoYPoB0hfrrdcZx+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599032; c=relaxed/simple;
	bh=Jltp9bnlx2+n18ClWB5oOsVvGL80S3zLfY6neFVpMps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JCh8ybKfBtcIDW+PqBA3FqyhMo63Bs9UYICBHyO/xgBfYXj+p6xPEuxw7x1KFbVrga5tDVbXXtJuR11JivKYjhrjAwjivgA7PeHIwAAJCbYR4crBYH8/7mnxuGWPn4QbomltpqzSQpSZ0UQ2Dh00CTGsBQCrGqVOv6GFwfCemhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Fkq8kNaT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=G8bXT
	8guXuEHe3zwPNQ59rUUL4Ht2a1ZJXky8kfhCQA=; b=Fkq8kNaT3vUsEagYjDe2A
	TPijfd9LPBgsy5soYFMlaHXk8bGjOYN2PiEVbIMT7tnRMH9Z5YOcjjQpWOk8Uq6m
	lAwAIkPnfgdTihOqolm6ATLLfO8AZV6GxUJFRh3NRUvKW+Om09VyClFE16/W19x/
	mSd8b82w1vHr1JsZUvaTqo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnDx5F4WNnd0biAA--.36215S4;
	Thu, 19 Dec 2024 17:03:02 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	james.qian.wang@arm.com,
	ayan.halder@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/komeda: Add check for komeda_get_layer_fourcc_list()
Date: Thu, 19 Dec 2024 17:02:56 +0800
Message-Id: <20241219090256.146424-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDx5F4WNnd0biAA--.36215S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDtFyrtry3ZrW3tFykGrg_yoWDKrXEkF
	1UJr1UXr4UCF9rZw12kw1fX34I9w4ayF4kJr1SqrySvr1xCrsFv3yxXwn8u3WUuay7XF4q
	k3Z8GF1UA3yxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU5rc3UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiMwq5bmdib3UAgQABsx

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


