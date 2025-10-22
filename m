Return-Path: <stable+bounces-188882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E28BF9F01
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 06:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11FA3B99BA
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 04:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784D92D661A;
	Wed, 22 Oct 2025 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exoWGZHQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016272C15BB
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107127; cv=none; b=b2V1SiTlGbyt7DUYhBU2bZhC7pvFPIikGby/Kjz5vMfjFuGGg417bk8olNS2sPCndAq/iXy+nCc+v/aaIz5PmDBFRiYiooCwh8dNPLqryQX5sNaeBz3IiwoLyR1ncXMzFOwNuCXawxbf0Z0PQ3bPBRzMAr92CFRcn2yNuuQh5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107127; c=relaxed/simple;
	bh=bsYa6X9KROYy7hv3d72FhLZXSqZ0WWU/HZUA1g//G3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mGbW2iG8YFKr2h9vS9OnNRS8meJhkt1wO/1GEzeC/x3oVLXJrY67l6/9ud9QTUULpKF07gumyd/mrAwBTgwthLTuvuwMjbB4EkDSIweDzSl9iMc+6C/JQmF58rKua60JVgle7a3X1kcicnzsFtd/IVDEXUdYDLTmz98+PlfPEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exoWGZHQ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-431d2ca8323so4379765ab.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761107124; x=1761711924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2LfB28zph799goFY4PIl5Hu2JZs6ZC/o5ejBi3O62Y=;
        b=exoWGZHQQDbNsbubt6n5JRRZ29qcKqLgoZYz0OCI/KQnHCdc1oB4YGwFEeXT8sJIwO
         h+ynMzFrroOOfnRd4EVAxKOy70jPHa1ttXVW5wAZXwKbpsrfnU0SAhoUhA6PI4zKS9mN
         j0JGlV0nv7KFeSLJw0JRgWDt5qX/sBOfEUlLLuXKfzAcTnDyVXesDG5OtSn0QLM2ZcSY
         fH2qwHlQUB/+MXGTr85NZiIwpDAAILuY/rk5afuhkQmV0guOiP+xPj8LU9aGiIfR730w
         LdKFsfR3F/YVUeVyEsdK1/vyN0SAL8tYf1Noe0XAUKqC7hBXBqGf60GAVu8/kbVvCuVx
         ofnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107124; x=1761711924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2LfB28zph799goFY4PIl5Hu2JZs6ZC/o5ejBi3O62Y=;
        b=ljbPLRXg97KqtzHQ0vuI/vfkiyQAI5dU+LyVq2CRWC4I9PXMgJEx0tVmEVhL2Duqjw
         nnqR0eGzD7XoBo7tFWnFXSZR4idLSOkj5RDh8c1/HUURa91UBVtVWGSkear2GPZfDZmp
         4GZLZjy0jPwo4UMeGc7pYeRRyr4i5V40jmJkM1uAkHMX1FN8w+hzR3dj69FMwZUeL68Y
         ytp3bNTjxfW68FkCz17Q5c6EgTgplg9lYpi2caTRr8Om308mFALiPug24ccVd4PyScRQ
         5iBhOsI2A9jSjEMXjTWe27FLToEq4t9A6u1x+vb4Z+b7gwMJtW8zH7lEdJIkXlEuHZdp
         Bmxw==
X-Forwarded-Encrypted: i=1; AJvYcCWFQrBDCNEhR3bDPcy6gf6142dUIMw2NI3JZMaPV0DVGfdD0PZFvepxjHvF3miK2RRMxvCb7J8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg47bQbWSaW/H8PaIKBmesISHXwI8tVca84s2n4I7aGY1BlgHt
	7bY2L+KiQk2wtkx5A+2ybVcXJ/EumNgnn5gILAPjrUR7WcXOmKGGwhN5
X-Gm-Gg: ASbGncsx2ufl/qNxXbZe/jn8AQ/pbFNCZmYIKFs4E3g5tNnKlifyu/f7MXdtlNyx876
	2VB5d99KI4FiMAqGRzvIcjskkIafGe96ZrRFD/40mw20qe3T2SF8F4oBe5urxJLqHf7VDY1xB7b
	PJIlBOI7YB7gEmAWnMa6TbsHnmLAzwztZpftj6mEVFByQlfD/0BGwjWe2ypO0lEAvORZyG8mzuB
	TEi0Qj2IjSSW1DdrO2jjm479IcE5s/9wwMsm+xcy05QEkiK20CVeNoHgf/VQ8yYbhIqnU8hnwq5
	2NdPvT08tIm/DLOhWk0Kwh6we04bOXbqIqWssvFnt3wLI3Yey5Pdh5oFXE2iKn/zrQjvbI5CkTF
	3xTBKdEUqsnN51qK8fB7YjP9rjry0o1wlqNsrR2StlmYOlC94/A4dkeoZDOQpgW63xwIG9gAxJ1
	BYjQSAyXM0HM9QisWNmylJ/kOMMCdvtveiSu5Zp0SBFVa70qU0H5S5JPg9fIApqZPOiAUl4KPTx
	Nydkj7wiaKZ+3fHFULdCQu23w==
X-Google-Smtp-Source: AGHT+IH49shBuQugYlN++wVSTOrOUhHiUw/C0tNQMZKmX9SB2vKCC6aIZVhWNKA0jz+AhfPi3lDZ1A==
X-Received: by 2002:a05:6e02:4510:b0:430:cad8:45fc with SMTP id e9e14a558f8ab-430cad847a8mr245028055ab.29.1761107123942;
        Tue, 21 Oct 2025 21:25:23 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07ccc89sm49925505ab.40.2025.10.21.21.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:25:23 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH v2] ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
Date: Tue, 21 Oct 2025 23:25:14 -0500
Message-Id: <20251022042514.2167599-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch_brightness_work delayed work accesses device->brightness
and device->backlight, which are freed by
acpi_video_dev_unregister_backlight() during device removal.

If the work executes after acpi_video_bus_unregister_backlight()
frees these resources, it causes a use-after-free when
acpi_video_switch_brightness() dereferences device->brightness or
device->backlight.

Fix this by calling cancel_delayed_work_sync() for each device's
switch_brightness_work before unregistering its backlight resources.
This ensures the work completes before the memory is freed.

Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a brightness up/down keypress")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
Changes in v2:
- Move cancel_delayed_work_sync() to acpi_video_bus_unregister_backlight()
  instead of acpi_video_bus_put_devices() for better logic clarity and to
  prevent potential UAF of device->brightness
- Correct Fixes tag to point to 8ab58e8e7e097 which introduced the delayed work
- Link to v1: https://lore.kernel.org/all/20251022040859.2102914-1-danisjiang@gmail.com
---
 drivers/acpi/acpi_video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 103f29661576..64709658bdc4 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1869,8 +1869,10 @@ static int acpi_video_bus_unregister_backlight(struct acpi_video_bus *video)
 	error = unregister_pm_notifier(&video->pm_nb);
 
 	mutex_lock(&video->device_list_lock);
-	list_for_each_entry(dev, &video->video_device_list, entry)
+	list_for_each_entry(dev, &video->video_device_list, entry) {
+		cancel_delayed_work_sync(&dev->switch_brightness_work);
 		acpi_video_dev_unregister_backlight(dev);
+	}
 	mutex_unlock(&video->device_list_lock);
 
 	video->backlight_registered = false;
-- 
2.34.1


