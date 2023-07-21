Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9975D2C3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGUTDW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjGUTDV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758A30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4652C61D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B1CC433C7;
        Fri, 21 Jul 2023 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966199;
        bh=qUNuOAxYk4ixVpAqTDFUxeAUN5gbxMuWtQSJd8OWX3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxEy0qIktwz1NnRNUrHBoY7viIeObt5RYBicfuNHbyX/R02cET5gLmH9fl+7OP9JK
         d97ne7ssc5wGmMTQFMyrM1FwUvAzCqecRN8a4G4O692QmzzVyrBNOxHX6zKYEIQymj
         M1mCKakre8EJgrFmvw7Ur9d1MOV6/+fJ3Xich9iM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 221/532] hwrng: virtio - dont waste entropy
Date:   Fri, 21 Jul 2023 18:02:05 +0200
Message-ID: <20230721160626.373806893@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Laurent Vivier <lvivier@redhat.com>

[ Upstream commit 5c8e933050044d6dd2a000f9a5756ae73cbe7c44 ]

if we don't use all the entropy available in the buffer, keep it
and use it later.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Link: https://lore.kernel.org/r/20211028101111.128049-4-lvivier@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: ac52578d6e8d ("hwrng: virtio - Fix race on data_avail and actual data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 52 +++++++++++++++++++----------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 173aeea835bb6..8ba97cf4ca8fb 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -26,6 +26,7 @@ struct virtrng_info {
 	/* data transfer */
 	struct completion have_data;
 	unsigned int data_avail;
+	unsigned int data_idx;
 	/* minimal size returned by rng_buffer_size() */
 #if SMP_CACHE_BYTES < 32
 	u8 data[32];
@@ -42,6 +43,9 @@ static void random_recv_done(struct virtqueue *vq)
 	if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
 		return;
 
+	vi->data_idx = 0;
+	vi->busy = false;
+
 	complete(&vi->have_data);
 }
 
@@ -58,6 +62,16 @@ static void register_buffer(struct virtrng_info *vi)
 	virtqueue_kick(vi->vq);
 }
 
+static unsigned int copy_data(struct virtrng_info *vi, void *buf,
+			      unsigned int size)
+{
+	size = min_t(unsigned int, size, vi->data_avail);
+	memcpy(buf, vi->data + vi->data_idx, size);
+	vi->data_idx += size;
+	vi->data_avail -= size;
+	return size;
+}
+
 static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 {
 	int ret;
@@ -68,17 +82,29 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	if (vi->hwrng_removed)
 		return -ENODEV;
 
-	if (!vi->busy) {
-		vi->busy = true;
-		reinit_completion(&vi->have_data);
-		register_buffer(vi);
+	read = 0;
+
+	/* copy available data */
+	if (vi->data_avail) {
+		chunk = copy_data(vi, buf, size);
+		size -= chunk;
+		read += chunk;
 	}
 
 	if (!wait)
-		return 0;
+		return read;
 
-	read = 0;
+	/* We have already copied available entropy,
+	 * so either size is 0 or data_avail is 0
+	 */
 	while (size != 0) {
+		/* data_avail is 0 */
+		if (!vi->busy) {
+			/* no pending request, ask for more */
+			vi->busy = true;
+			reinit_completion(&vi->have_data);
+			register_buffer(vi);
+		}
 		ret = wait_for_completion_killable(&vi->have_data);
 		if (ret < 0)
 			return ret;
@@ -88,20 +114,11 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 		if (vi->data_avail == 0)
 			return read;
 
-		chunk = min_t(unsigned int, size, vi->data_avail);
-		memcpy(buf + read, vi->data, chunk);
-		read += chunk;
+		chunk = copy_data(vi, buf + read, size);
 		size -= chunk;
-		vi->data_avail = 0;
-
-		if (size != 0) {
-			reinit_completion(&vi->have_data);
-			register_buffer(vi);
-		}
+		read += chunk;
 	}
 
-	vi->busy = false;
-
 	return read;
 }
 
@@ -161,6 +178,7 @@ static void remove_common(struct virtio_device *vdev)
 
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
+	vi->data_idx = 0;
 	complete(&vi->have_data);
 	vdev->config->reset(vdev);
 	vi->busy = false;
-- 
2.39.2



