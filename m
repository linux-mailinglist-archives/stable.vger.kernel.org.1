Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D079BA31
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjIKUwG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbjIKPEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:04:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DFE125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:04:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B83EC43391;
        Mon, 11 Sep 2023 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444679;
        bh=cvyhglbtVfJZIkGh4sCGWX58pWUG6N9U39VEGLedf5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8T1KKizD4VLPqZjvRYXs3RibXLDk0q9m1MBYnUeH9wCxIzdU5MmEQVy0wtLDkerd
         6zjRPCIWqSjKJlsd9f7fmSWISWBh1qqcRAsvOLn6uyKQ+zo0PGcgJPW3hgQ/hFXkQl
         wFu+SHbE008wy6cpGD2g5mlUxOyRwLYmCGJF3Q7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shih-Yi Chen <shihyic@nvidia.com>,
        Liming Sung <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 077/600] platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications
Date:   Mon, 11 Sep 2023 15:41:50 +0200
Message-ID: <20230911134635.887961016@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shih-Yi Chen <shihyic@nvidia.com>

[ Upstream commit 0848cab765c634597636810bf76d0934003cce28 ]

rshim console does not show all entries of dmesg.

Fixed by setting MLXBF_TM_TX_LWM_IRQ for every CONSOLE notification.

Signed-off-by: Shih-Yi Chen <shihyic@nvidia.com>
Reviewed-by: Liming Sung <limings@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Link: https://lore.kernel.org/r/20230821150627.26075-1-shihyic@nvidia.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index b2e19f30a928b..d31fe7eed38df 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -868,6 +868,7 @@ static bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq)
 			tm_vdev = fifo->vdev[VIRTIO_ID_CONSOLE];
 			mlxbf_tmfifo_console_output(tm_vdev, vring);
 			spin_unlock_irqrestore(&fifo->spin_lock[0], flags);
+			set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events);
 		} else if (test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
 					    &fifo->pend_events)) {
 			return true;
-- 
2.40.1



