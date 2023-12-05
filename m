Return-Path: <stable+bounces-4178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCF804665
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A78A1C20C88
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4966FB1;
	Tue,  5 Dec 2023 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vwrh2bR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC44437;
	Tue,  5 Dec 2023 03:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F14C433C7;
	Tue,  5 Dec 2023 03:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746830;
	bh=EwKhN0IBsyB3ABwVEd6kiGCvr2gE3oVnB34UZngwtD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vwrh2bR1YX8L5La4ekIQcUldn7Da46PGrU4Xnariaq8QVPqS6wA1HZDzT+sVgs+1x
	 zjw0EKH/X53AgdJeYOXnCRQrbJyFZNupOhaw4NVzucHm0lYZG2uQmJVSHxcw86uBW4
	 DjtYvoFoah2NZJ/r5QnU3r1sDk5utfr8SDmvKFaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Yingliang <yangyingliang@huawei.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4.19 35/71] firewire: core: fix possible memory leak in create_units()
Date: Tue,  5 Dec 2023 12:16:33 +0900
Message-ID: <20231205031519.884884218@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yingliang <yangyingliang@huawei.com>

commit 891e0eab32a57fca4d36c5162628eb0bcb1f0edf upstream.

If device_register() fails, the refcount of device is not 0, the name
allocated in dev_set_name() is leaked. To fix this by calling put_device(),
so that it will be freed in callback function kobject_cleanup().

unreferenced object 0xffff9d99035c7a90 (size 8):
  comm "systemd-udevd", pid 168, jiffies 4294672386 (age 152.089s)
  hex dump (first 8 bytes):
    66 77 30 2e 30 00 ff ff                          fw0.0...
  backtrace:
    [<00000000e1d62bac>] __kmem_cache_alloc_node+0x1e9/0x360
    [<00000000bbeaff31>] __kmalloc_node_track_caller+0x44/0x1a0
    [<00000000491f2fb4>] kvasprintf+0x67/0xd0
    [<000000005b960ddc>] kobject_set_name_vargs+0x1e/0x90
    [<00000000427ac591>] dev_set_name+0x4e/0x70
    [<000000003b4e447d>] create_units+0xc5/0x110

fw_unit_release() will be called in the error path, move fw_device_get()
before calling device_register() to keep balanced with fw_device_put() in
fw_unit_release().

Cc: stable@vger.kernel.org
Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Fixes: a1f64819fe9f ("firewire: struct device - replace bus_id with dev_name(), dev_set_name()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firewire/core-device.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -732,14 +732,11 @@ static void create_units(struct fw_devic
 					fw_unit_attributes,
 					&unit->attribute_group);
 
-		if (device_register(&unit->device) < 0)
-			goto skip_unit;
-
 		fw_device_get(device);
-		continue;
-
-	skip_unit:
-		kfree(unit);
+		if (device_register(&unit->device) < 0) {
+			put_device(&unit->device);
+			continue;
+		}
 	}
 }
 



