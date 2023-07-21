Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7089675D32B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGUTHu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjGUTHt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108730DF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:07:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D8D61D90
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4164CC433C7;
        Fri, 21 Jul 2023 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966456;
        bh=klay/In8JNkSFYJRJMsMEe37l+sPLxSN2CYS8ynkM7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTduNsSD90+cR0oTNmqltA8Bq1F8XYQK+XnrxRsDZW2gZMAwYIX+J7mo24gOk6o5z
         m1DEH5insmVkX9epqSg15yCswVnH43S5vL6xoA1v1PFN60ppKLj0i5ifp3lGj0+roA
         Ewim0mjruvQvcNiUYnccAbWR4Ujm/0sfvQWEvrJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nishanth Menon <nm@ti.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 322/532] mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0
Date:   Fri, 21 Jul 2023 18:03:46 +0200
Message-ID: <20230721160631.886526988@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

[ Upstream commit 1b712f18c461bd75f018033a15cf381e712806b5 ]

Sec proxy/message manager data buffer is 60 bytes with the last of the
registers indicating transmission completion. This however poses a bit
of a challenge.

The backing memory for sec_proxy / message manager is regular memory,
and all sec proxy does is to trigger a burst of all 60 bytes of data
over to the target thread backing ring accelerator. It doesn't do a
memory scrub when it moves data out in the burst. When we transmit
multiple messages, remnants of previous message is also transmitted
which results in some random data being set in TISCI fields of
messages that have been expanded forward.

The entire concept of backward compatibility hinges on the fact that
the unused message fields remain 0x0 allowing for 0x0 value to be
specially considered when backward compatibility of message extension
is done.

So, instead of just writing the completion register, we continue
to fill the message buffer up with 0x0 (note: for partial message
involving completion, we already do this).

This allows us to scale and introduce ABI changes back also work with
other boot stages that may have left data in the internal memory.

While at this, be consistent and explicit with the data_reg pointer
increment.

Fixes: aace66b170ce ("mailbox: Introduce TI message manager driver")
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/ti-msgmgr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index efb43b0385960..fa71ae837d235 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -385,14 +385,20 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 		/* Ensure all unused data is 0 */
 		data_trail &= 0xFFFFFFFF >> (8 * (sizeof(u32) - trail_bytes));
 		writel(data_trail, data_reg);
-		data_reg++;
+		data_reg += sizeof(u32);
 	}
+
 	/*
 	 * 'data_reg' indicates next register to write. If we did not already
 	 * write on tx complete reg(last reg), we must do so for transmit
+	 * In addition, we also need to make sure all intermediate data
+	 * registers(if any required), are reset to 0 for TISCI backward
+	 * compatibility to be maintained.
 	 */
-	if (data_reg <= qinst->queue_buff_end)
-		writel(0, qinst->queue_buff_end);
+	while (data_reg <= qinst->queue_buff_end) {
+		writel(0, data_reg);
+		data_reg += sizeof(u32);
+	}
 
 	return 0;
 }
-- 
2.39.2



