Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762607ECEFC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjKOTpc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjKOTpc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4F5B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3732C433CA;
        Wed, 15 Nov 2023 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077529;
        bh=Rgc5KMzGDPR6Ns4z0FwKqB9iLEyE6qs6A7eKXRKYa/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xFZ2MMCd7XySEOk9b8KoYZ01W7U7Z4T4Z4PG78s6DKV56a6E1qEQkPiKh4dipa3su
         Ux/yHBrE2lsErFVBfJ6ykg7UGxEZCIClV+/U6ViWZtNTWCR46AnNerQwwH7Y0m1VvH
         ZRoP6619fmH5T1/CDoqaTgZhuQ69KxVq2rXH50cA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 359/603] PCI: vmd: Correct PCI Header Type Registers multi-function check
Date:   Wed, 15 Nov 2023 14:15:04 -0500
Message-ID: <20231115191638.369890323@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 5827e17d0555b566c32044b0632b46f9f95054fa ]

vmd_domain_reset() attempts to find whether the device may contain multiple
functions by checking 0x80 (Multi-Function Device), however, the hdr_type
variable has already been masked with PCI_HEADER_TYPE_MASK so the check can
never true.

To fix the issue, don't mask the read with PCI_HEADER_TYPE_MASK.

Fixes: 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
Link: https://lore.kernel.org/r/20231003125300.5541-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index ad56df98b8e63..1c1c1aa940a51 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -525,8 +525,7 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
 						PCI_DEVFN(dev, 0), 0);
 
-			hdr_type = readb(base + PCI_HEADER_TYPE) &
-					 PCI_HEADER_TYPE_MASK;
+			hdr_type = readb(base + PCI_HEADER_TYPE);
 
 			functions = (hdr_type & 0x80) ? 8 : 1;
 			for (fn = 0; fn < functions; fn++) {
-- 
2.42.0



