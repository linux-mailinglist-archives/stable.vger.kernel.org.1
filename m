Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E26377AC39
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjHMVal (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjHMVak (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF18110DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75DFB62B22
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B080C433C8;
        Sun, 13 Aug 2023 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962241;
        bh=OJg+T5Lg0O13AYYT+gVUpj2iBVGnVhWRj3qhBybT/bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNDuHvw8h/cGDvqZD7a3FGrEPLeEIXw+5VxYdv0KhR6SnHkQ1jakkhSUMQRo4jZ/A
         NRr3FyYNW0KbQ3CnCwbj9UZBvMkl/ApYlZiuD2JJkClWfQ+jszrrkDfl20f8PljL/w
         BMto7ZoAPgecU6XslT9iFC5GPAfNbmsRSWBKJJH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.4 165/206] dmaengine: idxd: Clear PRS disable flag when disabling IDXD device
Date:   Sun, 13 Aug 2023 23:18:55 +0200
Message-ID: <20230813211729.748277072@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Fenghua Yu <fenghua.yu@intel.com>

commit 863676fe1ac1b82fc9eb56c242e80acfbfc18b76 upstream.

Disabling IDXD device doesn't reset Page Request Service (PRS)
disable flag to its initial value 0. This may cause user confusion
because once PRS is disabled user will see PRS still remains the
previous setting (i.e. disabled) via sysfs interface even after the
device is disabled.

To eliminate user confusion, reset PRS disable flag to ensure that
the PRS flag bit reflects correct state after the device is disabled.

Additionally, simplify the code by setting wq->flags to 0, which clears
all flag bits, including any future additions.

Fixes: f2dc327131b5 ("dmaengine: idxd: add per wq PRS disable")
Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20230712193505.3440752-1-fenghua.yu@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/idxd/device.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5abbcc61c528..9a15f0d12c79 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -384,9 +384,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	wq->threshold = 0;
 	wq->priority = 0;
 	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
-	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
-	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
-	clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
+	wq->flags = 0;
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
-- 
2.41.0



