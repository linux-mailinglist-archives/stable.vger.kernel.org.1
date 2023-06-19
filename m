Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F6735500
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjFSLAc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjFSLAF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85DEE60
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57F4960B5F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDC9C433C0;
        Mon, 19 Jun 2023 10:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172341;
        bh=kn5cdVjAARyR0aMANtkwTmbxaMEjTqWBiFrubMU9P7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tcV6YAN0kxxgrhz3j8hsS8hFZUi7qy56RuL/9Vk7TBCeap+aIjySqkeq+pUD1D8gv
         BXnuSOaNgBYZ4ovGYeElgtt88H16WKxQUqLFGOD0D0u8IHpqudaRW0Kyku/D3XLp/G
         CB8U0Oj1xWDOzoz30SNf67zdQqzEWL4xFilGeyb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.15 034/107] wifi: cfg80211: fix double lock bug in reg_wdev_chan_valid()
Date:   Mon, 19 Jun 2023 12:30:18 +0200
Message-ID: <20230619102143.134019452@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 996c3117dae4c02b38a3cb68e5c2aec9d907ec15 upstream.

The locking was changed recently so now the caller holds the wiphy_lock()
lock.  Taking the lock inside the reg_wdev_chan_valid() function will
lead to a deadlock.

Fixes: f7e60032c661 ("wifi: cfg80211: fix locking in regulatory disconnect")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/40c4114a-6cb4-4abf-b013-300b598aba65@moroto.mountain
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/reg.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2398,9 +2398,7 @@ static bool reg_wdev_chan_valid(struct w
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_ADHOC:
-		wiphy_lock(wiphy);
 		ret = cfg80211_reg_can_beacon_relax(wiphy, &chandef, iftype);
-		wiphy_unlock(wiphy);
 
 		return ret;
 	case NL80211_IFTYPE_STATION:


