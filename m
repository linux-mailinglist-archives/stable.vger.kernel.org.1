Return-Path: <stable+bounces-136728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC769A9CDD8
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043144E0302
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2A18FDD5;
	Fri, 25 Apr 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLQhv7WO"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D618C02E
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597549; cv=none; b=CA9xTT0c3nUF5FeVGXoybKc3KKLAuinlCWPxgQTG7MpxMFzxuSj1LBCqOC7UAf7i2u777cFRzRV2Y0lgWhm017C81nqc84J2yuca9CM6Pc3EMozgTqeNUkkzLkacabvoD3iRvXsPXCGudqDdZysW1MFS3Tw+4X06iN3JGyhz5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597549; c=relaxed/simple;
	bh=H8xvTJ/z9546bClK/os3wkPiMgA0cpepCJaAkf2H1xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww3IppAnYK9AlHQNetTXobaskQ5Fak0XIW+uOox8UU50PcqTAgz8ko0eW2eT3OS/qk41rx+WByrc+EkIiWnGUhUe8yEudOB9HqEDP1Uf6BwWV2/NNEvCXhks+iNbwKXmttIBt/HHkZz6j4dNp5jUIwRAwkT6a39DH5bDsTOmqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLQhv7WO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745597546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvZLXWXEAnZRTWNcPxXgyn2aw/XTTHDqwHq1N+dm8vg=;
	b=VLQhv7WOCwEYkFqaqfuFcC7Uwj5vpIrDoF2Jbtr8uck3moffodx0Z2TBZwG+lQh8eoNsvs
	IsQdifOW9tAMMr4lnoC3+dT2rSnUqvJrS0bdsa4QrhFBEDiEVCFUEkvHfwxnAbm0ZMDjXO
	FgIMe91w5/bgqbGD/Nzzh3VcxcdbbcY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-pR1YVgTfOBeSHjINr0wK2g-1; Fri, 25 Apr 2025 12:12:25 -0400
X-MC-Unique: pR1YVgTfOBeSHjINr0wK2g-1
X-Mimecast-MFC-AGG-ID: pR1YVgTfOBeSHjINr0wK2g_1745597544
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so18049365e9.2
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 09:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597544; x=1746202344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvZLXWXEAnZRTWNcPxXgyn2aw/XTTHDqwHq1N+dm8vg=;
        b=qXyOAOd/PYKTgFCFQu2gVmhWB3YUDgRKf3yrXyR2BoUSt6s2JEAQaz3oToSiG9TkZv
         99ard4H/4CNqzrF35YnjzUX2EC9JHvRnX8UM9259cs1nVdYtF5YUjcpMiNLvW1RQ0qmx
         YgwWGnSuv9H8w8jRQGVKu26oVWmiFRg4g+c1hvP+vMpn9WKq/3AIY1Oq1VA8D2PDmqVh
         JlZjowAilwe4YRysM9aeCzD+ANyGf5Xx5NLcVTsa+lQheLSlyOPdeVppGpj+37eFdHZ2
         UIUL/OoKPPaXLhX/e1mDpLjyqODox34Q6Zqzk7OIAdFffbGGj2z1/mJLBncIMySuNyUw
         oW3A==
X-Gm-Message-State: AOJu0YyOYR3PmEOW9IqUTwj7VI953344nVb+zjdmn0vBmJcxnMbFXZ06
	uFxNzV/i4VKVF60pfUYpA7DiZ2yoTKmWQKr+6bu4A/kDYH1Yy3uJYoUKs6WiMkPhWMrqwwVZKYu
	fN6BXnGnsgQRJ8Wdoiy3SGeVxT+4s01p5uUe1E5ya0Xaz0PrWDPJ/v3rLQQOY1WYyp76ZwhWMD7
	crsQTANeR6YaiVtpzOMENda2XANwMuGZATVW1x
X-Gm-Gg: ASbGncsJ/7RfLQirnXY/aVCBwz9aN9MrwUbOLCSkvVPI8YG9ICXZ6ZUf8JRaTsbRIS/
	j+7Ap+Zj47aJVr5i/D1TwMhMMCBZc8N4K6US42ZeS62WRQlhYRvz7I0TbV/VEFPNRgIu0wdGMi4
	JgFxbzJA15nSyr6xpGSiEPXBtoBv4bg9RbJV7fKjXAJjMm8DjFGqWAzOeFpIzxgZ6mjM7sdfM8F
	sH7WVlVHp6ONIzpL5v/anJLESwxk6/h61SQLUUsFvtxCUSEfwYb+yyN1PH6iwc/5dqfP/IiZSSx
	yBZ/oLlPJCb5CuB0tOU0/8u1Dj4Un1ctIBpbBpYh73oTxkdHDw715PVdU/ryxVx/IGrkuLM=
X-Received: by 2002:a05:6000:178b:b0:39c:1f10:d294 with SMTP id ffacd0b85a97d-3a074e419f2mr2418479f8f.26.1745597544055;
        Fri, 25 Apr 2025 09:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM6Ss1jVRCLtbVBwjlq+nh8vLl1j5CPRqt8asXxNwQ6Ry4CG8+azTIW8HIz1kF006QM5r+BQ==
X-Received: by 2002:a05:6000:178b:b0:39c:1f10:d294 with SMTP id ffacd0b85a97d-3a074e419f2mr2418444f8f.26.1745597543588;
        Fri, 25 Apr 2025 09:12:23 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073e5d479sm2823793f8f.92.2025.04.25.09.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 09:12:23 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Chandra Merla <cmerla@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 5.10.y] s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues
