Return-Path: <stable+bounces-99074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2C9E6F33
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A9163ED1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32AF206F3B;
	Fri,  6 Dec 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BCB9YGbb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B431FF7D4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491151; cv=none; b=JYkcOxyDqsRHmAfKqSGOrwM4je33cq82R6rRNwDmP9GaxsrHI5yAj/CjjUGQm9STU/no22SKUVF5DTr+V1uTNAhCm4PTDJBlMW6brimYmdYrlrL5dbKMhSjJTov36aISHBulHo39ElsDRaUn1NqJBCvho9J6SR0hdFq/YZ6YmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491151; c=relaxed/simple;
	bh=uRm06lyMY4bbL8I++DVZgxD+JBVM/7kQKzUddkeIdnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOmLDKvadpimRxzPo4lV7UkZgSdPKJAvMB+/KoF8P1AlHuZLGD0HexYetjSEjn9174dW8ghewg2kVjMnTbqM9YHq+Ky/QCziV9Ypfss3FHw5vDFrdZpWA+5fmXLNaU4SD4CjdGHgVLXW6HjTavmDfCZgSVp3mi7PDXkpDJpijFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BCB9YGbb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4668a28158cso29061661cf.0
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 05:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733491148; x=1734095948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuBFvxq+BZx2j/qPw2eVkLp9J70s+Bt2k7xN52PFfGg=;
        b=BCB9YGbbSvP4slE/0CVMM17FFacROExUYmfhxhlHMiIu+zXdYFFj+uTCCWLBKQtD9h
         v8UeNGk1KiBRCyk0n8SbQK3wMSCfjqgdr2c87Eo0n/6LMS2hIkj5iXEJgzxrePAejOuJ
         K00moXP5HIYYqFHzHURf7RL1LcDvAlJ2CSZY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733491148; x=1734095948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuBFvxq+BZx2j/qPw2eVkLp9J70s+Bt2k7xN52PFfGg=;
        b=MpWv6MctcEtzfa70bG054+m62gFgadcxuMkGwsmu6tvckDaxlwrnX4691fDD1AKLxr
         La6RZxP6JTbdrmWn0nIsu9c1UR7zQxCmv3KC7kU+j3my2xqo8/RbC4wo0r74Kl2vrMws
         irb+h5t138rB7CX9WqNYokbKs72B9tJ9ZRDlbK3c/Gk8xtJFkk3SO8QmEjw+kNDCXtq7
         EPg4pZL1kQiUebuzSVJcKDmR334f1e97qAqK7kacw/KwBLFKoRPGoDw9f7xi7KvTyo60
         DhrrOrtxZ4TBF+GxXW20Rc6bFEM6ju11Ce5eRA7Szs1482ugaxjH4op82fLiBS0pqdkR
         G34g==
X-Gm-Message-State: AOJu0YyKWnGl3AROTgq/CYN2mZvPNcc6AN3Ni6ett/d5/TX2Il5pXbFW
	mcTMx8wUc50JgHTCAv958YzrWUorhYTG4J7WVLIogbOuSXCOKKsOG+l+sOZRFYAy/bPQKhfB2/c
	=
X-Gm-Gg: ASbGncva7gjNkaFUt4sOb1AWo3b7p+uhnF/9Fyb+ihu0IzKTSFPHZbmdEjIeLzyI2K/
	AuGg/dHJ60pggXbfiw+HDiTrJWwwvytn77M4WoCShOmQLSiRIIn8T+j59Ekxq4upjW1N4rZvg1C
	TjzGCeIAiQhZnVrRMIHwB7CkMYG3Nlb06jAO+JlvzBVEFvbpmWLZJQkiO+/XRxpuqL3zhDme2bv
	YTq+YlkTu8VDCBKBxFL4NWInssjd3GsOQXAUll36n60JL1pz62DdhPMvD8KHGBI9DTaTlCgxIhl
	/uhYnwqBW/KaTi7nYb6p7QrQO9wWpw==
