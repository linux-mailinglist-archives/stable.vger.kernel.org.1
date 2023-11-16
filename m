Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261867EDBA2
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 07:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjKPGk1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 16 Nov 2023 01:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPGk0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 16 Nov 2023 01:40:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7995C2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 22:40:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32d895584f1so338007f8f.1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 22:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700116821; x=1700721621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rw43nmQ4n9y7cyda+AfzzBlyoi0wzBD4atAiqzcNo8U=;
        b=DL9nU/A/amQh3g0rMXIUVCu4GUeNAa5LoNOOFZNpLDEKXES1UiFrMGq1hIFnBtLZaY
         qkj8mfgPgfI/oOGF8zQycGHstRkkI52xadnOPXigq7VIL6Sqex7CsKjnBoQyJrc17CKe
         d+We2zUmOQQh1dTSqepbydf2MAEQArqjqNRjSQ0DJP57Fr6r992sr5ShiX12I4ijhfoY
         8XtX/inh8MOumIgXMt5/+uLRpY9V+TqFSFPEjHCWUfgMO+4dzK5SJ7keLUUG06dABH/L
         JOIYaRIAfUny0MxeW147JC7AeRmdoXHlUu9Q3afTgxeVgNBMbuUkkRHNL2cXEkzTQE5X
         1vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700116821; x=1700721621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rw43nmQ4n9y7cyda+AfzzBlyoi0wzBD4atAiqzcNo8U=;
        b=iqMBdnrmYtWHC7oGOjDWN6MLBJT17GaCJ9UTyfsw0yqZl8IuDZ/7IhYFt1MK8aVUqh
         qhoXKo2WTCyhRPSCSyz9opXpWlMbNJvlqnDO5if0Wa2l8qB4HaL4OGJ0PjifMRh9nKbT
         SR+8/8F5J3waEv2/O02lKo7nMxQZa21LzLY8mlQlMONsEXDUgOFQdLMzWrS0KX6t7Wia
         d7OOeLn6c03q3wGVgl8yeCZkLSXFYbZRfBiEZuKSvsl6rtJzGnNIOJDMxTf94Ro+uGxM
         UJGxeg/HoubaAyeMubmKFMIC5sFylU1FHgxsVBKZ3ZezHAbZ1KRMjN+oKRVo6fn6iEUL
         Be0A==
X-Gm-Message-State: AOJu0YxEIUqua8sIZbWuUDI1lz9c9/vzqpsNQrfcgsmruPmS7cOovvcF
        FJs7U2mPTi88Gzj+WTcb5sCh+UsaZiqUqfAA
X-Google-Smtp-Source: AGHT+IH9D1NY68cIoHgyFXVA2Utx4rhfU2IBuhSORsBZ99zqtB1k7PI6Kx/Vd0T8q32fjX5dm+VnQg==
X-Received: by 2002:adf:f28e:0:b0:32f:7cea:2ea1 with SMTP id k14-20020adff28e000000b0032f7cea2ea1mr9840863wro.18.1700116820482;
        Wed, 15 Nov 2023 22:40:20 -0800 (PST)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id b15-20020adff90f000000b0031fd849e797sm12485968wrr.105.2023.11.15.22.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 22:40:20 -0800 (PST)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     stable@vger.kernel.org
Cc:     starzhangzsd@gmail.com, zhangshida@kylinos.cn,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>,
        Gao Xiang <hsiangkao@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.19.y] iomap: Set all uptodate bits for an Uptodate page
Date:   Thu, 16 Nov 2023 14:40:10 +0800
Message-Id: <20231116064010.17023-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

commit 4595a298d5563cf76c1d852970f162051fd1a7a6 upstream.

For filesystems with block size < page size, we need to set all the
per-block uptodate bits if the page was already uptodate at the time
we create the per-block metadata.  This can happen if the page is
invalidated (eg by a write to drop_caches) but ultimately not removed
from the page cache.

This is a data corruption issue as page writeback skips blocks which
are marked !uptodate.

Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Qian Cai <cai@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/iomap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index ac7b2152c3ad..04e82b6bd9bf 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -109,6 +109,7 @@ static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
+	unsigned int nr_blocks = PAGE_SIZE / i_blocksize(inode);
 
 	if (iop || i_blocksize(inode) == PAGE_SIZE)
 		return iop;
@@ -118,6 +119,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	atomic_set(&iop->write_count, 0);
 	spin_lock_init(&iop->uptodate_lock);
 	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+	if (PageUptodate(page))
+		bitmap_fill(iop->uptodate, nr_blocks);
 
 	/*
 	 * migrate_page_move_mapping() assumes that pages with private data have
-- 
2.27.0

