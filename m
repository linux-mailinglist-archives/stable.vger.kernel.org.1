Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425347E2441
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjKFNUA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjKFNT6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:19:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7D3100
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:19:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FD9C433C8;
        Mon,  6 Nov 2023 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276795;
        bh=ydyomRHqMBMb1DY7OeoxI8gtns9ML4shK0kxW1tYHgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbOQPjSyrsr+lP9KTeawualDI+9UK632v6dYhEAPnPHa5T/v1lj3x9lCJsgg2Xrq0
         uuva+zYAFEP/Y11aaZYPVotYEb4f2SWYTYOPniW1h2jSYkvuGqB1NfL8RhgV7Apsu+
         OlilXSkfsb2BFKHT3VXx7Tz/431WghNak9a5BrW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Mateusz Palczewski <mateusz.palczewski@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH 5.4 10/74] igb: Fix potential memory leak in igb_add_ethtool_nfc_entry
Date:   Mon,  6 Nov 2023 14:03:30 +0100
Message-ID: <20231106130302.061577676@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mateusz Palczewski <mateusz.palczewski@intel.com>

[ Upstream commit 8c0b48e01daba5ca58f939a8425855d3f4f2ed14 ]

Add check for return of igb_update_ethtool_nfc_entry so that in case
of any potential errors the memory alocated for input will be freed.

Fixes: 0e71def25281 ("igb: add support of RX network flow classification")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 50f61b18ae1e3..de2c39436fe0a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2997,11 +2997,15 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if (err)
 		goto err_out_w_lock;
 
-	igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	err = igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	if (err)
+		goto err_out_input_filter;
 
 	spin_unlock(&adapter->nfc_lock);
 	return 0;
 
+err_out_input_filter:
+	igb_erase_filter(adapter, input);
 err_out_w_lock:
 	spin_unlock(&adapter->nfc_lock);
 err_out:
-- 
2.42.0



