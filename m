Return-Path: <stable+bounces-189036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0596BBFE1EC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 22:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745E03A79A4
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840812F83C4;
	Wed, 22 Oct 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz1qgeCp"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA12F60CA
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163633; cv=none; b=Rld+5hEapVJbcS26oelJy+pPQ7TNAjOM1romPW4j3ibv6y5WXxUdwkYdLjPAtV14WmwRzbAAKYq30a9bNYXwt/kqqp0YBobsSd6H9CGlV0JWem5iNrMIoVPwmOuYIqRrhIy9QyYhjQSX2yvRKic2rndQBxg+KENAinW6B1hO0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163633; c=relaxed/simple;
	bh=DztsLj3vdv3FYw0cPl2uS2ogmDunqfckdWo1ml2REqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gl7o17z4BZu68g70TR5+No1Jnpx839fidwpla37Muzlhmg20yTdLQHjX96JKOacq1XJNcF2HVe482LnwQhLZ/veQmWDwZwqYQVEZlCtz2jYsdwagmArnbhu5u+VX1DAEUBAa6Ljc+s3ttK6xVoriKUR9oUKpo8F2Pi2Sg6CDnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz1qgeCp; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430d098121cso467495ab.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761163631; x=1761768431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwbN+wurLTlI3kZfG9YY+LmisCptQEnBinwXCuD+yAQ=;
        b=hz1qgeCpqBUZZFb5VyO/yLXkt3Fm0AHzgo8yuuor30thglPC58BBNZ4D3ihi5z/cEM
         TAN3tpCkzn7jf9Ry82Uj3fItsgdMXyDRBkjIiYEqwfu9a/Dpcttd5AhrXNEThXxvovDV
         HWnvkN7jrcuyJSnXvzoD0dJiqWDUTm4pCq6jc3h8fmkOs+DpB8lPmYMfYAaFZf6FlJ3I
         l/5w7hBe5MmoynaNj2VYl7H+aZgoUbaREH0H0sPHveXN8imSuyOXEEgAZWafUAEm8ZKn
         Kf/BZhMFgrZp/qGK9Mmyq3e3S/OSc9LbSJ04eaPWRkuR7nYogQvHiNAuAAr/TadYgRN6
         j+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163631; x=1761768431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwbN+wurLTlI3kZfG9YY+LmisCptQEnBinwXCuD+yAQ=;
        b=uW/LpRchyugzOLKhcPYQDjkQTdH9XSEjxV+nDHz9typ1Dpqr8MzylkMwkBQsHeQQ3x
         GoF/8nRykNqvgSGlaGB8JKHygCdvBYPjNHHxR3RZT3bOqIH8EcKIjQGAeE1QFae8W4B6
         93r6qhznkn4M108oEaIF/Bl6QUZvdwcqKb38NLvabbpN2S51PvE/ibUOZwiKs91eQfM2
         DNVwTnBn94ZDIsoK6m0/bJ6/VqqvN/f9FGk6qxA9M0k5tKfMAJiTXFH4kLsAwscaBcdh
         Xegohqj8k2A1A2xW4WSKN01mOt0Zpgqc0mJO/ik/ggYHxW70vI9hUwJLtvp5dU+nmSXV
         D/ew==
X-Forwarded-Encrypted: i=1; AJvYcCU8SUl9lFvLxF8mZopf9P2KaHnfnOxaU1QJIRlscmdcc02Mknr0h4ReV9hmFJ/iiRCr9uf8V70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbKcVNEE5O6R4REljvihwXa7oue9BmXgUU267vwtAPqjcNOMs
	orl1cGgUAcWlCoEAEO9JaNnNTb/yUYq5zYRUtzaNqJoRoZEPfkQNMTVL
X-Gm-Gg: ASbGncstdzVFWoLm6MBWJPvFiJDTBW+1bQAl77FSiMV7zRHoKjRLqNiuKmEeIQ62rCq
	6Jh635VkMqM6I+opTCiLuZIxjyxlSkX+J8RKB6TjCLe8Rj/r/0XqETFMoWHkiWLq5PJTGSmwzG1
	C4ZtVON0GnbDwN6wxfEHMlzLJlgm9AKCsVIY2FDQyg+YwMJM3U41/4Vc+OIdT6e26EQTqGGD6Eo
	L/rgJQQSi7lgwSfT19yG63gT8K0DJtSnHw45cu79d+EbtLYJwT775uBNF+5D266NbtU690qmBjS
	womQE3TwH70AptzCBQW070MpOqblnewgGH6TJD1ujtimbLP7W5Th9uBITXpy4X69GAOWaSXklLK
	i2D/7ER9VZJg88f95QWzcYxQHMjECBJMmRcUkbF///qi2NZQ+YU5YDqz0aMrnPUSPUDWdmysVGe
	uc7gxk9+m141diQVeNjMZJwdQe/fq0NbeDwRDXVlhqLcAj0AmrwF8rUSasXwNS4tvEHAlD6X+jL
	+0s
X-Google-Smtp-Source: AGHT+IEi13vxAW3QWGvs47oIZZEeT5MJtjo5ggN538BbVhSvNenvFcif8+DslNFd6WG9e5ojjv5SEQ==
X-Received: by 2002:a05:6e02:156c:b0:430:ad98:981f with SMTP id e9e14a558f8ab-430c524b96bmr287934085ab.4.1761163630603;
        Wed, 22 Oct 2025 13:07:10 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb5432ca5sm18991173.16.2025.10.22.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:07:10 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH v3] ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
Date: Wed, 22 Oct 2025 15:07:04 -0500
Message-Id: <20251022200704.2655507-1-danisjiang@gmail.com>
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
switch_brightness_work in acpi_video_bus_remove_notify_handler()
after removing the notify handler that queues the work. This ensures
the work completes before the memory is freed.

Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a brightness up/down keypress")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
Changes in v3:
- Move cancel_delayed_work_sync() to acpi_video_bus_remove_notify_handler()
  instead of acpi_video_bus_unregister_backlight() for better logic placement
- Link to v2: https://lore.kernel.org/all/20251022042514.2167599-1-danisjiang@gmail.com/
---
 drivers/acpi/acpi_video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 103f29661576..be8e7e18abca 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1959,8 +1959,10 @@ static void acpi_video_bus_remove_notify_handler(struct acpi_video_bus *video)
 	struct acpi_video_device *dev;
 
 	mutex_lock(&video->device_list_lock);
-	list_for_each_entry(dev, &video->video_device_list, entry)
+	list_for_each_entry(dev, &video->video_device_list, entry) {
 		acpi_video_dev_remove_notify_handler(dev);
+		cancel_delayed_work_sync(&dev->switch_brightness_work);
+	}
 	mutex_unlock(&video->device_list_lock);
 
 	acpi_video_bus_stop_devices(video);
-- 
2.34.1