Date: Fri, 25 Apr 2025 18:12:22 +0200
Message-ID: <20250425161222.2183519-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025041736-abrasion-yonder-b301@gregkh>
References: <2025041736-abrasion-yonder-b301@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we finds a vq without a name in our input array in
virtio_ccw_find_vqs(), we treat it as "non-existing" and set the vq pointer
to NULL; we will not call virtio_ccw_setup_vq() to allocate/setup a vq.

Consequently, we create only a queue if it actually exists (name != NULL)
and assign an incremental queue index to each such existing queue.

However, in virtio_ccw_register_adapter_ind()->get_airq_indicator() we
will not ignore these "non-existing queues", but instead assign an airq
indicator to them.

Besides never releasing them in virtio_ccw_drop_indicators() (because
there is no virtqueue), the bigger issue seems to be that there will be a
disagreement between the device and the Linux guest about the airq
indicator to be used for notifying a queue, because the indicator bit
for adapter I/O interrupt is derived from the queue index.

The virtio spec states under "Setting Up Two-Stage Queue Indicators":

	... indicator contains the guest address of an area wherein the
	indicators for the devices are contained, starting at bit_nr, one
	bit per virtqueue of the device.

And further in "Notification via Adapter I/O Interrupts":

	For notifying the driver of virtqueue buffers, the device sets the
	bit in the guest-provided indicator area at the corresponding
	offset.

For example, QEMU uses in virtio_ccw_notify() the queue index (passed as
"vector") to select the relevant indicator bit. If a queue does not exist,
it does not have a corresponding indicator bit assigned, because it
effectively doesn't have a queue index.

Using a virtio-balloon-ccw device under QEMU with free-page-hinting
disabled ("free-page-hint=off") but free-page-reporting enabled
("free-page-reporting=on") will result in free page reporting
not working as expected: in the virtio_balloon driver, we'll be stuck
forever in virtballoon_free_page_report()->wait_event(), because the
waitqueue will not be woken up as the notification from the device is
lost: it would use the wrong indicator bit.

Free page reporting stops working and we get splats (when configured to
detect hung wqs) like:

 INFO: task kworker/1:3:463 blocked for more than 61 seconds.
       Not tainted 6.14.0 #4
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/1:3 [...]
 Workqueue: events page_reporting_process
 Call Trace:
  [<000002f404e6dfb2>] __schedule+0x402/0x1640
  [<000002f404e6f22e>] schedule+0x3e/0xe0
  [<000002f3846a88fa>] virtballoon_free_page_report+0xaa/0x110 [virtio_balloon]
  [<000002f40435c8a4>] page_reporting_process+0x2e4/0x740
  [<000002f403fd3ee2>] process_one_work+0x1c2/0x400
  [<000002f403fd4b96>] worker_thread+0x296/0x420
  [<000002f403fe10b4>] kthread+0x124/0x290
  [<000002f403f4e0dc>] __ret_from_fork+0x3c/0x60
  [<000002f404e77272>] ret_from_fork+0xa/0x38

There was recently a discussion [1] whether the "holes" should be
treated differently again, effectively assigning also non-existing
queues a queue index: that should also fix the issue, but requires other
workarounds to not break existing setups.

Let's fix it without affecting existing setups for now by properly ignoring
the non-existing queues, so the indicator bits will match the queue
indexes.

[1] https://lore.kernel.org/all/cover.1720611677.git.mst@redhat.com/

Fixes: a229989d975e ("virtio: don't allocate vqs when names[i] = NULL")
Reported-by: Chandra Merla <cmerla@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/r/20250402203621.940090-1-david@redhat.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
(cherry picked from commit 2ccd42b959aaf490333dbd3b9b102eaf295c036a)
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 54e686dca6dea..2b33b7f427790 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -261,11 +261,17 @@ static struct airq_info *new_airq_info(int index)
 static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 					u64 *first, void **airq_info)
 {
-	int i, j;
+	int i, j, queue_idx, highest_queue_idx = -1;
 	struct airq_info *info;
 	unsigned long indicator_addr = 0;
 	unsigned long bit, flags;
 
+	/* Array entries without an actual queue pointer must be ignored. */
+	for (i = 0; i < nvqs; i++) {
+		if (vqs[i])
+			highest_queue_idx++;
+	}
+
 	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
 		mutex_lock(&airq_areas_lock);
 		if (!airq_areas[i])
@@ -275,7 +281,7 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 		if (!info)
 			return 0;
 		write_lock_irqsave(&info->lock, flags);
-		bit = airq_iv_alloc(info->aiv, nvqs);
+		bit = airq_iv_alloc(info->aiv, highest_queue_idx + 1);
 		if (bit == -1UL) {
 			/* Not enough vacancies. */
 			write_unlock_irqrestore(&info->lock, flags);
@@ -284,8 +290,10 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 		*first = bit;
 		*airq_info = info;
 		indicator_addr = (unsigned long)info->aiv->vector;
-		for (j = 0; j < nvqs; j++) {
-			airq_iv_set_ptr(info->aiv, bit + j,
+		for (j = 0, queue_idx = 0; j < nvqs; j++) {
+			if (!vqs[j])
+				continue;
+			airq_iv_set_ptr(info->aiv, bit + queue_idx++,
 					(unsigned long)vqs[j]);
 		}
 		write_unlock_irqrestore(&info->lock, flags);
-- 
2.49.0


