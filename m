Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA479B2CA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbjIKVIN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbjIKOFm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:05:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E7FCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:05:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2029C433C7;
        Mon, 11 Sep 2023 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441138;
        bh=VvUOTrbQQPycn5pjl9ipF8pwAnqHRWW8D87Y27N6a1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpbPzbOaKcMNsK5x8tY9JHF86oy4flPXe0YoMAgwyXFK3N/AR8rBC7tD95SH2h6Fo
         7px9wxXhQkFin4YM2Kn3UmxP/KZwGFfKKx+gSjmvD/Kn/7PZAVBglq0rE2kfYd9hHk
         mUfitTf3SHWH9221T3DSvYTLSqSArdX8n6rQXdlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen Jiahao <chenjiahao16@huawei.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 308/739] soc: qcom: smem: Fix incompatible types in comparison
Date:   Mon, 11 Sep 2023 15:41:47 +0200
Message-ID: <20230911134659.722436957@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index b0d59e815c3b7..a516b8b5efac9 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -724,7 +724,7 @@ EXPORT_SYMBOL_GPL(qcom_smem_get_free_space);
 
 static bool addr_in_range(void __iomem *base, size_t size, void *addr)
 {
-	return base && (addr >= base && addr < base + size);
+	return base && ((void __iomem *)addr >= base && (void __iomem *)addr < base + size);
 }
 
 /**
-- 
2.40.1



