Return-Path: <stable+bounces-131320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C854A808B1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857E37B2425
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51926AAB7;
	Tue,  8 Apr 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="igkJElnS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE811AAA32;
	Tue,  8 Apr 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116078; cv=none; b=ROl0zRr4sPlWRRYKfzq6/lO/rimA6LhAyhB5F+N8R0YeuaAES21dVtrnR/FQSGbPjCcwlBp3aF/SmO5vFMI5zVKvFQ7Gu9bZvjruGcZsk7K5Xkmfljx8+DOMk0DlslECyWElK/9tUQwc+I2Rz3N16HTBxdv81bsDWm00bde42jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116078; c=relaxed/simple;
	bh=PDDpIJOYb+ievQrx8gTeZemQm5nI+wyFb50vgO7ewcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swz2juCLO8la8hqn+YEC3HXxX/0hKFzKB9uWOeIrPyvO22JQnro/vNsGKGXUD4Yok0Qkrf25T+35+UdOZQKei8oCPwHh526UeSrw+il10qgazzmwj/kRXjO6eFJMdEdlMwdvWac4FBPPvVJLPGIBhV5yxW2ocu0+C9jV3Ms2dyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=igkJElnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F62C4CEF6;
	Tue,  8 Apr 2025 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116078;
	bh=PDDpIJOYb+ievQrx8gTeZemQm5nI+wyFb50vgO7ewcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igkJElnSGN71KeLUxBwAnCrXnfnrjzfMUYGl23LXX/uoLYf6VRlx100s6T/WOaJkW
	 wQ7WONadejVxoXvv2wafD0ZTt2UYzrQtWaXp8YvM6nsIS51WjdZp2txKHPDs01bOhf
	 h7bfnU5LXjq25tLu6Beg+Fz0+DjhY5E7zbTQCFuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH 6.1 200/204] jfs: fix slab-out-of-bounds read in ea_get()
Date: Tue,  8 Apr 2025 12:52:10 +0200
Message-ID: <20250408104826.188553058@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Qasim Ijaz <qasdev00@gmail.com>

commit fdf480da5837c23b146c4743c18de97202fcab37 upstream.

During the "size_check" label in ea_get(), the code checks if the extended
attribute list (xattr) size matches ea_size. If not, it logs
"ea_get: invalid extended attribute" and calls print_hex_dump().

Here, EALIST_SIZE(ea_buf->xattr) returns 4110417968, which exceeds
INT_MAX (2,147,483,647). Then ea_size is clamped:

	int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));

Although clamp_t aims to bound ea_size between 0 and 4110417968, the upper
limit is treated as an int, causing an overflow above 2^31 - 1. This leads
"size" to wrap around and become negative (-184549328).

The "size" is then passed to print_hex_dump() (called "len" in
print_hex_dump()), it is passed as type size_t (an unsigned
type), this is then stored inside a variable called
"int remaining", which is then assigned to "int linelen" which
is then passed to hex_dump_to_buffer(). In print_hex_dump()
the for loop, iterates through 0 to len-1, where len is
18446744073525002176, calling hex_dump_to_buffer()
on each iteration:

	for (i = 0; i < len; i += rowsize) {
		linelen = min(remaining, rowsize);
		remaining -= rowsize;

		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
				   linebuf, sizeof(linebuf), ascii);

		...
	}

The expected stopping condition (i < len) is effectively broken
since len is corrupted and very large. This eventually leads to
the "ptr+i" being passed to hex_dump_to_buffer() to get closer
to the end of the actual bounds of "ptr", eventually an out of
bounds access is done in hex_dump_to_buffer() in the following
for loop:

	for (j = 0; j < len; j++) {
			if (linebuflen < lx + 2)
				goto overflow2;
			ch = ptr[j];
		...
	}

To fix this we should validate "EALIST_SIZE(ea_buf->xattr)"
before it is utilised.

Reported-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=4e6e7e4279d046613bc5
Fixes: d9f9d96136cb ("jfs: xattr: check invalid xattr size more strictly")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jfs/xattr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -559,11 +559,16 @@ static int ea_get(struct inode *inode, s
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
-		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
+		if (unlikely(EALIST_SIZE(ea_buf->xattr) > INT_MAX)) {
+			printk(KERN_ERR "ea_get: extended attribute size too large: %u > INT_MAX\n",
+			       EALIST_SIZE(ea_buf->xattr));
+		} else {
+			int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
 
-		printk(KERN_ERR "ea_get: invalid extended attribute\n");
-		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, size, 1);
+			printk(KERN_ERR "ea_get: invalid extended attribute\n");
+			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
+				       ea_buf->xattr, size, 1);
+		}
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;



