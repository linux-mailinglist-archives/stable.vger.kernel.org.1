Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ADE75BE91
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjGUGPw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGUGP3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1308F3592
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B48C96131A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F289C433C9;
        Fri, 21 Jul 2023 06:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919868;
        bh=2lSrX2zKk7GfEdt2KCy+s1K7qYJsxqH9RUIJ1+q2cSQ=;
        h=Subject:To:Cc:From:Date:From;
        b=Retw+07v2VslFNN63c+p2n/lewMDJl+wmAW0pQgFOHhzueKWvvxHFmmvps6LY+Dn/
         0LsncRx/8RlmnFIbIHlhNWqqlswZlFxfoByopFmmKGPN7e7HC8udIfB0w5oh6OfJAK
         sInIxudl6drsfqTIWln/tMcrQ6PHgD8o9i3nTjlQ=
Subject: FAILED: patch "[PATCH] PCI/ASPM: Avoid link retraining race" failed to apply to 5.4-stable tree
To:     ilpo.jarvinen@linux.intel.com, bhelgaas@google.com, lukas@wunner.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:10:57 +0200
Message-ID: <2023072157-underwire-tattle-5aaf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x e7e39756363ad5bd83ddeae1063193d0f13870fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072157-underwire-tattle-5aaf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

e7e39756363a ("PCI/ASPM: Avoid link retraining race")
9c7f136433d2 ("PCI/ASPM: Factor out pcie_wait_for_retrain()")
f5297a01ee80 ("PCI/ASPM: Return 0 or -ETIMEDOUT from  pcie_retrain_link()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7e39756363ad5bd83ddeae1063193d0f13870fd Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 May 2023 11:39:23 +0300
Subject: [PATCH] PCI/ASPM: Avoid link retraining race
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe r6.0.1, sec 7.5.3.7, recommends setting the link control parameters,
then waiting for the Link Training bit to be clear before setting the
Retrain Link bit.

This avoids a race where the LTSSM may not use the updated parameters if it
is already in the midst of link training because of other normal link
activity.

Wait for the Link Training bit to be clear before toggling the Retrain Link
bit to ensure that the LTSSM uses the updated link control parameters.

[bhelgaas: commit log, return 0 (success)/-ETIMEDOUT instead of bool for
both pcie_wait_for_retrain() and the existing pcie_retrain_link()]
Suggested-by: Lukas Wunner <lukas@wunner.de>
Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
Link: https://lore.kernel.org/r/20230502083923.34562-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 954717d7033f..3aa73ecdf86f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -213,8 +213,19 @@ static int pcie_wait_for_retrain(struct pci_dev *pdev)
 static int pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
+	int rc;
 	u16 reg16;
 
+	/*
+	 * Ensure the updated LNKCTL parameters are used during link
+	 * training by checking that there is no ongoing link training to
+	 * avoid LTSSM race as recommended in Implementation Note at the
+	 * end of PCIe r6.0.1 sec 7.5.3.7.
+	 */
+	rc = pcie_wait_for_retrain(parent);
+	if (rc)
+		return rc;
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);

