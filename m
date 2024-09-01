Return-Path: <stable+bounces-72054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AA9678FA
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA6BB21752
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584DC17DFFC;
	Sun,  1 Sep 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jD27Ico"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AFE1C68C;
	Sun,  1 Sep 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208689; cv=none; b=HiA29ToH5c+Kse7mMrfJ+IX0ZJ5Dy2jQtPhnZwlx/lqigLzSTVxdKBNfy+rJ52BW2ppPbONp7i2sQJ7Swh2jjEvoE+JHpBEvIQLVvoahfVzEibmJt7TbUZetEnqFXaT2Z7XXoGBg9Ptc8A2IlXEVzrx1S5ri9+dIO7xrVpPBb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208689; c=relaxed/simple;
	bh=ZuvHzXzO/TioRdHCMYz0wPvl8mZlMFY5B7ksXvcYvJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhHSP/b8vNr+NFDFkahMw6mUXUlTPq+BqF9ZOoMuk65mqZiUAt+xLnNzXLS98kweamNZ3QbrnF3Vz5WiVJcKQcF8XDuE3nfhgkJ507KIJrndMieed+BBNONOSwMwV7oGG26gmCC3g0UA+gRV20Wbpx1ZO3ntSi9vc0/p1jUt5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jD27Ico; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B0C4CEC3;
	Sun,  1 Sep 2024 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208689;
	bh=ZuvHzXzO/TioRdHCMYz0wPvl8mZlMFY5B7ksXvcYvJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2jD27IcopLXAFMaGNT+m4yw1ywp/K31QeAwROvHhzmvzozi0B6hSnbA3Pi0QjaFGt
	 VaHvRJ8nWVXmfG03p58e9VkFNdseklgywZ2mY3V4sDO7KtkIn54Cv6OngWtAQye7S7
	 pS6a47qi+Sg2rwAZOvvwv5VWcs8xihM6RkQma7L4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5.4 010/134] fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
Date: Sun,  1 Sep 2024 18:15:56 +0200
Message-ID: <20240901160810.499998989@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
References: <20240901160809.752718937@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 9a2fa1472083580b6c66bdaf291f591e1170123a upstream.

copy_fd_bitmaps(new, old, count) is expected to copy the first
count/BITS_PER_LONG bits from old->full_fds_bits[] and fill
the rest with zeroes.  What it does is copying enough words
(BITS_TO_LONGS(count/BITS_PER_LONG)), then memsets the rest.
That works fine, *if* all bits past the cutoff point are
clear.  Otherwise we are risking garbage from the last word
we'd copied.

For most of the callers that is true - expand_fdtable() has
count equal to old->max_fds, so there's no open descriptors
past count, let alone fully occupied words in ->open_fds[],
which is what bits in ->full_fds_bits[] correspond to.

The other caller (dup_fd()) passes sane_fdtable_size(old_fdt, max_fds),
which is the smallest multiple of BITS_PER_LONG that covers all
opened descriptors below max_fds.  In the common case (copying on
fork()) max_fds is ~0U, so all opened descriptors will be below
it and we are fine, by the same reasons why the call in expand_fdtable()
is safe.

Unfortunately, there is a case where max_fds is less than that
and where we might, indeed, end up with junk in ->full_fds_bits[] -
close_range(from, to, CLOSE_RANGE_UNSHARE) with
	* descriptor table being currently shared
	* 'to' being above the current capacity of descriptor table
	* 'from' being just under some chunk of opened descriptors.
In that case we end up with observably wrong behaviour - e.g. spawn
a child with CLONE_FILES, get all descriptors in range 0..127 open,
then close_range(64, ~0U, CLOSE_RANGE_UNSHARE) and watch dup(0) ending
up with descriptor #128, despite #64 being observably not open.

The minimally invasive fix would be to deal with that in dup_fd().
If this proves to add measurable overhead, we can go that way, but
let's try to fix copy_fd_bitmaps() first.

* new helper: bitmap_copy_and_expand(to, from, bits_to_copy, size).
* make copy_fd_bitmaps() take the bitmap size in words, rather than
bits; it's 'count' argument is always a multiple of BITS_PER_LONG,
so we are not losing any information, and that way we can use the
same helper for all three bitmaps - compiler will see that count
is a multiple of BITS_PER_LONG for the large ones, so it'll generate
plain memcpy()+memset().

Reproducer added to tools/testing/selftests/core/close_range_test.c

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/file.c              |   28 ++++++++++++----------------
 include/linux/bitmap.h |   12 ++++++++++++
 2 files changed, 24 insertions(+), 16 deletions(-)

--- a/fs/file.c
+++ b/fs/file.c
@@ -41,27 +41,23 @@ static void free_fdtable_rcu(struct rcu_
 #define BITBIT_NR(nr)	BITS_TO_LONGS(BITS_TO_LONGS(nr))
 #define BITBIT_SIZE(nr)	(BITBIT_NR(nr) * sizeof(long))
 
+#define fdt_words(fdt) ((fdt)->max_fds / BITS_PER_LONG) // words in ->open_fds
 /*
  * Copy 'count' fd bits from the old table to the new table and clear the extra
  * space if any.  This does not copy the file pointers.  Called with the files
  * spinlock held for write.
  */
-static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
-			    unsigned int count)
+static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
+			    unsigned int copy_words)
 {
-	unsigned int cpy, set;
+	unsigned int nwords = fdt_words(nfdt);
 
-	cpy = count / BITS_PER_BYTE;
-	set = (nfdt->max_fds - count) / BITS_PER_BYTE;
-	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
-	memset((char *)nfdt->open_fds + cpy, 0, set);
-	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
-	memset((char *)nfdt->close_on_exec + cpy, 0, set);
-
-	cpy = BITBIT_SIZE(count);
-	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
-	memcpy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
-	memset((char *)nfdt->full_fds_bits + cpy, 0, set);
+	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
+			copy_words, nwords);
 }
 
 /*
@@ -79,7 +75,7 @@ static void copy_fdtable(struct fdtable
 	memcpy(nfdt->fd, ofdt->fd, cpy);
 	memset((char *)nfdt->fd + cpy, 0, set);
 
-	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
 }
 
 static struct fdtable * alloc_fdtable(unsigned int nr)
@@ -330,7 +326,7 @@ struct files_struct *dup_fd(struct files
 		open_files = count_open_files(old_fdt);
 	}
 
-	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -248,6 +248,18 @@ static inline void bitmap_copy_clear_tai
 		dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
 }
 
+static inline void bitmap_copy_and_extend(unsigned long *to,
+					  const unsigned long *from,
+					  unsigned int count, unsigned int size)
+{
+	unsigned int copy = BITS_TO_LONGS(count);
+
+	memcpy(to, from, copy * sizeof(long));
+	if (count % BITS_PER_LONG)
+		to[copy - 1] &= BITMAP_LAST_WORD_MASK(count);
+	memset(to + copy, 0, bitmap_size(size) - copy * sizeof(long));
+}
+
 /*
  * On 32-bit systems bitmaps are represented as u32 arrays internally, and
  * therefore conversion is not needed when copying data from/to arrays of u32.



