Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098E979AFAE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377756AbjIKW2c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbjIKOa3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD1E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99F5C433C7;
        Mon, 11 Sep 2023 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442625;
        bh=69n/ccFV3z3zD6GhsK02+mLGxOSPuKhgawPZDKDkfHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5TwPvIbLeJv5J+JnL7GZ4gRMzlXCWRdkFmvu/YeiFh0TpBZakByrN/+ByLfA9rj7
         ay0LSXK11tWiTPNv2CedEmia4jcp9nsTj3VHImo2GM48cqLIEUd4g2qewW+2mhfP3q
         UM9I0mL7owUewFxCJsRogWqNJbTLOAiJmp43Qh9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Gong <quic_wgong@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 063/737] wifi: ath12k: Fix buffer overflow when scanning with extraie
Date:   Mon, 11 Sep 2023 15:38:42 +0200
Message-ID: <20230911134652.263967299@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 06f2ab86a5b6ed55f013258de4be9319841853ea ]

If cfg80211 is providing extraie's for a scanning process then ath12k will
copy that over to the firmware. The extraie.len is a 32 bit value in struct
element_info and describes the amount of bytes for the vendor information
elements.

The problem is the allocation of the buffer. It has to align the TLV
sections by 4 bytes. But the code was using an u8 to store the newly
calculated length of this section (with alignment). And the new
calculated length was then used to allocate the skbuff. But the actual
code to copy in the data is using the extraie.len and not the calculated
"aligned" length.

The length of extraie with IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS enabled
was 264 bytes during tests with a wifi card. But it only allocated 8
bytes (264 bytes % 256) for it. As consequence, the code to memcpy the
extraie into the skb was then just overwriting data after skb->end. Things
like shinfo were therefore corrupted. This could usually be seen by a crash
in skb_zcopy_clear which tried to call a ubuf_info callback (using a bogus
address).

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Link: https://lore.kernel.org/r/20230809081241.32765-1-quic_wgong@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7ae0bb78b2b53..1e65e35b5f3a6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2144,8 +2144,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	struct wmi_tlv *tlv;
 	void *ptr;
 	int i, ret, len;
-	u32 *tmp_ptr;
-	u8 extraie_len_with_pad = 0;
+	u32 *tmp_ptr, extraie_len_with_pad = 0;
 	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
 	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
 
-- 
2.40.1



