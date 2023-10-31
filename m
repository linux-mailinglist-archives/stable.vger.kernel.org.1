Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDF7DD4F0
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346973AbjJaRp3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346977AbjJaRp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:45:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561C91
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:45:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5347C433C9;
        Tue, 31 Oct 2023 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774325;
        bh=I6tCkKtCvq1zqbV1OHCfdr+B82hni//HdGnu3l/Q18o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4V04bnEZmYyM0JC00S0yhyXB/Lj/7wr714cSTzJDz3VSCx4lC1HDSSr9qu01xeCR
         EP72s7PEfAxJ10hWWN9qIzZUzoVUuDdYk8hwD1kxXwzJkNZZ7CxcCAOaNF6oBKn2Ej
         AsNfM6H8LksTrV4vcOldCuLdWHxrIp0BGzAwgsGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 6.5 012/112] virtio_pci: fix the common cfg map size
Date:   Tue, 31 Oct 2023 18:00:13 +0100
Message-ID: <20231031165901.678045479@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

commit 061b39fdfe7fd98946e67637213bcbb10a318cca upstream.

The function vp_modern_map_capability() takes the size parameter,
which corresponds to the size of virtio_pci_common_cfg. As a result,
this indicates the size of memory area to map.

Now the size is the size of virtio_pci_common_cfg, but some feature(such
as the _F_RING_RESET) needs the virtio_pci_modern_common_cfg, so this
commit changes the size to the size of virtio_pci_modern_common_cfg.

Cc: stable@vger.kernel.org
Fixes: 0b50cece0b78 ("virtio_pci: introduce helper to get/set queue reset")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-Id: <20231010031120.81272-3-xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virtio/virtio_pci_modern_dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -291,7 +291,7 @@ int vp_modern_probe(struct virtio_pci_mo
 	err = -EINVAL;
 	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
-				      0, sizeof(struct virtio_pci_common_cfg),
+				      0, sizeof(struct virtio_pci_modern_common_cfg),
 				      NULL, NULL);
 	if (!mdev->common)
 		goto err_map_common;


