Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C14C726D42
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjFGUkp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjFGUkm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AB52121
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19758645F4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E02EC433EF;
        Wed,  7 Jun 2023 20:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170409;
        bh=CuKgPgV6aZ3NzUMUfu26ivUi3ak9kLb/FiLkOUerykQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jonh4GeyfNIoo8eZpoyt5LwHXXD2AGRNS62n3FtJWE9KdHKCjQ+nbLN7aKeYSJk3O
         9yhVnUnnKhjidzl7ANw5NeCrke8Yd6lDD/piE81bWqi+n8CS82Vudgd2s0ksndKNr/
         kazMFnb45Un3zJShmcd1KTnsKoNjhGabVMd4Uykc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liming Sun <limings@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 073/225] platform/mellanox: fix potential race in mlxbf-tmfifo driver
Date:   Wed,  7 Jun 2023 22:14:26 +0200
Message-ID: <20230607200916.767379073@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Liming Sun <limings@nvidia.com>

[ Upstream commit 3d43f9f639542fadfb28f40b509bf147a6624d48 ]

This commit adds memory barrier for the 'vq' update in function
mlxbf_tmfifo_virtio_find_vqs() to avoid potential race due to
out-of-order memory write. It also adds barrier for the 'is_ready'
flag to make sure the initializations are visible before this flag
is checked.

Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://lore.kernel.org/r/b98c0ab61d644ba38fa9b3fd1607b138b0dd820b.1682518748.git.limings@nvidia.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 1ae3c56b66b09..b2e19f30a928b 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -765,7 +765,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 	fifo = vring->fifo;
 
 	/* Return if vdev is not ready. */
-	if (!fifo->vdev[devid])
+	if (!fifo || !fifo->vdev[devid])
 		return;
 
 	/* Return if another vring is running. */
@@ -961,9 +961,13 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 
 		vq->num_max = vring->num;
 
+		vq->priv = vring;
+
+		/* Make vq update visible before using it. */
+		virtio_mb(false);
+
 		vqs[i] = vq;
 		vring->vq = vq;
-		vq->priv = vring;
 	}
 
 	return 0;
@@ -1260,6 +1264,9 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 
 	mod_timer(&fifo->timer, jiffies + MLXBF_TMFIFO_TIMER_INTERVAL);
 
+	/* Make all updates visible before setting the 'is_ready' flag. */
+	virtio_mb(false);
+
 	fifo->is_ready = true;
 	return 0;
 
-- 
2.39.2



