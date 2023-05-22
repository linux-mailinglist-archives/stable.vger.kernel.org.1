Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1C70CA00
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbjEVTyA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjEVTyA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA899
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7BF662B5C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5343C433EF;
        Mon, 22 May 2023 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785238;
        bh=ZnF+tDHKp6d6f86Dw4rzg8Ww5VXtsdsCDdec6TNlMSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=weTHyN1GrIlBSV3A4jOGFZu+O6YETTm7byytrLTl3e3sQyrzUahQtr/yYNA3EnSaI
         ZAA+3csxcNy7WBCqAVTxNoSkfXlO1BLOPqUpm5II0y0DdJFsDzxXYSLmEfQRhZgQBw
         oGPvBqMG2/BArDE8QH/cP3tO437Gx5o7HpO83Sw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 6.3 356/364] arm64: mte: Do not set PG_mte_tagged if tags were not initialized
Date:   Mon, 22 May 2023 20:11:01 +0100
Message-Id: <20230522190421.674003898@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Collingbourne <pcc@google.com>

commit c4c597f1b367433c52c531dccd6859a39b4580fb upstream.

The mte_sync_page_tags() function sets PG_mte_tagged if it initializes
page tags. Then we return to mte_sync_tags(), which sets PG_mte_tagged
again. At best, this is redundant. However, it is possible for
mte_sync_page_tags() to return without having initialized tags for the
page, i.e. in the case where check_swap is true (non-compound page),
is_swap_pte(old_pte) is false and pte_is_tagged is false. So at worst,
we set PG_mte_tagged on a page with uninitialized tags. This can happen
if, for example, page migration causes a PTE for an untagged page to
be replaced. If the userspace program subsequently uses mprotect() to
enable PROT_MTE for that page, the uninitialized tags will be exposed
to userspace.

Fix it by removing the redundant call to set_page_mte_tagged().

Fixes: e059853d14ca ("arm64: mte: Fix/clarify the PG_mte_tagged semantics")
Signed-off-by: Peter Collingbourne <pcc@google.com>
Cc: <stable@vger.kernel.org> # 6.1
Link: https://linux-review.googlesource.com/id/Ib02d004d435b2ed87603b858ef7480f7b1463052
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
Link: https://lore.kernel.org/r/20230420214327.2357985-1-pcc@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/mte.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -66,13 +66,10 @@ void mte_sync_tags(pte_t old_pte, pte_t
 		return;
 
 	/* if PG_mte_tagged is set, tags have already been initialised */
-	for (i = 0; i < nr_pages; i++, page++) {
-		if (!page_mte_tagged(page)) {
+	for (i = 0; i < nr_pages; i++, page++)
+		if (!page_mte_tagged(page))
 			mte_sync_page_tags(page, old_pte, check_swap,
 					   pte_is_tagged);
-			set_page_mte_tagged(page);
-		}
-	}
 
 	/* ensure the tags are visible before the PTE is set */
 	smp_wmb();


