Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AE7035E3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbjEOREb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbjEOREK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D7286AC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDBC362A82
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2653C433EF;
        Mon, 15 May 2023 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170095;
        bh=/G/kat3/EVFVq40tGfSYWvnXpO4BwYJ+wVxdSxVdJrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nyY9iQiPtCx7rpU1d0N5A/3AZo46uDu5Cukdl13puv4wW2Dj2nOWzmco/QFYZh29U
         ghdp7xWFx3ZKToPWstmko4KXh3eFBodwnnyDUCJV/c3aZOVzFp4c9+zwjFVkXFr5Tb
         nbcKoTScFP9GEZbCv23bBC9HyYgHhtLf+DR+Ufh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/239] crypto: ccp - Clear PSP interrupt status register before calling handler
Date:   Mon, 15 May 2023 18:24:28 +0200
Message-Id: <20230515161721.729294303@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index c9c741ac84421..949a3fa0b94a9 100644
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



