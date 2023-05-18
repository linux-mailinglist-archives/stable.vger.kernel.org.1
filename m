Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965337077AD
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 03:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjERBwT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 21:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjERBwS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 21:52:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372C30FD
        for <stable@vger.kernel.org>; Wed, 17 May 2023 18:51:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a9614c154so23198417b3.2
        for <stable@vger.kernel.org>; Wed, 17 May 2023 18:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684374708; x=1686966708;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zXh/O/V/WptHcvZP+JCdTYTDP4LQ9st6a4OKh85bxLg=;
        b=IfmQuyHqbPtqNnhVieMu9NzCq4te8XLyLb/DhJuRmnprCTKiLUdOcW6g3y2jB1dgkw
         YFNcIF+OSbv5phj/j2mXjZK1mFlyvAe2aq1crDGN0RreDGx/deLCWh8WLU8nvJ4Gpn0x
         ochjMURbmABoRK5v6ctPRm/1GCnTeHPXmZ6bpCP4+Il3DO8AmNxg0xbQHm0/ZovoBPe+
         pA6kO/hvzAML1E0cPRlo4hwhaSAM0ELQy2CxzL/77SQq/Dko6cvu5yudJ7m4L03nAFUQ
         dXAFgjMf4adYvGjw99XcYjUepdrxgpym8kGLufrd3hhSNPGeUvt8xanCRGPdyEEyPAFX
         lNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684374708; x=1686966708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXh/O/V/WptHcvZP+JCdTYTDP4LQ9st6a4OKh85bxLg=;
        b=PesG5Ho/rd/iGIm8VWyfAMFW0Q6maK9qGSEAsHOje1EDozSIpFHKli17OSbR2THBTw
         c9CDVpqO0shk70dIWA73bV/2/+voP/Ulhet+X1A/I5sut9aNXkgXxhaSZfjAiVM8bGnE
         dPvwyKgWshJT/0M1Vn3ZuNAzCtEyFY30p5Ac0MX8uCz+6y1bFwoz3qaqHC4EoEYQ1PqD
         R1dZvDSCwesiqPRpuQzXdTnD/btym2KtDdTIwz9HwyllIzBtu4TmGmWze2ZIXpc6KMLM
         e0INQfvAWF12W8eHO+w4XusIbzsOHo7LEQBEGYajWO5cH+8YrpwGoQ2G6aovovsCJ0tX
         S7iA==
X-Gm-Message-State: AC+VfDzP7BI7bXKQ3M0UGD3DN2KDrwt9/sJCEqqDMKILiF80pZ44/LO1
        0vIYkWF1lslLkze+/hxt4Sz0i7GY5Hk=
X-Google-Smtp-Source: ACHHUZ5YR3a7R9JsHjBo5Xw0oxDMRKd1Rw9K1kdyGq6xvpeMZdMrKgm1WLSCiFPT5VQPXfLP5Z5nDA2kPAA=
X-Received: from pandoh.svl.corp.google.com ([2620:15c:2c5:11:2f7e:7405:7496:cdec])
 (user=pandoh job=sendgmr) by 2002:a0d:ec09:0:b0:54c:2409:c306 with SMTP id
 q9-20020a0dec09000000b0054c2409c306mr93492ywn.6.1684374708680; Wed, 17 May
 2023 18:51:48 -0700 (PDT)
Date:   Wed, 17 May 2023 18:50:54 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230518015054.2223833-1-pandoh@google.com>
Subject: [PATCH RESEND] iommu/amd: Fix domain flush size when syncing iotlb
From:   Jon Pan-Doh <pandoh@google.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jon Pan-Doh <pandoh@google.com>, stable@vger.kernel.org,
        Gary Zibrat <gzibrat@google.com>,
        Sudheer Dantuluri <dantuluris@google.com>,
        Nadav Amit <namit@vmware.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When running on an AMD vIOMMU, we observed multiple invalidations (of
decreasing power of 2 aligned sizes) when unmapping a single page.

Domain flush takes gather bounds (end-start) as size param. However,
gather->end is defined as the last inclusive address (start + size - 1).
This leads to an off by 1 error.

With this patch, verified that 1 invalidation occurs when unmapping a
single page.

Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Cc: <stable@vger.kernel.org> # 5.15.x
Suggested-by: Gary Zibrat <gzibrat@google.com>
Tested-by: Sudheer Dantuluri <dantuluris@google.com>
Acked-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..da45b1ab042d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.40.0.634.g4ca3ef3211-goog

