Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CD7E24A1
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjKFNXo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjKFNXn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:23:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E90D42
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:23:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553A3C433C8;
        Mon,  6 Nov 2023 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277016;
        bh=YbrSkASyqoppVuQmBY/wNWEGtxi3Hx5WlFi4+sRNlKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLPdbj9BuowuTQS9qO4M/V3I7IwGVvo3dbj+KXUlv6pBS93LdRxWQUXOWJe47Z53q
         N3JZekk4FUrEWD3IDAbBCkcQ/vHN4gP3qwbEH9yuGrIvKfzCCo3A7cJQivY3XpQNHO
         gZf8uoBWecrIoKcj0wWz3cNY9PX95i4vludFAudY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maximilian Heyne <mheyne@amazon.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5.15 010/128] virtio-mmio: fix memory leak of vm_dev
Date:   Mon,  6 Nov 2023 14:02:50 +0100
Message-ID: <20231106130309.602588318@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maximilian Heyne <mheyne@amazon.de>

commit fab7f259227b8f70aa6d54e1de1a1f5f4729041c upstream.

With the recent removal of vm_dev from devres its memory is only freed
via the callback virtio_mmio_release_dev. However, this only takes
effect after device_add is called by register_virtio_device. Until then
it's an unmanaged resource and must be explicitly freed on error exit.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Cc: stable@vger.kernel.org
Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Message-Id: <20230911090328.40538-1-mheyne@amazon.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/virtio/virtio_mmio.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -596,14 +596,17 @@ static int virtio_mmio_probe(struct plat
 	spin_lock_init(&vm_dev->lock);
 
 	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(vm_dev->base))
-		return PTR_ERR(vm_dev->base);
+	if (IS_ERR(vm_dev->base)) {
+		rc = PTR_ERR(vm_dev->base);
+		goto free_vm_dev;
+	}
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 
 	/* Check device version */
@@ -611,7 +614,8 @@ static int virtio_mmio_probe(struct plat
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto free_vm_dev;
 	}
 
 	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
@@ -620,7 +624,8 @@ static int virtio_mmio_probe(struct plat
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
@@ -650,6 +655,10 @@ static int virtio_mmio_probe(struct plat
 		put_device(&vm_dev->vdev.dev);
 
 	return rc;
+
+free_vm_dev:
+	kfree(vm_dev);
+	return rc;
 }
 
 static int virtio_mmio_remove(struct platform_device *pdev)