X-Google-Smtp-Source: AGHT+IH6gPKNWN9GGp6dyKZrVCFU+LHYoQoJCEFNZNykC1cpXL/DGixD9w8xMEjRGUlVHyQOTT6hyg==
X-Received: by 2002:a05:620a:462b:b0:7b1:8cfa:9222 with SMTP id af79cd13be357-7b6bc8fcb7fmr542863885a.1.1733491147644;
        Fri, 06 Dec 2024 05:19:07 -0800 (PST)
Received: from denia.c.googlers.com.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a6751esm171631785a.66.2024.12.06.05.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:19:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	syzbot+0584f746fde3d52b4675@syzkaller.appspotmail.com,
	syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 5.10.y] media: uvcvideo: Require entities to have a non-zero unique ID
Date: Fri,  6 Dec 2024 13:19:01 +0000
Message-ID: <20241206131901.55182-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <2024120653-blaspheme-emphases-81cb@gregkh>
References: <2024120653-blaspheme-emphases-81cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Per UVC 1.1+ specification 3.7.2, units and terminals must have a non-zero
unique ID.

```
Each Unit and Terminal within the video function is assigned a unique
identification number, the Unit ID (UID) or Terminal ID (TID), contained in
the bUnitID or bTerminalID field of the descriptor. The value 0x00 is
reserved for undefined ID,
```

So, deny allocating an entity with ID 0 or an ID that belongs to a unit
that is already added to the list of entities.

This also prevents some syzkaller reproducers from triggering warnings due
to a chain of entities referring to themselves. In one particular case, an
Output Unit is connected to an Input Unit, both with the same ID of 1. But
when looking up for the source ID of the Output Unit, that same entity is
found instead of the input entity, which leads to such warnings.

In another case, a backward chain was considered finished as the source ID
was 0. Later on, that entity was found, but its pads were not valid.

Here is a sample stack trace for one of those cases.

