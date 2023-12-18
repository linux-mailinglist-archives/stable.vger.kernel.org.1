Return-Path: <stable+bounces-7311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA638171F8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86B82837D2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157D49885;
	Mon, 18 Dec 2023 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6Ose48q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1584239A;
	Mon, 18 Dec 2023 14:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50ADC433C8;
	Mon, 18 Dec 2023 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908128;
	bh=YxNfbC/fRLqmcAn2+mVCOdHTiwyhzHX1cqZfdf38B3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6Ose48qGqDIvm1Etc0zHxkoaIsTPVZrI1CocvMTbLGjIijkYhZszPUugbuYG7iP5
	 MhxDkWazbFAMAgGfF2CrAEa4iWmv30DQZedDbw4GohzdRk6C+//zzYqlp62fhLRgea
	 XZcusXuUSubB7+/H9ILxJ7OID+aNH9ZTTfG/0yXY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangyu Hua <hbh25y@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.6 064/166] fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()
Date: Mon, 18 Dec 2023 14:50:30 +0100
Message-ID: <20231218135107.902613235@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1222,6 +1222,7 @@ void fuse_dax_conn_free(struct fuse_conn
 	if (fc->dax) {
 		fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
 		kfree(fc->dax);
+		fc->dax = NULL;
 	}
 }
 



