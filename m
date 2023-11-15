Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25557ECFC7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjKOTur (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjKOTuq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FAD1AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180F0C433C9;
        Wed, 15 Nov 2023 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077841;
        bh=ZLsTt+n5T2e3KCJQKwuwT8waAmW4jtM9lhWTJOLR2Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yF7S+/g/lUq3Psv3Ou6g14Oqn/IGjK3YGVbW10kMiGaRa4AeVF+c14e8GdGPKAI8a
         O5ALKZla8jFTMHoPiKM85i8lPdmP+XMkPjQfVwn5YNVMvHi3JNjA5MhWKRzinVlDAC
         ZS7s/XBf7QNSzCd1OipZqiw31NWfIXOQUqf6LkbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Chris Mi <chrism@mellanox.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        NeilBrown <neilb@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 553/603] Fix termination state for idr_for_each_entry_ul()
Date:   Wed, 15 Nov 2023 14:18:18 -0500
Message-ID: <20231115191649.969715105@linuxfoundation.org>
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

From: NeilBrown <neilb@suse.de>

[ Upstream commit e8ae8ad479e2d037daa33756e5e72850a7bd37a9 ]

The comment for idr_for_each_entry_ul() states

  after normal termination @entry is left with the value NULL

This is not correct in the case where UINT_MAX has an entry in the idr.
In that case @entry will be non-NULL after termination.
No current code depends on the documentation being correct, but to
save future code we should fix it.

Also fix idr_for_each_entry_continue_ul().  While this is not documented
as leaving @entry as NULL, the mellanox driver appears to depend on
it doing so.  So make that explicit in the documentation as well as in
the code.

Fixes: e33d2b74d805 ("idr: fix overflow case for idr_for_each_entry_ul()")
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mi <chrism@mellanox.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/idr.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9e..da5f5fa4a3a6a 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -200,7 +200,7 @@ static inline void idr_preload_end(void)
  */
 #define idr_for_each_entry_ul(idr, entry, tmp, id)			\
 	for (tmp = 0, id = 0;						\
-	     tmp <= id && ((entry) = idr_get_next_ul(idr, &(id))) != NULL; \
+	     ((entry) = tmp <= id ? idr_get_next_ul(idr, &(id)) : NULL) != NULL; \
 	     tmp = id, ++id)
 
 /**
@@ -224,10 +224,12 @@ static inline void idr_preload_end(void)
  * @id: Entry ID.
  *
  * Continue to iterate over entries, continuing after the current position.
+ * After normal termination @entry is left with the value NULL.  This
+ * is convenient for a "not found" value.
  */
 #define idr_for_each_entry_continue_ul(idr, entry, tmp, id)		\
 	for (tmp = id;							\
-	     tmp <= id && ((entry) = idr_get_next_ul(idr, &(id))) != NULL; \
+	     ((entry) = tmp <= id ? idr_get_next_ul(idr, &(id)) : NULL) != NULL; \
 	     tmp = id, ++id)
 
 /*
-- 
2.42.0