[   20.650953] usb 1-1: new high-speed USB device number 2 using dummy_hcd
[   20.830206] usb 1-1: Using ep0 maxpacket: 8
[   20.833501] usb 1-1: config 0 descriptor??
[   21.038518] usb 1-1: string descriptor 0 read error: -71
[   21.038893] usb 1-1: Found UVC 0.00 device <unnamed> (2833:0201)
[   21.039299] uvcvideo 1-1:0.0: Entity type for entity Output 1 was not initialized!
[   21.041583] uvcvideo 1-1:0.0: Entity type for entity Input 1 was not initialized!
[   21.042218] ------------[ cut here ]------------
[   21.042536] WARNING: CPU: 0 PID: 9 at drivers/media/mc/mc-entity.c:1147 media_create_pad_link+0x2c4/0x2e0
[   21.043195] Modules linked in:
[   21.043535] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.11.0-rc7-00030-g3480e43aeccf #444
[   21.044101] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   21.044639] Workqueue: usb_hub_wq hub_event
[   21.045100] RIP: 0010:media_create_pad_link+0x2c4/0x2e0
[   21.045508] Code: fe e8 20 01 00 00 b8 f4 ff ff ff 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 0f 0b eb e9 0f 0b eb 0a 0f 0b eb 06 <0f> 0b eb 02 0f 0b b8 ea ff ff ff eb d4 66 2e 0f 1f 84 00 00 00 00
[   21.046801] RSP: 0018:ffffc9000004b318 EFLAGS: 00010246
[   21.047227] RAX: ffff888004e5d458 RBX: 0000000000000000 RCX: ffffffff818fccf1
[   21.047719] RDX: 000000000000007b RSI: 0000000000000000 RDI: ffff888004313290
[   21.048241] RBP: ffff888004313290 R08: 0001ffffffffffff R09: 0000000000000000
[   21.048701] R10: 0000000000000013 R11: 0001888004313290 R12: 0000000000000003
[   21.049138] R13: ffff888004313080 R14: ffff888004313080 R15: 0000000000000000
[   21.049648] FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
[   21.050271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.050688] CR2: 0000592cc27635b0 CR3: 000000000431c000 CR4: 0000000000750ef0
[   21.051136] PKRU: 55555554
[   21.051331] Call Trace:
[   21.051480]  <TASK>
[   21.051611]  ? __warn+0xc4/0x210
[   21.051861]  ? media_create_pad_link+0x2c4/0x2e0
[   21.052252]  ? report_bug+0x11b/0x1a0
[   21.052540]  ? trace_hardirqs_on+0x31/0x40
[   21.052901]  ? handle_bug+0x3d/0x70
[   21.053197]  ? exc_invalid_op+0x1a/0x50
[   21.053511]  ? asm_exc_invalid_op+0x1a/0x20
[   21.053924]  ? media_create_pad_link+0x91/0x2e0
[   21.054364]  ? media_create_pad_link+0x2c4/0x2e0
[   21.054834]  ? media_create_pad_link+0x91/0x2e0
[   21.055131]  ? _raw_spin_unlock+0x1e/0x40
[   21.055441]  ? __v4l2_device_register_subdev+0x202/0x210
[   21.055837]  uvc_mc_register_entities+0x358/0x400
[   21.056144]  uvc_register_chains+0x1fd/0x290
[   21.056413]  uvc_probe+0x380e/0x3dc0
[   21.056676]  ? __lock_acquire+0x5aa/0x26e0
[   21.056946]  ? find_held_lock+0x33/0xa0
[   21.057196]  ? kernfs_activate+0x70/0x80
[   21.057533]  ? usb_match_dynamic_id+0x1b/0x70
[   21.057811]  ? find_held_lock+0x33/0xa0
[   21.058047]  ? usb_match_dynamic_id+0x55/0x70
[   21.058330]  ? lock_release+0x124/0x260
[   21.058657]  ? usb_match_one_id_intf+0xa2/0x100
[   21.058997]  usb_probe_interface+0x1ba/0x330
[   21.059399]  really_probe+0x1ba/0x4c0
[   21.059662]  __driver_probe_device+0xb2/0x180
[   21.059944]  driver_probe_device+0x5a/0x100
[   21.060170]  __device_attach_driver+0xe9/0x160
[   21.060427]  ? __pfx___device_attach_driver+0x10/0x10
[   21.060872]  bus_for_each_drv+0xa9/0x100
[   21.061312]  __device_attach+0xed/0x190
[   21.061812]  device_initial_probe+0xe/0x20
[   21.062229]  bus_probe_device+0x4d/0xd0
[   21.062590]  device_add+0x308/0x590
[   21.062912]  usb_set_configuration+0x7b6/0xaf0
[   21.063403]  usb_generic_driver_probe+0x36/0x80
[   21.063714]  usb_probe_device+0x7b/0x130
[   21.063936]  really_probe+0x1ba/0x4c0
[   21.064111]  __driver_probe_device+0xb2/0x180
[   21.064577]  driver_probe_device+0x5a/0x100
[   21.065019]  __device_attach_driver+0xe9/0x160
[   21.065403]  ? __pfx___device_attach_driver+0x10/0x10
[   21.065820]  bus_for_each_drv+0xa9/0x100
[   21.066094]  __device_attach+0xed/0x190
[   21.066535]  device_initial_probe+0xe/0x20
[   21.066992]  bus_probe_device+0x4d/0xd0
[   21.067250]  device_add+0x308/0x590
[   21.067501]  usb_new_device+0x347/0x610
[   21.067817]  hub_event+0x156b/0x1e30
[   21.068060]  ? process_scheduled_works+0x48b/0xaf0
[   21.068337]  process_scheduled_works+0x5a3/0xaf0
[   21.068668]  worker_thread+0x3cf/0x560
[   21.068932]  ? kthread+0x109/0x1b0
[   21.069133]  kthread+0x197/0x1b0
[   21.069343]  ? __pfx_worker_thread+0x10/0x10
[   21.069598]  ? __pfx_kthread+0x10/0x10
[   21.069908]  ret_from_fork+0x32/0x40
[   21.070169]  ? __pfx_kthread+0x10/0x10
[   21.070424]  ret_from_fork_asm+0x1a/0x30
[   21.070737]  </TASK>

