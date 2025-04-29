Return-Path: <stable+bounces-139006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A20AA3D98
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DB23BE4D5
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD192BD589;
	Tue, 29 Apr 2025 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7DNyqxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3F246776;
	Tue, 29 Apr 2025 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970707; cv=none; b=YR1Gr3vgcaQ+4HgtoIF/5m1hRnHTxfXDGLradPpY+4xpsuKMVpMh88YnqUy/0IbbF+WRIGTlVbt6oA4Z1NUDpuK5+owVRNLTi8l4YZhh7B+f2AzkTWJr1e0MvNyVaKjzAMdev+FYcZ72QR7gwUo15FUbDkW1tQ3TLi0/d6Hpogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970707; c=relaxed/simple;
	bh=t4WELsB66WJR8cUmt8AcNu+VhIDJ+oLOgkxO8z/fUrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPAXPLySkaKbTBhJAITkBSHP7Dyx0+Uqb+vaOKs+WuFnRG3R72Yp95cLOV8dwXtYF2rV6P7USfwMLDVdmgmyf0l1fobn/RQ+HdZxKud+/7wx6h2DNG+E6SEvs+4AKlVF9QdRVMDRmuU+2urCZZiEdNialzsw8OvpHRl8/1O0c0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7DNyqxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60E8C4CEEE;
	Tue, 29 Apr 2025 23:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970705;
	bh=t4WELsB66WJR8cUmt8AcNu+VhIDJ+oLOgkxO8z/fUrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7DNyqxhfY3P4a3/9ZiKx7rWfQxy6z1q+IlueE7Yq7erFNSW9ReBE9/aS5+58hZyY
	 y8VTSRcJwpFAHdU1EVWWZ0nONFxMVXiit2gl86xrr/lOn8TTRMB2YE9mBiiQxN6Gu8
	 klwnQru7XzlYO6X3eldLL2SQeW6W2ROpFSDEfKzcScpBVfsEYs+MZK845t81263MBF
	 dnSSjD7t31kIey4UEWUcUZ1F7rKKylDHb3nDNXvG78OEpt0S7SDJfFE4D90pL6fMXz
	 mqrZe8eYgxsj6C5MnlTAqPUXcL1RPhdONKgwiw0dNXPCIK3lrMvtElxgTIS9N6yyo2
	 A8Z2Kc8F7liNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>,
	syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 11/37] virtio_ring: Fix data race by tagging event_triggered as racy for KCSAN
Date: Tue, 29 Apr 2025 19:50:56 -0400
Message-Id: <20250429235122.537321-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

[ Upstream commit 2e2f925fe737576df2373931c95e1a2b66efdfef ]

syzbot reports a data-race when accessing the event_triggered, here is the
simplified stack when the issue occurred:

==================================================================
BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delayed

write to 0xffff8881025bc452 of 1 bytes by task 3288 on cpu 0:
 virtqueue_enable_cb_delayed+0x42/0x3c0 drivers/virtio/virtio_ring.c:2653
 start_xmit+0x230/0x1310 drivers/net/virtio_net.c:3264
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]

read to 0xffff8881025bc452 of 1 bytes by interrupt on cpu 1:
 virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:880 [inline]
 virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2566
 skb_xmit_done+0x5f/0x140 drivers/net/virtio_net.c:777
 vring_interrupt+0x161/0x190 drivers/virtio/virtio_ring.c:2715
 __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]

value changed: 0x01 -> 0x00
==================================================================

When the data race occurs, the function virtqueue_enable_cb_delayed() sets
event_triggered to false, and virtqueue_disable_cb_split/packed() reads it
as false due to the race condition. Since event_triggered is an unreliable
hint used for optimization, this should only cause the driver temporarily
suggest that the device not send an interrupt notification when the event
index is used.

Fix this KCSAN reported data-race issue by explicitly tagging the access as
data_racy.

Reported-by: syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67c7761a.050a0220.15b4b9.0018.GAE@google.com/
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Message-Id: <20250312130412.3516307-1-quic_zhonhan@quicinc.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0112742e4504b..d64ddc1414ac4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2530,7 +2530,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->event_triggered)
-		vq->event_triggered = false;
+		data_race(vq->event_triggered = false);
 
 	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
 				 virtqueue_enable_cb_delayed_split(_vq);
-- 
2.39.5


