Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585807036DE
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbjEOROo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbjEOROZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D22E8A53
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF5362B93
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2982C433D2;
        Mon, 15 May 2023 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170768;
        bh=CO+ruu5NkpRgtRYA3hftMbSIOvFlNRVgiGKt7J7EbIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOhufAFdpVkf5KWYQPoRPrxm+bVJq6r2jS6OUH/YxnL51/rL4SQM6hT5/tUd76hx/
         xrrlSz2GTk+uC8fBVnUJcrvMMC6D2WbAUuAbaf59A6NIkjmqCNJtEi7k1uKEDbuec/
         3XeMprTlbTVo2oOT3tIbcXnnSphB9dEqvRgJ96PE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.1 235/239] x86/amd_nb: Add PCI ID for family 19h model 78h
Date:   Mon, 15 May 2023 18:28:18 +0200
Message-Id: <20230515161728.758591816@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit 23a5b8bb022c1e071ca91b1a9c10f0ad6a0966e9 upstream.

Commit

  310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN index 0 for driver probe")

switched to using amd_smn_read() which relies upon the misc PCI ID used
by DF function 3 being included in a table.  The ID for model 78h is
missing in that table, so amd_smn_read() doesn't work.

Add the missing ID into amd_nb, restoring s2idle on this system.

  [ bp: Simplify commit message. ]

Fixes: 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN index 0 for driver probe")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_ids.h
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230427053338.16653-2-mario.limonciello@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/amd_nb.c |    2 ++
 include/linux/pci_ids.h  |    1 +
 2 files changed, 3 insertions(+)

--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -36,6 +36,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -79,6 +80,7 @@ static const struct pci_device_id amd_nb
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{}
 };
 
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -567,6 +567,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001


