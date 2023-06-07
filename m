Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7397726B9B
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjFGU0h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjFGU0f (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D89326A6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 538B56443A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A5DC433EF;
        Wed,  7 Jun 2023 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169574;
        bh=OXkMsN4v3FFJULQWV4/kyARqFXtJzpyCewzKLaeiJl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryub4uwxfyWi9Rf4BhQBGK7OWapQ+xsNWwn8UwGnMpaOqByIzZpUwaZvEo8RW18Xb
         F0hg0kOC6zld0JIMGUoPrj/TrlsxtW2/bmZLjj2PiBNHoWgquWIDjzrUjj7SIH4sA+
         4AjyMZ089LiKK+alhfxfEOW2VeJDDgkjma1zo6I4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liming Sun <limings@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 103/286] platform/mellanox: fix potential race in mlxbf-tmfifo driver
Date:   Wed,  7 Jun 2023 22:13:22 +0200
Message-ID: <20230607200926.432451885@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 91a077c35b8b8..a79318e90a139 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -784,7 +784,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 	fifo = vring->fifo;
 
 	/* Return if vdev is not ready. */
-	if (!fifo->vdev[devid])
+	if (!fifo || !fifo->vdev[devid])
 		return;
 
 	/* Return if another vring is running. */
@@ -980,9 +980,13 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 
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
@@ -1302,6 +1306,9 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 
 	mod_timer(&fifo->timer, jiffies + MLXBF_TMFIFO_TIMER_INTERVAL);
 
+	/* Make all updates visible before setting the 'is_ready' flag. */
+	virtio_mb(false);
+
 	fifo->is_ready = true;
 	return 0;
 
-- 
2.39.2



