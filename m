Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE377AC47
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjHMVbc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjHMVbc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389919AB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A10662B59
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22616C433C8;
        Sun, 13 Aug 2023 21:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962275;
        bh=dbiv4JoIik8CIJOcYHRdECQk2GbRTz5ylBKVgFVpwAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUX4UpAABYC7tNIzHa0eIe3EiJDis34mpvKpGDsyw4CA8daQ/q/COm8Y7Zm8U6oAI
         aywSQvhbE7S1YrGv9mxGCT8iIcZPhAdUR7XpGen1NoINDGnDLAlSS8HuHUEoa7xEwd
         rJt1GS+qGgqmUazlhPu8dsA1lbr0KFlsXBc5p8dQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nick Child <nnac123@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 176/206] ibmvnic: Unmap DMA login rsp buffer on send login fail
Date:   Sun, 13 Aug 2023 23:19:06 +0200
Message-ID: <20230813211730.060994486@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
@@ -4830,11 +4830,14 @@ static int send_login(struct ibmvnic_ada
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


