Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38370C674
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjEVTS1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjEVTSS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:18:18 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B15E58
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2533e0cd8f2so3516527a91.2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684783089; x=1687375089;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZb7r4mjAl6nH9Xl5o/6YEsrG35fo7vrfTgS3GOAo5I=;
        b=t2SREQBqGmfWxnD7rmiqFLmolKO1UYPh9Loq0blF5/min7UwY3mXbzTHv4mdjbGVbe
         ago4jjq87pCU+ymcbxOxwEgxvKV4fvyEiPUgWCV1+Iz5unSWRmNyLgQiIxUx9Fy/8PAG
         Rq+Rl5HMUwCHSKRensw4MoyEFbmJkV33rf3gJ2Q/cm5Dv/SOs49/b+e/u7qRQijpShLS
         pcCofasWGtKF2XJG/Hp3ezk10h9SjtPSWOZwTr0A0OmubixpQyQZkM+UStSonuYp+BnR
         GEEq5/t8MzZ4L+qp+JWDToWeXLOBwq2r5Hy06Rf+h9Lur2WOs3i41v15Vkt68dAP6le9
         ILjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783089; x=1687375089;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZb7r4mjAl6nH9Xl5o/6YEsrG35fo7vrfTgS3GOAo5I=;
        b=UPOfI/Yv2zErSH/+yGEgOflvKbmaQtOeC/T+M3ApEGKiTun833Qh56ca+mHTzxbmMQ
         b9PgiTLj34jUb6ZLC7c/7SuDyGAwCY988IKElH+jKlim5DKid+Uw5ZG1/ZR0KxsUxYTw
         E7uezkVpI67UofNJ8FfaqOOKMSLIzPA9KpSuOXuQHBl0ExXHVjOCbJ7p5T1mNN4+/+iI
         IDe9ZSXAk7Xg9XU0kWyR2uAHukyjIDEfpDkzSWKX88bkSMZoxBfsztR25JI4D8Z5fxBI
         bpmujMZg/kMd392uh/ESfWEVqrktQZ8uySyS+sp0fVgPLQ6W3tsfzQR8g0eQ+0wcEjdR
         Yp3Q==
X-Gm-Message-State: AC+VfDw5XhHqqEcoepr2idXXb8KP4i3tuo3Xan7jAUwW/0TGIroWuu3Y
        3yHSMRPK/Aoz6YLGt/ZiWLySP9DKGDtOldIiLCey9D2PRkHr6FUUmrfYBR/a3HEVfjJjClGMJ0/
        iNKqW7ZptIy7+xwE2pLQO54bBa2gcK+JAW3oRvSGcdpifhc2Y2FmpkQ==
X-Google-Smtp-Source: ACHHUZ4qMMjKpQCic8E+EDZb1l5MDGJWVe2E3uppHKGRh7IqvPbUhAmthafM4+u/wQA2jNztMyF7BCE=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:3d33:90fe:6f02:afdd])
 (user=pcc job=sendgmr) by 2002:a17:90a:a08c:b0:255:7a07:9e63 with SMTP id
 r12-20020a17090aa08c00b002557a079e63mr897122pjp.3.1684783088847; Mon, 22 May
 2023 12:18:08 -0700 (PDT)
Date:   Mon, 22 May 2023 12:17:39 -0700
In-Reply-To: <2023052236-helium-kilometer-7761@gregkh>
Message-Id: <20230522191739.585201-1-pcc@google.com>
Mime-Version: 1.0
References: <2023052236-helium-kilometer-7761@gregkh>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH 5.15.y] arm64: Also reset KASAN tag if page is not PG_mte_tagged
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
 arch/arm64/mm/copypage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 0dea80bf6de4..b44931deb227 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -21,9 +21,10 @@ void copy_highpage(struct page *to, struct page *from)
 
 	copy_page(kto, kfrom);
 
+	page_kasan_tag_reset(to);
+
 	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
 		set_bit(PG_mte_tagged, &to->flags);
-		page_kasan_tag_reset(to);
 		/*
 		 * We need smp_wmb() in between setting the flags and clearing the
 		 * tags because if another thread reads page->flags and builds a
-- 
2.40.1.698.g37aff9b760-goog

