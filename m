Return-Path: <stable+bounces-177059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C7B4030B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D014E630D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A309311C14;
	Tue,  2 Sep 2025 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MgS/6P0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5431197E;
	Tue,  2 Sep 2025 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819439; cv=none; b=BxIVLq2FU60aiQoby6GsfH71ZCdnvdmmH9GcykHMJffz1e/KQGgTc4ZZruZ7dpHJlE94b2klXR5zv/SAuuTxNPI8SZOApYzkxR+zuhrr+YeUsAvV8bzbg92tCZHxAw/eZlbY8/o5NBxYcXQLXw19eD1gpF92oTHXW9WKfWNaMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819439; c=relaxed/simple;
	bh=OxuImUvYIPbeGXNgTCk1YDRZyboqyZVpGTsNQVF6d9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAGP39mpW9AwKBez7BSt8CTCA6PpS6QQI4sXDxk+7sP0S83+JImu6A1LxH2zp7mb3e/AHtcbZImuVyfWhvTLyHLwivumYt/D7HURFkZIJ9/4ctCSJwLCwOGnzkxFDdy+GqpZOXnSKwD2CgMvC6KURiOZ9qr6d8EK74b0aZUCMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MgS/6P0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AACC4CEED;
	Tue,  2 Sep 2025 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819438;
	bh=OxuImUvYIPbeGXNgTCk1YDRZyboqyZVpGTsNQVF6d9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgS/6P0bogNoG3pTxHdkccI30xJ7wzwoyZ4mcZ8fLy3OmA+0HGOjlnOoxgaaDB168
	 CUuNzKRjqBFS3LLdfdyJ82RjMGJPjLU1WvniTbhGPtBSwqKw5s3GEYE9vy2OTUgXDn
	 r1rFHKT5wyA3n8Ke8NwPvWPAn1I4MVe7AIcO4780=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Ryabinin <arbn@yandex-team.com>,
	Hillf Danton <hdanton@sina.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.16 027/142] vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()
Date: Tue,  2 Sep 2025 15:18:49 +0200
Message-ID: <20250902131949.184286157@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Kuratov <kniv@yandex-team.ru>

commit dd54bcf86c91a4455b1f95cbc8e9ac91205f3193 upstream.

When operating on struct vhost_net_ubuf_ref, the following execution
sequence is theoretically possible:
CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NET_SET_BACKEND
                             // ubufs->refcount == 2
vhost_net_ubuf_put()                               vhost_net_ubuf_put_wait_and_free(oldubufs)
                                                     vhost_net_ubuf_put_and_wait()
                                                       vhost_net_ubuf_put()
                                                         int r = atomic_sub_return(1, &ubufs->refcount);
                                                         // r = 1
int r = atomic_sub_return(1, &ubufs->refcount);
// r = 0
                                                      wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
                                                      // no wait occurs here because condition is already true
                                                    kfree(ubufs);
if (unlikely(!r))
  wake_up(&ubufs->wait);  // use-after-free

This leads to use-after-free on ubufs access. This happens because CPU1
skips waiting for wake_up() when refcount is already zero.

To prevent that use a read-side RCU critical section in vhost_net_ubuf_put(),
as suggested by Hillf Danton. For this lock to take effect, free ubufs with
kfree_rcu().

Cc: stable@vger.kernel.org
Fixes: 0ad8b480d6ee9 ("vhost: fix ref cnt checking deadlock")
Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Message-Id: <20250805130917.727332-1-kniv@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -96,6 +96,7 @@ struct vhost_net_ubuf_ref {
 	atomic_t refcount;
 	wait_queue_head_t wait;
 	struct vhost_virtqueue *vq;
+	struct rcu_head rcu;
 };
 
 #define VHOST_NET_BATCH 64
@@ -247,9 +248,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqu
 
 static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
 {
-	int r = atomic_sub_return(1, &ubufs->refcount);
+	int r;
+
+	rcu_read_lock();
+	r = atomic_sub_return(1, &ubufs->refcount);
 	if (unlikely(!r))
 		wake_up(&ubufs->wait);
+	rcu_read_unlock();
 	return r;
 }
 
@@ -262,7 +267,7 @@ static void vhost_net_ubuf_put_and_wait(
 static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
 {
 	vhost_net_ubuf_put_and_wait(ubufs);
-	kfree(ubufs);
+	kfree_rcu(ubufs, rcu);
 }
 
 static void vhost_net_clear_ubuf_info(struct vhost_net *n)



