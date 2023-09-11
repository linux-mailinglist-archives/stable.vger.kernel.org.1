Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E23279BE36
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbjIKV6a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240390AbjIKOnF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:43:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDBACF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ACBC433C7;
        Mon, 11 Sep 2023 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443381;
        bh=llvRtMn+ER/VDPIqyY/WvV1RcZsYnDbU3x6uEeGmzXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqlsonIYx4c5wHI/KDrc21HObsTtr0lcLXwzAGK0OBN+HTsyPTo/DtUnYdn7DWUP6
         xMAgC4IICo2LHOUXhnXkgdo2T5j/QV7eLwK8tpQDoNF41KakimC568Ow4264w7tqcy
         EN2gTkAro1JYyAdOcxok488d5BLWM9K0YP+BrX0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen Jiahao <chenjiahao16@huawei.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 357/737] soc: qcom: smem: Fix incompatible types in comparison
Date:   Mon, 11 Sep 2023 15:43:36 +0200
Message-ID: <20230911134700.493568041@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Jiahao <chenjiahao16@huawei.com>

[ Upstream commit 5f908786cf44fcb397cfe0f322ef2f41b0909e2a ]

This patch fixes the following sparse error:

drivers/soc/qcom/smem.c:738:30: error: incompatible types in comparison expression (different add        ress spaces):
drivers/soc/qcom/smem.c:738:30:    void *
drivers/soc/qcom/smem.c:738:30:    void [noderef] __iomem *

In addr_in_range(), "base" is of type void __iomem *, converting
void *addr to the same type to fix above sparse error.

Fixes: 20bb6c9de1b7 ("soc: qcom: smem: map only partitions used by local HOST")
Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
Link: https://lore.kernel.org/r/20230801094807.4146779-1-chenjiahao16@huawei.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6be7ea93c78cf..1e08bb3b1679a 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -723,7 +723,7 @@ EXPORT_SYMBOL(qcom_smem_get_free_space);
 
 static bool addr_in_range(void __iomem *base, size_t size, void *addr)
 {
-	return base && (addr >= base && addr < base + size);
+	return base && ((void __iomem *)addr >= base && (void __iomem *)addr < base + size);
 }
 
 /**
-- 
2.40.1



