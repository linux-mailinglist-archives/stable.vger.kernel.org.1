Return-Path: <stable+bounces-7442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB679817292
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E231F1C24893
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5609A3D564;
	Mon, 18 Dec 2023 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cio/7Rao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01F1D14B;
	Mon, 18 Dec 2023 14:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B70DC433C7;
	Mon, 18 Dec 2023 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908478;
	bh=H/f4zKYC9mNnA4Zfnh/+om64AgFWeHsbHrLr357JOnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cio/7RaokYrPYO2KtOPAyoi75uSRACQPn126TD17/WEZD60Wohsc8q5fSIepMHR7l
	 yK34m2zenF3EJuz61idfyT6T6NYNY9s7VWJBz38Cd/4ASF6cP5uDdmZQXTrmJFsbsm
	 05lVVbr27AO07oW5Qo0B7JGC2h86uffNjnhZIt4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangyu Hua <hbh25y@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.10 25/62] fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()
Date: Mon, 18 Dec 2023 14:51:49 +0100
Message-ID: <20231218135047.369020876@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135046.178317233@linuxfoundation.org>
References: <20231218135046.178317233@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangyu Hua <hbh25y@gmail.com>

commit 7f8ed28d1401320bcb02dda81b3c23ab2dc5a6d8 upstream.

fuse_dax_conn_free() will be called when fuse_fill_super_common() fails
after fuse_dax_conn_alloc(). Then deactivate_locked_super() in
virtio_fs_get_tree() will call virtio_kill_sb() to release the discarded
superblock. This will call fuse_dax_conn_free() again in fuse_conn_put(),
resulting in a possible double free.

Fixes: 1dd539577c42 ("virtiofs: add a mount option to enable dax")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # v5.10
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/dax.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1228,6 +1228,7 @@ void fuse_dax_conn_free(struct fuse_conn
 	if (fc->dax) {
 		fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
 		kfree(fc->dax);
+		fc->dax = NULL;
 	}
 }
 



