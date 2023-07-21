Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749075BE8C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGUGOi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGUGOQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ABA44A7
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9753061331
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB00C433C7;
        Fri, 21 Jul 2023 06:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919906;
        bh=tMOJH1t8rd/UlumD9MZowbD9L2ypWucpJidMm2bUKiI=;
        h=Subject:To:Cc:From:Date:From;
        b=gzhrfY3172/3ioGZThA9TQXxrAzLBZwkLySOAQ8X660/4QNhmCjulZdloXKSvdFMd
         Ob+vhS6+yQAVQfrJ1Hi3Xsmto9Mim4B0N9jPk2gGGWY7ukWumo23pvZA5rfcj0cZH9
         oKpUXyVHTi99voYzCP9rBhQZtGy13pGDxm6zNalA=
Subject: FAILED: patch "[PATCH] PCI: qcom: Disable write access to read only registers for IP" failed to apply to 4.14-stable tree
To:     mani@kernel.org, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:11:44 +0200
Message-ID: <2023072143-slam-trickery-68af@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x a33d700e8eea76c62120cb3dbf5e01328f18319a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072143-slam-trickery-68af@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

a33d700e8eea ("PCI: qcom: Disable write access to read only registers for IP v2.3.3")
6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller/")
e52d38f4abf4 ("Merge branch 'lorenzo/pci/rockchip'")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a33d700e8eea76c62120cb3dbf5e01328f18319a Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Mon, 19 Jun 2023 20:34:00 +0530
Subject: [PATCH] PCI: qcom: Disable write access to read only registers for IP
 v2.3.3

In the post init sequence of v2.9.0, write access to read only registers
are not disabled after updating the registers. Fix it by disabling the
access after register update.

Link: https://lore.kernel.org/r/20230619150408.8468-2-manivannan.sadhasivam@linaro.org
Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: <stable@vger.kernel.org>

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4ab30892f6ef..ef385d36d653 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -836,6 +836,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
 		PCI_EXP_DEVCTL2);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 

