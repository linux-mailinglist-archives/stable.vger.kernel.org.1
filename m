Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0677A7ED33F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjKOUrB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjKOUrA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:47:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F6B7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED032C433CC;
        Wed, 15 Nov 2023 20:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081217;
        bh=I/UCFey5W2cIdfIm7fL2I2yml8TyKxNVxeGgMUmpnDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4VLMKbQIJHtsu6RG+6w1C8POQBkPNdJ+4e5XMqVq7J+5bce62ar5zsqjDc2KWCoK
         pBFw6WUFLfKDivJdowkL2Y4mjssWrMzTigV3+Waxtd1EFdZWyJ4ZuDqTFrh7rWegg1
         B/QCSrUW72pGBDUZ74iBlxtskSdLW5LWp9AT4I1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Reuben Hawkins <reubenhwk@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 004/244] vfs: fix readahead(2) on block devices
Date:   Wed, 15 Nov 2023 15:33:16 -0500
Message-ID: <20231115203548.644965476@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Reuben Hawkins <reubenhwk@gmail.com>

[ Upstream commit 7116c0af4b8414b2f19fdb366eea213cbd9d91c2 ]

Readahead was factored to call generic_fadvise.  That refactor added an
S_ISREG restriction which broke readahead on block devices.

In addition to S_ISREG, this change checks S_ISBLK to fix block device
readahead.  There is no change in behavior with any file type besides block
devices in this change.

Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNEED")
Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
Link: https://lore.kernel.org/r/20231003015704.2415-1-reubenhwk@gmail.com
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/readahead.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 41b75d76d36e1..a8f7e4e550f43 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -627,7 +627,8 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 */
 	ret = -EINVAL;
 	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	    (!S_ISREG(file_inode(f.file)->i_mode) &&
+	    !S_ISBLK(file_inode(f.file)->i_mode)))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
-- 
2.42.0



