Return-Path: <stable+bounces-33768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335F892630
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 22:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC54A1F2262D
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 21:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA3C13C3C5;
	Fri, 29 Mar 2024 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdFZ9tJQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506429D06
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748348; cv=none; b=ax3VjuZPBB+TAgnuLUWUJieDC8PXE2bP3WgoshEFOL9sI3SK1zPlCWgp1GPk7QSlBqXVofocZS5LbtLeqzfdFElF8UDfazRox49bLkmGDp0Mno6XEC9ZmK0ANRbPVAckeYN9aQx7kJsZsJhhj7LMWS3hMfE1AZlmnO7WkVEftuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748348; c=relaxed/simple;
	bh=xqVel5L4k2pv8B9jW6Ww9h8i710AbFg6ZX5tM3l6XO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvs5aOLs3WnpOIF5fx9yh0u0ztmf24qAzumjWYJEUvg0Kff/RNg4LVr8pxVDcKD1isEExZQjYbaRD1CgABPKnEyNldHpaGw80GRCB15ishxGwfJFzYbyxdZsP7y0Fuc0gxyjB/fNhlKVmRYJ1J8a0C8O3gJA80x4P6JxlUjA4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdFZ9tJQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711748345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzMnP394btx3N2RA/1dIjEkdqOtKvvCLW5NCv7BSqjo=;
	b=ZdFZ9tJQ0ewmjneCtAygmeGahPoR3j9JYddXOJOxmGYeUumvTy40dfCZGG2jlIx0FXsLzS
	2Rj4ZHziQAx9ZVv/4OcoRQQtMx1yKQFBJKBoApI7fP6EzCARRZ24x+oKFG3c1CUoY1FFRi
	ehnnx4ykr+uFnzmexT+Q0srTtF0/LEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-zEb4nJ-7Mn2Xa-mduMh6sA-1; Fri, 29 Mar 2024 17:39:03 -0400
X-MC-Unique: zEb4nJ-7Mn2Xa-mduMh6sA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDC00185A783;
	Fri, 29 Mar 2024 21:39:02 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2FAD492BDB;
	Fri, 29 Mar 2024 21:39:01 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com,
	Kevin Tian <kevin.tian@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 6.1.y 4/7] vfio: Introduce interface to flush virqfd inject workqueue
Date: Fri, 29 Mar 2024 15:38:51 -0600
Message-ID: <20240329213856.2550762-5-alex.williamson@redhat.com>
In-Reply-To: <20240329213856.2550762-1-alex.williamson@redhat.com>
References: <20240329213856.2550762-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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
---
 drivers/vfio/virqfd.c | 21 +++++++++++++++++++++
 include/linux/vfio.h  |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index a928c68df476..e06b32ddedce 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -104,6 +104,13 @@ static void virqfd_inject(struct work_struct *work)
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
@@ -127,6 +134,7 @@ int vfio_virqfd_enable(void *opaque,
 
 	INIT_WORK(&virqfd->shutdown, virqfd_shutdown);
 	INIT_WORK(&virqfd->inject, virqfd_inject);
+	INIT_WORK(&virqfd->flush_inject, virqfd_flush_inject);
 
 	irqfd = fdget(fd);
 	if (!irqfd.file) {
@@ -217,6 +225,19 @@ void vfio_virqfd_disable(struct virqfd **pvirqfd)
 }
 EXPORT_SYMBOL_GPL(vfio_virqfd_disable);
 
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
+
 module_init(vfio_virqfd_init);
 module_exit(vfio_virqfd_exit);
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index fdd393f70b19..5e7bf143cb22 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -268,6 +268,7 @@ struct virqfd {
 	wait_queue_entry_t		wait;
 	poll_table		pt;
 	struct work_struct	shutdown;
+	struct work_struct	flush_inject;
 	struct virqfd		**pvirqfd;
 };
 
@@ -275,5 +276,6 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 		       void (*thread)(void *, void *), void *data,
 		       struct virqfd **pvirqfd, int fd);
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
+void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
 #endif /* VFIO_H */
-- 
2.44.0


