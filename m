Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5375D458
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjGUTUS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjGUTUO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D134935AB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265BD61D5F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34102C433C8;
        Fri, 21 Jul 2023 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967204;
        bh=mHIEelpe/S7D/3a1+0wNKgINSFmILmE/v7jFAEfiVMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzUbEk7FEo8K7eB+/OtQ1lolLveHtrYGrAGgr8OvB8sY2RSGV7fzDV0t7ZYadOQQ2
         p/u2YXvG7bajUtLfSZeClIQbBpHr+Egu+maKzzyd5nDrBNOQSHUQ1M//+SUPZY0Aq9
         GsWnBVpyNwZve8AScpyv/HEkV0Lxcz941zXdVUao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chunhai Guo <guochunhai@vivo.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, Chao Yu <chao@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 052/223] erofs: avoid useless loops in z_erofs_pcluster_readmore() when reading beyond EOF
Date:   Fri, 21 Jul 2023 18:05:05 +0200
Message-ID: <20230721160523.073181343@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chunhai Guo <guochunhai@vivo.com>

[ Upstream commit 936aa701d82d397c2d1afcd18ce2c739471d978d ]

z_erofs_pcluster_readmore() may take a long time to loop when the page
offset is large enough, which is unnecessary should be prevented.

For example, when the following case is encountered, it will loop 4691368
times, taking about 27 seconds:
    - offset = 19217289215
    - inode_size = 1442672

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Fixes: 386292919c25 ("erofs: introduce readmore decompression strategy")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230710042531.28761-1-guochunhai@vivo.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 92b2e4ddb7ce9..bf6a369f9c696 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1660,7 +1660,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 	}
 
 	cur = map->m_la + map->m_llen - 1;
-	while (cur >= end) {
+	while ((cur >= end) && (cur < i_size_read(inode))) {
 		pgoff_t index = cur >> PAGE_SHIFT;
 		struct page *page;
 
-- 
2.39.2



