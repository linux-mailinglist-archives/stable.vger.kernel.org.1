Return-Path: <stable+bounces-134798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A4A951BE
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50323A4A54
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1A264A74;
	Mon, 21 Apr 2025 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="R9poRvbc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06413C918
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242678; cv=none; b=aIAQzQvwPhH/PyDWRK3BPFywTW9fZeXyX8v+FuX0YdOfoZYPgiGb5pP9XOjRIpgph8WP51UYdtfBgr2rdBksgwgnz4XUCImX/In2KsHUpAQuYr5xzEaVy0E+KYaNnR/wtFcGnQ3hMQa+En0y0PPzCHsCDEI2ouQ4U0fh8Mp2368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242678; c=relaxed/simple;
	bh=1TSsA8Kh2gn7NONwtN7E8Ied5rqj8SdO5IR6kFZLu3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkHCRv+1hPurn2B0cc4roDZPeYyyQbDwCgBasdUVkQQ9KqtmL9dbFoQacSKKqvEZfmMtKWZFGaTuWnSH5+vN+bOatKu9PWrbvxwoVZjVXM72DDYnX6wlrf+5s3JIQGAjXHiiK7vXgHYrUwuTPFWhGpULLbfRIxr8Kek/5SwZww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=R9poRvbc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7042ac0f4d6so34403907b3.1
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745242675; x=1745847475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/W+y9jkPyQT+cXxIrE/qHvHK+gsgO/zJ0x2ACvqvAgU=;
        b=R9poRvbciUVMTTqB4f4EeDWsbDuBAWKrgNzS8gLirA61r8Hn+kIJ9pQdTvJn7sZQHE
         Q5FQ0JhnUmzg8bN8aLXO4/aaYdP01F9nVg6pJ2yu93rKXmR61OGCFb4fgrTKaG6fYeXq
         Yk594sZaHkaxj1fKNfcwDvootyZxkCNCBubpAPLhKowuEGJgF8utBR3kghIjtZwKPyBZ
         OzuZ7EYyzFnmvXTaF7/Vwxr8d266cwJL8g8vRwdmVwuV2z5sgMFCLUDWwspXZgQdjHWf
         q/NI6x1hWI0yGzf3E2UZDK8qKZNXPX3BSDcWE8lASumJMqBu5f6Sm0ebmsxbdMSC0ie5
         gDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745242675; x=1745847475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/W+y9jkPyQT+cXxIrE/qHvHK+gsgO/zJ0x2ACvqvAgU=;
        b=Dq8EYe9ktQDIS+hA94wz01jXiG9CyWhfBh1/mUPU7iZvHf9YaHPKTnyUVEyUz2vpBm
         +oOu9nT6vzwizaQjrFyIXSu5l9p6vm/Q4wnp9qwswe7bryo2xuK7/1vn9EGNcSx0q3oR
         3/dvpch0wX0gsrHk7bMvo8kIYmJ7FqY4zmp4qz6bNDNJdJXqV63lASSyTZzocJ0yy7aL
         vXlbwBKkhrrZJjzxlW9nref+5p2ICkPNiHCyTZmODtUFR0WB1a9x7V3tt0zfXYq0tFKM
         zOu8yv4gQaHHnWG79IQMVuI0bMbr8yrT5YlhZFWr9b5K1ji75K/uscLy4kmZWjNlR8Vq
         5Fgw==
X-Gm-Message-State: AOJu0YwuBfSajTI0Gis/m3lsEyjgy0cUD6gQDPFbQzx19m+u/RHZO9wM
	iSkK24yiruqs4pdmcnmiGVQyXsTmKor6CbIs1n+Ktnhj9VLyeHjBtHEy2RMdVdMiQg2WAgfuxpg
	B2Isu2w==
X-Gm-Gg: ASbGnct9fkU43YpCA/tfdJLSyXyoDvw0F3YKVpt8tEAcD2K1hv9X/H/cwCwy63JB1ax
	o4/Yzg6a+mn3acYsQ7XHNLZd4n2lFnDlDyyYji4crtsV9qFG/3kRLoiF9I/CjzVx0nOl63kYTGV
	fLOX3W1cfk/ZcE1/6oqBX86NeOXwDflGCHoUK8Rbd8jHHHpIYMiGAr9Voc+C43wcJ2ULNdovq3W
	tbGVHgzm98WWmNoOkXPwKTVIAzS722wPM1ckIB+ofLTOmCYunPOyi7vlygXLKNxGoAVSf5v6JJ5
	djYC43EO3hqFsyVhrKVd5678BETv8kG8jgtLSN0lOMtzFojkPmN3uRpdyg1mjV9sF7QiMx8BYfN
	eog==
X-Google-Smtp-Source: AGHT+IEYTM6z7Iy7sGPXPq89AIrqC8ysYo7NMnDQvU0/HBZVS841aJ2WQmbqa7oLs6vn9b2XrhI+JQ==
X-Received: by 2002:a81:a807:0:b0:700:a61d:a2f1 with SMTP id 00721157ae682-706ccc8849fmr106386647b3.7.1745242675189;
        Mon, 21 Apr 2025 06:37:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca491d54sm19036277b3.60.2025.04.21.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:37:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: stable@vger.kernel.org,
	Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs: adjust subpage bit start based on sectorsize
Date: Mon, 21 Apr 2025 09:37:50 -0400
Message-ID: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1745242535.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

cc: stable@vger.kernel.org
Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- Further testing indicated that the page tagging theoretical race isn't getting
  hit in practice, so we're going to limit the "hotfix" to this specific patch,
  and then send subsequent patches to address the other issues we're hitting. My
  simplify metadata writebback patches are the more wholistic fix.

 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f08615b334f..6cfd286b8bbc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
 			spin_unlock(&folio->mapping->i_private_lock);
-			bit_start++;
+			bit_start += sectors_per_node;
 			continue;
 		}
 
-- 
2.48.1


