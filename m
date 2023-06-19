Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E92573536D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjFSKpg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFSKpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C210C4
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E9360B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6C0C433C9;
        Mon, 19 Jun 2023 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171476;
        bh=9ZOxKVTUrIzttJTVzTa3XupfHcO5Na4L4P3jSK5/WgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAXjXWAPq3Y4VUZJZJdsCPk2MumSbnBsUoJwD1VV2kitbIO21QD4PBjx4atdyLlSh
         KYrMAEiYam9NAE9sF06CQRbvymC7mMjG8kujLQayVRG3EN3d3ivqu7WsqeMBZGFxa1
         WHBwjifWqOp9eZHr+JQD6Ws+pMbFBrmJ+QbVzyz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 044/166] wifi: cfg80211: fix double lock bug in reg_wdev_chan_valid()
Date:   Mon, 19 Jun 2023 12:28:41 +0200
Message-ID: <20230619102156.837847289@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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
 net/wireless/reg.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2442,11 +2442,8 @@ static bool reg_wdev_chan_valid(struct w
 		case NL80211_IFTYPE_P2P_GO:
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
-			wiphy_lock(wiphy);
 			ret = cfg80211_reg_can_beacon_relax(wiphy, &chandef,
 							    iftype);
-			wiphy_unlock(wiphy);
-
 			if (!ret)
 				return ret;
 			break;


