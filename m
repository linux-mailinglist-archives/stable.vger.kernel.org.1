Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8076AD0E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjHAJZt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjHAJZf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0227C35BD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C37614FB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80669C433C7;
        Tue,  1 Aug 2023 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881857;
        bh=eIctwurLPCh32SM1IM67378SVqHj0DNRthqx0eX63PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3cJSB9HuEW4aXb7oTzDxFrPJClB5duGZ4vzVBacGkX/oGnCLWuzRkX3ubPQYL+9D
         Lb12Q9bhcWFTCPhEMlkUgdVs+Ngn0NrATPL+rjqRO6TPD4VZi6Oc3T1st9b6VGp/E5
         31QL2aZLLdyU8ha4jkVDGk4IC4gy6g4Qiu7+j7Ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 015/155] PCI/ASPM: Avoid link retraining race
Date:   Tue,  1 Aug 2023 11:18:47 +0200
Message-ID: <20230801091910.744645461@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit e7e39756363ad5bd83ddeae1063193d0f13870fd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5e09cbb563366..3078de668f911 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -212,8 +212,19 @@ static int pcie_wait_for_retrain(struct pci_dev *pdev)
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
-- 
2.39.2



