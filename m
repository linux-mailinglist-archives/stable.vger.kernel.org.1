Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A81C775B4A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHILQO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjHILQN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB410F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D85C63146
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF51C433C7;
        Wed,  9 Aug 2023 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579772;
        bh=HERCSDFXtrHEFVUh9ynredVBoKs8vuOPH08M125ZmQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b651THYISAdTdf6ng7NwI+evpMx6eMiD3zxT3JeHBlP7MXC1+WA81q60fJw6MKu51
         jG5XjjMP/zhYYKTG80Y1nju7DwTm2kuw+q5B2DHTK4rfRVSXAEFm9ivIDxQMy2AGuW
         sY5EZBiIW3BlLqatuN1glgUIyeOCOer+Jk4bmuZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Robert Hancock <robert.hancock@calian.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 111/323] i2c: xiic: Dont try to handle more interrupt events after error
Date:   Wed,  9 Aug 2023 12:39:09 +0200
Message-ID: <20230809103703.169980032@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robert Hancock <robert.hancock@calian.com>

[ Upstream commit cb6e45c9a0ad9e0f8664fd06db0227d185dc76ab ]

In xiic_process, it is possible that error events such as arbitration
lost or TX error can be raised in conjunction with other interrupt flags
such as TX FIFO empty or bus not busy. Error events result in the
controller being reset and the error returned to the calling request,
but the function could potentially try to keep handling the other
events, such as by writing more messages into the TX FIFO. Since the
transaction has already failed, this is not helpful and will just cause
issues.

This problem has been present ever since:

commit 7f9906bd7f72 ("i2c: xiic: Service all interrupts in isr")

which allowed non-error events to be handled after errors, but became
more obvious after:

commit 743e227a8959 ("i2c: xiic: Defer xiic_wakeup() and
__xiic_start_xfer() in xiic_process()")

which reworked the code to add a WARN_ON which triggers if both the
xfer_more and wakeup_req flags were set, since this combination is
not supposed to happen, but was occurring in this scenario.

Skip further interrupt handling after error flags are detected to avoid
this problem.

Fixes: 7f9906bd7f72 ("i2c: xiic: Service all interrupts in isr")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-xiic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index c7f74687282ea..c1f85114ab812 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -409,6 +409,8 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 			wakeup_req = 1;
 			wakeup_code = STATE_ERROR;
 		}
+		/* don't try to handle other events */
+		goto out;
 	}
 	if (pend & XIIC_INTR_RX_FULL_MASK) {
 		/* Receive register/FIFO is full */
-- 
2.39.2



