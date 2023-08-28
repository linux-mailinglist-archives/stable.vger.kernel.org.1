Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3567778AA43
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjH1KUi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjH1KUL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:20:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B1CCA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 716D86382F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8018FC433C7;
        Mon, 28 Aug 2023 10:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217988;
        bh=rNhQPptfqpHyjdloNYaxFDI7mtBqdHCder4EKfNRFZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksvPrlNO2016ntF/l3QQJxhfaYohx4yJraDxq4oxmN1WGO4RTbG6y6V4CAnvOsfMG
         RNwESSBpGIiZ8NKNeWbT4+ytSa3z0fFvzXWTdTh0fIlQrVJnnQOS/LFzD8MJYXlcvx
         pLe1J7NQzSNk9ZgxjhfT4WQmd21gZkpBIz9DtUDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.4 055/129] wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning
Date:   Mon, 28 Aug 2023 12:12:14 +0200
Message-ID: <20230828101159.193491603@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

commit b98c16107cc1647242abbd11f234c05a3a5864f6 upstream.

The commit 06470f7468c8 ("mac80211: add API to allow filtering frames in BA sessions")
added reorder_buf_filtered to mark frames filtered by firmware, and it
can only work correctly if hw.max_rx_aggregation_subframes <= 64 since
it stores the bitmap in a u64 variable.

However, new HE or EHT devices can support BlockAck number up to 256 or
1024, and then using a higher subframe index leads UBSAN warning:

 UBSAN: shift-out-of-bounds in net/mac80211/rx.c:1129:39
 shift exponent 215 is too large for 64-bit type 'long long unsigned int'
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x48/0x70
  dump_stack+0x10/0x20
  __ubsan_handle_shift_out_of_bounds+0x1ac/0x360
  ieee80211_release_reorder_frame.constprop.0.cold+0x64/0x69 [mac80211]
  ieee80211_sta_reorder_release+0x9c/0x400 [mac80211]
  ieee80211_prepare_and_rx_handle+0x1234/0x1420 [mac80211]
  ieee80211_rx_list+0xaef/0xf60 [mac80211]
  ieee80211_rx_napi+0x53/0xd0 [mac80211]

Since only old hardware that supports <=64 BlockAck uses
ieee80211_mark_rx_ba_filtered_frames(), limit the use as it is, so add a
WARN_ONCE() and comment to note to avoid using this function if hardware
capability is not suitable.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://lore.kernel.org/r/20230818014004.16177-1-pkshih@realtek.com
[edit commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/mac80211.h |    1 +
 net/mac80211/rx.c      |   12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6578,6 +6578,7 @@ void ieee80211_stop_rx_ba_session(struct
  * marks frames marked in the bitmap as having been filtered. Afterwards, it
  * checks if any frames in the window starting from @ssn can now be released
  * (in case they were only waiting for frames that were filtered.)
+ * (Only work correctly if @max_rx_aggregation_subframes <= 64 frames)
  */
 void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 					  u16 ssn, u64 filtered,
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1083,7 +1083,8 @@ static inline bool ieee80211_rx_reorder_
 	struct sk_buff *tail = skb_peek_tail(frames);
 	struct ieee80211_rx_status *status;
 
-	if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
+	if (tid_agg_rx->reorder_buf_filtered &&
+	    tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
 		return true;
 
 	if (!tail)
@@ -1124,7 +1125,8 @@ static void ieee80211_release_reorder_fr
 	}
 
 no_frame:
-	tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);
+	if (tid_agg_rx->reorder_buf_filtered)
+		tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);
 	tid_agg_rx->head_seq_num = ieee80211_sn_inc(tid_agg_rx->head_seq_num);
 }
 
@@ -4245,6 +4247,7 @@ void ieee80211_mark_rx_ba_filtered_frame
 					  u16 ssn, u64 filtered,
 					  u16 received_mpdus)
 {
+	struct ieee80211_local *local;
 	struct sta_info *sta;
 	struct tid_ampdu_rx *tid_agg_rx;
 	struct sk_buff_head frames;
@@ -4262,6 +4265,11 @@ void ieee80211_mark_rx_ba_filtered_frame
 
 	sta = container_of(pubsta, struct sta_info, sta);
 
+	local = sta->sdata->local;
+	WARN_ONCE(local->hw.max_rx_aggregation_subframes > 64,
+		  "RX BA marker can't support max_rx_aggregation_subframes %u > 64\n",
+		  local->hw.max_rx_aggregation_subframes);
+
 	if (!ieee80211_rx_data_set_sta(&rx, sta, -1))
 		return;
 


