Return-Path: <stable+bounces-59782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1CC932BBB
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1ED1C22298
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5217C9E9;
	Tue, 16 Jul 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQJBkJaW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F612B72;
	Tue, 16 Jul 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144892; cv=none; b=FL2vQcf0OuEhB9VWMFDVleLJGysqQJwuY5GMRBTgX+k2X9XsMzxXQz6WFjv89rwhbytiQMR9jjSxzUZUDK0vnwXiQwo7ApyUof7lAca6xmLYEmWywtZBJRqCC0R9Ot/havODT9g8L9YVb7fuNx7abCdS4tToJOYLsuZE++b6z1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144892; c=relaxed/simple;
	bh=gWYTYWv0zoYyqSGWnpSdHW1RyTQ1RvdQ2a+M3mo1vmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpY3qQ3nfuQ+52/LJKiCSvp7/gw6hbtjZeVaqx48bKh7aiMh+ucXE8WoqWyeyHati6d5tFoDDpTxZSS1p27MKxi4xGz1nEpBs0G6phzY7aA32eqixwKxBPBzm6pXgP2XWLjTl4R7zcUM3xlyMSkNrAROzwowxEIIUL6LD3ueQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQJBkJaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A51C116B1;
	Tue, 16 Jul 2024 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144892;
	bh=gWYTYWv0zoYyqSGWnpSdHW1RyTQ1RvdQ2a+M3mo1vmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQJBkJaWA6SrwxsKNKglU43Y1Dr3N7tAm8wqDyL4VgZYRCdRaH5SShzaGzcD+Om+c
	 URDuhhGB2NNsRAfq9y22co2Tqak64/1FwyoHGaposjSWDs4Gq1wi3aaMoOaelBhtJ/
	 taVpr9C6LBWnmn3W03E5cadM6RkjMhqC5uHB5T8E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hou Tao <houtao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 009/143] cachefiles: wait for ondemand_object_worker to finish when dropping object
Date: Tue, 16 Jul 2024 17:30:05 +0200
Message-ID: <20240716152756.346201997@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
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

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 12e009d60852f7bce0afc373ca0b320f14150418 ]

When queuing ondemand_object_worker() to re-open the object,
cachefiles_object is not pinned. The cachefiles_object may be freed when
the pending read request is completed intentionally and the related
erofs is umounted. If ondemand_object_worker() runs after the object is
freed, it will incur use-after-free problem as shown below.

process A  processs B  process C  process D

cachefiles_ondemand_send_req()
// send a read req X
// wait for its completion

           // close ondemand fd
           cachefiles_ondemand_fd_release()
           // set object as CLOSE

                       cachefiles_ondemand_daemon_read()
                       // set object as REOPENING
                       queue_work(fscache_wq, &info->ondemand_work)

                                // close /dev/cachefiles
                                cachefiles_daemon_release
                                cachefiles_flush_reqs
                                complete(&req->done)

// read req X is completed
// umount the erofs fs
cachefiles_put_object()
// object will be freed
cachefiles_ondemand_deinit_obj_info()
kmem_cache_free(object)
                       // both info and object are freed
                       ondemand_object_worker()

When dropping an object, it is no longer necessary to reopen the object,
so use cancel_work_sync() to cancel or wait for ondemand_object_worker()
to finish.

Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240628062930.2467993-8-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/ondemand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1c0fa7412a6fa..6b94f616e6579 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -661,6 +661,9 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 		}
 	}
 	xa_unlock(&cache->reqs);
+
+	/* Wait for ondemand_object_worker() to finish to avoid UAF. */
+	cancel_work_sync(&object->ondemand->ondemand_work);
 }
 
 int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
-- 
2.43.0




