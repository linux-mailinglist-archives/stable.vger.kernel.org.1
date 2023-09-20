Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7937A8153
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbjITMo1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjITMoY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:44:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBBC6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:44:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD11C433C7;
        Wed, 20 Sep 2023 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213858;
        bh=xB3k2jhMBQfgPw5fibatOdXWuYvCV/pbz75QjEnTQUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atD170RuDdOD5G2kVLYCKqtgSxJQC6ozeqma3ynYitoY+bjtrH2z61x36rHVt+Cgk
         hNCMWZ1l4UlsNK8mk90pUn5gWflvRSnfKORpDdsau980X5tQs3g437nIEXUqssydA5
         0c5aivC5MC0i95weKL/beJx6lExHbYDGsv7IOvv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 023/110] wifi: mac80211: check S1G action frame size
Date:   Wed, 20 Sep 2023 13:31:21 +0200
Message-ID: <20230920112831.261841819@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 19e4a47ee74718a22e963e8a647c8c3bfe8bb05c ]

Before checking the action code, check that it even
exists in the frame.

Reported-by: syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 175ead6b19cb4..26943c93f14c4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3557,6 +3557,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		goto queue;
 	case WLAN_CATEGORY_S1G:
+		if (len < offsetofend(typeof(*mgmt),
+				      u.action.u.s1g.action_code))
+			break;
+
 		switch (mgmt->u.action.u.s1g.action_code) {
 		case WLAN_S1G_TWT_SETUP:
 		case WLAN_S1G_TWT_TEARDOWN:
-- 
2.40.1



