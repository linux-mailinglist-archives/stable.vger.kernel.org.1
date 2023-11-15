Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AB7ED3A0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjKOUxq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjKOUxo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:53:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4388F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:53:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DD1C4E778;
        Wed, 15 Nov 2023 20:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081621;
        bh=govtWMQ90NxFoGHKRZKkn7n1fHZSDCiRhu3CSc9S/IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uAQkKMhyVEN+SOTAYRGSt1/CldeOP1JCc1xy98XKezHmRDw/8j8YBSDFmB9iKHH0H
         ab5fq8Zn1N6iIG/02wzOFu/5NHKFNJsfCQQ5wuLbpJNoZg5eumcb4Y7lZDBBlEeRDX
         pmY6knf7Y0ESvvFGFpSLvOJyY6WiRr1U8u7fTR0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Reuben Hawkins <reubenhwk@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 003/191] vfs: fix readahead(2) on block devices
Date:   Wed, 15 Nov 2023 15:44:38 -0500
Message-ID: <20231115204644.729037771@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index c5b0457415bef..d30bcf4bc63be 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -625,7 +625,8 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
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



