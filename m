Return-Path: <stable+bounces-33035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD788F231
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3C91F2EA22
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 22:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E5153BF9;
	Wed, 27 Mar 2024 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KppiD7TL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDA153BEF
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580112; cv=none; b=dZsenTOd8D/ES6NPIk5nHV/funL4iBzGjTv516AawshsEXYwpHHWeiY2ecH/+WZ1nN8+Ia++XDxCH3dRG0AovQHXlYI/HqYu45ZhwFLjppDpCerfATYCto+78SeV+q1Lcn3tAW1oZ703+1poodFU67i1kHBHTtA30pNYMEuBQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580112; c=relaxed/simple;
	bh=BnjVlT1EFno91KgemSt8hfIphhMhNHJ1lUcfKdC3wmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssV3r2dnj9H0UUug3v3vpZKcd93Z+gDTG0lKIKNRX89NE5K4kEPUFsbQn6eCUKEOADNfMvcM5WvaEJggEfPfItFigB28oytsUXhtvIrDcYXSPUn9L39muz/sskiZI/YZfCNnIYQBVLOfKYZvA0YA8HxYNnNn/V7PqA8B9mOgU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KppiD7TL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711580109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVU5cqweDoNH1rLkxHJUiRqVEfX3EPWMc6QLpYqDgQU=;
	b=KppiD7TLu0gBxlo+d7za14CDoJ+mK/8UuRCtcg0nnP21k3JxTjwnCME3LaJimXweUrEKOT
	8DHB1uPG20HxRwFxTZAm32Ecrz2atWuO200H4J/1TJOraQPZU5aHDeEOgBq/1fze/XJLCW
	jbr7CL/RuFHIa7sj2NCs1IyI3a6I5Co=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-oF2_VqyFOIGj4IIuQeObIA-1; Wed, 27 Mar 2024 18:55:05 -0400
X-MC-Unique: oF2_VqyFOIGj4IIuQeObIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51E93101A58F;
	Wed, 27 Mar 2024 22:55:05 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63046111F3C6;
	Wed, 27 Mar 2024 22:55:04 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	eric.auger@redhat.com,
	sashal@kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 6.6.y 1/4] vfio: Introduce interface to flush virqfd inject workqueue
Date: Wed, 27 Mar 2024 16:54:27 -0600
Message-ID: <20240327225444.909882-2-alex.williamson@redhat.com>
In-Reply-To: <20240327225444.909882-1-alex.williamson@redhat.com>
References: <20240327225444.909882-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

[ Upstream commit b620ecbd17a03cacd06f014a5d3f3a11285ce053 ]

In order to synchronize changes that can affect the thread callback,
introduce an interface to force a flush of the inject workqueue.  The
irqfd pointer is only valid under spinlock, but the workqueue cannot
be flushed under spinlock.  Therefore the flush work for the irqfd is
queued under spinlock.  The vfio_irqfd_cleanup_wq workqueue is re-used
for queuing this work such that flushing the workqueue is also ordered
relative to shutdown.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20240308230557.805580-4-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Stable-dep-of: 18c198c96a81 ("vfio/pci: Create persistent INTx handler")
---
 drivers/vfio/virqfd.c | 21 +++++++++++++++++++++
 include/linux/vfio.h  |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 29c564b7a6e1..532269133801 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -101,6 +101,13 @@ static void virqfd_inject(struct work_struct *work)
 		virqfd->thread(virqfd->opaque, virqfd->data);
 }
 
+static void virqfd_flush_inject(struct work_struct *work)
+{
+	struct virqfd *virqfd = container_of(work, struct virqfd, flush_inject);
+
+	flush_work(&virqfd->inject);
+}
+
 int vfio_virqfd_enable(void *opaque,
 		       int (*handler)(void *, void *),
 		       void (*thread)(void *, void *),
@@ -124,6 +131,7 @@ int vfio_virqfd_enable(void *opaque,
 
 	INIT_WORK(&virqfd->shutdown, virqfd_shutdown);
 	INIT_WORK(&virqfd->inject, virqfd_inject);
+	INIT_WORK(&virqfd->flush_inject, virqfd_flush_inject);
 
 	irqfd = fdget(fd);
 	if (!irqfd.file) {
@@ -213,3 +221,16 @@ void vfio_virqfd_disable(struct virqfd **pvirqfd)
 	flush_workqueue(vfio_irqfd_cleanup_wq);
 }
 EXPORT_SYMBOL_GPL(vfio_virqfd_disable);
+
+void vfio_virqfd_flush_thread(struct virqfd **pvirqfd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&virqfd_lock, flags);
+	if (*pvirqfd && (*pvirqfd)->thread)
+		queue_work(vfio_irqfd_cleanup_wq, &(*pvirqfd)->flush_inject);
+	spin_unlock_irqrestore(&virqfd_lock, flags);
+
+	flush_workqueue(vfio_irqfd_cleanup_wq);
+}
+EXPORT_SYMBOL_GPL(vfio_virqfd_flush_thread);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index a65b2513f8cd..5ac5f182ce0b 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -349,6 +349,7 @@ struct virqfd {
 	wait_queue_entry_t		wait;
 	poll_table		pt;
 	struct work_struct	shutdown;
+	struct work_struct	flush_inject;
 	struct virqfd		**pvirqfd;
 };
 
@@ -356,5 +357,6 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 		       void (*thread)(void *, void *), void *data,
 		       struct virqfd **pvirqfd, int fd);
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
+void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
 #endif /* VFIO_H */
-- 
2.44.0


