Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A673C6BA
	for <lists+stable@lfdr.de>; Sat, 24 Jun 2023 06:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFXESa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 24 Jun 2023 00:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFXES3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Jun 2023 00:18:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9C82706
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 21:18:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b516978829so10214605ad.1
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 21:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687580307; x=1690172307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8goi+Fi4kxpYFyeONTQD3fE19lOa6npUCTTdlkmr84=;
        b=jfLvkL3ZB8CcaKRoQXbGAnchJmY4Vj2SLI2LuiRahi2a/ZpVq0cI1FxJYY0J0g6Kme
         F6YlRFdYafoGzbiCBB538GcfqsChAIPpSQUf0id+j6Nmx+KQOuxM3lVNBtCSzVT1k45X
         pAZwBAH64xRZ545Er0jBCPAMVr9D6d9PxR8p+A2+4UngFy6PT0b0j1epXr7jiKhdSorV
         cNO/v2j8vUei6pX1EXdCyY4Ez5MI+5TKTqdU3YLUqPmaSnvPxS4YYDIRbrOqIF5udBcV
         pDStoGdp2uSjlH9Cha8lyYgP9tLTW0hnoxswO3LjLo4LlIkvfusNQPNthRs3R+uZNFFK
         40zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687580307; x=1690172307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8goi+Fi4kxpYFyeONTQD3fE19lOa6npUCTTdlkmr84=;
        b=COEgLqR2PNP+XiKDx1HDVnAgTdiN2hqJh/Nm0DsaGOx7vLtpeW2V9HoDm5Hf/T9gZ2
         41Ses3qorOFRDRcBOF0CWkJlXlIT+Ohx6HJTUvETRS7//C/YfEGCL+Fr7dLuN30Z9CnK
         SmhMzN13qWmHp7RFvbLdA3gDi6PclynCpyReZYL+JhWIS9R2qKS07ZS0Ywi4aeqIb/Wt
         laszdf7GiHKDKXs0+uYLO2hsR0/yALaa7CFb/4Kolf8g0uKlMT89wNty5C1Q0yTuRa0G
         PSq0+DbdWvu8SZ6GMJZ2OPHKnvfoy3cA2/GQenOpiDXA5QdRqKif3CRMB+Ti6UaqMYWe
         fUHA==
X-Gm-Message-State: AC+VfDwwQyadPPRL/8HpttSOGsahfqen2e1WUrV3HyG1L5daLu9M/fNe
        fExBIfZfhgbEdaf1rA9xjFabN4DiEZg=
X-Google-Smtp-Source: ACHHUZ76lDLZPOTUaNRxG4LQkn9RY8fTlD4paFY9XBnG5wVl1yMX9XV7zidEZFB3sjHY42NC8TScNw==
X-Received: by 2002:a17:903:11c7:b0:1b1:ced7:2c00 with SMTP id q7-20020a17090311c700b001b1ced72c00mr1334007plh.19.1687580307032;
        Fri, 23 Jun 2023 21:18:27 -0700 (PDT)
Received: from carrot.. (i220-108-176-228.s42.a014.ap.plala.or.jp. [220.108.176.228])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902b60100b0019ee045a2b3sm284228pls.308.2023.06.23.21.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 21:18:26 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.14 4.19 5.4 5.10 5.15 6.1] nilfs2: prevent general protection fault in nilfs_clear_dirty_page()
Date:   Sat, 24 Jun 2023 13:18:02 +0900
Message-Id: <20230624041802.4195-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023062316-swooned-scurvy-040f@gregkh>
References: <2023062316-swooned-scurvy-040f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 782e53d0c14420858dbf0f8f797973c150d3b6d7 upstream.

In a syzbot stress test that deliberately causes file system errors on
nilfs2 with a corrupted disk image, it has been reported that
nilfs_clear_dirty_page() called from nilfs_clear_dirty_pages() can cause a
general protection fault.

In nilfs_clear_dirty_pages(), when looking up dirty pages from the page
cache and calling nilfs_clear_dirty_page() for each dirty page/folio
retrieved, the back reference from the argument page to "mapping" may have
been changed to NULL (and possibly others).  It is necessary to check this
after locking the page/folio.

So, fix this issue by not calling nilfs_clear_dirty_page() on a page/folio
after locking it in nilfs_clear_dirty_pages() if the back reference
"mapping" from the page/folio is different from the "mapping" that held
the page/folio just before.

Link: https://lkml.kernel.org/r/20230612021456.3682-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/000000000000da4f6b05eb9bf593@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Please apply this patch to the above stable trees instead of the patch
that could not be applied to them.  This patch resolves the conflict
caused by the recent page to folio conversion applied in
nilfs_clear_dirty_pages().  The general protection fault reported by
syzbot reproduces on these stable kernels before the page/folio
conversion is applied.  This fixes it.

With this tweak, this patch is applicable from v3.10 to v6.2.  Also,
this patch has been tested against the -stable trees of each version in
the subject prefix.

 fs/nilfs2/page.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 39b7eea2642a..7d31833e68d1 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -369,7 +369,15 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
+
+			/*
+			 * This page may have been removed from the address
+			 * space by truncation or invalidation when the lock
+			 * was acquired.  Skip processing in that case.
+			 */
+			if (likely(page->mapping == mapping))
+				nilfs_clear_dirty_page(page, silent);
+
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
-- 
2.39.3

