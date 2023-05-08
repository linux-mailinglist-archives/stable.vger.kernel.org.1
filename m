Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D56FA628
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjEHKQz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjEHKQy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:16:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575532917
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFCC624BA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C50C433D2;
        Mon,  8 May 2023 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541011;
        bh=2+pifD5BQ9TqxoWBw3TXIm/3lmGhMa2zUTuk4bI/7+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBSo9dl4k56SVFYUQcI+tlcajRgL5g7UaaL+uwjhXrLM+apYuhls9np8OgGD+dOzs
         CpCNbQaWYolK6aPZ/gGl/dQoeaDXc6QOOnlfY/jA6Mktj7WPKXTLV7wdxSaZFJJkHt
         hli5vpD6ZwAVGeDMxzzBHp7RoS+Kf6mqGwZUFtV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.1 581/611] wifi: rtw89: fix potential race condition between napi_init and napi_enable
Date:   Mon,  8 May 2023 11:47:03 +0200
Message-Id: <20230508094440.812368577@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

commit 47515664ecfbde11425dff121f298ae4499425c9 upstream.

A race condition can happen if netdev is registered, but NAPI isn't
initialized yet, and meanwhile user space starts the netdev that will
enable NAPI. Then, it hits BUG_ON():

 kernel BUG at net/core/dev.c:6423!
 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 0 PID: 417 Comm: iwd Not tainted 6.2.7-slab-dirty #3 eb0f5a8a9d91
 Hardware name: LENOVO 21DL/LNVNB161216, BIOS JPCN20WW(V1.06) 09/20/2022
 RIP: 0010:napi_enable+0x3f/0x50
 Code: 48 89 c2 48 83 e2 f6 f6 81 89 08 00 00 02 74 0d 48 83 ...
 RSP: 0018:ffffada1414f3548 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffffa01425802080 RCX: 0000000000000000
 RDX: 00000000000002ff RSI: ffffada14e50c614 RDI: ffffa01425808dc0
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000001 R11: 0000000000000100 R12: ffffa01425808f58
 R13: 0000000000000000 R14: ffffa01423498940 R15: 0000000000000001
 FS:  00007f5577c0a740(0000) GS:ffffa0169fc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f5577a19972 CR3: 0000000125a7a000 CR4: 0000000000750ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  rtw89_pci_ops_start+0x1c/0x70 [rtw89_pci 6cbc75429515c181cbc386478d5cfb32ffc5a0f8]
  rtw89_core_start+0xbe/0x160 [rtw89_core fe07ecb874820b6d778370d4acb6ef8a37847f22]
  rtw89_ops_start+0x26/0x40 [rtw89_core fe07ecb874820b6d778370d4acb6ef8a37847f22]
  drv_start+0x42/0x100 [mac80211 c07fa22af8c3cf3f7d7ab3884ca990784d72e2d2]
  ieee80211_do_open+0x311/0x7d0 [mac80211 c07fa22af8c3cf3f7d7ab3884ca990784d72e2d2]
  ieee80211_open+0x6a/0x90 [mac80211 c07fa22af8c3cf3f7d7ab3884ca990784d72e2d2]
  __dev_open+0xe0/0x180
  __dev_change_flags+0x1da/0x250
  dev_change_flags+0x26/0x70
  do_setlink+0x37c/0x12c0
  ? ep_poll_callback+0x246/0x290
  ? __nla_validate_parse+0x61/0xd00
  ? __wake_up_common_lock+0x8f/0xd0

To fix this, follow Jonas' suggestion to switch the order of these
functions and move register netdev to be the last step of PCI probe.
Also, correct the error handling of rtw89_core_register_hw().

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Cc: stable@vger.kernel.org
Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/linux-wireless/CAOiHx=n7EwK2B9CnBR07FVA=sEzFagb8TkS4XC_qBNq8OwcYUg@mail.gmail.com/T/#t
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Tested-by: Larry Finger<Larry.Finger@lwfinger.net>
Reviewed-by: Larry Finger<Larry.Finger@lwfinger.net>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230323082839.20474-1-pkshih@realtek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw89/core.c |   10 +++++++---
 drivers/net/wireless/realtek/rtw89/pci.c  |   19 ++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3290,18 +3290,22 @@ static int rtw89_core_register_hw(struct
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to register hw\n");
-		goto err;
+		goto err_free_supported_band;
 	}
 
 	ret = rtw89_regd_init(rtwdev, rtw89_regd_notifier);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to init regd\n");
-		goto err;
+		goto err_unregister_hw;
 	}
 
 	return 0;
 
-err:
+err_unregister_hw:
+	ieee80211_unregister_hw(hw);
+err_free_supported_band:
+	rtw89_core_clr_supported_band(rtwdev);
+
 	return ret;
 }
 
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3828,25 +3828,26 @@ int rtw89_pci_probe(struct pci_dev *pdev
 	rtw89_pci_link_cfg(rtwdev);
 	rtw89_pci_l1ss_cfg(rtwdev);
 
-	ret = rtw89_core_register(rtwdev);
-	if (ret) {
-		rtw89_err(rtwdev, "failed to register core\n");
-		goto err_clear_resource;
-	}
-
 	rtw89_core_napi_init(rtwdev);
 
 	ret = rtw89_pci_request_irq(rtwdev, pdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to request pci irq\n");
-		goto err_unregister;
+		goto err_deinit_napi;
+	}
+
+	ret = rtw89_core_register(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to register core\n");
+		goto err_free_irq;
 	}
 
 	return 0;
 
-err_unregister:
+err_free_irq:
+	rtw89_pci_free_irq(rtwdev, pdev);
+err_deinit_napi:
 	rtw89_core_napi_deinit(rtwdev);
-	rtw89_core_unregister(rtwdev);
 err_clear_resource:
 	rtw89_pci_clear_resource(rtwdev, pdev);
 err_declaim_pci:


