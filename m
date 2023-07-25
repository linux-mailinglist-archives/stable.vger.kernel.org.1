Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DEB761237
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjGYLAT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGYK7x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739153C04
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1206D6165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21177C433C8;
        Tue, 25 Jul 2023 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282625;
        bh=99ArWk82MXHgryZ2pZbrD4DUKmoz2456CjFTnq0Mg7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZOr6cZRULP4D2JLykp0bKDflUAONqxlRzgZRGKCoLwVnAx8od4B6Q1Ss7tEPyMTX
         5ysYHRs5K/WzWOyM8bGaPVcgXravNC2oytR65TjUD35dHER40lkZkpH+PDlw3H18cP
         y1u/9fqZbeuIkNTKh7laI3PlYZJJJLKjVjw+w+vE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 157/227] iommu/sva: Fix signedness bug in iommu_sva_alloc_pasid()
Date:   Tue, 25 Jul 2023 12:45:24 +0200
Message-ID: <20230725104521.427550488@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit c20ecf7bb6153149b81a9277eda23398957656f2 ]

The ida_alloc_range() function returns negative error codes on error.
On success it returns values in the min to max range (inclusive).  It
never returns more then INT_MAX even if "max" is higher.  It never
returns values in the 0 to (min - 1) range.

The bug is that "min" is an unsigned int so negative error codes will
be promoted to high positive values errors treated as success.

Fixes: 1a14bf0fc7ed ("iommu/sva: Use GFP_KERNEL for pasid allocation")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/6b32095d-7491-4ebb-a850-12e96209eaaf@kili.mountain
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu-sva.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 3ebd4b6586b3e..05c0fb2acbc44 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -34,8 +34,9 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 	}
 
 	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
-	if (ret < min)
+	if (ret < 0)
 		goto out;
+
 	mm->pasid = ret;
 	ret = 0;
 out:
-- 
2.39.2



