Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9F726FE2
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbjFGVDE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbjFGVCu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0E2703
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 483F161704
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF24C433EF;
        Wed,  7 Jun 2023 21:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171725;
        bh=7L8cY1/FfTpIww6poA0DK9pAvBkFIbJCwCOQD29Wgns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNVIBCSHsXHbD/VNB5BBaU22b+maLiCivJ5zregDDNslWXBPTaFNotWW1+B067vdu
         WSYvTQIK397PknK0sgzy4O8zWNs5U7OYqj9w7kxjm8COfMZCFe8MdZZ+iOWGNazDtJ
         mvBQdN+zj52f+COE/BTUPF+E5rIZ7NhdfIeh1RhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaurav Batra <gbatra@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.15 126/159] powerpc/iommu: Limit number of TCEs to 512 for H_STUFF_TCE hcall
Date:   Wed,  7 Jun 2023 22:17:09 +0200
Message-ID: <20230607200907.802502332@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
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

From: Gaurav Batra <gbatra@linux.vnet.ibm.com>

commit 9d2ccf00bddc268045e3d65a8108d61ada0e4b4e upstream.

Currently in tce_freemulti_pSeriesLP() there is no limit on how many
TCEs are passed to the H_STUFF_TCE hcall. This has not caused an issue
until now, but newer firmware releases have started enforcing a limit of
512 TCEs per call.

The limit is correct per the specification (PAPR v2.12 § 14.5.4.2.3).

The code has been in it's current form since it was initially merged.

Cc: stable@vger.kernel.org
Signed-off-by: Gaurav Batra <gbatra@linux.vnet.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
[mpe: Tweak change log wording & add PAPR reference]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230525143454.56878-1-gbatra@linux.vnet.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/iommu.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -311,13 +311,22 @@ static void tce_free_pSeriesLP(unsigned
 static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
 {
 	u64 rc;
+	long rpages = npages;
+	unsigned long limit;
 
 	if (!firmware_has_feature(FW_FEATURE_STUFF_TCE))
 		return tce_free_pSeriesLP(tbl->it_index, tcenum,
 					  tbl->it_page_shift, npages);
 
-	rc = plpar_tce_stuff((u64)tbl->it_index,
-			     (u64)tcenum << tbl->it_page_shift, 0, npages);
+	do {
+		limit = min_t(unsigned long, rpages, 512);
+
+		rc = plpar_tce_stuff((u64)tbl->it_index,
+				     (u64)tcenum << tbl->it_page_shift, 0, limit);
+
+		rpages -= limit;
+		tcenum += limit;
+	} while (rpages > 0 && !rc);
 
 	if (rc && printk_ratelimit()) {
 		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");


