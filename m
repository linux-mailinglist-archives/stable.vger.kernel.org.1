Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29A370C8D0
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjEVTmg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjEVTme (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:42:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465F12B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42E8E629F0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF62C433D2;
        Mon, 22 May 2023 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784527;
        bh=byWCWSLw3MQQeHKSMnTSsapdwq8cJxSTwv7+8NmzPX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0WP6ta60Ckl+bJp9x/H8fC20GkefS9lt5LFAGNlKsssOoziYhuK3Zmam+tMoHYVt
         Kju0M4/WwNwvgi6HryPkXaj6YVaQxLCc6+lfZLKYovfBHAoYnCk+CEwCtesec8Tb/F
         cgHZwDoIdILIFONxzZDS4kBp45lrsA1J8BE03TbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 070/364] accel/ivpu: Remove D3hot delay for Meteorlake
Date:   Mon, 22 May 2023 20:06:15 +0100
Message-Id: <20230522190414.529838575@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Karol Wachowski <karol.wachowski@linux.intel.com>

[ Upstream commit cb949ce504e829193234e26cb3042bb448465d52 ]

VPU on MTL has hardware optimizations and does not require 10ms
D0 - D3hot transition delay imposed by PCI specification (PCIe
r6.0, sec 5.9.) .

The delay removal is traditionally done by adding PCI ID to
quirk_remove_d3hot_delay() in drivers/pci/quirks.c . But since
we do not need that optimization before driver probe and we
can better specify in the ivpu driver on what (future) hardware
use the optimization, we do not use quirk_remove_d3hot_delay()
for that.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230403121545.2995279-1-stanislaw.gruszka@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 6a320a73e3ccf..8396db2b52030 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -437,6 +437,10 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
 	/* Clear any pending errors */
 	pcie_capability_clear_word(pdev, PCI_EXP_DEVSTA, 0x3f);
 
+	/* VPU MTL does not require PCI spec 10m D3hot delay */
+	if (ivpu_is_mtl(vdev))
+		pdev->d3hot_delay = 0;
+
 	ret = pcim_enable_device(pdev);
 	if (ret) {
 		ivpu_err(vdev, "Failed to enable PCI device: %d\n", ret);
-- 
2.39.2



