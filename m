Return-Path: <stable+bounces-232715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFP3ARPVzGnnWwYAu9opvQ
	(envelope-from <stable+bounces-232715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:19:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D8A376A59
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8743530FEF13
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD1382389;
	Wed,  1 Apr 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="oCpI4IYa"
X-Original-To: stable@vger.kernel.org
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA313A8746
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031071; cv=none; b=AGW9r7LPXa9Bztd+WbImjudVOWuzu3KVJR8LkP6s/fQ5WB1rdlg/1Dm9691k4SpiG7GSCXzaGpuKpqnlEW94a3rig/QqF7t9gQY/Kl3sGWvAL95otneouTENt9rF8Im65qyAZ8aVyPMp9FLVtzvHoG5u5eei2dc7lf/o8xAZINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031071; c=relaxed/simple;
	bh=l/R7MstC1lsAPvOIyctP2OinN+opa7eRa+B8n53id0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bej57Ttx9pqV+7JerWGDu99v7RYyv7Hl5ddGXYCUVOAx+/G2/ubhJ3K+Wg1Vss/3wnKumOpazsTYlRuyC2bpOrioKGDkmleR6sF7ObSRdPbollcwogXAk5wWW8unrAlo5gCJlO/hvUZpdLrdenlUnUsLgjN/tq8bAv0ra6kfxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=oCpI4IYa; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1775031063;
	bh=IM6FBYx0ryIlI9rQj8aNP8O2s3A9zHT5fBYis5L3fPw=;
	h=From:Subject:Date:Message-Id;
	b=oCpI4IYaaKGklntSxgf5VggYsA3GFQ+LmrTg2jsso4YZgYsCLq7UgsT0SsEC2SaCu
	 SHOgGA9ODAWy9NYHEldO5C0fHUUdDsDZe6ajay++5kSJ4tm8sW9KJHJ35sSDU/0AHx
	 0F/UeQb6QO+gYOrqVOfY+5F0TSc0TPFOhoBp6k+c=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.21) with ESMTP
	id 69CCD30900004EEC; Wed, 1 Apr 2026 16:10:54 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 2810233408195
X-SMAIL-UIID: 8391BF5FA20746BB9CA1C3E05E85D98F-20260401-161054-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	syzbot+0584f746fde3d52b4675@syzkaller.appspotmail.com,
	syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com,
	Youngjun Lee <yjjuny.lee@samsung.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID
Date: Wed,  1 Apr 2026 16:10:48 +0800
Message-Id: <20260401081048.2338697-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232715-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[sina.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sina.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,igalia.com,syzkaller.appspotmail.com,samsung.com,chromium.org,ideasonboard.com,kernel.org,sina.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,0584f746fde3d52b4675,dd320d114deb3f5bb79b,cisco];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.com:dkim,sina.com:email,sina.com:mid,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ideasonboard.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 66D8A376A59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

[ Upstream commit 0e2ee70291e64a30fe36960c85294726d34a103e ]

Per UVC 1.1+ specification 3.7.2, units and terminals must have a non-zero
unique ID.

```
Each Unit and Terminal within the video function is assigned a unique
identification number, the Unit ID (UID) or Terminal ID (TID), contained in
the bUnitID or bTerminalID field of the descriptor. The value 0x00 is
reserved for undefined ID,
```

If we add a new entity with id 0 or a duplicated ID, it will be marked
as UVC_INVALID_ENTITY_ID.

In a previous attempt commit 3dd075fe8ebb ("media: uvcvideo: Require
entities to have a non-zero unique ID"), we ignored all the invalid units,
this broke a lot of non-compatible cameras. Hopefully we are more lucky
this time.

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

Reported-by: syzbot+0584f746fde3d52b4675@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0584f746fde3d52b4675
Reported-by: syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dd320d114deb3f5bb79b
Reported-by: Youngjun Lee <yjjuny.lee@samsung.com>
Fixes: a3fbc2e6bb05 ("media: mc-entity.c: use WARN_ON, validate link pads")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Co-developed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 73 +++++++++++++++++++-----------
 drivers/media/usb/uvc/uvcvideo.h   |  2 +
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 858fc5b26a5e..c39c1f237d10 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -413,6 +413,9 @@ struct uvc_entity *uvc_entity_by_id(struct uvc_device *dev, int id)
 {
 	struct uvc_entity *entity;
 
+	if (id == UVC_INVALID_ENTITY_ID)
+		return NULL;
+
 	list_for_each_entry(entity, &dev->entities, list) {
 		if (entity->id == id)
 			return entity;
@@ -1029,14 +1032,27 @@ static const u8 uvc_media_transport_input_guid[16] =
 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
 static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
 
-static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
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
+		dev_err(&dev->intf->dev, "Found Unit with invalid ID 0\n");
+		id = UVC_INVALID_ENTITY_ID;
+	}
+
+	/* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
+	if (uvc_entity_by_id(dev, id)) {
+		dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
+		id = UVC_INVALID_ENTITY_ID;
+	}
+
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	if (num_pads)
 		num_inputs = type & UVC_TERM_OUTPUT ? num_pads : num_pads - 1;
@@ -1046,7 +1062,7 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 	     + num_inputs;
 	entity = kzalloc(size, GFP_KERNEL);
 	if (entity == NULL)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	entity->id = id;
 	entity->type = type;
@@ -1136,10 +1152,10 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
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
 
 		memcpy(unit->guid, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
@@ -1249,10 +1265,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
@@ -1308,10 +1324,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
 
@@ -1332,9 +1348,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
 
@@ -1356,9 +1373,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
@@ -1387,9 +1404,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, n);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
+					    p + 1, n);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->guid, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
@@ -1528,9 +1546,10 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 		return dev_err_probe(&dev->intf->dev, irq,
 				     "No IRQ for privacy GPIO\n");
 
-	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
-	if (!unit)
-		return -ENOMEM;
+	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
+				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
+	if (IS_ERR(unit))
+		return PTR_ERR(unit);
 
 	unit->gpio.gpio_privacy = gpio_privacy;
 	unit->gpio.irq = irq;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 95af1591f105..be4b746d902c 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -41,6 +41,8 @@
 #define UVC_EXT_GPIO_UNIT		0x7ffe
 #define UVC_EXT_GPIO_UNIT_ID		0x100
 
+#define UVC_INVALID_ENTITY_ID          0xffff
+
 /* ------------------------------------------------------------------------
  * GUIDs
  */
-- 
2.34.1


