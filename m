Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3227553E0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjGPUX6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjGPUX5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94BE1A5
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DAA060DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD59C433C7;
        Sun, 16 Jul 2023 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539035;
        bh=15Ww9JzwZFyKJ37u2c8y8UIlSsnBC4+pR60qbDapO/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w51PF8bWIcVTavWOCaOvxalimUGiU6EsgHBowcnaKiysCJECgPV8OkChoN+v5x/4s
         HlGPsjTBs4ztbaz0kT9Y3bUSE8nI++chJZ2MDAYR803PaC8ExoMYwv4U9i1nE52Lmp
         R0u9g9Ko0Yy+or/862YQUdojQyY8rXko0Ub+inaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gal Pressman <gal@nvidia.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Feng Liu <feliu@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 657/800] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Date:   Sun, 16 Jul 2023 21:48:30 +0200
Message-ID: <20230716195004.371909670@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit fe37efba475375caa2dbc71cb06f53f7086277ef ]

The referenced patch calls set_vq_affinity without checking if the op is
valid. This patch adds the check.

Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Message-Id: <20230504135053.2283816-1-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Feng Liu <feliu@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_vdpa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index eb6aee8c06b2c..989e2d7184ce4 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			err = PTR_ERR(vqs[i]);
 			goto err_setup_vq;
 		}
-		ops->set_vq_affinity(vdpa, i, &masks[i]);
+
+		if (ops->set_vq_affinity)
+			ops->set_vq_affinity(vdpa, i, &masks[i]);
 	}
 
 	cb.callback = virtio_vdpa_config_cb;
-- 
2.39.2



