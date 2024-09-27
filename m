Return-Path: <stable+bounces-78140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162DA988962
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27E91F2178E
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230D9186609;
	Fri, 27 Sep 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zU1KuzKy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D5169397
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456081; cv=none; b=E+PIADA+4hQiI6C77StAzn0TYpwO402BCuHV4MjkJNEPO8Tc3XFlS13yhzoksKn1BYjxLHtTG23oFYgATt4o36NzFxXSzIj+NuT9w33PMdP+EOdZERMJiCuLIP6ubiNYpxlmi3EhQnLkFLkkiwqzjmsdx4VtJG1gTSTvRyaNmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456081; c=relaxed/simple;
	bh=O63ZucSq0CoIiw3X1i0tZTg+t+EghAHf/YIpJSXS3qU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g8WyehF1mjlmOFBYmAvWr420ZsUFq7ZhQvJEVY5vq7Ymd59FNWgwbIs/rXXqz9CwEVWAbwhWsLe4ndsMcmXv9pwrHv5gaCSg3LnyTI/JFnme1fxgsaE/T6RxabkMRQxDiyUlWX8Cx97Oq9tfUkoJmgeauzYwp/OYd0q6uAvrWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zU1KuzKy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d5a54dcaefso1975450a12.2
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727456080; x=1728060880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NsAYa2Y8TQz/xhZT3kI0TC0+2sPBJIbZREP+lHmFh2k=;
        b=zU1KuzKyhD8FvPne6oVE28jcwA0bv+QMt9KrJ09uupJaG5udn3UhQ2TQlGGChVvEpL
         oxn2ZyfMYyGZ5yN68q6S1Si9n21wtpA2i+wmwlpQCyXwvDpksG/+kA86W6j9oghDuimT
         TtvoM6/tqoMamauF82SURkrZQzv03QkxzaJRpH328AjVT9zgGepbje6UCjH/Jxv9OXUR
         Aj08wG8oLWzynn4GaoeVqhOnYkEcPHgYoNd4erJbOBnCuqq3GL/c+ukNIv6O4CMHnhrv
         boN8Ii6RE4GZHtyI9DCBdvSJEhhLBRNyZOxQABN5/3et8pjhXQUsYp/I5ciO+Lus62Ns
         qCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727456080; x=1728060880;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsAYa2Y8TQz/xhZT3kI0TC0+2sPBJIbZREP+lHmFh2k=;
        b=OO2TUlIaCu0CMUbnommTBJ/dVJvQ5aao3rwXIFxdzXKb7sbiNnSVPQkHCwWfXCT6mc
         tH3b70Orn+HiThJUSil2ouxarsg7gt8rAz8wBM4Rdlq5rYI3XeMSCP19e1P10J0qqVWI
         wEugAcLKRg6BJZjHbTgai7o+4CBRiDDhP3n+18Su8WgK+pDKBiXHEVruLD8wZbkz6HTH
         sL4SMnJtnVx0RZBZM5tQRc7bETChRhB104umIbAfNLanl2SrDACa4CsTH6gwF9ESKf3q
         jLamerb45M/HO6+pqKU4eDiH8IkddD47HsllRCKkppyr0tdW5+6PJOcKl6S7wYpjE8b3
         TEZw==
X-Gm-Message-State: AOJu0Yy0xTdynDSGkUGCwyh7w6EFxcYK3T7FpGhmTk4B9senYT8+mSFG
	xHLmeP/jUeVIjxe6kNc9NrVkcAApH+91mjSnrq7t4ljyaDzX/+Syr569VX4h2s//QDxq9cMRXXr
	YaATvxCNnZXaJgYgj/+H3UHodhXFVxr2jXYQldgp0hkX53BhzaQX1wudQszxbOSCSJ71Rn+GAMl
	7i8vQoZiUEXZKiA4TA
X-Google-Smtp-Source: AGHT+IEXzEwNhC7t12kCZDwozTho0aa9WBsoD0KxZH+pGCaoafn16DZSCyVyTZTOuViWsg3r8fjH1aw=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a63:575e:0:b0:75d:16f9:c075 with SMTP id
 41be03b00d2f7-7e6db07f64dmr4292a12.9.1727456079184; Fri, 27 Sep 2024 09:54:39
 -0700 (PDT)
Date: Fri, 27 Sep 2024 16:54:35 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927165435.1332526-1-ovt@google.com>
Subject: [PATCH 5.15.y] vfio/pci: fix potential memory leak in vfio_intx_enable()
From: Oleksandr Tymoshenko <ovt@google.com>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Sasha Levin <sashal@kernel.org>, Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 82b951e6fbd31d85ae7f4feb5f00ddd4c5d256e2 ]

If kzalloc() failed will lead to 'name' memory leak.

Fixes: 18c198c96a81 ("vfio/pci: Create persistent INTx handler")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240415015029.3699844-1-yebin10@huawei.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index cb55f96b4f03..f20512c413f7 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -181,8 +181,10 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 		return -ENOMEM;
 
 	vdev->ctx = kzalloc(sizeof(struct vfio_pci_irq_ctx), GFP_KERNEL);
-	if (!vdev->ctx)
+	if (!vdev->ctx) {
+		kfree(name);
 		return -ENOMEM;
+	}
 
 	vdev->num_ctx = 1;
 
-- 
2.46.1.824.gd892dcdcdd-goog


