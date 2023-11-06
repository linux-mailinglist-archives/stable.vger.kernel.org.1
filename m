Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25E7E23A7
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjKFNNa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjKFNN2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:13:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E97134
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:13:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14764C433C8;
        Mon,  6 Nov 2023 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276403;
        bh=Lz1TphCFq0ne5e1SCSw2NzMyI0OrlK7zYhd+Ubv5tM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loiiAfF15qG7qM2w0iZ4L2WisMDNzSnxHiSi0ekcveB6rcU20QdSQRr4XWCLK9M6u
         p6Y2n4l4nWU3ntprdUWwySWCVm+btXOdXqyxWwj7FkYC17g3ICkLYjvFNZXysPdCVj
         Sffm1VMaO/Axjts+9Zwvuq2lCKJyspCT5qdVDzos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Deepak R Varma <drv@mailo.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 30/62] LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()
Date:   Mon,  6 Nov 2023 14:03:36 +0100
Message-ID: <20231106130302.911110696@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index c74da7770e39e..f42a3be5f28d7 100644
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



