Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425BB713D57
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjE1TYV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjE1TYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC39EB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F80361BA7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE7EC433EF;
        Sun, 28 May 2023 19:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301858;
        bh=gyPQeB27qRBOEmUX6wQZplbuE1HpAQh69Z00+4a2jHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTqdIj7u8TENEstFmalcSVc0uv+M3hcQgZUKCfShwvayNNOgLaWv77VL6bH1zeCWM
         xdpY0UIKMbiz9R36fwEwNKPc7jd5zt4Ic++8jY+xsu1JtATgD4o0ZAkyZkJdcXrK4+
         fhvSd1b8NITTZuskLYzdJDN+9S8tNK6VOhUx13Mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 037/161] wifi: iwlwifi: pcie: fix possible NULL pointer dereference
Date:   Sun, 28 May 2023 20:09:21 +0100
Message-Id: <20230528190838.385348978@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit b655b9a9f8467684cfa8906713d33b71ea8c8f54 ]

It is possible that iwl_pci_probe() will fail and free the trans,
then afterwards iwl_pci_remove() will be called and crash by trying
to access trans which is already freed, fix it.

iwlwifi 0000:01:00.0: Detected crf-id 0xa5a5a5a2, cnv-id 0xa5a5a5a2
		      wfpm id 0xa5a5a5a2
iwlwifi 0000:01:00.0: Can't find a correct rfid for crf id 0x5a2
...
BUG: kernel NULL pointer dereference, address: 0000000000000028
...
RIP: 0010:iwl_pci_remove+0x12/0x30 [iwlwifi]
pci_device_remove+0x3e/0xb0
device_release_driver_internal+0x103/0x1f0
driver_detach+0x4c/0x90
bus_remove_driver+0x5c/0xd0
driver_unregister+0x31/0x50
pci_unregister_driver+0x40/0x90
iwl_pci_unregister_driver+0x15/0x20 [iwlwifi]
__exit_compat+0x9/0x98 [iwlwifi]
__x64_sys_delete_module+0x147/0x260

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230413213309.082f6e21341b.I0db21d7fa9a828d571ca886713bd0b5d0b6e1e5c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index f34297fd453c0..5153314e85554 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1173,6 +1173,9 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 {
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 
+	if (!trans)
+		return;
+
 	iwl_drv_stop(trans->drv);
 
 	iwl_trans_pcie_free(trans);
-- 
2.39.2



