Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9379E7BDDC9
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376811AbjJINNV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376774AbjJINNJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA51733
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B32C433C9;
        Mon,  9 Oct 2023 13:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857131;
        bh=l/bRcSSg57C8EjWpl/jE7rdkEkLtJOJO5q1haSwjhGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zvdm4iVTBbdaIvjmzK+Egi8fGh/dgxJHF/D/el9lFYqreA0OsKnpENyJRgthCl0Ak
         oTl3uXxqr5GvI5vGE4C26odJI1rJl89nAwZeVmOnchhKrvrCcrFUaqoxpFyh49ooES
         MFS3lBUHqgmZr0bVh4gdgmJWdHeBoTphXrhYwPVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 107/163] ovl: move freeing ovl_entry past rcu delay
Date:   Mon,  9 Oct 2023 15:01:11 +0200
Message-ID: <20231009130126.980225511@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit d9e8319a6e3538b430f692b5625a76ffa0758adc ]

... into ->free_inode(), that is.

Fixes: 0af950f57fef "ovl: move ovl_entry into ovl_inode"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index cc8977498c483..8e9c1cf83df24 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -164,6 +164,7 @@ static void ovl_free_inode(struct inode *inode)
 	struct ovl_inode *oi = OVL_I(inode);
 
 	kfree(oi->redirect);
+	kfree(oi->oe);
 	mutex_destroy(&oi->lock);
 	kmem_cache_free(ovl_inode_cachep, oi);
 }
@@ -173,7 +174,7 @@ static void ovl_destroy_inode(struct inode *inode)
 	struct ovl_inode *oi = OVL_I(inode);
 
 	dput(oi->__upperdentry);
-	ovl_free_entry(oi->oe);
+	ovl_stack_put(ovl_lowerstack(oi->oe), ovl_numlower(oi->oe));
 	if (S_ISDIR(inode->i_mode))
 		ovl_dir_cache_free(inode);
 	else
-- 
2.40.1



