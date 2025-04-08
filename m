Return-Path: <stable+bounces-130087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47164A80286
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80D67AA58F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB66268FE5;
	Tue,  8 Apr 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vPUbvTJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699EB267F5B;
	Tue,  8 Apr 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112780; cv=none; b=PS49fVkhCBRKk8aV3B6S2lqH78J5hMKkwCQnuytyY+5m6+0IAlyQkkvQ6tZls8/BYLb3ReiuIHk3iQxE+KVDDO6smapEK+PQR/zn7qg3vbofdXCr4Bzp7SgJ8ZVBqJhfdjdZeqhx+iPlCYkJRKfuONQ87hwE6B53nNsWBjUjHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112780; c=relaxed/simple;
	bh=eGewagAdoXJTfbeT9DxZEDJQywXQd0rUlxKxxLEPWAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwmlidwXXDlyeqswLwcPLL8mpHEH3cIAmk2JmAuG5ReHeG1TszrYcoOeSteC7Nb87i5QGfkD26YOlsDcJ4i951e/qXbFAEdNamvThz1OXI/cCr+WIVBprRwqmiOg7043ttc9onEFD9pJ9ihQ0VLIXj5/UMlXijdT5sDdmZNpisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vPUbvTJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC8DC4CEE5;
	Tue,  8 Apr 2025 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112780;
	bh=eGewagAdoXJTfbeT9DxZEDJQywXQd0rUlxKxxLEPWAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPUbvTJlYt8RwlR66yGdeXzmdgYDleo1+OmVdHeLxuumuRA/0UuVyAi5Rk8YHxVmf
	 fkyn+MROBs50GhGDHOsdCi6NNeQ/5ac5k+LfR3NgaZfw9hA5xudIkN812tpTh+w+xc
	 ma7TU+mfyjJJfDJXWHu/7NIgPB/MGYgB+ccfzMwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 194/279] isofs: fix KMSAN uninit-value bug in do_isofs_readdir()
Date: Tue,  8 Apr 2025 12:49:37 +0200
Message-ID: <20250408104831.572130281@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

[ Upstream commit 81a82e8f33880793029cd6f8a766fb13b737e6a7 ]

In do_isofs_readdir() when assigning the variable
"struct iso_directory_record *de" the b_data field of the buffer_head
is accessed and an offset is added to it, the size of b_data is 2048
and the offset size is 2047, meaning
"de = (struct iso_directory_record *) (bh->b_data + offset);"
yields the final byte of the 2048 sized b_data block.

The first byte of the directory record (de_len) is then read and
found to be 31, meaning the directory record size is 31 bytes long.
The directory record is defined by the structure:

	struct iso_directory_record {
		__u8 length;                     // 1 byte
		__u8 ext_attr_length;            // 1 byte
		__u8 extent[8];                  // 8 bytes
		__u8 size[8];                    // 8 bytes
		__u8 date[7];                    // 7 bytes
		__u8 flags;                      // 1 byte
		__u8 file_unit_size;             // 1 byte
		__u8 interleave;                 // 1 byte
		__u8 volume_sequence_number[4];  // 4 bytes
		__u8 name_len;                   // 1 byte
		char name[];                     // variable size
	} __attribute__((packed));

The fixed portion of this structure occupies 33 bytes. Therefore, a
valid directory record must be at least 33 bytes long
(even without considering the variable-length name field).
Since de_len is only 31, it is insufficient to contain
the complete fixed header.

The code later hits the following sanity check that
compares de_len against the sum of de->name_len and
sizeof(struct iso_directory_record):

	if (de_len < de->name_len[0] + sizeof(struct iso_directory_record)) {
		...
	}

Since the fixed portion of the structure is
33 bytes (up to and including name_len member),
a valid record should have de_len of at least 33 bytes;
here, however, de_len is too short, and the field de->name_len
(located at offset 32) is accessed even though it lies beyond
the available 31 bytes.

This access on the corrupted isofs data triggers a KASAN uninitialized
memory warning. The fix would be to first verify that de_len is at least
sizeof(struct iso_directory_record) before accessing any
fields like de->name_len.

Reported-by: syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=812641c6c3d7586a1613
Fixes: 2deb1acc653c ("isofs: fix access to unallocated memory when reading corrupted filesystem")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250211195900.42406-1-qasdev00@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/isofs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index eb2f8273e6f15..09df40b612fbf 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -147,7 +147,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 			de = tmpde;
 		}
 		/* Basic sanity check, whether name doesn't exceed dir entry */
-		if (de_len < de->name_len[0] +
+		if (de_len < sizeof(struct iso_directory_record) ||
+		    de_len < de->name_len[0] +
 					sizeof(struct iso_directory_record)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %lu\n", block,
-- 
2.39.5




