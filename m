Return-Path: <stable+bounces-19710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD985318E
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB1FB23293
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089455776;
	Tue, 13 Feb 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pcFd190R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173E55765
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830203; cv=none; b=fXmnACvCw8mSApte+1rV19xxxn+Xei8aHlF+Pk6lBDxmc/nhN+LjHBgitYmTfjVf8pk7PL9zMKh0nlLu7lu2JIwOphwABjfTIDwcwd9tyU35NwwIVWKPv2oObqHjr+KgqRt6vC3PWyHS1wiu45fG8ZtOl6BF2KaikDuG+qmE+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830203; c=relaxed/simple;
	bh=EW95ZBjSr3jWR6/q5X7UfOdsV0YEgFJVBXILrXjbWzg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SDm6DF2UZ3smbBvnkC7oWl4fwYA2w4rgHhJvtbmT7ZF6lk98spsnMl9sywdVQ6uI5VLOBi5F/BV0EAo/hIQ6ajeq1QGEs+7dIV7OPJwkTY3FsgPEPJGYCfGGSOfe20DgnXPFXR9TMAnyDNQxjFeopF9Lo71NSV1S1XRB4C9hzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pcFd190R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7309C43390;
	Tue, 13 Feb 2024 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707830202;
	bh=EW95ZBjSr3jWR6/q5X7UfOdsV0YEgFJVBXILrXjbWzg=;
	h=Subject:To:Cc:From:Date:From;
	b=pcFd190RSxDwKATHfH5qGNX3sAtAGzoUCIuPzORLRYY7Q50Eapa3wWgUwlF5DDi9P
	 CJgyZhTMuTlsHS4AjU7NOV7JRG18DW9yQ5Vcd6V4tEa4CFOZ50PGjFcb+H3YIUzX6j
	 vtOCF/L04H/811moNwbrqlo9pAtsMQAAuHxUXCDI=
Subject: FAILED: patch "[PATCH] io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL" failed to apply to 5.15-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2024 14:16:39 +0100
Message-ID: <2024021339-flick-facsimile-65c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 72bd80252feeb3bef8724230ee15d9f7ab541c6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021339-flick-facsimile-65c3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

72bd80252fee ("io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buffers")
f9ead18c1058 ("io_uring: split network related opcodes into its own file")
e0da14def1ee ("io_uring: move statx handling to its own file")
a9c210cebe13 ("io_uring: move epoll handler to its own file")
4cf90495281b ("io_uring: add a dummy -EOPNOTSUPP prep handler")
99f15d8d6136 ("io_uring: move uring_cmd handling to its own file")
cd40cae29ef8 ("io_uring: split out open/close operations")
453b329be5ea ("io_uring: separate out file table handling code")
f4c163dd7d4b ("io_uring: split out fadvise/madvise operations")
0d5847274037 ("io_uring: split out fs related sync/fallocate functions")
531113bbd5bf ("io_uring: split out splice related operations")
11aeb71406dd ("io_uring: split out filesystem related operations")
e28683bdfc2f ("io_uring: move nop into its own file")
5e2a18d93fec ("io_uring: move xattr related opcodes to its own file")
97b388d70b53 ("io_uring: handle completions in the core")
de23077eda61 ("io_uring: set completion results upfront")
e27f928ee1cb ("io_uring: add io_uring_types.h")
4d4c9cff4f70 ("io_uring: define a request type cleanup handler")
890968dc0336 ("io_uring: unify struct io_symlink and io_hardlink")
9a3a11f977f9 ("io_uring: convert iouring_cmd to io_cmd_type")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72bd80252feeb3bef8724230ee15d9f7ab541c6e Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 1 Feb 2024 06:42:36 -0700
Subject: [PATCH] io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL
 and buffers

If we use IORING_OP_RECV with provided buffers and pass in '0' as the
length of the request, the length is retrieved from the selected buffer.
If MSG_WAITALL is also set and we get a short receive, then we may hit
the retry path which decrements sr->len and increments the buffer for
a retry. However, the length is still zero at this point, which means
that sr->len now becomes huge and import_ubuf() will cap it to
MAX_RW_COUNT and subsequently return -EFAULT for the range as a whole.

Fix this by always assigning sr->len once the buffer has been selected.

Cc: stable@vger.kernel.org
Fixes: 7ba89d2af17a ("io_uring: ensure recv and recvmsg handle MSG_WAITALL correctly")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index a12ff69e6843..43bc9a5f96f9 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -923,6 +923,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		if (!buf)
 			return -ENOBUFS;
 		sr->buf = buf;
+		sr->len = len;
 	}
 
 	ret = import_ubuf(ITER_DEST, sr->buf, len, &msg.msg_iter);


