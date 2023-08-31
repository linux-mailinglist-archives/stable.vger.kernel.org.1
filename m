Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9D78EC06
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjHaLbJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjHaLbI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:31:08 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC713CF3
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:31:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vqy4whR_1693481462;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vqy4whR_1693481462)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 19:31:03 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-erofs@lists.ozlabs.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        keltargw <keltar.gw@gmail.com>
Subject: [PATCH 5.10.y] erofs: ensure that the post-EOF tails are all zeroed
Date:   Thu, 31 Aug 2023 19:29:57 +0800
Message-Id: <20230831112959.99884-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230831112959.99884-1-hsiangkao@linux.alibaba.com>
References: <20230831112959.99884-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit e4c1cf523d820730a86cae2c6d55924833b6f7ac upstream.

This was accidentally fixed up in commit e4c1cf523d82 but we can't
take the full change due to other dependancy issues, so here is just
the actual bugfix that is needed.

[Background]

keltargw reported an issue [1] that with mmaped I/Os, sometimes the
tail of the last page (after file ends) is not filled with zeroes.

The root cause is that such tail page could be wrongly selected for
inplace I/Os so the zeroed part will then be filled with compressed
data instead of zeroes.

A simple fix is to avoid doing inplace I/Os for such tail parts,
actually that was already fixed upstream in commit e4c1cf523d82
("erofs: tidy up z_erofs_do_read_page()") by accident.

[1] https://lore.kernel.org/r/3ad8b469-25db-a297-21f9-75db2d6ad224@linux.alibaba.com

Reported-by: keltargw <keltar.gw@gmail.com>
Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 9cff92738259..da133950d514 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -632,6 +632,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
+		++spiltted;
+		tight = false;
 		goto next_part;
 	}
 
-- 
2.24.4

