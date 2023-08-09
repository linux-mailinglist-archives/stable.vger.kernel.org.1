Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16DF775B42
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjHILQA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjHILP7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29968ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF8BD62842
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A95C433C8;
        Wed,  9 Aug 2023 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579758;
        bh=b5/2r0mO2yM0jJtuZ/50Uy3tbykH56JHbsBmL2rQ/eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnmYsr5BvXZmxnEcLTFAgu48DG9nOmtV6yTtZ0MCV6VLu4T966WDEekS1MMMzYb+r
         yyxYY5SmtdUASG5dAlNEOyl4g0aMEXBrUylRNDYnTrvwz10vLl3sA5DQfPz5tAfOIo
         TGCAeF/MRMtkM5KpHJdROtSoTtn+G/hb1xk0va7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/323] hwrng: virtio - Fix race on data_avail and actual data
Date:   Wed,  9 Aug 2023 12:38:34 +0200
Message-ID: <20230809103701.618052290@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index a84248c26fd7f..58884d8752011 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -17,6 +17,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
  */
 
+#include <asm/barrier.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/scatterlist.h>
@@ -49,13 +50,13 @@ struct virtrng_info {
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
 
@@ -64,7 +65,6 @@ static void request_entropy(struct virtrng_info *vi)
 	struct scatterlist sg;
 
 	reinit_completion(&vi->have_data);
-	vi->data_avail = 0;
 	vi->data_idx = 0;
 
 	sg_init_one(&sg, vi->data, sizeof(vi->data));
@@ -100,7 +100,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	read = 0;
 
 	/* copy available data */
-	if (vi->data_avail) {
+	if (smp_load_acquire(&vi->data_avail)) {
 		chunk = copy_data(vi, buf, size);
 		size -= chunk;
 		read += chunk;
-- 
2.39.2



