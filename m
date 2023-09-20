Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160957A7AD1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjITLqX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjITLqW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:46:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E8BB0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:46:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D123EC433C7;
        Wed, 20 Sep 2023 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210377;
        bh=EGbP65E2JJKL6leTj1OFrY7jOeKMnfVk/IJEj/U69i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JuaR9t7JWTmerxqkW2QQYSOeZCe52w8I9w8rP3B8MJB8V6d6IqrINTzYUlBKppJY
         abj2ZymOhcSY2TcXHpua61YkmMevXG++WsCtsnFFVZijqIweWp1ZjeMp2wwHME+EFy
         aXc9orkHSSwZaoqHuF7d86ERbAhXwApTW0p0hbGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 054/211] wifi: cfg80211: ocb: dont leave if not joined
Date:   Wed, 20 Sep 2023 13:28:18 +0200
Message-ID: <20230920112847.454098798@linuxfoundation.org>
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

[ Upstream commit abc76cf552e13cfa88a204b362a86b0e08e95228 ]

If there's no OCB state, don't ask the driver/mac80211 to
leave, since that's just confusing. Since set/clear the
chandef state, that's a simple check.

Reported-by: syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/ocb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/ocb.c b/net/wireless/ocb.c
index 27a1732264f95..29afaf3da54f3 100644
--- a/net/wireless/ocb.c
+++ b/net/wireless/ocb.c
@@ -68,6 +68,9 @@ int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->leave_ocb)
 		return -EOPNOTSUPP;
 
+	if (!wdev->u.ocb.chandef.chan)
+		return -ENOTCONN;
+
 	err = rdev_leave_ocb(rdev, dev);
 	if (!err)
 		memset(&wdev->u.ocb.chandef, 0, sizeof(wdev->u.ocb.chandef));
-- 
2.40.1



