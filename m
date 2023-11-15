Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7865F7ECB44
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjKOTVa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjKOTVQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA631990
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3D2C433C8;
        Wed, 15 Nov 2023 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076066;
        bh=0I/OQce0ai5oYfvKW20ZUkVruaSBLFFbUcbFQba/tpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nANRHOoQH2UGSiWWOB9tX/VJuDV4RtpQjwq3fjEuD7+MHaLmbO7hdyNXoZ6BMfOZ5
         DSAQ4kxx8Gvyz5u4pKYLuyeh0PqvDemA0QlKvEyUfH9Z5W8xsg3KdWXuHxCCHr8XUP
         3WOqT4s0EZYxgx1Agc0084b/hqXKsLabxQONt9SU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 054/550] wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()
Date:   Wed, 15 Nov 2023 14:10:38 -0500
Message-ID: <20231115191604.432179147@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8c73d5248dcf112611654bcd32352dc330b02397 ]

Clearly, there's no space in the function name, not sure how
that could've happened. Put the underscore that it should be.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 56cfb8ce1f7f ("wifi: cfg80211: add flush functions for wiphy work")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0f0bf26adb15d..d58d6d37a4479 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5881,7 +5881,7 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 			       struct wiphy_delayed_work *dwork);
 
 /**
- * wiphy_delayed work_flush - flush previously queued delayed work
+ * wiphy_delayed_work_flush - flush previously queued delayed work
  * @wiphy: the wiphy, for debug purposes
  * @work: the work to flush
  *
-- 
2.42.0



