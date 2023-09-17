Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5DF7A3D1F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbjIQUjC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241333AbjIQUiy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:38:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39062195
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:38:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A78AC433CA;
        Sun, 17 Sep 2023 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983122;
        bh=H+qykmsIdwf7MzEaj3tEiSH2jJEDMcSvWkQeAB7Ei98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zalFDr5+z0OaPyzfHGrj/SXkP+ZMUh6mHLJj2GVaj+ohqnVD7gVrZnp28tnVOZpSk
         o4DVELQU1vGoFsQXj6FcUQWsqegZJPmn4ULp0wo2YNWcNffXyZFqOA22XA3kXdKkf+
         Q4BrmBWDBrwoY8Jd/JB7xR2cCou3uwkWD+WmLh/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ariel Marcovitch <arielmarcovitch@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 450/511] idr: fix param name in idr_alloc_cyclic() doc
Date:   Sun, 17 Sep 2023 21:14:37 +0200
Message-ID: <20230917191124.620916095@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ariel Marcovitch <arielmarcovitch@gmail.com>

[ Upstream commit 2a15de80dd0f7e04a823291aa9eb49c5294f56af ]

The relevant parameter is 'start' and not 'nextid'

Fixes: 460488c58ca8 ("idr: Remove idr_alloc_ext")
Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/idr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index 7ecdfdb5309e7..13f2758c23773 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(idr_alloc);
  * @end: The maximum ID (exclusive).
  * @gfp: Memory allocation flags.
  *
- * Allocates an unused ID in the range specified by @nextid and @end.  If
+ * Allocates an unused ID in the range specified by @start and @end.  If
  * @end is <= 0, it is treated as one larger than %INT_MAX.  This allows
  * callers to use @start + N as @end as long as N is within integer range.
  * The search for an unused ID will start at the last ID allocated and will
-- 
2.40.1



