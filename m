Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B279085C
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjIBPKJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjIBPKJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 11:10:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE95D3
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 08:10:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf6ea270b2so138025ad.0
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693667405; x=1694272205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqqoDYd1FHd12OO46vOXyku/YUe+pXbN5ZgPGWhqMvU=;
        b=FBY6YMn/vUITVTewhgTMURoh66EnRnv9/33ijAAFFiuYryM2wX/igSsKX1EIKUMa8c
         7robhrizf6nvIVbTlGX5B43cqhdV/Z9P+bzIVsFVUw0Oqrftr6Enemx4J23olocTRs9q
         ibgHFQRSNpyxwQa/B1HVR1SH+uzmdl+FLD1UGw3KMhq4tm8SO4lwrMMjwpR5LXt7M7Bd
         dbCNF5HRquzZBUHBWamfDRdK46cirBT7xIzTV7vtGhbOkav/MkSA3Hq2qn2ejaanMDs+
         rdZV+3L64uRLsVdlcikZ1SeIUq5zOBG2JxPeV9eVn4yWJw2EgoQerAyuJz+KM/ifuo5B
         KZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693667405; x=1694272205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqqoDYd1FHd12OO46vOXyku/YUe+pXbN5ZgPGWhqMvU=;
        b=iKNsjTrCthrDCgb/QnTQYSB7tbAWx1b5gELcR6hom+r/HbCjAvYpLC318OEOlY68Lp
         ruYk3Xq4IS6MASpj9oO3ra/NJZvWgO9ozVzmYKriqEIMP7Ad5lnoIiYtKba4n93FnpOf
         46Jwf8BMTR+xUjVOZVOV6tufgfsTYFE5zTqwX0p5ovpMshUwfyVVNkdslA0mt1gKqoc+
         n3VYzRAwScy3vBEZwxKgM3MB2xNCatXwiPh2QZqTHdgEc1b23FaMNINKiuQthXzF+cFl
         /QbG9W45Sz69rj1B/LXVGptChu7+kE3ZiW9Xzc0gX7uvrMU9BkJsLRn0OkdMnd/2CB6w
         +/Xw==
X-Gm-Message-State: AOJu0YwD1xoahHVhdY1UVl5GRAeqTXZvDt2gtz+/fYDLRPwkvRdkc/DB
        vm2bvs9JmPmCRSta0/metvD5vuYzu98=
X-Google-Smtp-Source: AGHT+IF/6/RpRhnJKyIXxK8FjjhrGIT+3o17IPuXbTSu3r6Kd5lHqaZEDbZ9Fi/u06S8fr+PtCadJQ==
X-Received: by 2002:a17:902:db08:b0:1c0:e472:5412 with SMTP id m8-20020a170902db0800b001c0e4725412mr7064519plx.18.1693667404898;
        Sat, 02 Sep 2023 08:10:04 -0700 (PDT)
Received: from carrot.. (i223-217-149-48.s42.a014.ap.plala.or.jp. [223.217.149.48])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902ed5500b001bb7a736b4csm4751035plb.77.2023.09.02.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 08:10:03 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1] nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
Date:   Sun,  3 Sep 2023 00:10:00 +0900
Message-Id: <20230902151000.3817-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit f83913f8c5b882a312e72b7669762f8a5c9385e4 upstream.

A syzbot stress test reported that create_empty_buffers() called from
nilfs_lookup_dirty_data_buffers() can cause a general protection fault.

Analysis using its reproducer revealed that the back reference "mapping"
from a page/folio has been changed to NULL after dirty page/folio gang
lookup in nilfs_lookup_dirty_data_buffers().

Fix this issue by excluding pages/folios from being collected if, after
acquiring a lock on each page/folio, its back reference "mapping" differs
from the pointer to the address space struct that held the page/folio.

Link: https://lkml.kernel.org/r/20230805132038.6435-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/0000000000002930a705fc32b231@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Please apply this patch to the above stable trees instead of the patch
that could not be applied to them.  This patch resolves the conflict
caused by the recent page to folio conversion applied in
nilfs_lookup_dirty_data_buffers().  The general protection fault reported
by syzbot reproduces on these stable kernels before the page/folio
conversion is applied.  This fixes it.

With this tweak, this patch is applicable from v4.15 to v6.2.  Also,
this patch has been tested against the -stable trees of each version in
the subject prefix.

fs/nilfs2/segment.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 21e8260112c8..a4a147a983e0 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -725,6 +725,11 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		struct page *page = pvec.pages[i];
 
 		lock_page(page);
+		if (unlikely(page->mapping != mapping)) {
+			/* Exclude pages removed from the address space */
+			unlock_page(page);
+			continue;
+		}
 		if (!page_has_buffers(page))
 			create_empty_buffers(page, i_blocksize(inode), 0);
 		unlock_page(page);
-- 
2.39.3

