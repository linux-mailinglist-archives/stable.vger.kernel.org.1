Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0691F6FA42F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjEHJ4W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjEHJ4Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1442ABED
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C7EC62223
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C58BC433D2;
        Mon,  8 May 2023 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539768;
        bh=ZWIRwAg7IPLlHct21/7ya5hTaUiW4CpbGRlioL9i2Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wrc0uENKtBiZOVTwA/M1Sz4Keug0DQa2WslDOObmlen6COAp04bjsM94j9yQwRbwx
         JKP2X8Q6KbDaJRWM2bJASpMkns+ZqPbKyP5WhUezX278nRLFMvPfkepc2kK0y0WSiQ
         nXnNdQZ1zuxjCewU7fIBYUdg6MJwHr53dW6Udz40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jingbo Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Chao Yu <chao@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/611] erofs: fix potential overflow calculating xattr_isize
Date:   Mon,  8 May 2023 11:39:32 +0200
Message-Id: <20230508094426.483407669@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index 4868000806d8b..340bd56a57559 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -311,7 +311,7 @@ struct erofs_inode {
 
 	unsigned char datalayout;
 	unsigned char inode_isize;
-	unsigned short xattr_isize;
+	unsigned int xattr_isize;
 
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
-- 
2.39.2



