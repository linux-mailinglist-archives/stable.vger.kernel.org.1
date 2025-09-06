Return-Path: <stable+bounces-177959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA2EB46E17
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410695A41B3
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B82F28ED;
	Sat,  6 Sep 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiF71iWp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD314A0B5
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165196; cv=none; b=b8/1A+mVWIchp/qvgwOog2bTqXxYH8jGJhKDgwAgSsjI6unQ+ttlcSaxzuvU7MHYphBfRQ4ET6dTdylK4KPcWyRSxTk6inHVRmIs6SQuIjnyq3/6sVy7EBAkWqdw6Loex7RSryepOUfWXkqmww67UBGGAGTd/wI+HBvj8mo76yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165196; c=relaxed/simple;
	bh=EuZQUZ3jhPKBaWcT98RG8ebSa6FgkRhlACjDnPAWJFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrsV+4WEosxXkoYUnAekgxQgaSJoiL8YPPMP7omOBIoqbbTKMAahzZBdTRV6RZHX2qdWuOIASgI7rKNliz1ufRhHAtHWWIPSgN9iRlyTrI55ms4cIf2q6jfExylKgOeIl1RQclQUJ55g3RVUIriv8YtbDiK92rQuMFcY7FhM9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiF71iWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BC1C4CEE7;
	Sat,  6 Sep 2025 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757165195;
	bh=EuZQUZ3jhPKBaWcT98RG8ebSa6FgkRhlACjDnPAWJFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiF71iWpEwM5eWk+VZaug9G+A7fL0FV5jvAcig9baHZJVge+tFnx3tQ2Hlu+crMke
	 Ezm9lPZrtFh9pUqjmWZhrboN+dq8qj4HO2W0T2IuM4hIkyEqBGGyNDdRQ/xKp/c2U5
	 31bKzNFdyVzCZnJICyMxeXrM1baHLQvHXC1LOqEoLwVqU88RbxiwLuwgxtDXR4thKe
	 v0qd/ifhreKBjKPqIj+o5vu5x0JtbhMik8SQXQuTcvvq5gWfRWtbGjiEo1NIOoe1FT
	 ERD2ZDZAJWc4pCppj1f9+3nt8tElLGmv7ug0fuJeguSXjgBjH4SwclzFDue4MT7ZEi
	 JjovYYv5Eqn0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: adjust subpage bit start based on sectorsize
Date: Sat,  6 Sep 2025 09:26:32 -0400
Message-ID: <20250906132632.3892771-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025050512-showpiece-rehab-9f57@gregkh>
References: <2025050512-showpiece-rehab-9f57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit e08e49d986f82c30f42ad0ed43ebbede1e1e3739 ]

When running machines with 64k page size and a 16k nodesize we started
seeing tree log corruption in production.  This turned out to be because
we were not writing out dirty blocks sometimes, so this in fact affects
all metadata writes.

When writing out a subpage EB we scan the subpage bitmap for a dirty
range.  If the range isn't dirty we do

	bit_start++;

to move onto the next bit.  The problem is the bitmap is based on the
number of sectors that an EB has.  So in this case, we have a 64k
pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is 4
bits for every node.  With a 64k page size we end up with 4 nodes per
page.

To make this easier this is how everything looks

[0         16k       32k       48k     ] logical address
[0         4         8         12      ] radix tree offset
[               64k page               ] folio
[ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
[ | | | |  | | | |   | | | |   | | | | ] bitmap

Now we use all of our addressing based on fs_info->sectorsize_bits, so
as you can see the above our 16k eb->start turns into radix entry 4.

When we find a dirty range for our eb, we correctly do bit_start +=
sectors_per_node, because if we start at bit 0, the next bit for the
next eb is 4, to correspond to eb->start 16k.

However if our range is clean, we will do bit_start++, which will now
put us offset from our radix tree entries.

In our case, assume that the first time we check the bitmap the block is
not dirty, we increment bit_start so now it == 1, and then we loop
around and check again.  This time it is dirty, and we go to find that
start using the following equation

	start = folio_start + bit_start * fs_info->sectorsize;

so in the case above, eb->start 0 is now dirty, and we calculate start
as

	0 + 1 * fs_info->sectorsize = 4096
	4096 >> 12 = 1

Now we're looking up the radix tree for 1, and we won't find an eb.
What's worse is now we're using bit_start == 1, so we do bit_start +=
sectors_per_node, which is now 5.  If that eb is dirty we will run into
the same thing, we will look at an offset that is not populated in the
radix tree, and now we're skipping the writeout of dirty extent buffers.

The best fix for this is to not use sectorsize_bits to address nodes,
but that's a larger change.  Since this is a fs corruption problem fix
it simply by always using sectors_per_node to increment the start bit.

Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ed08d8e5639f5..48b06459bc485 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1742,7 +1742,7 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
 			spin_unlock(&page->mapping->private_lock);
-			bit_start++;
+			bit_start += sectors_per_node;
 			continue;
 		}
 
-- 
2.51.0


