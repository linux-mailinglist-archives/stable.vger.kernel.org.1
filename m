Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2778AD56
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjH1Kr0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjH1KrA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3D136
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A4763FEC
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41573C433C7;
        Mon, 28 Aug 2023 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219603;
        bh=Ow4Bqa27v16KlON6UnQqYn5gLJMa80lNX3jB6ka1TfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDQkTc+20WY2KgBqexXeLh9xFgOeAFp3RlK4n6Qair/QZOALpLSSIUEq0YovQrBga
         uw523rVSqi4ZgHZGhvDf+/nljQNjg5uPdhnFtJxIJ4Kv1D8pU1Rn5zbC7wGS4J9UZG
         9/qRCxnVTd8XDg9to9VY7JrAeX7LBL+KJTWBVayY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 87/89] mm: memory-failure: kill soft_offline_free_page()
Date:   Mon, 28 Aug 2023 12:14:28 +0200
Message-ID: <20230828101153.180319605@linuxfoundation.org>
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

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 7adb45887c8af88985c335b53d253654e9d2dd16 ]

Open-code the page_handle_poison() into soft_offline_page() and kill
unneeded soft_offline_free_page().

Link: https://lkml.kernel.org/r/20220819033402.156519-1-wangkefeng.wang@huawei.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: e2c1ab070fdc ("mm: memory-failure: fix unexpected return value in soft_offline_page()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-failure.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9f9dd968fbe3c..69d22af10adfc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2219,16 +2219,6 @@ static int soft_offline_in_use_page(struct page *page)
 	return __soft_offline_page(page);
 }
 
-static int soft_offline_free_page(struct page *page)
-{
-	int rc = 0;
-
-	if (!page_handle_poison(page, true, false))
-		rc = -EBUSY;
-
-	return rc;
-}
-
 static void put_ref_page(struct page *page)
 {
 	if (page)
@@ -2294,7 +2284,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (ret > 0) {
 		ret = soft_offline_in_use_page(page);
 	} else if (ret == 0) {
-		if (soft_offline_free_page(page) && try_again) {
+		if (!page_handle_poison(page, true, false) && try_again) {
 			try_again = false;
 			flags &= ~MF_COUNT_INCREASED;
 			goto retry;
-- 
2.40.1



