Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D387035D0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243515AbjEORDB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243448AbjEORCf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627B9023
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5D762A72
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0961EC433D2;
        Mon, 15 May 2023 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170039;
        bh=wPaE1+O9Ly+mIkF9fGSsPQBXm+jU8VENihJ33NT6UR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9XcgCTeZY1FYt42+8+vZpSVBy3wIc/uPx5E/R1AZN+SMdNmRrFTDkLpIZycybuhk
         xCt4q6Aelgr7TVSDQeQGvYbk2nIoFpeZD8AUltgGCuVtqEhgWXXKwLYug+As/S5wt/
         Z5Mhe72NP95kaA2f2CyimOTRYbBuPW/D6wGozCo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.3 244/246] s390/mm: rename POPULATE_ONE2ONE to POPULATE_DIRECT
Date:   Mon, 15 May 2023 18:27:36 +0200
Message-Id: <20230515161729.989332092@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 07fdd6627f7f9c72ed68d531653b56df81da9996 ]

Architectures generally use the "direct map" wording for mapping the whole
physical memory. Use that wording as well in arch/s390/boot/vmem.c, instead
of "one to one" in order to avoid confusion.

This also matches what is already done in arch/s390/mm/vmem.c.

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/boot/vmem.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -29,7 +29,7 @@ unsigned long __bootdata(pgalloc_low);
 
 enum populate_mode {
 	POPULATE_NONE,
-	POPULATE_ONE2ONE,
+	POPULATE_DIRECT,
 	POPULATE_ABS_LOWCORE,
 };
 
@@ -102,7 +102,7 @@ static unsigned long _pa(unsigned long a
 	switch (mode) {
 	case POPULATE_NONE:
 		return -1;
-	case POPULATE_ONE2ONE:
+	case POPULATE_DIRECT:
 		return addr;
 	case POPULATE_ABS_LOWCORE:
 		return __abs_lowcore_pa(addr);
@@ -251,9 +251,9 @@ void setup_vmem(unsigned long asce_limit
 	 * the lowcore and create the identity mapping only afterwards.
 	 */
 	pgtable_populate_init();
-	pgtable_populate(0, sizeof(struct lowcore), POPULATE_ONE2ONE);
+	pgtable_populate(0, sizeof(struct lowcore), POPULATE_DIRECT);
 	for_each_mem_detect_usable_block(i, &start, &end)
-		pgtable_populate(start, end, POPULATE_ONE2ONE);
+		pgtable_populate(start, end, POPULATE_DIRECT);
 	pgtable_populate(__abs_lowcore, __abs_lowcore + sizeof(struct lowcore),
 			 POPULATE_ABS_LOWCORE);
 	pgtable_populate(__memcpy_real_area, __memcpy_real_area + PAGE_SIZE,


