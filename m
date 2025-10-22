Return-Path: <stable+bounces-188879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ABCBF9E99
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 06:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408144EF569
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 04:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0D12D661A;
	Wed, 22 Oct 2025 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWIAvNof"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5142C21D8
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106145; cv=none; b=LNjq1GjrGKHyxAzUV4v0WPiSLVc1OBSBm926N2N9TNnwusARr5qVFX4GsvPHGy3mB5adZEF+8iuzf9zIrEVQ97UDzsAZivM5cz72g4iUQP85JRoS0DjlWQqUnmFR539zbDL3twxJV1t5Ht5WBiNmQ8msCn9w50TwotHI+4xCky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106145; c=relaxed/simple;
	bh=MW4it84Oe/dptYdFMqsXjx3kV/biDh03d8d64XgDmRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PeZPlscBiBCpJyj7+Z3SUEsLPPRI6SXQNlXTFhnsK8t8M3W76OyN23QOCmQeFAGxPKl/0XlqtKBcBs5IHOimIuOeYOlXhvFA11QLFkL7CkkbEE/D0CvELmXrhOQ1+xDdyZt6faKP31F2fGE/iNjFVYvNnlzUBLqFNt3uHHmCmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWIAvNof; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430abca3354so59569835ab.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106143; x=1761710943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=HWIAvNofpJdOh0q2a4NzIJAHNkchFnOIfkO/t9+VHppTWoYbrUmnqFkOpf7Qmu21rN
         j+FplWlP50AriG3xaG5CA2zskh3wE5Ze+8Wv/QJptDgZmWDIOIkL9Re5BWbdU3F69Vol
         R0xgsvyPGbkb2HEWc2dXYLq9A+MJmkKku2OLnDg4/JzQhS7yi+sEBeKj4ynMCFjZBmb1
         Mnv4tUUTmT3V5Qm/un63N5GxdajYstdhzYaHUwLBQuWfgPwN8X0s1WAEYg2CewksuXzb
         vo548yHqTpfkylVjthYo/gejEKJf2RHABmS1SEBRjcpxWMBNbIhT1PPK6YinAsB5jb3D
         Z3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106143; x=1761710943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=Af1p+PCaWV2jRamfek1/VvjWBGHKpCi//T8ec8ppy03YpiGuoPRfKAnj5OYcGzxwCA
         vCn0VYrbVnJ8TrjhUQVKAOU2dWheQZFIT5WwLvyHkK3iWU/K1LyTL9ZMe9MFXAEURQR7
         j83dRWsfcOZYVPbCu3MUyuabKuWW361Mbx5PPRwJPeMP342y1l1giYKf4rr44Fxyt7fZ
         GId2Poi34SV/lkEXk3p7n42iSH+NDfOyoVc2IFvZA3c1CYRxHDO9Vx174g/5k3nzDLxE
         SLRyF7/qYHsZVJxGeSWJ8J7KD8eFdrLqQ4c+sydjJMlrhdaILNKqWtNaNVex2FLEifOn
         yk/A==
X-Forwarded-Encrypted: i=1; AJvYcCUYTs73R/xW8v2tME2iui/T50b7LiPhbLaz1PhiZtG8ZGkNr1YljcS+k6U5t0Q2RDTkD3hj+lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLQ2PXvyqr3eVxbpJk8Nrkf4oCFZR6fenypy2Mhu2v0CFhWpu
	qPlEXz/17Wp4oaMsPecJIofNvMEh4rYp1Mj55mxM7sHTUJqMOT5izuEx
X-Gm-Gg: ASbGncseQhmWzh2hHWgclb1673NzM7GOZXWnE0QlvFo3fEnbE6QEtJNHbUbmA1pmd3y
	Fo6feWAtviyHY3H5M8xawfkNHnZprCHZ8m4gKGOCjtfnBx63JN4uihKhuLXsNvQXxEfPZygsESV
	QKmmLXLdGLklrRtO5mnnfmPVoNmfnGdovTA7HQtD+0qtXksPF+w63JLrobpmbU8zQ0nTcEZFwGd
	g7GoZydK60PrqHJjVE3WkPLLLLCUxDM4uf5KhjFBgT75jE5saGywxfnzFZNoXoW8SqThgfJmh/l
	gEqpo5nnS27ZTe+VZcx8fCTk6VSWwErobieZhbZmHzKgtAKip7ZhJIAhhWYebMmH+2lZ3jWv2ER
	gNWK8uDhPUtdDygN71nyd4sDeZw0/1A4O59Ucalvw4JByebRe60wmgL178bzVtfsnvHDj0EEfuD
	kk+DUBqeUk5AvT7tEHu3rdO8F5nP+fBAf2wonXAIGUNO4tSilsqTsofF/lTkqWgxXUK3LEMuTqs
	tu2EZitRwuG39Y=
X-Google-Smtp-Source: AGHT+IGi+HG544y5rI9TG7VHo47lrEeo2lT1g0Tam3Wcn6OeSr+gRnQ9mh2vuhld3fbwmO7bH5SAqA==
X-Received: by 2002:a05:6e02:188b:b0:430:b05a:ecb3 with SMTP id e9e14a558f8ab-430c52899ddmr295700205ab.9.1761106143223;
        Tue, 21 Oct 2025 21:09:03 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07a8725sm51436015ab.21.2025.10.21.21.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:09:02 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] ACPI: video: Fix use-after-free in acpi_video_bus_put_devices()
Date: Tue, 21 Oct 2025 23:08:58 -0500
Message-Id: <20251022040859.2102914-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code contains a use-after-free vulnerability due to missing
cancellation of delayed work during device removal. Specifically,
in acpi_video_bus_remove(), the function acpi_video_bus_put_devices()
is called, which frees all acpi_video_device structures without
cancelling the associated delayed work (switch_brightness_work).

This work is scheduled via brightness_switch_event() in response to
ACPI events (e.g., brightness key presses) with a 100ms delay. If
the work is pending when the device is removed, it may execute after
the memory is freed, leading to use-after-free when the work function
acpi_video_switch_brightness() accesses the device structure.

Fix this by calling cancel_delayed_work_sync() before freeing each
acpi_video_device to ensure the work is fully completed before the
memory is released.

Fixes: 67b662e189f46 ("ACPI / video: seperate backlight control and event interface")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 drivers/acpi/acpi_video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 103f29661576..5b80f87e078f 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1974,6 +1974,7 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 
 	mutex_lock(&video->device_list_lock);
 	list_for_each_entry_safe(dev, next, &video->video_device_list, entry) {
+		cancel_delayed_work_sync(&dev->switch_brightness_work);
 		list_del(&dev->entry);
 		kfree(dev);
 	}
-- 
2.34.1


