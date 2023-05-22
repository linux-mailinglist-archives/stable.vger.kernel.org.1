Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3905770C838
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjEVTg2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjEVTg1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0251B4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D308962942
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E11C433D2;
        Mon, 22 May 2023 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784168;
        bh=p2GvdELpo5zpk3FhuKwcRZZDNbx594w8qGk9VuZlfbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=do/OwA1Dy7iZd3WvFiZKiyxBmg3SKaNYiki7B4f9Yj8ANRos7BIcEHpiKB/ImBDgc
         d06xkSC75ar6Sl4sCJEgFG6lEoYcsKYkitj4LK7NJtf6YQYi++TkFqHzTqIu2D7+FI
         ykKbXXcftk6hbMo1ZADF/FhAbRa2VGiE4mu2sJTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 285/292] arm64: mte: Do not set PG_mte_tagged if tags were not initialized
Date:   Mon, 22 May 2023 20:10:42 +0100
Message-Id: <20230522190413.068676734@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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
@@ -72,13 +72,10 @@ void mte_sync_tags(pte_t old_pte, pte_t
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


