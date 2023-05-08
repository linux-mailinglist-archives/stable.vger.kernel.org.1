Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED86FA672
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjEHKTm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjEHKTf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5836BD873
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C087B6251A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF34C433EF;
        Mon,  8 May 2023 10:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541170;
        bh=NN7bBK93HRhvkiI8sBU1h/1yIMisFqvlgSL/Q4yVGDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0LZxPoZkkuqpbYKSRHzKKgQ60cGwHW2lHUyFdtyflBWKG0+4L9xll+vXhCjRuycqi
         n25CA1/7lYQ2cYCS7nlehWgeAQEvWSyyjDdFVE4XHNy5wZy7y/Mi63RgqhKme78hKv
         nB1PqCGP0o80ixDpqTowjcupvBd1keIPRU+Q9Vgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Slark Xiao <slark_xiao@163.com>,
        Fabio Porcedda <fabio.porcedda@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.2 028/663] bus: mhi: host: pci_generic: Revert "Add a secondary AT port to Telit FN990"
Date:   Mon,  8 May 2023 11:37:34 +0200
Message-Id: <20230508094429.359686060@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Slark Xiao <slark_xiao@163.com>

commit 14853a0676c126aad836eb249499552fa9d6e85a upstream.

This reverts commit 2d5253a096c6057bbf7caa5520856dcdf7eca8bb.
There are 2 commits with commit message "Add a secondary AT port to Telit
FN990":

commit 2d5253a096c6 ("bus: mhi: host: pci_generic: Add a secondary AT port
to Telit FN990")
commit 479aa3b0ec2e ("bus: mhi: host: pci_generic: Add a secondary AT port
to Telit FN990")

This turned out to be due to the patch getting applied through different
trees and git settled on a resolution while applying it second time. But
the second AT port of Foxconn devices don't work in PCIe mode. So the
second commit needs to be reverted.

Cc: stable@vger.kernel.org # 6.2
Fixes: 2d5253a096c6 ("bus: mhi: host: pci_generic: Add a secondary AT port to Telit FN990")
Signed-off-by: Slark Xiao <slark_xiao@163.com>
Reviewed-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/20230310101715.69209-1-slark_xiao@163.com
[mani: massaged the commit message a bit, added fixes tag and CCed stable]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/host/pci_generic.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -344,8 +344,6 @@ static const struct mhi_channel_config m
 	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
-	MHI_CHANNEL_CONFIG_UL(92, "DUN2", 32, 1),
-	MHI_CHANNEL_CONFIG_DL(93, "DUN2", 32, 1),
 	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
 	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
 };


