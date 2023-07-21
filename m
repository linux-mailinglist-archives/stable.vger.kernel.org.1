Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02F75D45A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjGUTUV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjGUTUU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E163A90
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC60F61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CF4C433C8;
        Fri, 21 Jul 2023 19:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967210;
        bh=qK7T5UjBpI9uIvzNn8qNCy7/FF7AT8/dyzfqNPzR9A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B7oohGfFH9nTL8cUuecj9E8iRYNIrSDe2RXrtN9/nM7OxnyXWaIkCkLtV9qJkXn7j
         RdaO65SrLmXrAYAixii9abGFDZbV8LpKstAFupLYEagvsA22/LIHv7lQRHAHd40kvh
         w2eL6F8xnVeKK9CjWSvNTJHgsG39ifuTvPyuTdd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Yin <yinxin.x@bytedance.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Chao Yu <chao@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 054/223] erofs: fix fsdax unavailability for chunk-based regular files
Date:   Fri, 21 Jul 2023 18:05:07 +0200
Message-ID: <20230721160523.156508026@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xin Yin <yinxin.x@bytedance.com>

[ Upstream commit 18bddc5b67038722cb88fcf51fbf41a0277092cb ]

DAX can be used to share page cache between VMs, reducing guest memory
overhead. And chunk based data format is widely used for VM and
container image. So enable dax support for it, make erofs better used
for VM scenarios.

Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230711062130.7860-1-yinxin.x@bytedance.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5aadc73d57652..e090bcd46db14 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -186,7 +186,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
+	    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
+	     vi->datalayout == EROFS_INODE_CHUNK_BASED))
 		inode->i_flags |= S_DAX;
 	if (!nblks)
 		/* measure inode.i_blocks as generic filesystems */
-- 
2.39.2



