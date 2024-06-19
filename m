Return-Path: <stable+bounces-54269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBE90ED6E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FD81C21C44
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AD7143C4E;
	Wed, 19 Jun 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qJaipRxV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5C82495;
	Wed, 19 Jun 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803081; cv=none; b=DeprGdCPe8rVrDcPEoB+Tro/qYeJKdk+wPAMWAqpBATFep+L8KHmNfQ9manqY0Rr7oZ5lnAFhqahWMVj/CnzaUcs7rOxtNfiNxvet54i9UrGKriIMKvvjxCtIjW6TR6JrU34OAzx9wdIFye/glwIPe8Kw0ZPcrQG9y5cI76wCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803081; c=relaxed/simple;
	bh=j0NaD9lQpN/TsJwq42deeYUM3ggTTHVe1sDxabmUfL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ti7gKDNTRM7zCSGoUxK5QWmKWTD1RfmbzGTNxOKQkZP+grXCfr1kwNVeraNDa3HjHQg7hn1PjvhpTAdRUocFmGbXBvN1Byj5JqQNrkB2bqRCBgzteiCs2obeNt2XUMjcLZpSiQ7zGreJhot2cgwGpVW2rB2zocmzSVI7R4UmBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qJaipRxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B17C2BBFC;
	Wed, 19 Jun 2024 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803081;
	bh=j0NaD9lQpN/TsJwq42deeYUM3ggTTHVe1sDxabmUfL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJaipRxV0CAcJRIv5i1ovMYnDnA9iXzcFpkxuQED7lNwJ38WS/2SmOp1s10yfPq18
	 BNwCYQuSZpK6N/T9mq6WjZx3n5V8sMV9/iGLJkVDv2FDT7j3AzKTbltu5/xnngxSdX
	 PhmfmSOfcdPr5R8IDWtlpKiCcCDHwEPqnoGdt7zM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 116/281] cachefiles: never get a new anonymous fd if ondemand_id is valid
Date: Wed, 19 Jun 2024 14:54:35 +0200
Message-ID: <20240619125614.311166233@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 4988e35e95fc938bdde0e15880fe72042fc86acf ]

Now every time the daemon reads an open request, it gets a new anonymous fd
and ondemand_id. With the introduction of "restore", it is possible to read
the same open request more than once, and therefore an object can have more
than one anonymous fd.

If the anonymous fd is not unique, the following concurrencies will result
in an fd leak:

     t1     |         t2         |          t3
------------------------------------------------------------
 cachefiles_ondemand_init_object
  cachefiles_ondemand_send_req
   REQ_A = kzalloc(sizeof(*req) + data_len)
   wait_for_completion(&REQ_A->done)
            cachefiles_daemon_read
             cachefiles_ondemand_daemon_read
              REQ_A = cachefiles_ondemand_select_req
              cachefiles_ondemand_get_fd
                load->fd = fd0
                ondemand_id = object_id0
                                  ------ restore ------
                                  cachefiles_ondemand_restore
                                   // restore REQ_A
                                  cachefiles_daemon_read
                                   cachefiles_ondemand_daemon_read
                                    REQ_A = cachefiles_ondemand_select_req
                                      cachefiles_ondemand_get_fd
                                        load->fd = fd1
                                        ondemand_id = object_id1
             process_open_req(REQ_A)
             write(devfd, ("copen %u,%llu", msg->msg_id, size))
             cachefiles_ondemand_copen
              xa_erase(&cache->reqs, id)
              complete(&REQ_A->done)
   kfree(REQ_A)
                                  process_open_req(REQ_A)
                                  // copen fails due to no req
                                  // daemon close(fd1)
                                  cachefiles_ondemand_fd_release
                                   // set object closed
 -- umount --
 cachefiles_withdraw_cookie
  cachefiles_ondemand_clean_object
   cachefiles_ondemand_init_close_req
    if (!cachefiles_ondemand_object_is_open(object))
      return -ENOENT;
    // The fd0 is not closed until the daemon exits.

However, the anonymous fd holds the reference count of the object and the
object holds the reference count of the cookie. So even though the cookie
has been relinquished, it will not be unhashed and freed until the daemon
exits.

In fscache_hash_cookie(), when the same cookie is found in the hash list,
if the cookie is set with the FSCACHE_COOKIE_RELINQUISHED bit, then the new
cookie waits for the old cookie to be unhashed, while the old cookie is
waiting for the leaked fd to be closed, if the daemon does not exit in time
it will trigger a hung task.

To avoid this, allocate a new anonymous fd only if no anonymous fd has
been allocated (ondemand_id == 0) or if the previously allocated anonymous
fd has been closed (ondemand_id == -1). Moreover, returns an error if
ondemand_id is valid, letting the daemon know that the current userland
restore logic is abnormal and needs to be checked.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240522114308.2402121-9-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index c8389bb118f5b..dbcd4161ea3a1 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -14,11 +14,18 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 					  struct file *file)
 {
 	struct cachefiles_object *object = file->private_data;
-	struct cachefiles_cache *cache = object->volume->cache;
-	struct cachefiles_ondemand_info *info = object->ondemand;
+	struct cachefiles_cache *cache;
+	struct cachefiles_ondemand_info *info;
 	int object_id;
 	struct cachefiles_req *req;
-	XA_STATE(xas, &cache->reqs, 0);
+	XA_STATE(xas, NULL, 0);
+
+	if (!object)
+		return 0;
+
+	info = object->ondemand;
+	cache = object->volume->cache;
+	xas.xa = &cache->reqs;
 
 	xa_lock(&cache->reqs);
 	spin_lock(&info->lock);
@@ -275,22 +282,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 		goto err_put_fd;
 	}
 
+	spin_lock(&object->ondemand->lock);
+	if (object->ondemand->ondemand_id > 0) {
+		spin_unlock(&object->ondemand->lock);
+		/* Pair with check in cachefiles_ondemand_fd_release(). */
+		file->private_data = NULL;
+		ret = -EEXIST;
+		goto err_put_file;
+	}
+
 	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
 	fd_install(fd, file);
 
 	load = (void *)req->msg.data;
 	load->fd = fd;
 	object->ondemand->ondemand_id = object_id;
+	spin_unlock(&object->ondemand->lock);
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
 	return 0;
 
+err_put_file:
+	fput(file);
 err_put_fd:
 	put_unused_fd(fd);
 err_free_id:
 	xa_erase(&cache->ondemand_ids, object_id);
 err:
+	spin_lock(&object->ondemand->lock);
+	/* Avoid marking an opened object as closed. */
+	if (object->ondemand->ondemand_id <= 0)
+		cachefiles_ondemand_set_object_close(object);
+	spin_unlock(&object->ondemand->lock);
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
 	return ret;
 }
@@ -373,10 +397,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
-		if (ret) {
-			cachefiles_ondemand_set_object_close(req->object);
+		if (ret)
 			goto out;
-		}
 	}
 
 	msg->msg_id = xas.xa_index;
-- 
2.43.0




