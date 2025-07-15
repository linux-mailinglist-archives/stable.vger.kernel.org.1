Return-Path: <stable+bounces-162547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC208B05DF3
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8367B5BC2
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB012E49B8;
	Tue, 15 Jul 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a6ZtqU7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2B2E3AEA;
	Tue, 15 Jul 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586843; cv=none; b=qE2eJCT1URfa6k/jx6QvoLzZAtuT8oN0YeXPfJy+Q4EScBXIfyK9tsabVgvLbh0jct6s+GuvpWaNDHOPvio1ylchvrxTqc8FM3V2PmkfBqcb7dv0Fb5BSByivHq7BMRc3H28iDOzVkbMNCio1eifZ0q02vtD53D+Z1AjORKG5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586843; c=relaxed/simple;
	bh=+UQwviovj8R0yeRjccW07m/0KY8Fyt+NppJ5+JRgQ3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myKYlVge4CGCnG59G78aQlAuJX2frZ7tMloaphIoFwxlT7Z6uCV6VmeY0ZfU38TvLj9dUNpgylCrP+hjN/4q7lepCVKtkAhL84NdBp3IPJKUcPX6CMcdzA6i4OiIXTh+saQA6MUR3MLjmt535OWVKtMaHRMmv5G2HgzKIEwvB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a6ZtqU7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68646C4CEE3;
	Tue, 15 Jul 2025 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586843;
	bh=+UQwviovj8R0yeRjccW07m/0KY8Fyt+NppJ5+JRgQ3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6ZtqU7J5w1RaCWF6O4vs4xLpSMk845fHt2dN5KI1jyvqPeZVjVJF1RtVRjQvisbk
	 KrzW+FJW75pZdYt/5hEnpViEx9lgEwy532nXllOtLF5TWOn1Q+Vy99v/UFC0LLY9fB
	 7kd6XOyrKNxxqTW0Vqtx+Bbq+iigekPcUg0fE/Co=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerald Gibson <gerald.gibson@oracle.com>,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 6.15 070/192] md/md-bitmap: fix GPF in bitmap_get_stats()
Date: Tue, 15 Jul 2025 15:12:45 +0200
Message-ID: <20250715130817.747060856@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Håkon Bugge <haakon.bugge@oracle.com>

commit c17fb542dbd1db745c9feac15617056506dd7195 upstream.

The commit message of commit 6ec1f0239485 ("md/md-bitmap: fix stats
collection for external bitmaps") states:

    Remove the external bitmap check as the statistics should be
    available regardless of bitmap storage location.

    Return -EINVAL only for invalid bitmap with no storage (neither in
    superblock nor in external file).

But, the code does not adhere to the above, as it does only check for
a valid super-block for "internal" bitmaps. Hence, we observe:

Oops: GPF, probably for non-canonical address 0x1cd66f1f40000028
RIP: 0010:bitmap_get_stats+0x45/0xd0
Call Trace:

 seq_read_iter+0x2b9/0x46a
 seq_read+0x12f/0x180
 proc_reg_read+0x57/0xb0
 vfs_read+0xf6/0x380
 ksys_read+0x6d/0xf0
 do_syscall_64+0x8c/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

We fix this by checking the existence of a super-block for both the
internal and external case.

Fixes: 6ec1f0239485 ("md/md-bitmap: fix stats collection for external bitmaps")
Cc: stable@vger.kernel.org
Reported-by: Gerald Gibson <gerald.gibson@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Link: https://lore.kernel.org/linux-raid/20250702091035.2061312-1-haakon.bugge@oracle.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md-bitmap.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2357,8 +2357,7 @@ static int bitmap_get_stats(void *data,
 
 	if (!bitmap)
 		return -ENOENT;
-	if (!bitmap->mddev->bitmap_info.external &&
-	    !bitmap->storage.sb_page)
+	if (!bitmap->storage.sb_page)
 		return -EINVAL;
 	sb = kmap_local_page(bitmap->storage.sb_page);
 	stats->sync_size = le64_to_cpu(sb->sync_size);



