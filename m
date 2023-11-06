Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D7A7E2426
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjKFNSt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjKFNSs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:18:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DEFF1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:18:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD886C433C7;
        Mon,  6 Nov 2023 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276726;
        bh=6Y2SBe5+MO2isqZnfvRlCFLhihD9grEYjYWOBF0O7cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHRIkEUyls5gJo9aLs+2lbIuxLNRon0FpCphVrNnkxq6ubK8Qeo2LB3jo0+ttv3GK
         UwlRvZUfwERrAZGzEeNwNDdWKpgpf52PBA/kOj5QnNq80cN+p8Vj0VraPZMjecksbz
         qVULcyBkGHzhNakjM2FgA1TfpEhRf1rJ2P1kUct4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Deepak R Varma <drv@mailo.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 48/88] LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()
Date:   Mon,  6 Nov 2023 14:03:42 +0100
Message-ID: <20231106130307.621590964@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 477a0ebec101359f49d92796e3b609857d564b52 ]

Replace kmap_atomic()/kunmap_atomic() calls with kmap_local_page()/
kunmap_local() in copy_user_highpage() which can be invoked from both
preemptible and atomic context [1].

[1] https://lore.kernel.org/all/20201029222652.302358281@linutronix.de/

Suggested-by: Deepak R Varma <drv@mailo.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 51c9a6c90a169..d967d881c3fef 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -68,11 +68,11 @@ void copy_user_highpage(struct page *to, struct page *from,
 {
 	void *vfrom, *vto;
 
-	vto = kmap_atomic(to);
-	vfrom = kmap_atomic(from);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
-	kunmap_atomic(vfrom);
-	kunmap_atomic(vto);
+	kunmap_local(vfrom);
+	kunmap_local(vto);
 	/* Make sure this page is cleared on other CPU's too before using it */
 	smp_wmb();
 }
-- 
2.42.0



