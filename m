Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A107A8031
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjITMdn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjITMdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:33:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21781AB
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C1C433CA;
        Wed, 20 Sep 2023 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213216;
        bh=9OL4dYu5Z5MVc5sdmdOf2kFkNtHPngz7tzGSCjJyf00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNTvdd0OnIn/oNdBVtGsRBt6tDzDmQP+w2AhNTndYqt2wWND9/5QQiKZQAyKKnFCU
         2+CCe0ALVubkXZeEoamMIqT4ckfDIkhiXjUXj8Tb2G8N+h/+buB526oA9QoPfx7fod
         XEsEZeSTAHpTLqDBtaaXMTpgmJtac1hbdUHJU9t8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Yao <yuanyaogoog@chromium.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 203/367] virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
Date:   Wed, 20 Sep 2023 13:29:40 +0200
Message-ID: <20230920112903.879317771@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuan Yao <yuanyaogoog@chromium.org>

[ Upstream commit 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab ]

In current packed virtqueue implementation, the avail_wrap_counter won't
flip, in the case when the driver supplies a descriptor chain with a
length equals to the queue size; total_sg == vq->packed.vring.num.

Let’s assume the following situation:
vq->packed.vring.num=4
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 0

Then the driver adds a descriptor chain containing 4 descriptors.

We expect the following result with avail_wrap_counter flipped:
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 1

But, the current implementation gives the following result:
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 0

To reproduce the bug, you can set a packed queue size as small as
possible, so that the driver is more likely to provide a descriptor
chain with a length equal to the packed queue size. For example, in
qemu run following commands:
sudo qemu-system-x86_64 \
-enable-kvm \
-nographic \
-kernel "path/to/kernel_image" \
-m 1G \
-drive file="path/to/rootfs",if=none,id=disk \
-device virtio-blk,drive=disk \
-drive file="path/to/disk_image",if=none,id=rwdisk \
-device virtio-blk,drive=rwdisk,packed=on,queue-size=4,\
indirect_desc=off \
-append "console=ttyS0 root=/dev/vda rw init=/bin/bash"

Inside the VM, create a directory and mount the rwdisk device on it. The
rwdisk will hang and mount operation will not complete.

This commit fixes the wrap counter error by flipping the
packed.avail_wrap_counter, when start of descriptor chain equals to the
end of descriptor chain (head == i).

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
Message-Id: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b5c0509112769..e3c78c9f84584 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1180,7 +1180,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		}
 	}
 
-	if (i < head)
+	if (i <= head)
 		vq->packed.avail_wrap_counter ^= 1;
 
 	/* We're using some buffers from the free list. */
-- 
2.40.1



