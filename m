Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0F77AD9A
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHMVti (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjHMVtH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826D1FC4
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DCBB60F71
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5475DC433C7;
        Sun, 13 Aug 2023 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962933;
        bh=DMDY5byok+LnweDNn+7Bg/bl6dF0YkABVBmF1Pfj0Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gegh1RR7eqdRBmpwHconlUMV0mWH0UthtlvPO7P8Z7jJeBpjWaEn3qsiPcJ3HlEk1
         z3x1sJm/cdA7DOCdsHAWKtcIIXhCl0yxwB4BesBNywXuB19XyqfGVYtkSVu/pSozvq
         Zt2seYDTjKHhqrLZm3wRpN2GcDYswINMjDvIQS5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nick Child <nnac123@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 53/68] ibmvnic: Unmap DMA login rsp buffer on send login fail
Date:   Sun, 13 Aug 2023 23:19:54 +0200
Message-ID: <20230813211709.757111058@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
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

From: Nick Child <nnac123@linux.ibm.com>

commit 411c565b4bc63e9584a8493882bd566e35a90588 upstream.

If the LOGIN CRQ fails to send then we must DMA unmap the response
buffer. Previously, if the CRQ failed then the memory was freed without
DMA unmapping.

Fixes: c98d9cc4170d ("ibmvnic: send_login should check for crq errors")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230809221038.51296-2-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3861,11 +3861,14 @@ static int send_login(struct ibmvnic_ada
 	if (rc) {
 		adapter->login_pending = false;
 		netdev_err(adapter->netdev, "Failed to send login, rc=%d\n", rc);
-		goto buf_rsp_map_failed;
+		goto buf_send_failed;
 	}
 
 	return 0;
 
+buf_send_failed:
+	dma_unmap_single(dev, rsp_buffer_token, rsp_buffer_size,
+			 DMA_FROM_DEVICE);
 buf_rsp_map_failed:
 	kfree(login_rsp_buffer);
 	adapter->login_rsp_buf = NULL;


