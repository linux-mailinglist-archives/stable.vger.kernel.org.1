Return-Path: <stable+bounces-7181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC22081714D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8431C23ECD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAA1D148;
	Mon, 18 Dec 2023 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGDVizS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990171D13D;
	Mon, 18 Dec 2023 13:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3BCC433C8;
	Mon, 18 Dec 2023 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907780;
	bh=P3UXjMA6BiHXFaNyQQ2ao7X7V4E8nl4m3mZj6uO8qnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGDVizS6kk2Uf0aXIQ/s+F44UOF4ZywWvUO5rwnXPJH2hk7U1iRHpITxe1jeimaA2
	 gJnX78kK4w2+FAavU6k2B1P3kFlUcj8H7qSIvcFwHZryJpP1dx21AXlAzKC+myt6Li
	 U5mocimoQVnKSFvBRQtIoCRJ+npn4GVdO//hJ62o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangyu Hua <hbh25y@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.1 044/106] fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()
Date: Mon, 18 Dec 2023 14:50:58 +0100
Message-ID: <20231218135056.896405298@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1224,6 +1224,7 @@ void fuse_dax_conn_free(struct fuse_conn
 	if (fc->dax) {
 		fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
 		kfree(fc->dax);
+		fc->dax = NULL;
 	}
 }
 



