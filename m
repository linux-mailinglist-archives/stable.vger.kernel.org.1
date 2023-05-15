Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED9703A59
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbjEORun (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244799AbjEORuZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276D15537
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02F5062F36
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E612DC433EF;
        Mon, 15 May 2023 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172898;
        bh=T0CeFnq3CHc5Xe1O31FYeiX17Q66noo5q2ST0EwTdNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZM1aAuWRR3u35YCPrKPuWZFETbl7NRXJgSRODrQsWqOLqEJmnlshMohVkU4ql2tl
         1r0BftT5/0jPvKMy9niYLUCPkmhIEcPRVtJLjDedX3XEw4wkKueXm6V/xLXgdNnQ9I
         1Esy4h4r5q0M3FiE3S0W1nxbHqQTTLnwMob3qq0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 303/381] crypto: ccp - Clear PSP interrupt status register before calling handler
Date:   Mon, 15 May 2023 18:29:14 +0200
Message-Id: <20230515161750.511276964@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>

[ Upstream commit 45121ad4a1750ca47ce3f32bd434bdb0cdbf0043 ]

The PSP IRQ is edge-triggered (MSI or MSI-X) in all cases supported by
the psp module so clear the interrupt status register early in the
handler to prevent missed interrupts. sev_irq_handler() calls wake_up()
on a wait queue, which can result in a new command being submitted from
a different CPU. This then races with the clearing of isr and can result
in missed interrupts. A missed interrupt results in a command waiting
until it times out, which results in the psp being declared dead.

This is unlikely on bare metal, but has been observed when running
virtualized. In the cases where this is observed, sev->cmdresp_reg has
PSP_CMDRESP_RESP set which indicates that the command was processed
correctly but no interrupt was asserted.

The full sequence of events looks like this:

CPU 1: submits SEV cmd #1
CPU 1: calls wait_event_timeout()
CPU 0: enters psp_irq_handler()
CPU 0: calls sev_handler()->wake_up()
CPU 1: wakes up; finishes processing cmd #1
CPU 1: submits SEV cmd #2
CPU 1: calls wait_event_timeout()
PSP:   finishes processing cmd #2; interrupt status is still set; no interrupt
CPU 0: clears intsts
CPU 0: exits psp_irq_handler()
CPU 1: wait_event_timeout() times out; psp_dead=true

Fixes: 200664d5237f ("crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support")
Cc: stable@vger.kernel.org
Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/psp-dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index ae7b445999144..4bf9eaab4456f 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -42,6 +42,9 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 	/* Read the interrupt status: */
 	status = ioread32(psp->io_regs + psp->vdata->intsts_reg);
 
+	/* Clear the interrupt status by writing the same value we read. */
+	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
+
 	/* invoke subdevice interrupt handlers */
 	if (status) {
 		if (psp->sev_irq_handler)
@@ -51,9 +54,6 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 			psp->tee_irq_handler(irq, psp->tee_irq_data, status);
 	}
 
-	/* Clear the interrupt status by writing the same value we read. */
-	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.39.2



