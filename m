Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1141E703AEF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjEOR5O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244997AbjEOR4G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D48714E40
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD9EE62F8D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23BBC433D2;
        Mon, 15 May 2023 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173253;
        bh=sNjFJXXSGnJhGP/9x0qVMOuSRz2T50pkHklqgv1IzY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ac+SfOHkfMgpS27jP8gXxp14+vmzJLAIrA0zidWcURqTSVtNbmCEHl2xEsWUZZ3FW
         0qAe4JfO0ee7LIQOvAIUr/U/X0y0xxta5lkAZwx2M2Ugf95fBxgom+PsCZs21nuobI
         FkR5fVEgLalrJhKB2D2Wz0zLwSYXQjQ2Oq0Kbjnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jingbo Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Chao Yu <chao@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/282] erofs: fix potential overflow calculating xattr_isize
Date:   Mon, 15 May 2023 18:26:52 +0200
Message-Id: <20230515161723.296550598@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit 1b3567a1969b26f709d82a874498c0754ea841c3 ]

Given on-disk i_xattr_icount is 16 bits and xattr_isize is calculated
from i_xattr_icount multiplying 4, xattr_isize has a theoretical maximum
of 256K (64K * 4).

Thus declare xattr_isize as unsigned int to avoid the potential overflow.

Fixes: bfb8674dc044 ("staging: erofs: add erofs in-memory stuffs")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230414061810.6479-1-jefflexu@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453f3076c..cc7a42682814c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -226,7 +226,7 @@ struct erofs_inode {
 
 	unsigned char datalayout;
 	unsigned char inode_isize;
-	unsigned short xattr_isize;
+	unsigned int xattr_isize;
 
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
-- 
2.39.2



