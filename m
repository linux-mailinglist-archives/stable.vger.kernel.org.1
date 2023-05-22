Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD770C760
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjEVT2v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjEVT2u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E618EDC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8304C62605
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2ABC433EF;
        Mon, 22 May 2023 19:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783727;
        bh=aOAJdRZ7SnZENcvARAFYwb74mKw2i7tpKS6bCcV0SSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7DTRPTI1T5VOvF2MFZ8GOTUIMCOrn5koCxkCRYWoAxbiR3x3SoRlgLkMupULtWxT
         yARwtcSCBIJuRshDZiCA8rNdDjlWVCU1196htAqSl4iBVmbND8y5e6j7fWi9M6td/J
         l0FF2SfGGwAjzcF22z/BnP5znbd6n9EaSSp/GOa8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/292] Bluetooth: btintel: Add LE States quirk support
Date:   Mon, 22 May 2023 20:07:52 +0100
Message-Id: <20230522190408.839275669@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Chethan T N <chethan.tumkur.narayan@intel.com>

[ Upstream commit 77f542b10c535c9a93bf8afdd2665524935807c2 ]

Basically all Intel controllers support both Central/Peripheral
LE states.

This patch enables the LE States quirk by default on all
Solar and Magnertor Intel controllers.

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f6b4b7a1be4cc..bbad1207cdfd8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2553,9 +2553,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-		/* Valid LE States quirk for GfP */
-		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
-			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		/* Apply LE States quirk from solar onwards */
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
-- 
2.39.2



