Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96211761356
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjGYLJn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjGYLJ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8213C11
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 052A261648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18528C433C8;
        Tue, 25 Jul 2023 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283311;
        bh=u0s5v0cHR+hs5cNgLiIluV/YDq29nb9yExBQ2TG2pYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCt6b4yC3LJ1V8RQQF0d7Fk8JcjDXSa47WvhaHbiSHM3LTBuqx6q7RjpvYAUolbia
         0+1GzVC0WC94GaZa+e3lfMkX2hun2swMASFCCDIdIoqR1JrKpK8Fg0duVgg/jYl9Yw
         UE51EER6mbdJ+KHgap7AAguAsur9nY6rTk+E42uE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonathan Katz <jkatz@eitmlabs.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.15 09/78] fuse: ioctl: translate ENOSYS in outarg
Date:   Tue, 25 Jul 2023 12:46:00 +0200
Message-ID: <20230725104451.685794071@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit 6a567e920fd0451bf29abc418df96c3365925770 upstream.

Fuse shouldn't return ENOSYS from its ioctl implementation. If userspace
responds with ENOSYS it should be translated to ENOTTY.

There are two ways to return an error from the IOCTL request:

 - fuse_out_header.error
 - fuse_ioctl_out.result

Commit 02c0cab8e734 ("fuse: ioctl: translate ENOSYS") already fixed this
issue for the first case, but missed the second case.  This patch fixes the
second case.

Reported-by: Jonathan Katz <jkatz@eitmlabs.org>
Closes: https://lore.kernel.org/all/CALKgVmcC1VUV_gJVq70n--omMJZUb4HSh_FqvLTHgNBc+HCLFQ@mail.gmail.com/
Fixes: 02c0cab8e734 ("fuse: ioctl: translate ENOSYS")
Cc: <stable@vger.kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/ioctl.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -9,14 +9,23 @@
 #include <linux/compat.h>
 #include <linux/fileattr.h>
 
-static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args)
+static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
+			       struct fuse_ioctl_out *outarg)
 {
-	ssize_t ret = fuse_simple_request(fm, args);
+	ssize_t ret;
+
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+
+	ret = fuse_simple_request(fm, args);
 
 	/* Translate ENOSYS, which shouldn't be returned from fs */
 	if (ret == -ENOSYS)
 		ret = -ENOTTY;
 
+	if (ret >= 0 && outarg->result == -ENOSYS)
+		outarg->result = -ENOTTY;
+
 	return ret;
 }
 
@@ -264,13 +273,11 @@ long fuse_do_ioctl(struct file *file, un
 	}
 
 	ap.args.out_numargs = 2;
-	ap.args.out_args[0].size = sizeof(outarg);
-	ap.args.out_args[0].value = &outarg;
 	ap.args.out_args[1].size = out_size;
 	ap.args.out_pages = true;
 	ap.args.out_argvar = true;
 
-	transferred = fuse_send_ioctl(fm, &ap.args);
+	transferred = fuse_send_ioctl(fm, &ap.args, &outarg);
 	err = transferred;
 	if (transferred < 0)
 		goto out;
@@ -399,12 +406,10 @@ static int fuse_priv_ioctl(struct inode
 	args.in_args[1].size = inarg.in_size;
 	args.in_args[1].value = ptr;
 	args.out_numargs = 2;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
 	args.out_args[1].size = inarg.out_size;
 	args.out_args[1].value = ptr;
 
-	err = fuse_send_ioctl(fm, &args);
+	err = fuse_send_ioctl(fm, &args, &outarg);
 	if (!err) {
 		if (outarg.result < 0)
 			err = outarg.result;


