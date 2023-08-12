Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8A1779D79
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjHLGDL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHLGDK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9498F1AA
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32091644C8
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439E4C433C9;
        Sat, 12 Aug 2023 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820189;
        bh=b4Kf6xsVr1yze4jR3tzIKMpxcFs8r/W63EGV9rlWxEY=;
        h=Subject:To:Cc:From:Date:From;
        b=uq26pSYiWYCNw+ZsfTTC5kmkFxs8FCqqgXzRdfABMyBv1WWUGjJwg94LAojlFxdfx
         IEhU/P2AX05N0e3vT/wHtZb4CUy8CXCEkO/Xy7GhoRRc3aw6CDtQgGDT3fN4PW69X5
         jgmrewkNr+oj3JXePp0Sdsf5/2CgV5KaR21S8sno=
Subject: FAILED: patch "[PATCH] io_uring: correct check for O_TMPFILE" failed to apply to 5.15-stable tree
To:     cyphar@cyphar.com, axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 08:02:58 +0200
Message-ID: <2023081258-sturdy-retying-2572@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081258-sturdy-retying-2572@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

72dbde0f2afb ("io_uring: correct check for O_TMPFILE")
0ffae640ad83 ("io_uring: always go async for unsupported open flags")
cd40cae29ef8 ("io_uring: split out open/close operations")
453b329be5ea ("io_uring: separate out file table handling code")
f4c163dd7d4b ("io_uring: split out fadvise/madvise operations")
0d5847274037 ("io_uring: split out fs related sync/fallocate functions")
531113bbd5bf ("io_uring: split out splice related operations")
11aeb71406dd ("io_uring: split out filesystem related operations")
e28683bdfc2f ("io_uring: move nop into its own file")
5e2a18d93fec ("io_uring: move xattr related opcodes to its own file")
97b388d70b53 ("io_uring: handle completions in the core")
de23077eda61 ("io_uring: set completion results upfront")
e27f928ee1cb ("io_uring: add io_uring_types.h")
4d4c9cff4f70 ("io_uring: define a request type cleanup handler")
890968dc0336 ("io_uring: unify struct io_symlink and io_hardlink")
9a3a11f977f9 ("io_uring: convert iouring_cmd to io_cmd_type")
ceb452e1b4ba ("io_uring: convert xattr to use io_cmd_type")
ea5af87d29cf ("io_uring: convert rsrc_update to io_cmd_type")
c1ee55950155 ("io_uring: convert msg and nop to io_cmd_type")
2511d3030c5e ("io_uring: convert splice to use io_cmd_type")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f Mon Sep 17 00:00:00 2001
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 7 Aug 2023 12:24:15 +1000
Subject: [PATCH] io_uring: correct check for O_TMPFILE

O_TMPFILE is actually __O_TMPFILE|O_DIRECTORY. This means that the old
check for whether RESOLVE_CACHED can be used would incorrectly think
that O_DIRECTORY could not be used with RESOLVE_CACHED.

Cc: stable@vger.kernel.org # v5.12+
Fixes: 3a81fd02045c ("io_uring: enable LOOKUP_CACHED path resolution for filename lookups")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Link: https://lore.kernel.org/r/20230807-resolve_cached-o_tmpfile-v3-1-e49323e1ef6f@cyphar.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index 10ca57f5bd24..e3fae26e025d 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -35,9 +35,11 @@ static bool io_openat_force_async(struct io_open *open)
 {
 	/*
 	 * Don't bother trying for O_TRUNC, O_CREAT, or O_TMPFILE open,
-	 * it'll always -EAGAIN
+	 * it'll always -EAGAIN. Note that we test for __O_TMPFILE because
+	 * O_TMPFILE includes O_DIRECTORY, which isn't a flag we need to force
+	 * async for.
 	 */
-	return open->how.flags & (O_TRUNC | O_CREAT | O_TMPFILE);
+	return open->how.flags & (O_TRUNC | O_CREAT | __O_TMPFILE);
 }
 
 static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)

