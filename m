Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF427DD53C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376475AbjJaRsa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376494AbjJaRs1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB59ED
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0291C433CB;
        Tue, 31 Oct 2023 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774498;
        bh=MYHPeqnmScChCwTdJff+4CRpLLItqqFA8VK7w3MZ0FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNctvWkRlgK7TqGbTeYrI0yecNANk6tmCnjhoxGEkOcxleLHUW40ukRSzv6Oc0Sjn
         MYWxrRD2uWkr0fzx7Loy8YsFfAl+sCuJPZ9lOa599xrN1/RbREaUArTU7zoBFV+pVM
         dNMR3MjTlPtHnJy2wwwb+L8sJpuMaBBgT8DK9P44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        hq.dev+kernel@msdfc.xyz,
        Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH 6.5 022/112] i40e: sync next_to_clean and next_to_process for programming status desc
Date:   Tue, 31 Oct 2023 18:00:23 +0100
Message-ID: <20231031165902.009158690@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

commit 068d8b75c1aee153193522211ace6c13c21cd16b upstream.

When a programming status desc is encountered on the rx_ring,
next_to_process is bumped along with cleaned_count but next_to_clean is
not. This causes I40E_DESC_UNUSED() macro to misbehave resulting in
overwriting whole ring with new buffers.

Update next_to_clean to point to next_to_process on seeing a programming
status desc if not in the middle of handling a multi-frag packet. Also,
bump cleaned_count only for such case as otherwise next_to_clean buffer
may be returned to hardware on reaching clean_threshold.

Fixes: e9031f2da1ae ("i40e: introduce next_to_process to i40e_ring")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reported-by: hq.dev+kernel@msdfc.xyz
Reported by: Solomon Peachy <pizza@shaftnet.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217678
Tested-by: hq.dev+kernel@msdfc.xyz
Tested by: Indrek Järve <incx@dustbite.net>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://lore.kernel.org/r/20231019203852.3663665-1-jacob.e.keller@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 0b3a27f118fb..50c70a8e470a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2544,7 +2544,14 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			rx_buffer = i40e_rx_bi(rx_ring, ntp);
 			i40e_inc_ntp(rx_ring);
 			i40e_reuse_rx_page(rx_ring, rx_buffer);
-			cleaned_count++;
+			/* Update ntc and bump cleaned count if not in the
+			 * middle of mb packet.
+			 */
+			if (rx_ring->next_to_clean == ntp) {
+				rx_ring->next_to_clean =
+					rx_ring->next_to_process;
+				cleaned_count++;
+			}
 			continue;
 		}
 
-- 
2.42.0



