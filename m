Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30C75D298
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjGUTB3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGUTB3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B461230DD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48EE561D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D2DC433C7;
        Fri, 21 Jul 2023 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966086;
        bh=to5B9D5qf0Y6+XQ1rhkyuHzXZKaeHvIUOnBmmVx6Q+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLll2sN34slY/Qak1Aleehpicub+4AAYaIvFtXTffvER8+7BZmTr7YCv0h+8vnkan
         LHI6PWENyetoZXZLBoalyzEYeSdui+0V2bDyNr4Zvs3v2dsY0Vrthto4smEosLJmkc
         wl2makH1tFQRDapLFJo+A/HKOP2gWQvmkv9GWeRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 219/532] hwrng: virtio - add an internal buffer
Date:   Fri, 21 Jul 2023 18:02:03 +0200
Message-ID: <20230721160626.269681568@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

From: Laurent Vivier <lvivier@redhat.com>

[ Upstream commit bf3175bc50a3754dc427e2f5046e17a9fafc8be7 ]

hwrng core uses two buffers that can be mixed in the
virtio-rng queue.

If the buffer is provided with wait=0 it is enqueued in the
virtio-rng queue but unused by the caller.
On the next call, core provides another buffer but the
first one is filled instead and the new one queued.
And the caller reads the data from the new one that is not
updated, and the data in the first one are lost.

To avoid this mix, virtio-rng needs to use its own unique
internal buffer at a cost of a data copy to the caller buffer.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Link: https://lore.kernel.org/r/20211028101111.128049-2-lvivier@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: ac52578d6e8d ("hwrng: virtio - Fix race on data_avail and actual data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index a90001e02bf7a..208c547dcac16 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
 struct virtrng_info {
 	struct hwrng hwrng;
 	struct virtqueue *vq;
-	struct completion have_data;
 	char name[25];
-	unsigned int data_avail;
 	int index;
 	bool busy;
 	bool hwrng_register_done;
 	bool hwrng_removed;
+	/* data transfer */
+	struct completion have_data;
+	unsigned int data_avail;
+	/* minimal size returned by rng_buffer_size() */
+#if SMP_CACHE_BYTES < 32
+	u8 data[32];
+#else
+	u8 data[SMP_CACHE_BYTES];
+#endif
 };
 
 static void random_recv_done(struct virtqueue *vq)
@@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
 }
 
 /* The host will fill any buffer we give it with sweet, sweet randomness. */
-static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
+static void register_buffer(struct virtrng_info *vi)
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, buf, size);
+	sg_init_one(&sg, vi->data, sizeof(vi->data));
 
 	/* There should always be room for one buffer. */
-	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
+	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
 
 	virtqueue_kick(vi->vq);
 }
@@ -55,6 +62,8 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 {
 	int ret;
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
+	unsigned int chunk;
+	size_t read;
 
 	if (vi->hwrng_removed)
 		return -ENODEV;
@@ -62,19 +71,33 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	if (!vi->busy) {
 		vi->busy = true;
 		reinit_completion(&vi->have_data);
-		register_buffer(vi, buf, size);
+		register_buffer(vi);
 	}
 
 	if (!wait)
 		return 0;
 
-	ret = wait_for_completion_killable(&vi->have_data);
-	if (ret < 0)
-		return ret;
+	read = 0;
+	while (size != 0) {
+		ret = wait_for_completion_killable(&vi->have_data);
+		if (ret < 0)
+			return ret;
+
+		chunk = min_t(unsigned int, size, vi->data_avail);
+		memcpy(buf + read, vi->data, chunk);
+		read += chunk;
+		size -= chunk;
+		vi->data_avail = 0;
+
+		if (size != 0) {
+			reinit_completion(&vi->have_data);
+			register_buffer(vi);
+		}
+	}
 
 	vi->busy = false;
 
-	return vi->data_avail;
+	return read;
 }
 
 static void virtio_cleanup(struct hwrng *rng)
-- 
2.39.2



