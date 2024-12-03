Return-Path: <stable+bounces-97311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73609E241E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1531689C0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659FE1FCCF9;
	Tue,  3 Dec 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGIxEm5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466D1F8AD4;
	Tue,  3 Dec 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240120; cv=none; b=GgwkzAz90CbxDe7YSDkHjKxdq/dtulV99hULtQtlUYsBno4f7lO7z2TL+b5iKubHqDMvha2Yen17kQRj6YulxVE2pxcVkbKW+ay904pXYZ0Lco2OL1NiTa59WmQJuKKUbUddUJ+wCzn8JKaNUYEpgqpFrxJrWlsdAQjotn+/Pkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240120; c=relaxed/simple;
	bh=EkIgvEgTErh71jIE+KlzADZtyifs6sK8jcUffv51CUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyj0+W8De/4UgjiLRzsbgvMBj92EgAgOK7dyckPduZswpHb9/2148jlJCsjMP3Ho4sTLmG4HolfJIhwJgmgKcDTT7wbztgOhQPSxiEUH+RKq7niAToUY+Y73f513DVLRRnkw+L8i0ajOm6fdwv+h+unJ/BZAon203MhkTtK/x5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oGIxEm5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3569DC4CECF;
	Tue,  3 Dec 2024 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240119;
	bh=EkIgvEgTErh71jIE+KlzADZtyifs6sK8jcUffv51CUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGIxEm5QiyMalA+Z7O98iqhWJZvg1cBH8AWudmmN9ASGLPi17vx6Si8V4iaxeSOxc
	 lXGYUR6FrwKq8NUQJB91APFljuvfxtx/F9JSr7jToG6MXPmQ2CAiyqJu1D1+t1bcPv
	 SM8jcDi08k0AEm/x6M2zmq+x6L155B0MKvr2TA78=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zizhi Wo <wozizhi@huawei.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 029/826] cachefiles: Fix incorrect length return value in cachefiles_ondemand_fd_write_iter()
Date: Tue,  3 Dec 2024 15:35:56 +0100
Message-ID: <20241203144744.597908090@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zizhi Wo <wozizhi@huawei.com>

[ Upstream commit 10c35abd35aa62c9aac56898ae0c63b4d7d115e5 ]

cachefiles_ondemand_fd_write_iter() function first aligns "pos" and "len"
to block boundaries. When calling __cachefiles_write(), the aligned "pos"
is passed in, but "len" is the original unaligned value(iter->count).
Additionally, the returned length of the write operation is the modified
"len" aligned by block size, which is unreasonable.

The alignment of "pos" and "len" is intended only to check whether the
cache has enough space. But the modified len should not be used as the
return value of cachefiles_ondemand_fd_write_iter() because the length we
passed to __cachefiles_write() is the previous "len". Doing so would result
in a mismatch in the data written on-demand. For example, if the length of
the user state passed in is not aligned to the block size (the preread
scene/DIO writes only need 512 alignment/Fault injection), the length of
the write will differ from the actual length of the return.

To solve this issue, since the __cachefiles_prepare_write() modifies the
size of "len", we pass "aligned_len" to __cachefiles_prepare_write() to
calculate the free blocks and use the original "len" as the return value of
cachefiles_ondemand_fd_write_iter().

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Link: https://lore.kernel.org/r/20241107110649.3980193-2-wozizhi@huawei.com
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/ondemand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 470c966583850..bdd321017f1c4 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -61,7 +61,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 	struct cachefiles_object *object = kiocb->ki_filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file = object->file;
-	size_t len = iter->count;
+	size_t len = iter->count, aligned_len = len;
 	loff_t pos = kiocb->ki_pos;
 	const struct cred *saved_cred;
 	int ret;
@@ -70,7 +70,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 		return -ENOBUFS;
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(object, file, &pos, &len, len, true);
+	ret = __cachefiles_prepare_write(object, file, &pos, &aligned_len, len, true);
 	cachefiles_end_secure(cache, saved_cred);
 	if (ret < 0)
 		return ret;
-- 
2.43.0




