Return-Path: <stable+bounces-128729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39265A7EB1E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F9189252E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966112566E9;
	Mon,  7 Apr 2025 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZBeucak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3F2561D8;
	Mon,  7 Apr 2025 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049809; cv=none; b=TzJfYyok+t2wiz9hcxoptT9+54HohbyAEi8jZgqC+nKbTIuyb0GmD/QxKe6K0B/liKn5P0Xg+I2Qwt9wos3lQs454htInjXNXRl0pjriZm0xYhvAFERnA5RJvquPq7+IooLdzUlRisI2olH4a5VvFokDbQhu0cAH7RKVzqT9LeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049809; c=relaxed/simple;
	bh=BeW7KyRz9QXFfHF0mE0Pz/vjKgeDBXwEhubm2TUylA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjZAWla9m/2PGDPJHeQHXv38Tizt5QHV6mHfcGdDExlQ8QC8i2y8tJC4xW2cahnnQN3y8kh32NWzuyw9jaraPI2V+ZDGWm7xvZmRRt3uWXXBTX1YCJw+B5OxmKLyW4dXFRSKPhtVFGe07zeg2IAftDjaN5i4IrE0yFslGl0LaN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZBeucak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E6CC4CEF5;
	Mon,  7 Apr 2025 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049809;
	bh=BeW7KyRz9QXFfHF0mE0Pz/vjKgeDBXwEhubm2TUylA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZBeucak0SSrKDLXbd47J1Seu14uR891jmftGo0EElUF0FluUdmysnGOlzvjwvJP9
	 GAfJIDDAUubeFZcqSOc3XUMKAoMJrRizjEnmkM24V1cL+ZCmgKfmnw5A+h2EpN+iaE
	 q5UHmW+kZyFQCk5XGHedwzmH9TGAr/OYPw7YZBj5D5u1oadJ6/a3m5o+TUb54QlikA
	 k2WZt+6WL3ev3WGtxf2+R6KQOtS0e+k0tdSDprB95t1btcBhHbYVQvIhlZvJkdX6rI
	 RmKwlufWg3vDEEFpLnWOZwIWROGFBlgY+mDzOYKuLXJPOV6co4mEt81Jz+5+iMqW+g
	 WxxgmsIHLTxGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Robert Morris <rtm@mit.edu>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Sasha Levin <sashal@kernel.org>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 5/9] 9p/net: fix improper handling of bogus negative read/write replies
Date: Mon,  7 Apr 2025 14:16:31 -0400
Message-Id: <20250407181635.3184105-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181635.3184105-1-sashal@kernel.org>
References: <20250407181635.3184105-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <asmadeus@codewreck.org>

[ Upstream commit d0259a856afca31d699b706ed5e2adf11086c73b ]

In p9_client_write() and p9_client_read_once(), if the server
incorrectly replies with success but a negative write/read count then we
would consider written (negative) <= rsize (positive) because both
variables were signed.

Make variables unsigned to avoid this problem.

The reproducer linked below now fails with the following error instead
of a null pointer deref:
9pnet: bogus RWRITE count (4294967295 > 3)

Reported-by: Robert Morris <rtm@mit.edu>
Closes: https://lore.kernel.org/16271.1734448631@26-5-164.dynamic.csail.mit.edu
Message-ID: <20250319-9p_unsigned_rw-v3-1-71327f1503d0@codewreck.org>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/client.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 09f8ced9f8bb7..52a5497cfca79 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1548,7 +1548,8 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 	struct p9_client *clnt = fid->clnt;
 	struct p9_req_t *req;
 	int count = iov_iter_count(to);
-	int rsize, received, non_zc = 0;
+	u32 rsize, received;
+	bool non_zc = false;
 	char *dataptr;
 
 	*err = 0;
@@ -1571,7 +1572,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 				       0, 11, "dqd", fid->fid,
 				       offset, rsize);
 	} else {
-		non_zc = 1;
+		non_zc = true;
 		req = p9_client_rpc(clnt, P9_TREAD, "dqd", fid->fid, offset,
 				    rsize);
 	}
@@ -1592,11 +1593,11 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		return 0;
 	}
 	if (rsize < received) {
-		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
+		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
 		received = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", received);
+	p9_debug(P9_DEBUG_9P, "<<< RREAD count %u\n", received);
 
 	if (non_zc) {
 		int n = copy_to_iter(dataptr, received, to);
@@ -1623,9 +1624,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	*err = 0;
 
 	while (iov_iter_count(from)) {
-		int count = iov_iter_count(from);
-		int rsize = fid->iounit;
-		int written;
+		size_t count = iov_iter_count(from);
+		u32 rsize = fid->iounit;
+		u32 written;
 
 		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
 			rsize = clnt->msize - P9_IOHDRSZ;
@@ -1633,7 +1634,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		if (count < rsize)
 			rsize = count;
 
-		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
+		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %u (/%zu)\n",
 			 fid->fid, offset, rsize, count);
 
 		/* Don't bother zerocopy for small IO (< 1024) */
@@ -1659,11 +1660,11 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			break;
 		}
 		if (rsize < written) {
-			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
+			pr_err("bogus RWRITE count (%u > %u)\n", written, rsize);
 			written = rsize;
 		}
 
-		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", written);
+		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %u\n", written);
 
 		p9_req_put(clnt, req);
 		iov_iter_revert(from, count - written - iov_iter_count(from));
@@ -2098,7 +2099,8 @@ EXPORT_SYMBOL_GPL(p9_client_xattrcreate);
 
 int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 {
-	int err, rsize, non_zc = 0;
+	int err, non_zc = 0;
+	u32 rsize;
 	struct p9_client *clnt;
 	struct p9_req_t *req;
 	char *dataptr;
@@ -2107,7 +2109,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 
 	iov_iter_kvec(&to, ITER_DEST, &kv, 1, count);
 
-	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
+	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %u\n",
 		 fid->fid, offset, count);
 
 	clnt = fid->clnt;
@@ -2142,11 +2144,11 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 		goto free_and_error;
 	}
 	if (rsize < count) {
-		pr_err("bogus RREADDIR count (%d > %d)\n", count, rsize);
+		pr_err("bogus RREADDIR count (%u > %u)\n", count, rsize);
 		count = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %d\n", count);
+	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %u\n", count);
 
 	if (non_zc)
 		memmove(data, dataptr, count);
-- 
2.39.5


