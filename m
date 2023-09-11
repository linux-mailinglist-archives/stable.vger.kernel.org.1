Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF679BFE1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376655AbjIKWUK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbjIKOgN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F92F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79371C433C8;
        Mon, 11 Sep 2023 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442968;
        bh=00iuae5JbGwT1LwcMk0YSqpaBvYIEmC1lvCMRwk3MA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DR76MMRxOz6k2FW/0WYrVONF/aGkQeVdIjJbB4vY6XMVQu15IxJzhaG8yb8YBg/Bn
         nU+lsV/+wUAtiJ635RuTGIk0Jg1A1jkCH0dmuvfquhJAWmHlEr10es3G351LxeNn4r
         iXAHgAgvLGqfDh3KWKqhBUmbG0OCqJ0U3TmQvmWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 184/737] wifi: ath12k: fix memcpy array overflow in ath12k_peer_assoc_h_he()
Date:   Mon, 11 Sep 2023 15:40:43 +0200
Message-ID: <20230911134655.710692118@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 603cf6c2fcdcbc38f1daa316794e7268852677a7 ]

Two memory copies in this function copy from a short array into a longer one,
using the wrong size, which leads to an out-of-bounds access:

include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);
                        ^
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
2 errors generated.

Fixes: d889913205cf7 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230703123737.3420464-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 58acfe8fdf8c0..faccea2d8148c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1634,9 +1634,9 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
 
 	memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
-	       sizeof(arg->peer_he_cap_macinfo));
+	       sizeof(he_cap->he_cap_elem.mac_cap_info));
 	memcpy(&arg->peer_he_cap_phyinfo, he_cap->he_cap_elem.phy_cap_info,
-	       sizeof(arg->peer_he_cap_phyinfo));
+	       sizeof(he_cap->he_cap_elem.phy_cap_info));
 	arg->peer_he_ops = vif->bss_conf.he_oper.params;
 
 	/* the top most byte is used to indicate BSS color info */
-- 
2.40.1



