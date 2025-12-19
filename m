Return-Path: <stable+bounces-203100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B154CCD07B5
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF33305BC79
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23950347FEE;
	Fri, 19 Dec 2025 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKmWG048"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E35348899
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157651; cv=none; b=U4qtjpHfRiNNdAU4TlKn41SL3tjG46nrDuePsGVnH3GGT1Jp+hi301/OK8IiQprL3M001uhJJQL03nEe8hgusorPTBKajRqxR/T8h8GKMwhg7RK2LoY2Oi3K/0nK6CwRBBxdCQgdQlTILbr13Hz9pSUoal9gFYX1swcdxnqvUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157651; c=relaxed/simple;
	bh=yHNdgzqc/4lAM8dbFsHeaviI2nF5q/YpEVMw74Bnsuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZfk/GC8g4haXM0f8F233R8bzpxS6eDe4WYuL8X8Su6aMTHMXXWnRNsvw+8+ApG6qmqEw5F58dDNs0yAvaT4MlgXgmQum5WgC1AVHH9hn+Fg+YbNNqdh6M7N9fVnu9fsCxR7WAolWoAt3MwvWWjjQ81pyI9FBlnSvcucwMjwmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKmWG048; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso1656696b3a.0
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 07:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766157649; x=1766762449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FRLyHIcaTYgGGdTbN+5lMzudMmbrt4aktasmpYS38uM=;
        b=cKmWG048BaPXQBBqK3wUWEs6NmAoyhpC9TxTNyvxJzavY/jMCksKSqBwLMd3KuD78d
         81zn/rUco3vAWp/s+7sTPo6WO6mn58ziVOIf8OS6qruJ6Ejk2ymUbRUdNj+naGzpYrpa
         SUANyjH9LcOcbhFFRUuLWs1KH4C3c+zJ02NW6WV1yqRuqSoCy+sfnIMHsp4+1yRaGVmG
         tPlQ3GQWfZFjuUs0Z04ma/NXJEt4uVE17VqobZ/NEXW4aF3ajNe6aRiz93G7gMTZO98X
         RD/U5juM6VdEwREKuPWotiVNCevj2cV/HBMu0iReoFA2iakq0FDFW7FQZgS4UmpruttA
         2MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766157649; x=1766762449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRLyHIcaTYgGGdTbN+5lMzudMmbrt4aktasmpYS38uM=;
        b=u7rC8HptbshA1On/9cL4NdA7Za2QMkPo2BPlJrJc6eZayGC7zlmeQ0wSeWg7LrrDVJ
         zU1k/iCgrCIuntom+717RI9sO0AUMlj/EVr5+uxXCvjLPoidyfSjFg7rwikG8bIt3JYO
         wXqJnTKjX+bJCJ3I30o1S8piMKLphmkjCY5JaITYM5zF13CkvHXVcoV4yoxVALVsZguj
         ShYcAk2kBaadCI7yznG5f1uYHLE3uq3TXZuAKDtiOuGEb3FP4ZGWiK19qXAipiMQIXCf
         KrMxIAmOj4Z3nd5cS74h8h9vRsiRnHcf+/Qt+DcLkHu9a6YYm7PhTP34H+5kTF4Ehu0Y
         isrw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Gg3Me1vKDP9aVXbZyF31Mjn0juyPG0rXOVS6tpr7IjgwDtDpYGRhuAFMojC+gq7+GREFYM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0FGo66jSe8ZAIGsZVteS4XLvA/AMWv4GeOc+PwoicPBQZ9Li
	tdv26KvMkMYF+fV51QJ0MIiCcddVz5HLAZ5sj3N26npAZ0c/i6FCu/Ay
X-Gm-Gg: AY/fxX46G+98GBdrydCq8k4gL92tII/YEPor6T+WKFrMrZNwHyARDsUJtaP5u3DVRjD
	bLnUoom01vTHUnvkA66tUiMEqglXHOwhylzDKa9LKJZoDq0QN/CWH1B5T6zoEmjZ4gkRd39mi3Y
	WjkVhr9pZYJOcSPiENzH3t26V72I8/0KOvVeixVgmYJE0BH0tsvAQBWrDhdSp90+rlXhzYWxzJW
	7gZNOqIXRWpnD957doow8yWuuvZHguPxbCkFg7mQ1a+V3oI04/ceDPoCT70osZR9i3xG/8GqZlj
	i5J5Kf6rONUef4etdHkcsdejHd5d5dSOFwxi6QdvJWasIaNq2KjfbqSn4rqV6KJreLQ9MA+06B+
	46ABHoLewUuFCqBSADLBHluIOSmYQFDIejQZiyUn5VT0IzXa2tFFlk4ApQKLvwgKIKGs7NggiO7
	uHbPBZPE9Kcg/u
X-Google-Smtp-Source: AGHT+IHZF6dThhbGJCz/FfsvtZUXhVynNTqCbs4rVadVbBB844qGhg3Y+x98uNRKysilHK4dqgzXuw==
X-Received: by 2002:a05:6a20:7d9f:b0:366:14b2:31a with SMTP id adf61e73a8af0-376aa6eadcbmr3041159637.77.1766157648759;
        Fri, 19 Dec 2025 07:20:48 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7bd61b40sm2459612a12.23.2025.12.19.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 07:20:48 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/fsl-dcu: fix clock reference leak in fsl_tcon_init error path
Date: Fri, 19 Dec 2025 19:20:35 +0400
Message-Id: <20251219152036.2958051-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fsl_tcon_init(), when of_clk_get_by_name() succeeds but
clk_prepare_enable() fails, the function jumps to err_node_put label
without releasing the clock reference obtained.
This causes a clock reference leak.

Fix by calling clk_put() that properly releases the clock
reference.

Found via static analysis and code review.

Fixes: fb127b7943c9 ("drm/fsl-dcu: add TCON driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_tcon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
index 49bbd00c77ae..b7ba90814b0e 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
@@ -86,7 +86,7 @@ struct fsl_tcon *fsl_tcon_init(struct device *dev)
 	ret = clk_prepare_enable(tcon->ipg_clk);
 	if (ret) {
 		dev_err(dev, "Couldn't enable the TCON clock\n");
-		goto err_node_put;
+		goto err_clk_put;
 	}
 
 	of_node_put(np);
@@ -94,6 +94,8 @@ struct fsl_tcon *fsl_tcon_init(struct device *dev)
 
 	return tcon;
 
+err_clk_put:
+	clk_put(tcon->ipg_clk);
 err_node_put:
 	of_node_put(np);
 	return NULL;
-- 
2.25.1


