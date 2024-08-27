Return-Path: <stable+bounces-70398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58261960DE5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6761C231BB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DD51C578D;
	Tue, 27 Aug 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NY3TPl/2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B473466;
	Tue, 27 Aug 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769766; cv=none; b=euA5K4hA98u+Cd10A7/0TldHGfVxxOEFcF9oiditEpBTgTRHeKqdRUTxnrNpFovNv46SArhb4cncOAQQPd9GC4y1Ech30FGHKgaMLHjlodlhIiANBFQxCybglxat49BFawuz9160anegViWfEA4F87KYNnDouG8+KcfaCizR+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769766; c=relaxed/simple;
	bh=BaptlAA+4C8dTiklCfkFUes6V7YaVRKvt8jztRr8BH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiPGq4gLUbhErmjFfDu+aa+FfBEW6Px1iA3nKEKJ02axqC/gePHwotXw0ri819B9jXzjPr3IXA9zolwyr8daZn9N9iwg1+yny5qBERbvu+7uVSE3Yq7xFRpPDg7VqrvhTEcb0r1De+KAWEOL65nYmL0rxJMBjXYQniu52REoQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NY3TPl/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93593C6104B;
	Tue, 27 Aug 2024 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724769766;
	bh=BaptlAA+4C8dTiklCfkFUes6V7YaVRKvt8jztRr8BH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NY3TPl/2ToifP7hYhQe2j9Yt30uiXY+vw4wCJVplX34s1G5qtrcsT8LD0S8wLhgqn
	 BdxqA2VzmKNZx+gddhbE2J1uSO6/iKsbbLZCX+/uCQM8QDLUzaQYBtGceflHWLoHOK
	 FlE2EWRpBwkkBzCfFp1f8K9YGW9SR2ELr8HPZVhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6.6 030/341] fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
Date: Tue, 27 Aug 2024 16:34:21 +0200
Message-ID: <20240827143844.556609892@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
 fs/file.c                                       |   28 ++++++++-----------
 include/linux/bitmap.h                          |   12 ++++++++
 tools/testing/selftests/core/close_range_test.c |   35 ++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 16 deletions(-)

--- a/fs/file.c
+++ b/fs/file.c
@@ -46,27 +46,23 @@ static void free_fdtable_rcu(struct rcu_
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
@@ -84,7 +80,7 @@ static void copy_fdtable(struct fdtable
 	memcpy(nfdt->fd, ofdt->fd, cpy);
 	memset((char *)nfdt->fd + cpy, 0, set);
 
-	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
 }
 
 /*
@@ -374,7 +370,7 @@ struct files_struct *dup_fd(struct files
 		open_files = sane_fdtable_size(old_fdt, max_fds);
 	}
 
-	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -281,6 +281,18 @@ static inline void bitmap_copy_clear_tai
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
  * On 32-bit systems bitmaps are represented as u32 arrays internally. On LE64
  * machines the order of hi and lo parts of numbers match the bitmap structure.
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -563,4 +563,39 @@ TEST(close_range_cloexec_unshare_syzbot)
 	EXPECT_EQ(close(fd3), 0);
 }
 
+TEST(close_range_bitmap_corruption)
+{
+	pid_t pid;
+	int status;
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	/* get the first 128 descriptors open */
+	for (int i = 2; i < 128; i++)
+		EXPECT_GE(dup2(0, i), 0);
+
+	/* get descriptor table shared */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* unshare and truncate descriptor table down to 64 */
+		if (sys_close_range(64, ~0U, CLOSE_RANGE_UNSHARE))
+			exit(EXIT_FAILURE);
+
+		ASSERT_EQ(fcntl(64, F_GETFD), -1);
+		/* ... and verify that the range 64..127 is not
+		   stuck "fully used" according to secondary bitmap */
+		EXPECT_EQ(dup(0), 64)
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 TEST_HARNESS_MAIN



