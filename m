Return-Path: <stable+bounces-162033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EAB05B3A
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0927A9CF6
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555372E2EF9;
	Tue, 15 Jul 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3xgQvh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FFD27470;
	Tue, 15 Jul 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585495; cv=none; b=e+6HqOv4+0qMvD05EkLD6AkAiibmYh0OG4+YP7bc4Mygztd4T1QW4UtmxtUuzUwdd7Jr5CqqwaJ5emGVeovyNYcmPfFZwn9iy2x0U3ii8pZrurwv7Rt+/nit4ZrPui+9S5YyrqcOEEZqKB2aeLDfVOxsdOz5yXbAapGY7OaaU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585495; c=relaxed/simple;
	bh=mGJxCtH2catRql4J5d+bWG/hfC3dB3hPV23wiYJWLUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3bIeDgBOpUkhdTds5iB3E7eW/7XwqT2loqQKWmiE6bhxBBakCAbLJJM5WTmMkF7YkiZt8Z7edpvVpV1GBZ3YCnw15vdSoU1Ht66M/jQEWSpg+bZv06VobdFYl+PVu3YCnhpJf3gsmJKXkK4hpah7G3Afxj33rMeRORh8yWPW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3xgQvh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D126C4CEE3;
	Tue, 15 Jul 2025 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585495;
	bh=mGJxCtH2catRql4J5d+bWG/hfC3dB3hPV23wiYJWLUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3xgQvh77D5+lmbVzmZThmqJokdEakCGT0SepVMUjTATOIylcdL7j5NiQa2BodC4e
	 jvE1dPpBDx7uk3d/UpAVjEXeN8k7/b9lN0NVRrwM7VzYuoN13mFYK2XqDhWRoKo8UO
	 zj1nsq73HDNye7FZvGYTfHvnyXLnx5eIf3O/+aqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerald Gibson <gerald.gibson@oracle.com>,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 6.12 062/163] md/md-bitmap: fix GPF in bitmap_get_stats()
Date: Tue, 15 Jul 2025 15:12:10 +0200
Message-ID: <20250715130811.241568057@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2355,8 +2355,7 @@ static int bitmap_get_stats(void *data,
 
 	if (!bitmap)
 		return -ENOENT;
-	if (!bitmap->mddev->bitmap_info.external &&
-	    !bitmap->storage.sb_page)
+	if (!bitmap->storage.sb_page)
 		return -EINVAL;
 	sb = kmap_local_page(bitmap->storage.sb_page);
 	stats->sync_size = le64_to_cpu(sb->sync_size);



