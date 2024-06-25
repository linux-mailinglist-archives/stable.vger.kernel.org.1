Return-Path: <stable+bounces-55395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB73916365
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4021C2106E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C82E1487E9;
	Tue, 25 Jun 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CayMMLma"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CD1465A8;
	Tue, 25 Jun 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308778; cv=none; b=rlfknvJ/uwCfpgKDXB+yePHfCtywsx9b3DP3rUrFvnzgBXr9yrxtAwmN/qwsllM75JA66Db+3s/yPZkrjpmQWVSz3DL+oA9oJlq5ICIaX29SAxW3x2iuZqzQs2rj3g5f9nnWdMsqAEyNGgA42C011YkbY2+yTRflPt3/6Y1L5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308778; c=relaxed/simple;
	bh=wW2Fn7DXm1y1wL5+QhOri0Khd/yPdOpDpyqL0i5yEro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lrob1vam0r/7nhhFd4sbVkv4qBhuJFsDlgVrFddSF3C/0hpDOwb7fq3BsXe93Zz2X7SQB/uSAay0ILHN+vqURFHmflLPBNLL661OpRg50EuVi2RDhfuuGKZNtYmLivvAXDUijb2h2xA52i6twdMNJk5JU/5vzJAF9ET/3etTAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CayMMLma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A32CC32781;
	Tue, 25 Jun 2024 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308777;
	bh=wW2Fn7DXm1y1wL5+QhOri0Khd/yPdOpDpyqL0i5yEro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CayMMLmahqw76NocnaUlVShkKktlQ/S9qK5JUE9Y79ICV34bf99Xzoz7RIQ0rTPN3
	 SAoXjjWamzQvBq82j2xYLfgd9cYX03hL5eJWIcChmxxfCKhITWoKms782gMOzGG6xo
	 McV374j/dym11hUKnN1Ix6skXnQVBkxw0FbT56rw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.9 195/250] RDMA/mlx5: Remove extra unlock on error path
Date: Tue, 25 Jun 2024 11:32:33 +0200
Message-ID: <20240625085555.535446960@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit c1eb2512596fb3542357bb6c34c286f5e0374538 upstream.

The below commit lifted the locking out of this function but left this
error path unlock behind resulting in unbalanced locking. Remove the
missed unlock too.

Cc: stable@vger.kernel.org
Fixes: 627122280c87 ("RDMA/mlx5: Add work to remove temporary entries from the cache")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://lore.kernel.org/r/78090c210c750f47219b95248f9f782f34548bb1.1716900410.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/mr.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -641,10 +641,8 @@ static int mlx5_cache_ent_insert(struct
 			new = &((*new)->rb_left);
 		if (cmp < 0)
 			new = &((*new)->rb_right);
-		if (cmp == 0) {
-			mutex_unlock(&cache->rb_lock);
+		if (cmp == 0)
 			return -EEXIST;
-		}
 	}
 
 	/* Add new node and rebalance tree. */



