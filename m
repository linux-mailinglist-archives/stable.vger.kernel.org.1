Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456067D3147
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjJWLHc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJWLHa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:07:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFE310E2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AABAC433C7;
        Mon, 23 Oct 2023 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059247;
        bh=ESw/XkAAX5wyRKq2cv2DvrqRN7RdDW20Tx/nbAEuU+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOwER6lmlneB7XWGOaJxKihBlLkOKxn844+t4wcbglpjQEKiw2EDS+v7JG2GlQm9d
         AXMbnXR9FnWQozO8WgA+armtAb4v39PpfPIhoJldFJdSqoBsqm+0mcOV53aRtJdgLe
         8P/nfcP/JS3ISlMUxbww55znsCeDlqpSd+c01jbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 113/241] wifi: cfg80211: validate AP phy operation before starting it
Date:   Mon, 23 Oct 2023 12:54:59 +0200
Message-ID: <20231023104836.643884757@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

[ Upstream commit 5112fa502708aaaf80acb78273fc8625f221eb11 ]

Many regulatories can have HE/EHT Operation as not permitted. In such
cases, AP should not be allowed to start if it is using a channel
having the no operation flag set. However, currently there is no such
check in place.

Fix this issue by validating such IEs sent during start AP against the
channel flags.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://lore.kernel.org/r/20230905064857.1503-1-quic_adisi@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 705d1cf048309..3d286f3a60e60 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5910,6 +5910,21 @@ static void nl80211_send_ap_started(struct wireless_dev *wdev,
 	nlmsg_free(msg);
 }
 
+static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params)
+{
+	struct ieee80211_channel *channel = params->chandef.chan;
+
+	if ((params->he_cap ||  params->he_oper) &&
+	    (channel->flags & IEEE80211_CHAN_NO_HE))
+		return -EOPNOTSUPP;
+
+	if ((params->eht_cap || params->eht_oper) &&
+	    (channel->flags & IEEE80211_CHAN_NO_EHT))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -6179,6 +6194,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out_unlock;
 
+	err = nl80211_validate_ap_phy_operation(params);
+	if (err)
+		goto out_unlock;
+
 	if (info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS])
 		params->flags = nla_get_u32(
 			info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS]);
-- 
2.40.1



