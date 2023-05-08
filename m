Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E877C6FAA1B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjEHK7c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjEHK6z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404B2DD73
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E12E629CF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A49C433EF;
        Mon,  8 May 2023 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543455;
        bh=c4s/d7N9CygnHM5HXhDB3gqOhdRQiA9yT9344RTsDz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQG3ssqe5ZDZNdrlv/TxERG07FksToE/Tjcphd4n+r+SL2bc+inlmJYanLJGjems9
         QF4BCLcDnVnk8gV76k4rAIsbgMi9dJIuCVh11wYnkuK7e26ZSIritNH53yXdeIyUJA
         w2lfakKMvTmKZFnsacoZIRL1eu9WZwuizhfJHxR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.3 096/694] bus: mhi: host: Remove duplicate ee check for syserr
Date:   Mon,  8 May 2023 11:38:51 +0200
Message-Id: <20230508094435.629573814@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Jeffrey Hugo <quic_jhugo@quicinc.com>

commit d469d9448a0f1a33c175d3280b1542fa0158ad7a upstream.

If we detect a system error via intvec, we only process the syserr if the
current ee is different than the last observed ee.  The reason for this
check is to prevent bhie from running multiple times, but with the single
queue handling syserr, that is not possible.

The check can cause an issue with device recovery.  If PBL loads a bad SBL
via BHI, but that SBL hangs before notifying the host of an ee change,
then issuing soc_reset to crash the device and retry (after supplying a
fixed SBL) will not recover the device as the host will observe a PBL->PBL
transition and not process the syserr.  The device will be stuck until
either the driver is reloaded, or the host is rebooted.  Instead, remove
the check so that we can attempt to recover the device.

Fixes: ef2126c4e2ea ("bus: mhi: core: Process execution environment changes serially")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1681142292-27571-2-git-send-email-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/host/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -503,7 +503,7 @@ irqreturn_t mhi_intvec_threaded_handler(
 	}
 	write_unlock_irq(&mhi_cntrl->pm_lock);
 
-	if (pm_state != MHI_PM_SYS_ERR_DETECT || ee == mhi_cntrl->ee)
+	if (pm_state != MHI_PM_SYS_ERR_DETECT)
 		goto exit_intvec;
 
 	switch (ee) {


