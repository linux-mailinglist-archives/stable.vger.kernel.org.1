Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC127ECD46
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjKOTfb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjKOTf3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DAEA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F32C433C8;
        Wed, 15 Nov 2023 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076926;
        bh=reKCB7yyYl5v8qFgobGXdXvTGPBXo7s7O+080RAx0Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHgX4FwkFlltM4ofvgVNqmDnPg8oGCXIVXIf6NbC65+22vHzrN16Dd9PT5oA8MH2I
         oQeprQ5vlp+zuavXo0hnLJIbEAnpxlDMTsm0Wde2WQCqVzw4IfJhM5rO14ERHS3v18
         o7ajzqpjbeYWYID7VivpfBk2Y/LXM3o67cJo/DKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 051/603] wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()
Date:   Wed, 15 Nov 2023 14:09:56 -0500
Message-ID: <20231115191616.678191179@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 308a004c1d1dc..153a8c3e7213d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5880,7 +5880,7 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 			       struct wiphy_delayed_work *dwork);
 
 /**
- * wiphy_delayed work_flush - flush previously queued delayed work
+ * wiphy_delayed_work_flush - flush previously queued delayed work
  * @wiphy: the wiphy, for debug purposes
  * @work: the work to flush
  *
-- 
2.42.0



