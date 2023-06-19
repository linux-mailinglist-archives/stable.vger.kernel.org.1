Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9A73536C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjFSKpf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFSKpA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52647E7E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E449A60B86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A70C433C0;
        Mon, 19 Jun 2023 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171473;
        bh=YvqZyImX3oc9dexuIHkfqLrQGupJS59FbO2PUZpbKPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2e2B9yNjptxbFC2eQudWoxTQJeEnMneuYHX93CP0uDnWlOkaorAELkSWzvGaUCXn
         /nfAGy6Yp5XgSumfWphPjQwZfMlrcF6RgbeAhFESGDXa/RdjqRmu2Rj0BbEFQ5AaC6
         TSRvLvWuzXtuvJ+UkUJAwz1lZDfzwtwPXfA5JSHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 043/166] wifi: cfg80211: fix locking in regulatory disconnect
Date:   Mon, 19 Jun 2023 12:28:40 +0200
Message-ID: <20230619102156.796387410@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

commit f7e60032c6618dfd643c7210d5cba2789e2de2e2 upstream.

This should use wiphy_lock() now instead of requiring the
RTNL, since __cfg80211_leave() via cfg80211_leave() is now
requiring that lock to be held.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/reg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2478,11 +2478,11 @@ static void reg_leave_invalid_chans(stru
 	struct wireless_dev *wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	ASSERT_RTNL();
-
+	wiphy_lock(wiphy);
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		if (!reg_wdev_chan_valid(wiphy, wdev))
 			cfg80211_leave(rdev, wdev);
+	wiphy_unlock(wiphy);
 }
 
 static void reg_check_chans_work(struct work_struct *work)


