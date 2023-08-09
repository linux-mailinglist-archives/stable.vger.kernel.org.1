Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77486775B3F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjHILPv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjHILPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86CA10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC0C62842
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B53FC433C7;
        Wed,  9 Aug 2023 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579749;
        bh=8pt/FH3ReOt5iaKQqBcK7StgEyCd0UjNigyelQWn7hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfTOswCfvmy4geG2V/n+XuaRNOFMVSp5DmRoYYIqfLDe+136T9QzthTP+t26/FywZ
         ymuGLQ5T4i4cfe5eQkfdf++E7TAMGOfJ2kB5CfDKzyyXSXtHZnN5k4LPZcZi1NYyFB
         mkcVz4XRKFJg8TlPBaN85XoEH1SabgqPnV4RHrgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/323] hwrng: virtio - dont wait on cleanup
Date:   Wed,  9 Aug 2023 12:38:31 +0200
Message-ID: <20230809103701.493621661@linuxfoundation.org>
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

From: Laurent Vivier <lvivier@redhat.com>

[ Upstream commit 2bb31abdbe55742c89f4dc0cc26fcbc8467364f6 ]

When virtio-rng device was dropped by the hwrng core we were forced
to wait the buffer to come back from the device to not have
remaining ongoing operation that could spoil the buffer.

But now, as the buffer is internal to the virtio-rng we can release
the waiting loop immediately, the buffer will be retrieve and use
when the virtio-rng driver will be selected again.

This avoids to hang on an rng_current write command if the virtio-rng
device is blocked by a lack of entropy. This allows to select
another entropy source if the current one is empty.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Link: https://lore.kernel.org/r/20211028101111.128049-3-lvivier@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: ac52578d6e8d ("hwrng: virtio - Fix race on data_avail and actual data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 999f523c80c1e..9a3fbd2b41107 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -94,6 +94,11 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 		ret = wait_for_completion_killable(&vi->have_data);
 		if (ret < 0)
 			return ret;
+		/* if vi->data_avail is 0, we have been interrupted
+		 * by a cleanup, but buffer stays in the queue
+		 */
+		if (vi->data_avail == 0)
+			return read;
 
 		chunk = min_t(unsigned int, size, vi->data_avail);
 		memcpy(buf + read, vi->data, chunk);
@@ -117,7 +122,7 @@ static void virtio_cleanup(struct hwrng *rng)
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
 
 	if (vi->busy)
-		wait_for_completion(&vi->have_data);
+		complete(&vi->have_data);
 }
 
 static int probe_common(struct virtio_device *vdev)
-- 
2.39.2



