Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B3775751
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHIKoi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHIKoh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC7B10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3666C63121
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414E1C433C8;
        Wed,  9 Aug 2023 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577875;
        bh=auQ52G1uv/fBXl0ISBN+jSXMtoyKyYwBp1qb5Qn69no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXiyVHyuHDSm5rr7T/o6LaTeZiJjZ3Qn81lKsRycdeLftC0I1YH1dIY3wrEI4A5bE
         yf4a2oCfVnS6llbZSUDqklBmxLMUaFgDRPJ4JWgxEHmQI9YYpJs+ETD3AimCsVo8cf
         70OS8ouYdal6LRP9H2Bv/1rh39uthEFr3nyNOO8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shijie Sun <sunshijie@xiaomi.com>,
        Yue Hu <huyue2@coolpad.com>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 025/165] erofs: fix wrong primary bvec selection on deduplicated extents
Date:   Wed,  9 Aug 2023 12:39:16 +0200
Message-ID: <20230809103643.634655293@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 94c43de73521d8ed7ebcfc6191d9dace1cbf7caa ]

When handling deduplicated compressed data, there can be multiple
decompressed extents pointing to the same compressed data in one shot.

In such cases, the bvecs which belong to the longest extent will be
selected as the primary bvecs for real decompressors to decode and the
other duplicated bvecs will be directly copied from the primary bvecs.

Previously, only relative offsets of the longest extent were checked to
decompress the primary bvecs.  On rare occasions, it can be incorrect
if there are several extents with the same start relative offset.
As a result, some short bvecs could be selected for decompression and
then cause data corruption.

For example, as Shijie Sun reported off-list, considering the following
extents of a file:
 117:   903345..  915250 |   11905 :     385024..    389120 |    4096
...
 119:   919729..  930323 |   10594 :     385024..    389120 |    4096
...
 124:   968881..  980786 |   11905 :     385024..    389120 |    4096

The start relative offset is the same: 2225, but extent 119 (919729..
930323) is shorter than the others.

Let's restrict the bvec length in addition to the start offset if bvecs
are not full.

Reported-by: Shijie Sun <sunshijie@xiaomi.com>
Fixes: 5c2a64252c5d ("erofs: introduce partial-referenced pclusters")
Tested-by Shijie Sun <sunshijie@xiaomi.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230719065459.60083-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4a1c238600c52..470988bb7867e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1110,10 +1110,11 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 					 struct z_erofs_bvec *bvec)
 {
 	struct z_erofs_bvec_item *item;
+	unsigned int pgnr;
 
-	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK)) {
-		unsigned int pgnr;
-
+	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK) &&
+	    (bvec->end == PAGE_SIZE ||
+	     bvec->offset + bvec->end == be->pcl->length)) {
 		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
 		DBG_BUGON(pgnr >= be->nr_pages);
 		if (!be->decompressed_pages[pgnr]) {
-- 
2.40.1



