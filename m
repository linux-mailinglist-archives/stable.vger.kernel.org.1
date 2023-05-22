Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A070C63A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjEVTQW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjEVTQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B22E50
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F5A962758
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9839FC4339B;
        Mon, 22 May 2023 19:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782955;
        bh=/TGR4uKvgJibnKmgX0SbV59BKNwneOqpzqjWdmtOygY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZohnWpbpy68pEfTSjhVMOrDbFEgdR2EezjMlQ3Klzg6dUxx+NmtdVmeJCoOrszBUt
         b6MzzvxiX5PFeMrW5SOont7HUo+Kmog0CPcd6XI180+OUSapcwDU5rwfKZTufHTvem
         H+oSgAifsvtq/C2mM5cr1hC+ishrotgK+aMgzUC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 061/203] scsi: ufs: ufs-pci: Add support for Intel Lunar Lake
Date:   Mon, 22 May 2023 20:08:05 +0100
Message-Id: <20230522190356.683960070@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 0a07d3c7a1d205b47d9f3608ff4e9d1065d63b6d ]

Add PCI ID to support Intel Lunar Lake, same as MTL.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20230328105832.3495-1-adrian.hunter@intel.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index e892b9feffb11..0920530a72d28 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -596,6 +596,7 @@ static const struct pci_device_id ufshcd_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x51FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x54FF), (kernel_ulong_t)&ufs_intel_adl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x7E47), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
+	{ PCI_VDEVICE(INTEL, 0xA847), (kernel_ulong_t)&ufs_intel_mtl_hba_vops },
 	{ }	/* terminate list */
 };
 
-- 
2.39.2



