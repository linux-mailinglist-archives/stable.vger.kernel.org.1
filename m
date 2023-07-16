Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E97555EB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjGPUqB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGPUp7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36BE43
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3C560EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B62C433C7;
        Sun, 16 Jul 2023 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540358;
        bh=3gBxixUEpVwvNLElwm1ve6HsZDovot6za93L8ukxGjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JM0C03r9RKqn+I6kWMWmMv+VXXByHhgurzcQoj98L1SDdTFzG0JJU1pPGm30arveH
         CWwfWHJ6OM28nMzFO3nOF5L+FIg40OPskl4molkASdfQPFSL3Cws/lO/YfKO4M0ySt
         fQHJhyIhyqvEg8MeeyRr4w5naah+1iutSj52B8LE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 334/591] hwrng: virtio - Fix race on data_avail and actual data
Date:   Sun, 16 Jul 2023 21:47:53 +0200
Message-ID: <20230716194932.535195820@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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
index a6f3a8a2aca6d..35304117338ab 100644
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



