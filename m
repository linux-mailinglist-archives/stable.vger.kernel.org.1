Return-Path: <stable+bounces-106620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F45A9FF16A
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 20:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F371882647
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F918A6DF;
	Tue, 31 Dec 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcjktVWg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE267189916
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735671883; cv=none; b=SIWUFQlPECZX/7nZcBG/X+tQprTwJEwpmhW91tHY7+07UD2TIkJzk2W+TsSOLQjVK2GEfH2R33soWWMoShKDlx1s+60bV5N5PVMRFc4uswMxrR7cTHvB/1xiR+ZhGywGrOVZ3Vn8QTYwjjcXXayMFnCWHaYpDArEMlNysR5MewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735671883; c=relaxed/simple;
	bh=ZX3Ib23MhAaOZ3D+oGP/O7t7bJ74JpA3W4ldTY/G+Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBQuERWhW+DTT9VZDHSmLclIDYd84Ywhcy6gLlitrvMEuKxJbwKn7553jopzTbzyhZWz5ndIwJJWGPJEfw7IfVh/fwF72yxsQ1l5UVYQS+t4FklQfYP1QACA3I9sI0NjdbFig92awJB+mvRV8cFHhuy8LgS+zGwBsxTjUkQA5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcjktVWg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735671880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JhDDOdNBpVpswo8EuYIsLYoMu4Pnxo1biq0r/Q3W3Lw=;
	b=KcjktVWgX4cVZXFB25nnMZVRW91iMzD6XFCOmtZHzYc4kSVbBYFXfCSK0Y1FG+KiptvwOH
	PgecGTBv909GDQKClV8iVgBK6ijU6VtBSEXMbFZGoKmgkbfOEsmMdsak63IEAnkycqL7W6
	PYl19GMaxTlTRyR3PsXph3iisWwr8Ko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-BpLQJnRlMjaI6VzGW8zTrw-1; Tue, 31 Dec 2024 14:04:39 -0500
X-MC-Unique: BpLQJnRlMjaI6VzGW8zTrw-1
X-Mimecast-MFC-AGG-ID: BpLQJnRlMjaI6VzGW8zTrw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436723bf7ffso61562045e9.3
        for <stable@vger.kernel.org>; Tue, 31 Dec 2024 11:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735671877; x=1736276677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhDDOdNBpVpswo8EuYIsLYoMu4Pnxo1biq0r/Q3W3Lw=;
        b=L+TVSA7jqYoO0U9bQBo25vtarak2eaOz6MkZtyaZw6O1zmSf9/DbzvhHUpz7uniZGe
         K8/3WPnlWmhrdamhrGGU24MvIhqG5dOj2wBNJDt/pVuMfNJ0FUAlXfdwE4Qs/btErzEi
         uD2lcTR+BKUBV1Je94Iv57Q25l/DKw6/+k0peXhIDr1W0qsOCHm0eZh0mE2XczPfxLWf
         m0rJcGE7y9ho74TMEZ2ZuJkMexzzmAVNhFVf/mgQb4zy3z/aly92S37JJ0E2iPJnnTw5
         EOxAu9eYYDPUl+qxeatq1S8qfr/pb+QlA03lhT1cUMg0N/epJFvyaKzOJpIT3Icox5OC
         CPNA==
X-Forwarded-Encrypted: i=1; AJvYcCUmZF10B+kBV2ZSYRcjS15WOWzDJM5XBvN9E8Dx+6fu1V/NXYdyeeJLNo/r5D3F1ZNfE90ej+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SFP4vtCvqEF/SL33F0i6wbU9c0HMZGNfNXxOIs1b4BZkColo
	JvqDZZrBqzaMHrWOUtU35yJaW06h/8t+n6RepmAH9V/5/dLROq50JXbpla8aq0B7GwMM0AaI8ah
	4z0dv0SZxzETlXpoq+EFsNTDSeAFdn7gDwUWeH1Mhd+yIErPKJsq+qw==
X-Gm-Gg: ASbGncvPpFia8JBLJCMQUULPGYhpjM4Y3f6I0R9dW4mcuqBFYD2ZA52anZbAQdzDE7z
	j2kcQ1K2ZdEahBtFE/pYIyVIui5BGlqeQqRH2Yn1Zthlx6+tDd+iuzg2P08YOxmVrGFeFSrLWxv
	fr83fNTRapBZymyD7qB/ZHcnKvoN5OqUy0ptShMGe/WAN8C9+aD2j9/cJ6O+3AUM5zb3DTx3yjP
	vbhldIN9FaWdotJ2GEsECDFc+jeikO56JMALos7QVvWrn8TojOKUb3Ov2/7Y56LcCSEBXVVAwO9
