Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135979B5B2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbjIKVrP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjIKOAV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:00:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A0CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:00:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84882C433C8;
        Mon, 11 Sep 2023 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440816;
        bh=B3mGKoJXjsHx/Vyoniy5lOqNvAvKiDRlVVns+mXr9ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtOkEdfiAtIGiPWdXDM+r/cbiNcsjDFb+uxYH4ocN6ITkcHBTHsfGR0g4ar1EHUd5
         8s5SnX1MQ8uos5n+kJI2ZOT4OXMeljlJcEfe1Hu+cNPFFHaNp5od+r1s0bx4wa90nk
         Wx81AOKWtXgUHiRMHbZWbVZP6W1+GqpLnml6BKo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 168/739] mac80211: make ieee80211_tx_info padding explicit
Date:   Mon, 11 Sep 2023 15:39:27 +0200
Message-ID: <20230911134655.870145614@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a7a2ef0c4b3efbd7d6f3fabd87dbbc0b3f2de5af ]

While looking at a bug, I got rather confused by the layout of the
'status' field in ieee80211_tx_info. Apparently, the intention is that
status_driver_data[] is used for driver specific data, and fills up the
size of the union to 40 bytes, just like the other ones.

This is indeed what actually happens, but only because of the
combination of two mistakes:

 - "void *status_driver_data[18 / sizeof(void *)];" is intended
   to be 18 bytes long but is actually two bytes shorter because of
   rounding-down in the division, to a multiple of the pointer
   size (4 bytes or 8 bytes).

 - The other fields combined are intended to be 22 bytes long, but
   are actually 24 bytes because of padding in front of the
   unaligned tx_time member, and in front of the pointer array.

The two mistakes cancel out. so the size ends up fine, but it seems
more helpful to make this explicit, by having a multiple of 8 bytes
in the size calculation and explicitly describing the padding.

Fixes: ea5907db2a9cc ("mac80211: fix struct ieee80211_tx_info size")
Fixes: 02219b3abca59 ("mac80211: add WMM admission control support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230623152443.2296825-2-arnd@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mac80211.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2a55ae932c568..ad41581384d9f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1192,9 +1192,11 @@ struct ieee80211_tx_info {
 			u8 ampdu_ack_len;
 			u8 ampdu_len;
 			u8 antenna;
+			u8 pad;
 			u16 tx_time;
 			u8 flags;
-			void *status_driver_data[18 / sizeof(void *)];
+			u8 pad2;
+			void *status_driver_data[16 / sizeof(void *)];
 		} status;
 		struct {
 			struct ieee80211_tx_rate driver_rates[
-- 
2.40.1



