Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B265477ACDB
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjHMVhz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjHMVhy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18AA10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 471E2633D2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B165C433C8;
        Sun, 13 Aug 2023 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962675;
        bh=TZqAcznvCqCvpUicTpX3fxdcny3QexH2xqVkMvJHJUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLrjr2hjsnH+hEFPa5tXXhTrSmi+VR7d77GY4VHRlMHJDoPpbIfm2Bfuze+NduNjB
         evL3/mhMoqE2aum3d8rQMY8FWhz23CuvSsiBTZ2zY3StVaPCrWaBCH4c7qib7Ka+GQ
         bfFII5vJw9gF5Qr0cfmRiYEHVUhX+3JPqy8vzqpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Jianhua <chris.zjh@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 115/149] dmaengine: owl-dma: Modify mismatched function name
Date:   Sun, 13 Aug 2023 23:19:20 +0200
Message-ID: <20230813211722.186736789@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

From: Zhang Jianhua <chris.zjh@huawei.com>

commit 74d7221c1f9c9f3a8c316a3557ca7dca8b99d14c upstream.

No functional modification involved.

drivers/dma/owl-dma.c:208: warning: expecting prototype for struct owl_dma_pchan. Prototype was for struct owl_dma_vchan instead HDRTEST usr/include/sound/asequencer.h

Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA driver")
Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20230722153244.2086949-1-chris.zjh@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/owl-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -192,7 +192,7 @@ struct owl_dma_pchan {
 };
 
 /**
- * struct owl_dma_pchan - Wrapper for DMA ENGINE channel
+ * struct owl_dma_vchan - Wrapper for DMA ENGINE channel
  * @vc: wrapped virtual channel
  * @pchan: the physical channel utilized by this channel
  * @txd: active transaction on this channel


