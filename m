Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C741870C6D6
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjEVTXL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjEVTXE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:23:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E81B5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:22:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba83fed5097so13219554276.2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684783374; x=1687375374;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mx5S0ZT/3ZJYq9OBWml8SsAoAgI0k6rO+AEJA5XZveM=;
        b=VtyvZ2EAC+fSaJSquxRmS/AmmOySXNUaFYmA148Q8GdVOXN5NYEqin68sZSIpRsk88
         2XOz2/JRMQG1Ecs6kWUctASllMfTjoUl/i/YDb3Bqkk3FP9ad7QbWFTl2nfM3YYYGQNN
         2LE2dwPesxpxptmjlV1PIX0J1RnyDVDd52ReezFJq8+eqgJeAlsepEOkcfKAbOUo1eI7
         +U7llslqS+fIU9UOAupZhn1WMo44D/r2gxd8BAVAlRYxyiDSvNYMquGsfQC8+KZ8o0GL
         NP5NBFqMmo0TjtCrIdZp7pyHyY+FtxqLxTS/D4Nh6MbMfga5fJMeEBKm5z3bKRZ0GMjH
         t0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783374; x=1687375374;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mx5S0ZT/3ZJYq9OBWml8SsAoAgI0k6rO+AEJA5XZveM=;
        b=i1ax8H4hDoF0/IVyLfJ9NwjFYVnsgJkL0mI+qx2PPQ8mDzJw4THvZaE0civJYMeFuE
         ZTXGyv9usnJAy0E4qH0A57Vfih2eW9GYi6OSMB7qQ8EhAvntPOhDV/wrSz2h/ZwanIZg
         nCupLfW1efB/8bxxTnMFGpMNMgXanGXFx/Au6d6/23EY/JylOYNC6rdUT/YLdQEygC/Y
         +vGwx6x0Qspg0CrPhHb/3Hi3I+vzCigljfX1v8Y1Zl/lk38AD1/zSDWhnxmcgKBT3Hfu
         0RzsEcGvjHQJkJ99T0I1K/PF3Lnwxw6iJZYpHaHjdfqm12qxxozFkFhpnI/17URdiwbZ
         iMgw==
X-Gm-Message-State: AC+VfDzJ3ZqZ/IdZ4rDj9nLFi3YYWcrLoCU27aUP/Mmyhg/FVcgQnRxP
        PJMp4jWHD9u+gYu8nNU0WNeaSimy/b/J0bo9X89hXg5VVi/ORR8FhU0dlDdm2BeiFxlhUVc4/bR
        PN7dRFDsMObG5VbbieqNygELFC+DKr/vvbvG4DnSvAoE+iAap0CABOA==
X-Google-Smtp-Source: ACHHUZ76O+DUj9umoQTSNw+8tgDERCVpM1r/H5+MNraWO/2kAJbN5oPjNlZZqLOHiQNQI0YH19TmRVU=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:3d33:90fe:6f02:afdd])
 (user=pcc job=sendgmr) by 2002:a05:6902:3c2:b0:ba8:939b:6574 with SMTP id
 g2-20020a05690203c200b00ba8939b6574mr6989604ybs.12.1684783374364; Mon, 22 May
 2023 12:22:54 -0700 (PDT)
Date:   Mon, 22 May 2023 12:22:45 -0700
In-Reply-To: <2023052235-cut-gulp-ad69@gregkh>
Message-Id: <20230522192245.661455-1-pcc@google.com>
Mime-Version: 1.0
References: <2023052235-cut-gulp-ad69@gregkh>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH 6.1.y] arm64: Also reset KASAN tag if page is not PG_mte_tagged
From:   Peter Collingbourne <pcc@google.com>
To:     stable@vger.kernel.org
Cc:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Consider the following sequence of events:

1) A page in a PROT_READ|PROT_WRITE VMA is faulted.
2) Page migration allocates a page with the KASAN allocator,
   causing it to receive a non-match-all tag, and uses it
   to replace the page faulted in 1.
3) The program uses mprotect() to enable PROT_MTE on the page faulted in 1.

As a result of step 3, we are left with a non-match-all tag for a page
with tags accessible to userspace, which can lead to the same kind of
tag check faults that commit e74a68468062 ("arm64: Reset KASAN tag in
copy_highpage with HW tags only") intended to fix.

The general invariant that we have for pages in a VMA with VM_MTE_ALLOWED
is that they cannot have a non-match-all tag. As a result of step 2, the
invariant is broken. This means that the fix in the referenced commit
was incomplete and we also need to reset the tag for pages without
PG_mte_tagged.

Fixes: e5b8d9218951 ("arm64: mte: reset the page tag in page->flags")
Cc: <stable@vger.kernel.org> # 5.15
Link: https://linux-review.googlesource.com/id/I7409cdd41acbcb215c2a7417c1e50d37b875beff
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20230420210945.2313627-1-pcc@google.com
Signed-off-by: Will Deacon <will@kernel.org>
(cherry picked from commit 2efbafb91e12ff5a16cbafb0085e4c10c3fca493)
---
 arch/arm64/mm/copypage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 6dbc822332f2..f2fa8a0776e2 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -21,9 +21,10 @@ void copy_highpage(struct page *to, struct page *from)
 
 	copy_page(kto, kfrom);
 
+	if (kasan_hw_tags_enabled())
+		page_kasan_tag_reset(to);
+
 	if (system_supports_mte() && page_mte_tagged(from)) {
-		if (kasan_hw_tags_enabled())
-			page_kasan_tag_reset(to);
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);
 	}
-- 
2.40.1.698.g37aff9b760-goog

