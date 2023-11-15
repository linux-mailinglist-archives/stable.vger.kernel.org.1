Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2F7ECDB1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjKOThu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjKOTht (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6971A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3F9C433C8;
        Wed, 15 Nov 2023 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077065;
        bh=b4z2N3MXhsapvaByRlIWGDnmiU4ihedCTFvGFfErWDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhpQMrUFhYMdBpYKtUbH+YfD2CHE4/pKNuzi7tW2IoVEtmI3vhypnvK8YEiNXIrZI
         5XHRKtLVn68Uf6j0Q52HmmYYo1LnWFwCz2jzv9IfbH4NQ4jzaDsuB6gLn2LDEDpBnJ
         gdOMpAQhSp9M8jhEGBX32bwwRNKFqhb0q+SVOnqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Chris Mi <chrism@mellanox.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        NeilBrown <neilb@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 510/550] Fix termination state for idr_for_each_entry_ul()
Date:   Wed, 15 Nov 2023 14:18:14 -0500
Message-ID: <20231115191636.276791127@linuxfoundation.org>
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



