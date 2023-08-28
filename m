Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F131E78AD57
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjH1Kr0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjH1KrH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A219B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D595E642B0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AF3C433C8;
        Mon, 28 Aug 2023 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219606;
        bh=GGy72m5RuqyQjFBIfb+AsjUCn8kN/SQq/qh5bteSykc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKiPK/a54dJNoYyvaVFs53prXVgcaoX1c3folC8oR2zUzb+iVfecr6DHjDSUCi2vo
         OCeC1CAHSsFDHGsBYbpmySQIWto5WbQ+ZXn2rGZI8CTwvILTEg+Jof275ROLtFjAbc
         G1VeG06Ex1UPjJsAb/hh857iUAZPLm6d9ZXGv5QM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 88/89] mm: memory-failure: fix unexpected return value in soft_offline_page()
Date:   Mon, 28 Aug 2023 12:14:29 +0200
Message-ID: <20230828101153.216728715@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit e2c1ab070fdc81010ec44634838d24fce9ff9e53 ]

When page_handle_poison() fails to handle the hugepage or free page in
retry path, soft_offline_page() will return 0 while -EBUSY is expected in
this case.

Consequently the user will think soft_offline_page succeeds while it in
fact failed.  So the user will not try again later in this case.

Link: https://lkml.kernel.org/r/20230627112808.1275241-1-linmiaohe@huawei.com
Fixes: b94e02822deb ("mm,hwpoison: try to narrow window race for free pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-failure.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 69d22af10adfc..bcd71d8736be5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2284,10 +2284,13 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (ret > 0) {
 		ret = soft_offline_in_use_page(page);
 	} else if (ret == 0) {
-		if (!page_handle_poison(page, true, false) && try_again) {
-			try_again = false;
-			flags &= ~MF_COUNT_INCREASED;
-			goto retry;
+		if (!page_handle_poison(page, true, false)) {
+			if (try_again) {
+				try_again = false;
+				flags &= ~MF_COUNT_INCREASED;
+				goto retry;
+			}
+			ret = -EBUSY;
 		}
 	}
 
-- 
2.40.1



