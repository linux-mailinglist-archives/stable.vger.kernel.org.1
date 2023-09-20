Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55787A7ACE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjITLqP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjITLqO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:46:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E49CF
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:46:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F7BC433C9;
        Wed, 20 Sep 2023 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210369;
        bh=ACCrwhR7fJUrTq04osvUuDPa79B5z0eqkC3GCe+MOEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hE0bOuhKv/eJDeLIgnEC755QefjjtQdPtzbpAX5QGXrMN8aX/+bWCGQ83c8e7NIgE
         m3ZYMLvfs+2E1qaoUDwUdEaq+BO2ZkjzQT9/2ExuhxhIBJk/JN2ry0OidJN1fhGjBs
         OZK6R9Z1CwJ8TPZM/Ljjze8oS/7FNnh8dtMbbhic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 051/211] wifi: mac80211: check S1G action frame size
Date:   Wed, 20 Sep 2023 13:28:15 +0200
Message-ID: <20230920112847.364551552@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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
index 0af2599c17e8d..e751cda5eef69 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3734,6 +3734,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
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



