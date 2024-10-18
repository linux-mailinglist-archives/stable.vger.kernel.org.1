Return-Path: <stable+bounces-86782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432C69A3851
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042A8288EB5
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191A118CBF9;
	Fri, 18 Oct 2024 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmNt/pOG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A917BB25;
	Fri, 18 Oct 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239355; cv=none; b=KrWqTvA6AZYGPlvFsLvdlUbWNTpn2s6ElsfdKlISDoVB+AdtrUv46A+fYppOI30YxR9rwtnnIJMXEFXmUpOuvu/M6PmzZwDqZxIN09+fGOoqH7xWKzwOsmscsOawqwRK+vF8svqEOhkDxjjEdDs+pUGSTUvVBAcwUT8x5uEmv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239355; c=relaxed/simple;
	bh=RcKxo8IHykWio7Epy94ZSrP8OjGiZBjXqv606YO30ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JiOlGcpwUhwCRHclSRcrECorlvbpM+xcE1en6L7Y++2H9r9MnGLtQwnuOqJjZLIK9TvbHHkbKzKSLjSd9PscpLqiB6J6i/EwXWED4t0LZqY+x1gOOAZbvP154FO8nxFKsTce5zSgGlqZJJ2maRDHGs9Cq6spBHsWy6Wbk4jHef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmNt/pOG; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso1240362a12.1;
        Fri, 18 Oct 2024 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729239354; x=1729844154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaThnzZRV6Q6AeNcXEdele7BxnNbtOKtfxcNYz7goU8=;
        b=PmNt/pOGrkxmHv6FYZxNWL2omyqsGgP2mljDn+pBae8u0wYxZFiPfQtsrsXxAeEUNS
         9IEhxh7E8rzaE9ql9iDwVdu8WnZ1O5zhvsE4CG59PG3vV5pMwqEnGkeL9ra06IBDyUC9
         gUbmEuSytnZkUk192/zQC9Oii0O66VTfASGp3AiOX0mkExuHgTbKHgfR4EL5azO9KH4X
         1J4kFFuH9KvVLy17Z+fxBItxuRIg4LzXw0TiqDabAUl4CA22DPtYp97lITuec9ncJkuI
         TUYh0dVDsZQ1P3blk3ky8cEgIlTdImwgESgY7WiUalEUeMXgLzJlhwEv71qoKD3AUVQ0
         7lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239354; x=1729844154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaThnzZRV6Q6AeNcXEdele7BxnNbtOKtfxcNYz7goU8=;
        b=kZzp9Xj4Rm7ad15C3p78jnFqUW6EyqX7gX7OnQvFvxio1e4TeQ82utnJuXmjr0qa+I
         qTGcOwAnFV/aDTs5GSb0iDJTeZvq4bVn4JS3t78Ys590kwN0QLHaIqJec/hLb8LW6/ng
         oE9cM3HALudi9VikMSiNePqXiLLvI5vwg7ElwmCh+UIDeqLeXd5MOiD0TAzKyUrmo+sE
         7Ldh0D9dBP/dyGmlUI4yQiuXFG9K7q264xRERjgYiqnN9pFofuEp5ys3XLE1VJHP+NG8
         ghGVGSUZQNX1GyUYrtTkVGpMD//K3zIpFkvrS+AqsPGwKcjjVFxtzosZVJEyv1odqIdF
         3sgw==
X-Forwarded-Encrypted: i=1; AJvYcCXW6AieVZSUipKWiVqaevDVh34mUtzK4aIKa+WoTgUEOt/5oEeywgRSx8KnSpnzQhufS2v5Jp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNty4Cp6RQsFdO87/YkPCEXIzj5lYSd/fqdHu9F8V0l5L171E
	jrZoFvrD0+i9x2AxfJpJX71acGL7i/F4r3q1lc+AfDx1Cf/VcnM+
X-Google-Smtp-Source: AGHT+IEdDGGkrw0Ij96vDXytjOIi7vQKWW/rzmJKZtgFtVE8XLmu0fMMbF95YfTg5RPQBnZKvX3yZg==
X-Received: by 2002:a05:6a21:1349:b0:1d8:f97e:b402 with SMTP id adf61e73a8af0-1d92ca59dc0mr2335728637.13.1729239353653;
        Fri, 18 Oct 2024 01:15:53 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34a8077sm890571b3a.190.2024.10.18.01.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:15:53 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: linux@armlinux.org.uk,
	suzuki.poulose@arm.com,
	rmk+kernel@armlinux.org.uk,
	sumit.garg@linaro.org,
	gregkh@linuxfoundation.org,
	andi.shyti@kernel.org,
	krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] amba: Fix atomicity violation in amba_match()
Date: Fri, 18 Oct 2024 16:15:39 +0800
Message-Id: <20241018081539.1358921-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomicity violation occurs during consecutive reads of 
pcdev->driver_override. Consider a scenario: after pvdev->driver_override 
passes the if statement, due to possible concurrency, 
pvdev->driver_override may change. This leads to pvdev->driver_override 
passing the condition with an old value, but entering the 
return !strcmp(pcdev->driver_override, drv->name); statement with a new 
value. This causes the function to return an unexpected result. 
Since pvdev->driver_override is a string that is modified byte by byte, 
without considering atomicity, data races may cause a partially modified 
pvdev->driver_override to enter both the condition and return statements, 
resulting in an error.

To fix this, we suggest protecting all reads of pvdev->driver_override 
with a lock, and storing the result of the strcmp() function in a new 
variable retval. This ensures that pvdev->driver_override does not change 
during the entire operation, allowing the function to return the expected 
result.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 5150a8f07f6c ("amba: reorder functions")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/amba/bus.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 34bc880ca20b..e310f4f83b27 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -209,6 +209,7 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	const struct amba_driver *pcdrv = to_amba_driver(drv);
+	int retval;
 
 	mutex_lock(&pcdev->periphid_lock);
 	if (!pcdev->periphid) {
@@ -230,8 +231,14 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
 	mutex_unlock(&pcdev->periphid_lock);
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (pcdev->driver_override)
-		return !strcmp(pcdev->driver_override, drv->name);
+
+	device_lock(dev);
+	if (pcdev->driver_override) {
+		retval = !strcmp(pcdev->driver_override, drv->name);
+		device_unlock(dev);
+		return retval;
+	}
+	device_unlock(dev);
 
 	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
 }
-- 
2.34.1