Cc: stable@vger.kernel.org
Reported-by: syzbot+0584f746fde3d52b4675@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0584f746fde3d52b4675
Reported-by: syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dd320d114deb3f5bb79b
Fixes: a3fbc2e6bb05 ("media: mc-entity.c: use WARN_ON, validate link pads")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20240913180601.1400596-2-cascardo@igalia.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
(cherry picked from commit 3dd075fe8ebbc6fcbf998f81a75b8c4b159a6195)
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
[ribalda: The context around the changes differs from master. This
version is also missing the gpio unit, so that part is gone from the
patch.]
---
 drivers/media/usb/uvc/uvc_driver.c | 63 ++++++++++++++++++------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 519fd648f26c..f80a9ae2cf4c 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1029,14 +1029,27 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 	return ret;
 }
 
-static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
-		unsigned int num_pads, unsigned int extra_size)
+static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
+					       u16 id, unsigned int num_pads,
+					       unsigned int extra_size)
 {
 	struct uvc_entity *entity;
 	unsigned int num_inputs;
 	unsigned int size;
 	unsigned int i;
 
+	/* Per UVC 1.1+ spec 3.7.2, the ID should be non-zero. */
+	if (id == 0) {
+		dev_err(&dev->udev->dev, "Found Unit with invalid ID 0.\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
+	if (uvc_entity_by_id(dev, id)) {
+		dev_err(&dev->udev->dev, "Found multiple Units with ID %u\n", id);
+		return ERR_PTR(-EINVAL);
+	}
+
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	if (num_pads)
 		num_inputs = type & UVC_TERM_OUTPUT ? num_pads : num_pads - 1;
@@ -1046,7 +1059,7 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
 	     + num_inputs;
 	entity = kzalloc(size, GFP_KERNEL);
 	if (entity == NULL)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	entity->id = id;
 	entity->type = type;
@@ -1117,10 +1130,10 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
 			break;
 		}
 
-		unit = uvc_alloc_entity(UVC_VC_EXTENSION_UNIT, buffer[3],
-					p + 1, 2*n);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, UVC_VC_EXTENSION_UNIT,
+					    buffer[3], p + 1, 2 * n);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
@@ -1231,10 +1244,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		term = uvc_alloc_entity(type | UVC_TERM_INPUT, buffer[3],
-					1, n + p);
-		if (term == NULL)
-			return -ENOMEM;
+		term = uvc_alloc_new_entity(dev, type | UVC_TERM_INPUT,
+					    buffer[3], 1, n + p);
+		if (IS_ERR(term))
+			return PTR_ERR(term);
 
 		if (UVC_ENTITY_TYPE(term) == UVC_ITT_CAMERA) {
 			term->camera.bControlSize = n;
@@ -1290,10 +1303,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return 0;
 		}
 
-		term = uvc_alloc_entity(type | UVC_TERM_OUTPUT, buffer[3],
-					1, 0);
-		if (term == NULL)
-			return -ENOMEM;
+		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
+					    buffer[3], 1, 0);
+		if (IS_ERR(term))
+			return PTR_ERR(term);
 
 		memcpy(term->baSourceID, &buffer[7], 1);
 
@@ -1314,9 +1327,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, 0);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
+					    p + 1, 0);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->baSourceID, &buffer[5], p);
 
@@ -1338,9 +1352,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_entity(buffer[2], buffer[3], 2, n);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3], 2, n);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->baSourceID, &buffer[4], 1);
 		unit->processing.wMaxMultiplier =
@@ -1369,9 +1383,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, n);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
+					    p + 1, n);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
-- 
2.47.0.338.g60cca15819-goog


