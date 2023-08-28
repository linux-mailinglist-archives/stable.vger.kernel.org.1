Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401C878AC33
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjH1Khz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjH1Khb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F2A6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:37:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C6C463F25
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F773C433C8;
        Mon, 28 Aug 2023 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219048;
        bh=mWwr4Rh+z/6RUVOfszFiUurmttLkIPPmg/vVR7V7ZdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lB/r5fUqwzB1ZoilvM26mZiQTargGEVdwaKoqsK/8FyvGXc4vWDwzUHeR8jo/yGuO
         DKCs1mtH6mls1Wo0OyUDgDHlkcUEaZZKVQRS6Tj1uZE/1qZLRaUGYGJEA9dyT5Lw66
         EfGyXr5Ygl5l0yRN/8+fAojqoszxplSpEVsDs090=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 054/158] virtio-mmio: dont break lifecycle of vm_dev
Date:   Mon, 28 Aug 2023 12:12:31 +0200
Message-ID: <20230828101159.147977576@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 55c91fedd03d7b9cf0c5199b2eb12b9b8e95281a ]

vm_dev has a separate lifecycle because it has a 'struct device'
embedded. Thus, having a release callback for it is correct.

Allocating the vm_dev struct with devres totally breaks this protection,
though. Instead of waiting for the vm_dev release callback, the memory
is freed when the platform_device is removed. Resulting in a
use-after-free when finally the callback is to be called.

To easily see the problem, compile the kernel with
CONFIG_DEBUG_KOBJECT_RELEASE and unbind with sysfs.

The fix is easy, don't use devres in this case.

Found during my research about object lifetime problems.

Fixes: 7eb781b1bbb7 ("virtio_mmio: add cleanup for virtio_mmio_probe")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Message-Id: <20230629120526.7184-1-wsa+renesas@sang-engineering.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e39b530b218a2..aee8b5ce8b63c 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -543,9 +543,8 @@ static void virtio_mmio_release_dev(struct device *_d)
 	struct virtio_device *vdev =
 			container_of(_d, struct virtio_device, dev);
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	struct platform_device *pdev = vm_dev->pdev;
 
-	devm_kfree(&pdev->dev, vm_dev);
+	kfree(vm_dev);
 }
 
 /* Platform device */
@@ -556,7 +555,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	unsigned long magic;
 	int rc;
 
-	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
+	vm_dev = kzalloc(sizeof(*vm_dev), GFP_KERNEL);
 	if (!vm_dev)
 		return -ENOMEM;
 
-- 
2.40.1



