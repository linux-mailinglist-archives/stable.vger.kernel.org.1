Return-Path: <stable+bounces-93200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB59CD7E2
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA04AB25B04
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D418859F;
	Fri, 15 Nov 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwGS731/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DA29A9;
	Fri, 15 Nov 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653124; cv=none; b=KRa1M4Zpz+ORpD8xX0bJI3pztpf6S+gyyoWyoXOehmLdSJC/PVKSlgDlqAZGgc2Obt0qqLaAG7r4IzyOVpybstxAZ/xBMOH2AJlqEXkdmOAxFrHT9wMCoZXycy44RdKPuWCUI75jJkZ7pqrsws9mOaEXU0Bu9uKzgMAqCx4fnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653124; c=relaxed/simple;
	bh=vpR3kkxWgrXQUBzINV/RGao3PcyuPXm0GlfvOikVn7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLipfwr7CF3Gq5uqjdhnj5yHnF/epkoCqI+WSuWls96SFwuUtktuyREPG7XLj5e03PVrImNy2rRsVdm3+2mzM983VrmycGVj0tedTuKxliRXuE8NZcnvptq9XI6g0mj6rpgwfNiWYWuARr964AgqHXao9QD2NhllSUCFQbCpUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwGS731/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E53DC4CED4;
	Fri, 15 Nov 2024 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653124;
	bh=vpR3kkxWgrXQUBzINV/RGao3PcyuPXm0GlfvOikVn7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwGS731/svSwIt1uUiAnVcZTssVt5T4XKNSI+G+9PKwwHUgwYjnZuNdej1HYBlzMm
	 B02D5YzphLlbNEF9sEwa607T76mluS5Zt9SP4cXuIVaiU5df8KNdRvOdvQfHYpQGUm
	 sp3w73Z85IJOjCHmQwfeVHvE7Gy9KA6kOMKfyMsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Hagar Gamal Halim <hagarhem@amazon.de>
Subject: [PATCH 5.4 61/66] md/raid10: improve code of mrdev in raid10_sync_request
Date: Fri, 15 Nov 2024 07:38:10 +0100
Message-ID: <20241115063725.043366095@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
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

From: Li Nan <linan122@huawei.com>

commit 59f8f0b54c8ffb4521f6bbd1cb6f4dfa5022e75e upstream.

'need_recover' and 'mrdev' are equivalent in raid10_sync_request(), and
inc mrdev->nr_pending is unreasonable if don't need recovery. Replace
'need_recover' with 'mrdev', and only inc nr_pending when needed.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230527072218.2365857-3-linan666@huaweicloud.com
Cc: Hagar Gamal Halim <hagarhem@amazon.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3069,7 +3069,6 @@ static sector_t raid10_sync_request(stru
 			sector_t sect;
 			int must_sync;
 			int any_working;
-			int need_recover = 0;
 			struct raid10_info *mirror = &conf->mirrors[i];
 			struct md_rdev *mrdev, *mreplace;
 
@@ -3077,14 +3076,13 @@ static sector_t raid10_sync_request(stru
 			mrdev = rcu_dereference(mirror->rdev);
 			mreplace = rcu_dereference(mirror->replacement);
 
-			if (mrdev != NULL &&
-			    !test_bit(Faulty, &mrdev->flags) &&
-			    !test_bit(In_sync, &mrdev->flags))
-				need_recover = 1;
+			if (mrdev && (test_bit(Faulty, &mrdev->flags) ||
+			    test_bit(In_sync, &mrdev->flags)))
+				mrdev = NULL;
 			if (mreplace && test_bit(Faulty, &mreplace->flags))
 				mreplace = NULL;
 
-			if (!need_recover && !mreplace) {
+			if (!mrdev && !mreplace) {
 				rcu_read_unlock();
 				continue;
 			}
@@ -3118,7 +3116,8 @@ static sector_t raid10_sync_request(stru
 				rcu_read_unlock();
 				continue;
 			}
-			atomic_inc(&mrdev->nr_pending);
+			if (mrdev)
+				atomic_inc(&mrdev->nr_pending);
 			if (mreplace)
 				atomic_inc(&mreplace->nr_pending);
 			rcu_read_unlock();
@@ -3205,7 +3204,7 @@ static sector_t raid10_sync_request(stru
 				r10_bio->devs[1].devnum = i;
 				r10_bio->devs[1].addr = to_addr;
 
-				if (need_recover) {
+				if (mrdev) {
 					bio = r10_bio->devs[1].bio;
 					bio->bi_next = biolist;
 					biolist = bio;
@@ -3250,7 +3249,7 @@ static sector_t raid10_sync_request(stru
 					for (k = 0; k < conf->copies; k++)
 						if (r10_bio->devs[k].devnum == i)
 							break;
-					if (!test_bit(In_sync,
+					if (mrdev && !test_bit(In_sync,
 						      &mrdev->flags)
 					    && !rdev_set_badblocks(
 						    mrdev,
@@ -3276,12 +3275,14 @@ static sector_t raid10_sync_request(stru
 				if (rb2)
 					atomic_dec(&rb2->remaining);
 				r10_bio = rb2;
-				rdev_dec_pending(mrdev, mddev);
+				if (mrdev)
+					rdev_dec_pending(mrdev, mddev);
 				if (mreplace)
 					rdev_dec_pending(mreplace, mddev);
 				break;
 			}
-			rdev_dec_pending(mrdev, mddev);
+			if (mrdev)
+				rdev_dec_pending(mrdev, mddev);
 			if (mreplace)
 				rdev_dec_pending(mreplace, mddev);
 			if (r10_bio->devs[0].bio->bi_opf & MD_FAILFAST) {



