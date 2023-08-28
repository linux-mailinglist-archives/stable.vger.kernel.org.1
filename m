Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F078AC30
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjH1Khy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjH1Kh3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB0EA7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC2063F26
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7D0C433C9;
        Mon, 28 Aug 2023 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219045;
        bh=OcYJya7kdCJwx7YTqzC6S8LFabkrPsUnGAiD1zw5pRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1evmExCrWJkiwdgtLaJxyPxYYgK4n/nW3hoHnLutjtOwpcA1AuvW8MLPhkzutHu+Y
         pIQrAagOgRIJ+McXZ7VKRhfldb1KXan8rur51aUXSVPIidQoUrs43uWXdEE8PVjgkI
         Ec0lhGWLSxqCqB7+MvPZuO1D/X7JGNNq7YilzE9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tang Bin <tangbin@cmss.chinamobile.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 053/158] virtio-mmio: Use to_virtio_mmio_device() to simply code
Date:   Mon, 28 Aug 2023 12:12:30 +0200
Message-ID: <20230828101159.118941193@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Bin <tangbin@cmss.chinamobile.com>

[ Upstream commit da98b54d02981de5b07d8044b2a632bf6ba3ac45 ]

The file virtio_mmio.c has defined the function to_virtio_mmio_device,
so use it instead of container_of() to simply code.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Link: https://lore.kernel.org/r/20210222055724.220-1-tangbin@cmss.chinamobile.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index dd8fec8738564..e39b530b218a2 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -542,8 +542,7 @@ static void virtio_mmio_release_dev(struct device *_d)
 {
 	struct virtio_device *vdev =
 			container_of(_d, struct virtio_device, dev);
-	struct virtio_mmio_device *vm_dev =
-			container_of(vdev, struct virtio_mmio_device, vdev);
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct platform_device *pdev = vm_dev->pdev;
 
 	devm_kfree(&pdev->dev, vm_dev);
-- 
2.40.1



