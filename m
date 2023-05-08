Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4626FA989
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjEHKwj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjEHKwK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12AA2A9D9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7365762952
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5730EC433D2;
        Mon,  8 May 2023 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543074;
        bh=eW60ZPeDAo2K/gdp1icDzLlbYiLJ1t0cpuJ8cKZtxXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7OXZfGGj/W0OFJaqczEYRlNoYF2xPxSdrU0GNOXr5V+zIzsyzIng54QocpmlBZE4
         /RpSwsTTmfhr6TBchUB1BYc/bXuinpdKvRPWFneSevv5ung1hZzF6DOOO/oWgGRrrh
         pjnK7J1znls9uCjlrlA8XAVqyN5G2yKPbJQXgnI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.2 642/663] ia64: fix an addr to taddr in huge_pte_offset()
Date:   Mon,  8 May 2023 11:47:48 +0200
Message-Id: <20230508094450.834845521@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Hugh Dickins <hughd@google.com>

commit 3647ebcfbfca384840231fe13fae665453238a61 upstream.

I know nothing of ia64 htlbpage_to_page(), but guess that the p4d
line should be using taddr rather than addr, like everywhere else.

Link: https://lkml.kernel.org/r/732eae88-3beb-246-2c72-281de786740@google.com
Fixes: c03ab9e32a2c ("ia64: add support for folded p4d page tables")
Signed-off-by: Hugh Dickins <hughd@google.com
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/ia64/mm/hugetlbpage.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -58,7 +58,7 @@ huge_pte_offset (struct mm_struct *mm, u
 
 	pgd = pgd_offset(mm, taddr);
 	if (pgd_present(*pgd)) {
-		p4d = p4d_offset(pgd, addr);
+		p4d = p4d_offset(pgd, taddr);
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, taddr);
 			if (pud_present(*pud)) {


