Return-Path: <stable+bounces-136725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E34A9CDA8
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D4C18896FB
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F61482E7;
	Fri, 25 Apr 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fee4+RiB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC152701DA
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596889; cv=none; b=kXey7E8FY3L4ra1OYe2OEhMPmNVEg3MISxOi8sqjz3gBBAwRuiAWw30tXK/wkpU22Dx9XAHA2eqVKlV49/QgF2dhS8hxUzi62MkZrEsb3LUeY43iJKBeNFA0eQ9zddK6T22/4W/eDGAk0SLLeLc4uku3JTdAP1KQuY9k4GMRdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596889; c=relaxed/simple;
	bh=eJU0fqy42krozPjlS+w5tzWeChF0hB9d6RfwLpC9yyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2IV6zRKUP946hak3RXEe1IMwUrX1k6biX8jIVGVwjitqaqEYm7Yymzd5k0GCbSETfTWFHZ6AsEk2Pw460PqF8+glJTPm1q4Zi4AbWnD2xEXUqmKvdVjXlheHHzG9/Yss9GF6bevMf46ol8bZ4Fz5g0fE6/KEqQm05JoIF4JPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fee4+RiB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745596886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwFxjOBAerNkoR3/aJuoDZPwad0WKdgtA16K4F7+84A=;
	b=fee4+RiBdCKVeRpMBI8BkJUp0rpNCtACbKvf0jF3EAhnxaVsmwZ0JKmHjHblnHgTRnZR2L
	xNjOcJ6pTb2d+fm0dw5djz+19NmoMCqwM2lkQDmkZfnCUmy25IhwWpMO+X4SQlJWQW+aYp
	L5SgvVX8zxAnLA868trGugyyj7TANPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-AbhJV7MHMJSenv-AyW9REA-1; Fri, 25 Apr 2025 12:01:24 -0400
X-MC-Unique: AbhJV7MHMJSenv-AyW9REA-1
X-Mimecast-MFC-AGG-ID: AbhJV7MHMJSenv-AyW9REA_1745596883
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so14777185e9.3
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 09:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745596883; x=1746201683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwFxjOBAerNkoR3/aJuoDZPwad0WKdgtA16K4F7+84A=;
        b=r3rRrlLTAhioxK1S9/X5ilk3x4fo2vcNIchTrII/t9qTzhygFeG1YqR/9d0imPC4vH
         RLAMnRHSREzH5LhdQSUQdQdPNeIWK8+zvtikbKLqkdJDrMkxhXuTT9rw5PlWESHR6/ky
         7VkuszhDQSlv9hs/zGO4B0FtMf5nEoaLrX8VTrK68fwuhvviAtkhlCHRIHxFl6nY4EZ4
         IhrOc4r3OqXKX4YYXMWo3LC3taZVDUMgs/nmjQjxeSOlV9gdBWKATq0dzdu+EAppnEGE
         3i077IfTrnp+0ZuA+BLtIl3PYMBvTbB1t6ofwhcTB25c3CJNrEJMz3u9oZ8om0dkZHZF
         owDA==
X-Gm-Message-State: AOJu0YzfIrcgrqYsayhzSNPrYI+rlHNe4W3otckJ1Q0xK6o76vGJBnic
	+xqHOHMozCqx+QgFHpbcj8p5KXrvgFveEMXBdO937O6etyH0SefMMba+GsSlHLAR6rOmFAB7lLj
	Un3emE6r+LHwGB4OlUXpZdE0i+4e9TPDlfNeOMlqUDaIf0zUdeo3yMU6WwtHcDiuUojk46GIHbh
	DNCWEOUQsFFOFvMtKYTaZ0lozQ18uWNotaHwh3
X-Gm-Gg: ASbGncuavsOXRgufQvPTLJh3vSLXBTt9cT5u4dLkniVc2kH7BGagTmRrwPlnsDYXRf3
	yMEw5Hs/SeliJCjMJMg2TyLv6/rQrb0YwIEeGwd+Un2uhVyfv81YbLccx71F29ZqLCyT9AmxkI9
	2LZFzWFfuKOj+I0fNHE+RMQ3HWO99wtEFx2uzR/tkaIhHSGRizaaRJvCN7n+euLFiq9wez2UBLy
	BZWFCJFbgtUyoEaAeB5WNpiPlpfeRSGEdQ05BhEUAT638Q0tUaIrNoJx1z7KvsFPm+gP/1RP/uQ
	WqscWAq+aMnhSlpKLAAW/CumDdRQzitpq5l7WSOQva6LQ1+o76GYtmvuGrV4QbOv2BPUAnU=
X-Received: by 2002:a5d:598b:0:b0:39e:dd1e:f325 with SMTP id ffacd0b85a97d-3a074e3bacamr2818179f8f.31.1745596882760;
        Fri, 25 Apr 2025 09:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5wMA8JyN7pNw/c6QsTKawrHUJ8eA3qxhe1feZpa+3/7wHO33pXsRsK3c8spE6+yV3c4IdoQ==
X-Received: by 2002:a5d:598b:0:b0:39e:dd1e:f325 with SMTP id ffacd0b85a97d-3a074e3bacamr2818104f8f.31.1745596881955;
        Fri, 25 Apr 2025 09:01:21 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073e461bfsm2740768f8f.79.2025.04.25.09.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 09:01:21 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Chandra Merla <cmerla@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.1.y] s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues
Date: Fri, 25 Apr 2025 18:01:20 +0200
Message-ID: <20250425160120.2164213-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025041733-cosmetics-brigade-9ed7@gregkh>
References: <2025041733-cosmetics-brigade-9ed7@gregkh>
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
index a10dbe632ef9b..462d67c069ac7 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -264,11 +264,17 @@ static struct airq_info *new_airq_info(int index)
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
@@ -278,7 +284,7 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 		if (!info)
 			return 0;
 		write_lock_irqsave(&info->lock, flags);
-		bit = airq_iv_alloc(info->aiv, nvqs);
+		bit = airq_iv_alloc(info->aiv, highest_queue_idx + 1);
 		if (bit == -1UL) {
 			/* Not enough vacancies. */
 			write_unlock_irqrestore(&info->lock, flags);
@@ -287,8 +293,10 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
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


