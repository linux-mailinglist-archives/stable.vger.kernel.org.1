Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347FC703BA9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbjEOSFR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245007AbjEOSE4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA911BB9B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11F163071
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A86C433EF;
        Mon, 15 May 2023 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173758;
        bh=ZEvsQuva0xNOrYGykGwpQjElS5A1ix7RmXvxqguUFJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFiYMEfVFOsO4yEWJbhDNRS9q0vKN6Cm++84KwCHigR816D72sn40EqT2rKk1qqMK
         DpVtnEtunOP8+mzr8zaR6BC13gPcjIJx453vp8HoT4LcVo65jiH6Qtq1GIBUPgarXQ
         5iT+Zg47f2dxaFVgSYa239NKyYyFoozzcwchNVKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tanmay Shah <tanmay.shah@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 5.4 196/282] mailbox: zynqmp: Fix IPI isr handling
Date:   Mon, 15 May 2023 18:29:34 +0200
Message-Id: <20230515161728.133273066@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Tanmay Shah <tanmay.shah@amd.com>

commit 74ad37a30ffee3643bc34f9ca7225b20a66abaaf upstream.

Multiple IPI channels are mapped to same interrupt handler.
Current isr implementation handles only one channel per isr.
Fix this behavior by checking isr status bit of all child
mailbox nodes.

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230311012407.1292118-3-tanmay.shah@amd.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(
 	struct zynqmp_ipi_message *msg;
 	u64 arg0, arg3;
 	struct arm_smccc_res res;
-	int ret, i;
+	int ret, i, status = IRQ_NONE;
 
 	(void)irq;
 	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
@@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(
 				memcpy_fromio(msg->data, mchan->req_buf,
 					      msg->len);
 				mbox_chan_received_data(chan, (void *)msg);
-				return IRQ_HANDLED;
+				status = IRQ_HANDLED;
 			}
 		}
 	}
-	return IRQ_NONE;
+	return status;
 }
 
 /**


