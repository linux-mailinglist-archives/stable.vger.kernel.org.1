Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893E775D92
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjHILjC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjHILjB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F3173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 855A76357A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AF4C433C8;
        Wed,  9 Aug 2023 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581140;
        bh=xI7tUpXiEioH4kiYsvdPspS8wMK6On5hF2ELWJg0nwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilY6sEALfvF1Q/OuR3O3RawkgO0txkmczGzyBVrhAg1Z5ykYghmQ8iB0mNDE5sAnL
         36BbODV+GfD1la6tqeoUxlPPdMRPJOZE3FILDqIEZtggFUfepNr4wCXIlTquE3jha2
         de8OJrJy/cXckCOH3PfRWPilAYOc9xwSGcKx1Txg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.10 089/201] file: always lock position for FMODE_ATOMIC_POS
Date:   Wed,  9 Aug 2023 12:41:31 +0200
Message-ID: <20230809103646.797089106@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

commit 20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f upstream.

The pidfd_getfd() system call allows a caller with ptrace_may_access()
abilities on another process to steal a file descriptor from this
process. This system call is used by debuggers, container runtimes,
system call supervisors, networking proxies etc. So while it is a
special interest system call it is used in common tools.

That ability ends up breaking our long-time optimization in fdget_pos(),
which "knew" that if we had exclusive access to the file descriptor
nobody else could access it, and we didn't need the lock for the file
position.

That check for file_count(file) was always fairly subtle - it depended
on __fdget() not incrementing the file count for single-threaded
processes and thus included that as part of the rule - but it did mean
that we didn't need to take the lock in all those traditional unix
process contexts.

So it's sad to see this go, and I'd love to have some way to re-instate
the optimization. At the same time, the lock obviously isn't ever
contended in the case we optimized, so all we were optimizing away is
the atomics and the cacheline dirtying. Let's see if anybody even
notices that the optimization is gone.

Link: https://lore.kernel.org/linux-fsdevel/20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org/
Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Cc: stable@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/file.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/fs/file.c
+++ b/fs/file.c
@@ -1013,10 +1013,8 @@ unsigned long __fdget_pos(unsigned int f
 	struct file *file = (struct file *)(v & ~3);
 
 	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
-		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
-			mutex_lock(&file->f_pos_lock);
-		}
+		v |= FDPUT_POS_UNLOCK;
+		mutex_lock(&file->f_pos_lock);
 	}
 	return v;
 }


