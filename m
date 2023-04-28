Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09A36F168B
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjD1L2G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjD1L2F (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A5E4EC3
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89E376130B
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98176C433D2;
        Fri, 28 Apr 2023 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681283;
        bh=0Fwiq/nR4pi//wLkSptLfKz0IAcuW006TiMRd6C1+J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0xgfPqlZDxhhpZ4S5EhPfPEKEaujszTW0PjqLXFKzPkeX4hPHWP9moohsa32llqfg
         22u7ModTmqGGpA3Q8xkbRhK5ZgRgBOkPJK+D8P+9uRXTBXNjUXBl4K9Y8uKsmBZSxm
         mvnacvuqSrDsWoZWdBRyIaBJTDjqTMC2YO7Aw0ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+51177e4144d764827c45@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 6.3 02/11] fsverity: reject FS_IOC_ENABLE_VERITY on mode 3 fds
Date:   Fri, 28 Apr 2023 13:27:37 +0200
Message-Id: <20230428112039.977228992@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
References: <20230428112039.886496777@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 04839139213cf60d4c5fc792214a08830e294ff8 upstream.

Commit 56124d6c87fd ("fsverity: support enabling with tree block size <
PAGE_SIZE") changed FS_IOC_ENABLE_VERITY to use __kernel_read() to read
the file's data, instead of direct pagecache accesses.

An unintended consequence of this is that the
'WARN_ON_ONCE(!(file->f_mode & FMODE_READ))' in __kernel_read() became
reachable by fuzz tests.  This happens if FS_IOC_ENABLE_VERITY is called
on a fd opened with access mode 3, which means "ioctl access only".

Arguably, FS_IOC_ENABLE_VERITY should work on ioctl-only fds.  But
ioctl-only fds are a weird Linux extension that is rarely used and that
few people even know about.  (The documentation for FS_IOC_ENABLE_VERITY
even specifically says it requires O_RDONLY.)  It's probably not
worthwhile to make the ioctl internally open a new fd just to handle
this case.  Thus, just reject the ioctl on such fds for now.

Fixes: 56124d6c87fd ("fsverity: support enabling with tree block size < PAGE_SIZE")
Reported-by: syzbot+51177e4144d764827c45@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=2281afcbbfa8fdb92f9887479cc0e4180f1c6b28
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230406215106.235829-1-ebiggers@kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/verity/enable.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -347,6 +347,13 @@ int fsverity_ioctl_enable(struct file *f
 	err = file_permission(filp, MAY_WRITE);
 	if (err)
 		return err;
+	/*
+	 * __kernel_read() is used while building the Merkle tree.  So, we can't
+	 * allow file descriptors that were opened for ioctl access only, using
+	 * the special nonstandard access mode 3.  O_RDONLY only, please!
+	 */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EBADF;
 
 	if (IS_APPEND(inode))
 		return -EPERM;


