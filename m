Return-Path: <stable+bounces-87554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE49A6963
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BFF1F22B50
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A41E8841;
	Mon, 21 Oct 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DmA+F3s9"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F41D1E9F
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515608; cv=none; b=jBqfHNaKTJoWjfUCZB9wGpgysWBQv6d/RXmIywjRJcLCsAwG3ZkfmbIx2L8Xslqx1ro95NkDZpiv0l1Zsxpesf82xt7cJEG70DUn8d+ajJ9XmPLn1nZhNn9dHAvjT9xSSH9S3J4EH4mDgsbBUweojLK7/wX3ijnA5T6Wvpbj6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515608; c=relaxed/simple;
	bh=GARdp70yvURA2iZ0BI591v73U712ryU6EX0XnYuzTmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEJDGhHewhfVF/CPZkuNpvnjt4KuKyP4KnQchKAGhNvLrPgWU9AaeFLB14WqP3Mchnd/tWkUaiy/Q9YedLUQHxCByKT6fqMOriUWCSAo+3u32tymptAK3BL67Amq+ByLp1fQ5R6rtjzQz8x5G1/W8ltIScKlXVSmUPTZ3sX6rOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DmA+F3s9; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hYcy7oXdllXHw//tNKpnNP1mE4JLQadm24jSsZ6IZyk=; b=DmA+F3s9YtPMTBdcLhbqxBQ7Eg
	GPe6MnTrPTGRs4ecYB2kAU0iayrKUJyiv8qYWKVVk3j1swfRh66NKi+iW/ik7WKJqW+w3Joq79Ofg
	70v3sV8iQp+xfA2ovtVvp2Hpt+/AvL4iqfPOfGR6LHIwIksqqRRzBBNZxqryv8ARZP0oOsBgUQyW7
	0flS6hxsHJMWsNU7H/KRXcyV+yniWAYn9Jpoj/KwF4BAszTn9cZdwO7i5LFt7j4MAqIObO0EVmsGi
	zdOJucqUXTohHMKrzXTTTKmsElYEnlm/r7SFrP1LPzBmnKjR+ERVDBRBFjxZRMzP9Y9S0cHOcXxdy
	KYcnudXA==;
Received: from [187.43.135.173] (helo=quatroqueijos..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t2s0r-00D9zS-Ot; Mon, 21 Oct 2024 14:59:58 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.10 1/1] splice: don't generate zero-len segement bvecs
Date: Mon, 21 Oct 2024 09:59:42 -0300
Message-Id: <20241021125942.2090200-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021125942.2090200-1-cascardo@igalia.com>
References: <20241021125942.2090200-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 0f1d344feb534555a0dcd0beafb7211a37c5355e ]

iter_file_splice_write() may spawn bvec segments with zero-length. In
preparation for prohibiting them, filter out by hand at splice level.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/splice.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 866d5c2367b2..474fb8b5562a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -662,12 +662,14 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* build the vector */
 		left = sd.total_len;
-		for (n = 0; !pipe_empty(head, tail) && left && n < nbufs; tail++, n++) {
+		for (n = 0; !pipe_empty(head, tail) && left && n < nbufs; tail++) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t this_len = buf->len;
 
-			if (this_len > left)
-				this_len = left;
+			/* zero-length bvecs are not supported, skip them */
+			if (!this_len)
+				continue;
+			this_len = min(this_len, left);
 
 			ret = pipe_buf_confirm(pipe, buf);
 			if (unlikely(ret)) {
@@ -680,6 +682,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 			array[n].bv_len = this_len;
 			array[n].bv_offset = buf->offset;
 			left -= this_len;
+			n++;
 		}
 
 		iov_iter_bvec(&from, WRITE, array, n, sd.total_len - left);
-- 
2.34.1


