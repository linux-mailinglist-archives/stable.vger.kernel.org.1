Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84A7BDDBB
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376698AbjJINM4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376968AbjJINMq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9986D53
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E54C433C8;
        Mon,  9 Oct 2023 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857095;
        bh=qVgVK9to3MbkVHD6z32ethxBBgNESBYLxehQQWPlCtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6D8CnKFNeedviiuu7vmoFEWCgTYiyFbbJXH+/jRx4EwtdBx+2X2EFtP4hu4wr/Z5
         FzbJ0qRklUdX7skc7OV7nKxEajfHW9F4cevzwKt9ykbt/1IGU6mHziCMXjHVAqS+SX
         ZZWznJdKuWVu5An8IlWoyU2y5BlNVO80ywCyL1GE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 068/163] wifi: cfg80211: add missing kernel-doc for cqm_rssi_work
Date:   Mon,  9 Oct 2023 15:00:32 +0200
Message-ID: <20231009130125.925481241@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d1383077c225ceb87ac7a3b56b2c505193f77ed7 ]

As reported by Stephen, I neglected to add the kernel-doc
for the new struct member. Fix that.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 37c20b2effe9 ("wifi: cfg80211: fix cqm_config access race")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0debc3c9364e8..641c6edc9b81d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5942,6 +5942,7 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
  * @event_lock: (private) lock for event list
  * @owner_nlportid: (private) owner socket port ID
  * @nl_owner_dead: (private) owner socket went away
+ * @cqm_rssi_work: (private) CQM RSSI reporting work
  * @cqm_config: (private) nl80211 RSSI monitor state
  * @pmsr_list: (private) peer measurement requests
  * @pmsr_lock: (private) peer measurements requests/results lock
-- 
2.40.1



