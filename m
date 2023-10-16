Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2130A7CAC5D
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjJPOxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjJPOxf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:53:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F9E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:53:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5DAC433C8;
        Mon, 16 Oct 2023 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468013;
        bh=6iS6nIiJBEZPCKHsKcwneuovDYQC1qi5NaY1p/zRrL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9yH8yQElBMsLwfN8PFp36q20f0BcVwMbATDXtSm50NBmrwIpRZQx1Q7GwIB1oKSC
         Nevnkphd0Q7Pqi+2OIHybY4ID/FqXzExiJ1rciy6nT83ELu9yIQ8TbjxtfVBYLUB9Q
         /+rRjQfyLKGkHg+S6/YGR4kK7OiTvNNVYB5km1SY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 135/191] ksmbd: not allow to open file if delelete on close bit is set
Date:   Mon, 16 Oct 2023 10:42:00 +0200
Message-ID: <20231016084018.540956363@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit f43328357defc0dc9d28dbd06dc3361fd2b22e28 upstream.

Cthon test fail with the following error.

check for proper open/unlink operation
nfsjunk files before unlink:
  -rwxr-xr-x 1 root root 0  9월 25 11:03 ./nfs2y8Jm9
./nfs2y8Jm9 open; unlink ret = 0
nfsjunk files after unlink:
  -rwxr-xr-x 1 root root 0  9월 25 11:03 ./nfs2y8Jm9
data compare ok
nfsjunk files after close:
  ls: cannot access './nfs2y8Jm9': No such file or directory
special tests failed

Cthon expect to second unlink failure when file is already unlinked.
ksmbd can not allow to open file if flags of ksmbd inode is set with
S_DEL_ON_CLS flags.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/vfs_cache.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -106,7 +106,7 @@ int ksmbd_query_inode_status(struct inod
 	ci = __ksmbd_inode_lookup(inode);
 	if (ci) {
 		ret = KSMBD_INODE_STATUS_OK;
-		if (ci->m_flags & S_DEL_PENDING)
+		if (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS))
 			ret = KSMBD_INODE_STATUS_PENDING_DELETE;
 		atomic_dec(&ci->m_count);
 	}
@@ -116,7 +116,7 @@ int ksmbd_query_inode_status(struct inod
 
 bool ksmbd_inode_pending_delete(struct ksmbd_file *fp)
 {
-	return (fp->f_ci->m_flags & S_DEL_PENDING);
+	return (fp->f_ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS));
 }
 
 void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp)


