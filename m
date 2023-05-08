Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797A06FAA39
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjEHLAz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjEHLAU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC382B43E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04A2761E4B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA22C433D2;
        Mon,  8 May 2023 10:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543535;
        bh=O9OEPqL8n1K9QQlTf6lbACmDaUQTy6seLjxY/nnSzN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7ci+USGTCyoS95LlAIm8T6IHQkSJagBZqMTqYTKUbSt1EclDr9gKOlVj7cfZksOu
         zbwO+GXldTb7MLH1h4ZYjfIsXEn/Y3M2Gv72DDEaqml6uRiQjINH0JgcoMkasSL4E1
         EH+AgXjLvq4ZsmyZu6JVpXkhQzyi7fFqhjIAxIBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tanmay Shah <tanmay.shah@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 6.3 122/694] mailbox: zynqmp: Fix counts of child nodes
Date:   Mon,  8 May 2023 11:39:17 +0200
Message-Id: <20230508094436.426379378@linuxfoundation.org>
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

From: Tanmay Shah <tanmay.shah@amd.com>

commit f72f805e72882c361e2a612c64a6e549f3da7152 upstream.

If child mailbox node status is disabled it causes
crash in interrupt handler. Fix this by assigning
only available child node during driver probe.

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230311012407.1292118-2-tanmay.shah@amd.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -634,7 +634,12 @@ static int zynqmp_ipi_probe(struct platf
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
+	num_mboxes = of_get_available_child_count(np);
+	if (num_mboxes == 0) {
+		dev_err(dev, "mailbox nodes not available\n");
+		return -EINVAL;
+	}
+
 	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
 			     GFP_KERNEL);
 	if (!pdata)


