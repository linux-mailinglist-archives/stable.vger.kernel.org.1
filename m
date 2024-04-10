Return-Path: <stable+bounces-37938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BD89EEA4
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CCB1C21676
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0615A488;
	Wed, 10 Apr 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e95/wGFo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D8159914
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740656; cv=none; b=nc2F+btQQo5c05wlp9j1nm5WFCXq9rq0hvWA6JOobEOs6Qeh0f78HE4WqWWJCR+q4HY89LEX4c40VAxIuUPet9YaRN9pGpoRiiRRC4GTRTXICPFRbtzs3dogXLG5yhdeJq0p2Ixhf8zexBGGkohlPQ84T1UCACNzn6l6PUD0cNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740656; c=relaxed/simple;
	bh=9LHGpQLsUsV9IlCelwSTEta5vFdCxyJ+Y6K7CgbLUh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVs6+f3GqRxsUbtWsMkWunBNaair66vLOnskOecQv+MtLwDxWWy+7EDEANvBpOeNV+J3fdCgkSXvbVfxq4NAAO+YVulc2eqG1NFv26ukcOySQYXITUqjopctMwDC8y2uSmpnbkNFSeAsT8Zz4T9NjiWBU3cm3upk7qsJXnDQXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e95/wGFo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712740653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDok1ZU+W6gDZg/tidOnUiBM7iNh4cGdBD5Z0gIhBCs=;
	b=e95/wGFoeHb1nkpjlGfxe1Kq92XfmY9c/Ewn0NH/0cSSq36vvp9DVZRXGBEyElhn7r3Xmf
	5Fqn9Ok7OOGm4s5ZmQJ4KTzFb2INqJPqsW3AqPRW/xe65x4C/nXKzNfXNKd9+EEi2afTIr
	742I6yp0aPBMt1tAQFltcfxwol3xInQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-U3v3Xgj8NiyxyvdMockbmw-1; Wed, 10 Apr 2024 05:17:30 -0400
X-MC-Unique: U3v3Xgj8NiyxyvdMockbmw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDC8E10499A7;
	Wed, 10 Apr 2024 09:17:29 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2123E4867A2;
	Wed, 10 Apr 2024 09:17:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 4.19.y] virtio: reenable config if freezing device failed
Date: Wed, 10 Apr 2024 11:17:22 +0200
Message-ID: <20240410091722.113899-1-david@redhat.com>
In-Reply-To: <20240327122643.2841302-1-sashal@kernel.org>
References: <20240327122643.2841302-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Currently, we don't reenable the config if freezing the device failed.

For example, virtio-mem currently doesn't support suspend+resume, and
trying to freeze the device will always fail. Afterwards, the device
will no longer respond to resize requests, because it won't get notified
about config changes.

Let's fix this by re-enabling the config if freezing fails.

Fixes: 22b7050a024d ("virtio: defer config changed notifications")
Cc: <stable@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240213135425.795001-1-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 310227f42882c52356b523e2f4e11690eebcd2ab)
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 89935105df49..3a16ac6b47fc 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -376,13 +376,19 @@ EXPORT_SYMBOL_GPL(unregister_virtio_device);
 int virtio_device_freeze(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
 
 	virtio_config_disable(dev);
 
 	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
 
-	if (drv && drv->freeze)
-		return drv->freeze(dev);
+	if (drv && drv->freeze) {
+		ret = drv->freeze(dev);
+		if (ret) {
+			virtio_config_enable(dev);
+			return ret;
+		}
+	}
 
 	return 0;
 }
-- 
2.44.0


