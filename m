Return-Path: <stable+bounces-136727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C3A9CDD0
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA2B3B1353
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A018C322;
	Fri, 25 Apr 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibKzPxUx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDEF12C544
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597363; cv=none; b=tb58F8Px8iR1af6mpA330eCgPmWTX57St2J19cckifj5ZP9rzwft3PsnHEPXJ1txWmic1Bf8HDgRuIsztrgZNeE3Nai/SZb1+i2pBfrtmovZBCu8eElQwgcFTh3xbyjYwtHisJf+N8YZNbIy1gcISmhWPrTjX1/EltGcdaQPXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597363; c=relaxed/simple;
	bh=WJGUq1gw3BgUkoKK4+PTl4UDQy0n0VVCsfcSoYDyWIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXqN5bgMA6AoXpv6djdHNSsn6dRGAZDGSX39Ii6zlBuS6gq4LsWXp3agjwqUVJcnmfSwenpMIr5eExb6UK1lrDKitoIBpuV9CiqIlgOIMGsorR5n0hyCfXH7wGDmzNZhTFyjCdDGR/tO34CQk9ey2Mso1Y+RRKquochndrOuZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibKzPxUx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745597360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3soF/qLye5dVIQOQ9JLSIx6TABEciUGof6ZbxtO4oKI=;
	b=ibKzPxUx1Vjlwt1raNs7ZJ7Uca9LAIpSsX4R5cKzEYCWOTtlxxkWedH1F8w/2N+PTgD7AS
	QwBGY7jqhUVum2hxn+q2J9DCAWndyxfOI0GwIbqsmx4YBozVFQyPaKsyxaDRsK1IG2Xhq5
	9D2HcMWzDM17ScZztWqpgL8VCF54rhM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-uimT9dO_PoWhyOjFc06bEA-1; Fri, 25 Apr 2025 12:09:19 -0400
X-MC-Unique: uimT9dO_PoWhyOjFc06bEA-1
X-Mimecast-MFC-AGG-ID: uimT9dO_PoWhyOjFc06bEA_1745597358
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so12632685e9.0
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 09:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597358; x=1746202158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3soF/qLye5dVIQOQ9JLSIx6TABEciUGof6ZbxtO4oKI=;
        b=www9ZE9WJxvT8AB1Hok1eaH3BWnTmYMZqRJDf1uQ4sllcaxojAkdvbDFXFE1C/hv4v
         ZxAV0a/2ezaWBCZe7ysA+Jk7upjg2Ie+/cL+5T4rM/HJ6zvgXejIlkRguMts/q0OwfAg
         HUiExwemV1VWG66ybug0qjMKmQ1cBS9X2Av8Cfnx5ZKHbq5LBxOurJciz0MuhpA1g8gX
         /LJi0Iy8sNF4Ara5rPd4L+lsy5ljRY6og8hdVq+9wEHnXjnHzfrI5dNYRlkGnsFTpKdF
         Crnw36b+Qd8xThcRXxyVAbH8z0kekJQ9lSQWbL2q9bO8dBdLOEDnD/XXcTubAd2cb90C
         P8Xg==
X-Gm-Message-State: AOJu0YyclyJehaloe1kc8qhUf65pmD3jrjOTa30Xc/zd2lqfyGg1RtVp
	BfyU+CkO/59cry556UEjFgVZ/zicIfV/5dthJLv42FueMR0RkYwXsqAakOeZZxLWy3kazVX4oc2
	tUWTwHObGDO62T6Q2Qdm2HgG7M1Q/Skv/nVwqc9ouG/UU59W4ZDMbcDEo6V5XaMGc23mhV2qCDw
	oeD7nVA3a5qGtHbibIF5D4VVuZsp3oZk1pmSp1
X-Gm-Gg: ASbGnctBfEE6wMYeSS55atlEg0uze3bZ/uCHEg7c0zbQ4UDiiUTAhyU7FY3pnIyFIyT
	4Rcs2yB2ekl8cNRgzpOvd85Uj+EzsrOST65J77ezoTqVvTQzCG3oqV5WND3+2LCLhVr9BMH/yuy
	25UG2m9MSp16mwIEdkyPuCcySiGjKaHFdoJA6lxVzdh2gXpaClzMPrT7twk543OYCWfWwM6eo7z
	d56ayQFajjhD31ZNMzB66oad+QFqTS9aErDJoypU9ut7XZ0dDGJgtVkXOzN9inM1C16eFDg4WmI
	2VP7RpW1IGrrUjFuX1vvPc+oELK31b/t1sCIVzEFO6jMCG7IZagriJYiV1yRsA04FXNWsDM=
X-Received: by 2002:a05:600c:524f:b0:43c:eec7:eabb with SMTP id 5b1f17b1804b1-440a65dcddfmr20915285e9.8.1745597357672;
        Fri, 25 Apr 2025 09:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyj6tdfGfrgXOgn54Y/UusnMa8435YXE2xJIFvr2Bf6EG64f7FjjB2ysvvvjHzBph/9vgerQ==
X-Received: by 2002:a05:600c:524f:b0:43c:eec7:eabb with SMTP id 5b1f17b1804b1-440a65dcddfmr20914655e9.8.1745597357081;
        Fri, 25 Apr 2025 09:09:17 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-440a52f8909sm30396725e9.2.2025.04.25.09.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 09:09:16 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Chandra Merla <cmerla@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 5.15.y] s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues
Date: Fri, 25 Apr 2025 18:09:15 +0200
Message-ID: <20250425160915.2178126-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025041734-deport-antennae-d763@gregkh>
References: <2025041734-deport-antennae-d763@gregkh>
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
index d35e7a3f7067b..2febb4c56e06b 100644
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


