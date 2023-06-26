Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE27273E76A
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFZSPB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjFZSOw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E4C10E6
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB09360F24
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D77C433C0;
        Mon, 26 Jun 2023 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803290;
        bh=2Pb0O4lZV3y9fkbZ1F9uotQjaSVGpgTrJqBP2l6VvjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyqSMJ8u8N00TLevXxHAiRnpkq7fYNoP+fqB4JbjbIZ1wse3AyfT7fFjEyikzEe4L
         rACwRGi+T3FLkttvBgC7JY/G0QDnmRAHrRDtGLp60YSImkPhOdfxEN0vvxn5Dfsr55
         NVj3W8A4/NGG825recatTO+Yr1kPUf7PXLxj9mgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Kravetz <mike.kravetz@oracle.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dongwon Kim <dongwon.kim@intel.com>,
        James Houghton <jthoughton@google.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 011/199] udmabuf: revert Add support for mapping hugepages (v4)
Date:   Mon, 26 Jun 2023 20:08:37 +0200
Message-ID: <20230626180806.139123832@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Mike Kravetz <mike.kravetz@oracle.com>

commit b7cb3821905b79b6ed474fd5ba34d1e187649139 upstream.

This effectively reverts commit 16c243e99d33 ("udmabuf: Add support for
mapping hugepages (v4)").  Recently, Junxiao Chang found a BUG with page
map counting as described here [1].  This issue pointed out that the
udmabuf driver was making direct use of subpages of hugetlb pages.  This
is not a good idea, and no other mm code attempts such use.  In addition
to the mapcount issue, this also causes issues with hugetlb vmemmap
optimization and page poisoning.

For now, remove hugetlb support.

If udmabuf wants to be used on hugetlb mappings, it should be changed to
only use complete hugetlb pages.  This will require different alignment
and size requirements on the UDMABUF_CREATE API.

[1] https://lore.kernel.org/linux-mm/20230512072036.1027784-1-junxiao.chang@intel.com/

Link: https://lkml.kernel.org/r/20230608204927.88711-1-mike.kravetz@oracle.com
Fixes: 16c243e99d33 ("udmabuf: Add support for mapping hugepages (v4)")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Jerome Marchand <jmarchan@redhat.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma-buf/udmabuf.c |   47 +++++-----------------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -12,7 +12,6 @@
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
 #include <linux/udmabuf.h>
-#include <linux/hugetlb.h>
 #include <linux/vmalloc.h>
 #include <linux/iosys-map.h>
 
@@ -207,9 +206,7 @@ static long udmabuf_create(struct miscde
 	struct udmabuf *ubuf;
 	struct dma_buf *buf;
 	pgoff_t pgoff, pgcnt, pgidx, pgbuf = 0, pglimit;
-	struct page *page, *hpage = NULL;
-	pgoff_t subpgoff, maxsubpgs;
-	struct hstate *hpstate;
+	struct page *page;
 	int seals, ret = -EINVAL;
 	u32 i, flags;
 
@@ -245,7 +242,7 @@ static long udmabuf_create(struct miscde
 		if (!memfd)
 			goto err;
 		mapping = memfd->f_mapping;
-		if (!shmem_mapping(mapping) && !is_file_hugepages(memfd))
+		if (!shmem_mapping(mapping))
 			goto err;
 		seals = memfd_fcntl(memfd, F_GET_SEALS, 0);
 		if (seals == -EINVAL)
@@ -256,48 +253,16 @@ static long udmabuf_create(struct miscde
 			goto err;
 		pgoff = list[i].offset >> PAGE_SHIFT;
 		pgcnt = list[i].size   >> PAGE_SHIFT;
-		if (is_file_hugepages(memfd)) {
-			hpstate = hstate_file(memfd);
-			pgoff = list[i].offset >> huge_page_shift(hpstate);
-			subpgoff = (list[i].offset &
-				    ~huge_page_mask(hpstate)) >> PAGE_SHIFT;
-			maxsubpgs = huge_page_size(hpstate) >> PAGE_SHIFT;
-		}
 		for (pgidx = 0; pgidx < pgcnt; pgidx++) {
-			if (is_file_hugepages(memfd)) {
-				if (!hpage) {
-					hpage = find_get_page_flags(mapping, pgoff,
-								    FGP_ACCESSED);
-					if (!hpage) {
-						ret = -EINVAL;
-						goto err;
-					}
-				}
-				page = hpage + subpgoff;
-				get_page(page);
-				subpgoff++;
-				if (subpgoff == maxsubpgs) {
-					put_page(hpage);
-					hpage = NULL;
-					subpgoff = 0;
-					pgoff++;
-				}
-			} else {
-				page = shmem_read_mapping_page(mapping,
-							       pgoff + pgidx);
-				if (IS_ERR(page)) {
-					ret = PTR_ERR(page);
-					goto err;
-				}
+			page = shmem_read_mapping_page(mapping, pgoff + pgidx);
+			if (IS_ERR(page)) {
+				ret = PTR_ERR(page);
+				goto err;
 			}
 			ubuf->pages[pgbuf++] = page;
 		}
 		fput(memfd);
 		memfd = NULL;
-		if (hpage) {
-			put_page(hpage);
-			hpage = NULL;
-		}
 	}
 
 	exp_info.ops  = &udmabuf_ops;


