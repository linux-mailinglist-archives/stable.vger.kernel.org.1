Return-Path: <stable+bounces-188878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1EFBF9E93
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 06:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63831466EA0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 04:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663962D6407;
	Wed, 22 Oct 2025 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwm5t3cm"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8B279358
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106073; cv=none; b=FKhw2ibdQ/++Aeefk8C2kD9qmsgkDqaLvWT3YkLEKbcbuA7CygM8xCn5FLFJN+YHscYK76bBIv63/VOTbC5M+GBRNBs5N5yDIIv+hhXJI5gfAFuqR9onZactZqG7G/gicWK7lURB8SpdibTBuEV6l28qrVNHIfQryTBk0wF2pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106073; c=relaxed/simple;
	bh=MW4it84Oe/dptYdFMqsXjx3kV/biDh03d8d64XgDmRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JprrcyoDHS515OXa1qOiF18QDUN6stqdaxGn2tVLl326a2Vnc87MHA+aRFFMRXAbV4E47Lvycy8f/gAVu5cMSTRMy5NGCmBmkRHgWSqPv4qiRNl/BpjImRaNBm7jHMVPukLbrIR4CTAnjXDTyXKMpRkdlGTcuCfE61FRWTJ4osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwm5t3cm; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430da09aa87so14314435ab.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106069; x=1761710869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=cwm5t3cm1hRHihqOBNWEEcJS6PIEzbVRd9e9t0JEbF27S1OoPbG0p3em7oreN8PlsH
         i9/4f9NmRPjCm+gD/th02pVl5s4+m1f2SO882nmdzOjNDlSucuTxBdlNYThdJsGdRbSS
         YDSplIVRFFB2FqJj3gtMUXBc6qxRiAfIhuty2k2H9eI/+bpN0BIir++ot1c2NGmZh7iD
         BiN15QEfsgOEFTXfs9pfPNkDDVLCTFKp9uIx5zMq/K2ixav2v0Ns8fehnpZVUbFjmBkZ
         QCMAUMCcQnnr1A67lWNqzNd6FJQyWjXshNpPv0lIZimvEHZtUF8z19lzOsp0L5u+8hec
         ss7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106069; x=1761710869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=AoAdHRsW0BLv5nrlCGXc6nIvXSamtEloTtwWWFX5FxM0bthaBfmE1CpETG/RlcKiQK
         mY80IDbR+EFFbEg6Myg86AMq9bJ8HCvNXdqpoHPdT1mF4v2Z3G3WovVjCQdR/DZ+HDXC
         K2sAeFCYbtxDGWHTN5V9BvXpd7ur6OlZ+Uc5WYyjCY5l5GsyUr2J4FSTxMylQXqD1URu
         uvmEuIlfm9iTs0fHgF/P7C0P83hqYTMB7SlCteuECGTXHnD4oSOKInPKpaSKl4arAqm6
         F08rMxRdpG0Tcy6jzhtASKJmR1WCIrYjxAVHPqpCzRzQ9OoP0qc2ozjxJANOuK0FmjB8
         WTMA==
X-Forwarded-Encrypted: i=1; AJvYcCVY0VUEAB6lYwhGZGq0bu8z7WdCtNmgWqgX3g3G4YIYnSlWsp7kU9ukSjWLEtI0+Hhb2BaccqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4xYT2yA9bdrDrA0uDTqUkroP+0i3e+ldf18z/ltZrfon4YpE
	ryrylwuESYQXx2J9RJNgRKALB/d4mgCz3ICImavYOumUXdmzqWtSR3HlyHNEFGtXsNs=
X-Gm-Gg: ASbGnctQqO1KSnjLdxMJWewz8UcO4fhSzZ6pPYcOQirfiB+gL9hn3ivKW8udMMY31JZ
	utybql8bPqXvupr4LwqfIPfQy3Y7UoaexIYFMylUpg69gdjnhF52/yOSdDzuzTpTCHluuxAOcRO
	F4MtuEjtGvQuR/sIMucqJqrIpCM1i/OI/+vUpbfdE9BhusLTGUaOgBN4q/MxGcaghGVAOFdg5y/
	/nE49YLt2wp13cd2wG5atecAgRoGZE4/OtM9dQe4Y8d7P0QiItrY6liC7qx5YnU6Do5kizDmE4G
	7XiIFRzR8WuqIaiV/WGCjdC7D62Him9PN42259uPlzHPiiOPjEMDV+gv894+RY8TkocvuF7c6Td
	GSCg0c/UZu57c9B1r4T7nJYyyQNEef9AUxkJboUSLzdpYrqKXY+eKTSPvfxUqrHGPlwuQirKA/j
	wrCyGTP/Xaq+yMfUSxIygE6mw6WqHdOXo+HD0LsIHF/T/dxi/hLNutdbUN5Q5mDU70ylRxRNl1C
	ddZS1DJGGX8dcLP1pqEcc8oVQ==
X-Google-Smtp-Source: AGHT+IHycVsOrBUODML9NXrlWEyYylPn+mFR0f8GM0RC+6bm0D8tC29dIctmGREmTFZcZ0hx5duVJg==
X-Received: by 2002:a05:6e02:16ce:b0:42f:9e92:a434 with SMTP id e9e14a558f8ab-430c52b5a2cmr232223235ab.21.1761106069589;
        Tue, 21 Oct 2025 21:07:49 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a973ea40sm4752982173.31.2025.10.21.21.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:07:49 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] ACPI: video: Fix use-after-free in acpi_video_bus_put_devices()
Date: Tue, 21 Oct 2025 23:07:42 -0500
Message-Id: <20251022040743.2102717-1-danisjiang@gmail.com>
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