X-Received: by 2002:a05:600c:350c:b0:434:9ec0:9e4e with SMTP id 5b1f17b1804b1-43668b5f6f7mr365412605e9.30.1735671877625;
        Tue, 31 Dec 2024 11:04:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa8a8m7RDNw4uUVorjlPblNdvcvnmA8WMiAexDLorVnq8zdmKAgj1ehk8FuTdGNKsgepfNew==
X-Received: by 2002:a05:600c:350c:b0:434:9ec0:9e4e with SMTP id 5b1f17b1804b1-43668b5f6f7mr365412405e9.30.1735671877300;
        Tue, 31 Dec 2024 11:04:37 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4365c08afcbsm406389675e9.21.2024.12.31.11.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 11:04:36 -0800 (PST)
From: Lubomir Rintel <lrintel@redhat.com>
X-Google-Original-From: Lubomir Rintel <lkundrak@v3.sk>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lubomir Rintel <lkundrak@v3.sk>,
	stable@vger.kernel.org
Subject: [PATCH] media/mmp: Bring back registration of the device
Date: Tue, 31 Dec 2024 20:04:34 +0100
Message-ID: <20241231190434.438517-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 4af65141e38e ("media: marvell: cafe: Register V4L2 device
earlier"), a call to v4l2_device_register() was moved away from
mccic_register() into its caller, marvell/cafe's cafe_pci_probe().
This is not the only caller though -- there's also marvell/mmp.

Add v4l2_device_register() into mmpcam_probe() to unbreak the MMP camera
driver, in a fashion analogous to what's been done to the Cafe driver.
Same for the teardown path.

Fixes: 4af65141e38e ("media: marvell: cafe: Register V4L2 device earlier")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: stable@vger.kernel.org # v6.6+
---
 drivers/media/platform/marvell/mmp-driver.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/marvell/mmp-driver.c b/drivers/media/platform/marvell/mmp-driver.c
index 3fd4fc1b9c48..d3da7ebb4a2b 100644
--- a/drivers/media/platform/marvell/mmp-driver.c
+++ b/drivers/media/platform/marvell/mmp-driver.c
@@ -231,13 +231,23 @@ static int mmpcam_probe(struct platform_device *pdev)
 
 	mcam_init_clk(mcam);
 
+	/*
+	 * Register with V4L.
+	 */
+
+	ret = v4l2_device_register(mcam->dev, &mcam->v4l2_dev);
+	if (ret)
+		return ret;
+
 	/*
 	 * Create a match of the sensor against its OF node.
 	 */
 	ep = fwnode_graph_get_next_endpoint(of_fwnode_handle(pdev->dev.of_node),
 					    NULL);
-	if (!ep)
-		return -ENODEV;
+	if (!ep) {
+		ret = -ENODEV;
+		goto out_v4l2_device_unregister;
+	}
 
 	v4l2_async_nf_init(&mcam->notifier, &mcam->v4l2_dev);
 
@@ -246,7 +256,7 @@ static int mmpcam_probe(struct platform_device *pdev)
 	fwnode_handle_put(ep);
 	if (IS_ERR(asd)) {
 		ret = PTR_ERR(asd);
-		goto out;
+		goto out_v4l2_device_unregister;
 	}
 
 	/*
@@ -254,7 +264,7 @@ static int mmpcam_probe(struct platform_device *pdev)
 	 */
 	ret = mccic_register(mcam);
 	if (ret)
-		goto out;
+		goto out_v4l2_device_unregister;
 
 	/*
 	 * Add OF clock provider.
@@ -283,6 +293,8 @@ static int mmpcam_probe(struct platform_device *pdev)
 	return 0;
 out:
 	mccic_shutdown(mcam);
+out_v4l2_device_unregister:
+	v4l2_device_unregister(&mcam->v4l2_dev);
 
 	return ret;
 }
@@ -293,6 +305,7 @@ static void mmpcam_remove(struct platform_device *pdev)
 	struct mcam_camera *mcam = &cam->mcam;
 
 	mccic_shutdown(mcam);
+	v4l2_device_unregister(&mcam->v4l2_dev);
 	pm_runtime_force_suspend(mcam->dev);
 }
 
-- 
2.47.1


