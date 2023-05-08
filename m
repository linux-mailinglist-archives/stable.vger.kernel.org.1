Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9726C6FACFB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjEHLaD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbjEHL3r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:29:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA93C4A2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61EFA62F07
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DE8C433EF;
        Mon,  8 May 2023 11:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545345;
        bh=KQBoVz47dUV/NC1LnE0YmKV9npUXjJR4A2kw/fkkYek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygxm+hdswAQF2uau/IjEHbQiq/Ff2CP8q1KYSvnjXVCA0vYWvjDaMlgrAPGDE1kUU
         7ZfXKwht6MYBOyeYLUxIpoQGgwip+rOEGcDuw/HNenBB1cWvSLWcCeQC+JecqGCYUa
         UFYmf+lgWPPZuBcXoX0cW3CHNYq2PQBqkNOimadg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anson Tsao <anson.tsao@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 5.15 010/371] wifi: mt76: mt7921e: Set memory space enable in PCI_COMMAND if unset
Date:   Mon,  8 May 2023 11:43:31 +0200
Message-Id: <20230508094812.435739489@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit 09d4d6da1b65d09414e7bce61459593f3c80ead1 upstream.

When the BIOS has been configured for Fast Boot, systems with mt7921e
have non-functional wifi.  Turning on Fast boot caused both bus master
enable and memory space enable bits in PCI_COMMAND not to get configured.

The mt7921 driver already sets bus master enable, but explicitly check
and set memory access enable as well to fix this problem.

Tested-by: Anson Tsao <anson.tsao@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -218,6 +218,7 @@ static int mt7921_pci_probe(struct pci_d
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
 	int ret;
+	u16 cmd;
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
@@ -227,6 +228,11 @@ static int mt7921_pci_probe(struct pci_d
 	if (ret)
 		return ret;
 
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (!(cmd & PCI_COMMAND_MEMORY)) {
+		cmd |= PCI_COMMAND_MEMORY;
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	}
 	pci_set_master(pdev);
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);


