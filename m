Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F757831FC
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjHUUGL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjHUUGL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D2E3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC5364928
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B84AC433C8;
        Mon, 21 Aug 2023 20:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648368;
        bh=BqPXxtOZY5nbB6UuCVLHDUGDHzYWzn1bPTBy1S6n88U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ij53scJCtU9vDzU7YVE/07XwJgYFmWlJX4cYnvO3C7LYT8NtGYwjB5GZ5q82w5w5I
         hZLJj3dFEkAmtRR6/bbK4/KT2JmcVUTo20MuUoXEu5OY4Z0RE4AXY88lCBLCL9Ks5Y
         85Yl2LjUPjKBs0a0k76QFgXmZdAm6D7brcDeRbeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 150/234] octeon_ep: fix timeout value for waiting on mbox response
Date:   Mon, 21 Aug 2023 21:41:53 +0200
Message-ID: <20230821194135.471380287@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 519b227904f0e70d4a1d6cf41daa5392715f2d2f ]

The intention was to wait up to 500 ms for the mbox response.
The third argument to wait_event_interruptible_timeout() is supposed to
be the timeout duration. The driver mistakenly passed absolute time
instead.

Fixes: 577f0d1b1c5f ("octeon_ep: add separate mailbox command and response queues")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230810150114.107765-2-mschmidt@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 1cc6af2feb38a..565320ec24f81 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -55,7 +55,7 @@ static int octep_send_mbox_req(struct octep_device *oct,
 	list_add_tail(&d->list, &oct->ctrl_req_wait_list);
 	ret = wait_event_interruptible_timeout(oct->ctrl_req_wait_q,
 					       (d->done != 0),
-					       jiffies + msecs_to_jiffies(500));
+					       msecs_to_jiffies(500));
 	list_del(&d->list);
 	if (ret == 0 || ret == 1)
 		return -EAGAIN;
-- 
2.40.1



