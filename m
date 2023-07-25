Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86989761483
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjGYLUI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjGYLUE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:20:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AA410D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:20:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4EE6167E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B2AC433C9;
        Tue, 25 Jul 2023 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284002;
        bh=d3ngUTbu7OHCcg+lxRS9R70eruI3G/PNnTp8z6hF6xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rYMqK6iq5LP/KuntE9C/FvAGI2EpxoZ/EaATvU60/Kod+w1PWQcNbdj12VDZ+LEq
         4g6VV6edguLAE2VqXs58rGgo3iWQ4MNdx4M11l7cxEijv4JyUhvbAlbzxuu+c82b9n
         vTMCCYmke2QwyZCF9XBBsr9MlGkLilrQJpnECD3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 200/509] hwrng: virtio - Fix race on data_avail and actual data
Date:   Tue, 25 Jul 2023 12:42:19 +0200
Message-ID: <20230725104602.910721468@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit ac52578d6e8d300dd50f790f29a24169b1edd26c ]

The virtio rng device kicks off a new entropy request whenever the
data available reaches zero.  When a new request occurs at the end
of a read operation, that is, when the result of that request is
only needed by the next reader, then there is a race between the
writing of the new data and the next reader.

This is because there is no synchronisation whatsoever between the
writer and the reader.

Fix this by writing data_avail with smp_store_release and reading
it with smp_load_acquire when we first enter read.  The subsequent
reads are safe because they're either protected by the first load
acquire, or by the completion mechanism.

Also remove the redundant zeroing of data_idx in random_recv_done
(data_idx must already be zero at this point) and data_avail in
request_entropy (ditto).

Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 0a7dde135db19..3a194eb3ce8ad 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 2007, 2008 Rusty Russell IBM Corporation
  */
 
+#include <asm/barrier.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/scatterlist.h>
@@ -37,13 +38,13 @@ struct virtrng_info {
 static void random_recv_done(struct virtqueue *vq)
 {
 	struct virtrng_info *vi = vq->vdev->priv;
+	unsigned int len;
 
 	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
-	if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
+	if (!virtqueue_get_buf(vi->vq, &len))
 		return;
 
-	vi->data_idx = 0;
-
+	smp_store_release(&vi->data_avail, len);
 	complete(&vi->have_data);
 }
 
@@ -52,7 +53,6 @@ static void request_entropy(struct virtrng_info *vi)
 	struct scatterlist sg;
 
 	reinit_completion(&vi->have_data);
-	vi->data_avail = 0;
 	vi->data_idx = 0;
 
 	sg_init_one(&sg, vi->data, sizeof(vi->data));
@@ -88,7 +88,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	read = 0;
 
 	/* copy available data */
-	if (vi->data_avail) {
+	if (smp_load_acquire(&vi->data_avail)) {
 		chunk = copy_data(vi, buf, size);
 		size -= chunk;
 		read += chunk;
-- 
2.39.2



