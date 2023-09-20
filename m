Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47307A7F12
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjITMXk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjITMXj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:23:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5D83
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:23:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DC3C433C7;
        Wed, 20 Sep 2023 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212613;
        bh=EiTQUWLcRDTT7CPTA3mVjQJ59I6BLTJcN2UsW74SWYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crZgvcxmFZeV9l/zUDNvALsWBtH4WcEQtl/rF2uO4MvwCqtr8pHVwoQA9rqDfkyKE
         G1FPrK6utvqJ8H4q5poCLaLf6V+P+HjzLo1aLdAQB4ru7FjFse6EbzunX84Vr+Qx7V
         p1tN8/w7SqQN5tZN1rp+ZmCGoGymE6obMPi+fBJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 5.10 67/83] ovl: fix incorrect fdput() on aio completion
Date:   Wed, 20 Sep 2023 13:31:57 +0200
Message-ID: <20230920112829.304551266@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 724768a39374d35b70eaeae8dd87048a2ec7ae8e upstream.

ovl_{read,write}_iter() always call fdput(real) to put one or zero
refcounts of the real file, but for aio, whether it was submitted or not,
ovl_aio_put() also calls fdput(), which is not balanced.  This is only a
problem in the less common case when FDPUT_FPUT flag is set.

To fix the problem use get_file() to take file refcount and use fput()
instead of fdput() in ovl_aio_put().

Fixes: 2406a307ac7d ("ovl: implement async IO routines")
Cc: <stable@vger.kernel.org> # v5.6
Reviewed-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/file.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -19,7 +19,6 @@ struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
-	struct fd fd;
 };
 
 static struct kmem_cache *ovl_aio_request_cachep;
@@ -261,7 +260,7 @@ static rwf_t ovl_iocb_to_rwf(int ifl)
 static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref)) {
-		fdput(aio_req->fd);
+		fput(aio_req->iocb.ki_filp);
 		kmem_cache_free(ovl_aio_request_cachep, aio_req);
 	}
 }
@@ -327,10 +326,9 @@ static ssize_t ovl_read_iter(struct kioc
 		if (!aio_req)
 			goto out;
 
-		aio_req->fd = real;
 		real.flags = 0;
 		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, real.file);
+		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
 		refcount_set(&aio_req->ref, 2);
 		ret = vfs_iocb_iter_read(real.file, &aio_req->iocb, iter);
@@ -399,10 +397,9 @@ static ssize_t ovl_write_iter(struct kio
 		/* Pacify lockdep, same trick as done in aio_write() */
 		__sb_writers_release(file_inode(real.file)->i_sb,
 				     SB_FREEZE_WRITE);
-		aio_req->fd = real;
 		real.flags = 0;
 		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, real.file);
+		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
 		refcount_set(&aio_req->ref, 2);


