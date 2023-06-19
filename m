Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36094735253
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjFSKdi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjFSKdh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1822B3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F1A060B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9582DC433C8;
        Mon, 19 Jun 2023 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170815;
        bh=ug6aMGsAF7TYHqvIPkyMW7em+8VP0OeXiA3hy2IHHRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBmHFI7x6e+n4E2w4ra7oOyBlTzDRykqTblMQZXkyArLVy35rkV1YGQa7Xpuk2hS4
         oqUyb16XmzSmlOzXMffy3/w7ij458HhfzhYYl91+D9EPJ7djmswEXsLUdus0S56M3z
         nLmBEUo6OhEgbE7w7h7RF+DyfEPzy7JGSAYAdcA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.3 046/187] wifi: cfg80211: fix double lock bug in reg_wdev_chan_valid()
Date:   Mon, 19 Jun 2023 12:27:44 +0200
Message-ID: <20230619102159.834267615@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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
@@ -2404,11 +2404,8 @@ static bool reg_wdev_chan_valid(struct w
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


