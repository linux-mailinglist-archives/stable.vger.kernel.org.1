Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BF7039CA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjEORqC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbjEORpi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB84B16911
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A33562046
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC41C433D2;
        Mon, 15 May 2023 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172607;
        bh=gkfnnr1qoSbUOYReg2jWrFx1R+8WYHwcmUOKvnwDoOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jE0pc0exoiUTUSICE17abHwNXtvFsy+sIYh9uHyahpG984lVewAVd6uFyMAJHOJcn
         ypB/RgxRTqW2BMEYwa5vkFsCa016QVqnH1yYW8I4ciPPa2IjiLe2lFS7a4Eki3Qus/
         OpnQE0Big4bDQJOdWhGE6jRBU4Vb2r5lY0yHizVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tsaur Erwin <erwin.tsaur@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 209/381] PCI/EDR: Clear Device Status after EDR error recovery
Date:   Mon, 15 May 2023 18:27:40 +0200
Message-Id: <20230515161746.233747250@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

[ Upstream commit c441b1e03da6c680a3e12da59c554f454f2ccf5e ]

During EDR recovery, the OS must clear error status of the port that
triggered DPC even if firmware retains control of DPC and AER (see the
implementation note in the PCI Firmware spec r3.3, sec 4.6.12).

Prior to 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
OS owns AER"), the port Device Status was cleared in this path:

  edr_handle_event
    dpc_process_error(dev)                 # "dev" triggered DPC
    pcie_do_recovery(dev, dpc_reset_link)
      dpc_reset_link                       # exit DPC
      pcie_clear_device_status(dev)        # clear Device Status

After 068c29a248b6, pcie_do_recovery() no longer clears Device Status when
firmware controls AER, so the error bit remains set even after recovery.

Per the "Downstream Port Containment configuration control" bit in the
returned _OSC Control Field (sec 4.5.1), the OS is allowed to clear error
status until it evaluates _OST, so clear Device Status in
edr_handle_event() if the error recovery was successful.

[bhelgaas: commit log]
Fixes: 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if OS owns AER")
Link: https://lore.kernel.org/r/20230315235449.1279209-1-sathyanarayanan.kuppuswamy@linux.intel.com
Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/edr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index a6b9b479b97ad..87734e4c3c204 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 */
 	if (estate == PCI_ERS_RESULT_RECOVERED) {
 		pci_dbg(edev, "DPC port successfully recovered\n");
+		pcie_clear_device_status(edev);
 		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
 	} else {
 		pci_dbg(edev, "DPC port recovery failed\n");
-- 
2.39.2



