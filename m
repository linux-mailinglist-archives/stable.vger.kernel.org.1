Return-Path: <stable+bounces-118998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FADA42363
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F061C7A15AB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74F825486D;
	Mon, 24 Feb 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKDThrW/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7476F24EF78;
	Mon, 24 Feb 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407972; cv=none; b=FzU4ilHDI9sxTMLf6un/u2ecRv4u++1JsnscTpKTeXazug1pqEHQimnIxHXkPpUlOtKcPeNd9f52JG+Prb8ziOEZM4x4Dd/2RJtLc4Rqr5CPV0PywdhTA/K4Z9B9jLf7zwthif0VOcKioYUpKIkO0UAT37NZ2FHZyR8Q4eZLsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407972; c=relaxed/simple;
	bh=r8sxdShY72+9IymeVMtkmV1pHdFI7k/4Vb4H66Wsv2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkui4w2t1ofxJTVfrqf14IyaSb2BE7kbvQ6Wk5+26Dj4teUZQ2/qEV3Wus8AYJOgM4aoOoZod/4i7cHqziF9+JT30i5q+cAzX1oFhP5EwaHJf8v4W9oWCeI5eFg+4ZaDpgsUdhDBv7l1CZ8PoLDpqpjNN8FfVw4ec4toCsgV4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKDThrW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89F5C4CED6;
	Mon, 24 Feb 2025 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740407972;
	bh=r8sxdShY72+9IymeVMtkmV1pHdFI7k/4Vb4H66Wsv2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKDThrW/IGxyQis0JBjChwJXf05cElXZW13T2w2fDHVBM2nuEvQ8VSF2jdckqk/NL
	 o8SaSXSdwnYz0LP5yzvNPapsnLV4BATt54k+oO5l1f5odCLJOuaT4H1UaKi3iaXVgj
	 mfyD0j+CNgAKnO30xBzfvyQ2yLc/PxjsE238//XI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 030/140] md: simplify md_seq_ops
Date: Mon, 24 Feb 2025 15:33:49 +0100
Message-ID: <20250224142604.192843945@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit cf1b6d4441fffd0ba8ae4ced6a12f578c95ca049 ]

Before this patch, the implementation is hacky and hard to understand:

1) md_seq_start set pos to 1;
2) md_seq_show found pos is 1, then print Personalities;
3) md_seq_next found pos is 1, then it update pos to the first mddev;
4) md_seq_show found pos is not 1 or 2, show mddev;
5) md_seq_next found pos is not 1 or 2, update pos to next mddev;
6) loop 4-5 until the last mddev, then md_seq_next update pos to 2;
7) md_seq_show found pos is 2, then print unused devices;
8) md_seq_next found pos is 2, stop;

This patch remove the magic value and use seq_list_start/next/stop()
directly, and move printing "Personalities" to md_seq_start(),
"unsed devices" to md_seq_stop():

1) md_seq_start print Personalities, and then set pos to first mddev;
2) md_seq_show show mddev;
3) md_seq_next update pos to next mddev;
4) loop 2-3 until the last mddev;
5) md_seq_stop print unsed devices;

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230927061241.1552837-3-yukuai1@huaweicloud.com
Stable-dep-of: 8d28d0ddb986 ("md/md-bitmap: Synchronize bitmap_get_stats() with bitmap lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 100 +++++++++++-------------------------------------
 1 file changed, 22 insertions(+), 78 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 836e8ed58c8ad..27a6a11b71ee4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8260,105 +8260,46 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 }
 
 static void *md_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(&all_mddevs_lock)
 {
-	struct list_head *tmp;
-	loff_t l = *pos;
-	struct mddev *mddev;
+	struct md_personality *pers;
 
-	if (l == 0x10000) {
-		++*pos;
-		return (void *)2;
-	}
-	if (l > 0x10000)
-		return NULL;
-	if (!l--)
-		/* header */
-		return (void*)1;
+	seq_puts(seq, "Personalities : ");
+	spin_lock(&pers_lock);
+	list_for_each_entry(pers, &pers_list, list)
+		seq_printf(seq, "[%s] ", pers->name);
+
+	spin_unlock(&pers_lock);
+	seq_puts(seq, "\n");
+	seq->poll_event = atomic_read(&md_event_count);
 
 	spin_lock(&all_mddevs_lock);
-	list_for_each(tmp,&all_mddevs)
-		if (!l--) {
-			mddev = list_entry(tmp, struct mddev, all_mddevs);
-			if (!mddev_get(mddev))
-				continue;
-			spin_unlock(&all_mddevs_lock);
-			return mddev;
-		}
-	spin_unlock(&all_mddevs_lock);
-	if (!l--)
-		return (void*)2;/* tail */
-	return NULL;
+
+	return seq_list_start(&all_mddevs, *pos);
 }
 
 static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct list_head *tmp;
-	struct mddev *next_mddev, *mddev = v;
-	struct mddev *to_put = NULL;
-
-	++*pos;
-	if (v == (void*)2)
-		return NULL;
-
-	spin_lock(&all_mddevs_lock);
-	if (v == (void*)1) {
-		tmp = all_mddevs.next;
-	} else {
-		to_put = mddev;
-		tmp = mddev->all_mddevs.next;
-	}
-
-	for (;;) {
-		if (tmp == &all_mddevs) {
-			next_mddev = (void*)2;
-			*pos = 0x10000;
-			break;
-		}
-		next_mddev = list_entry(tmp, struct mddev, all_mddevs);
-		if (mddev_get(next_mddev))
-			break;
-		mddev = next_mddev;
-		tmp = mddev->all_mddevs.next;
-	}
-	spin_unlock(&all_mddevs_lock);
-
-	if (to_put)
-		mddev_put(to_put);
-	return next_mddev;
-
+	return seq_list_next(v, &all_mddevs, pos);
 }
 
 static void md_seq_stop(struct seq_file *seq, void *v)
+	__releases(&all_mddevs_lock)
 {
-	struct mddev *mddev = v;
-
-	if (mddev && v != (void*)1 && v != (void*)2)
-		mddev_put(mddev);
+	status_unused(seq);
+	spin_unlock(&all_mddevs_lock);
 }
 
 static int md_seq_show(struct seq_file *seq, void *v)
 {
-	struct mddev *mddev = v;
+	struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
 	sector_t sectors;
 	struct md_rdev *rdev;
 
-	if (v == (void*)1) {
-		struct md_personality *pers;
-		seq_printf(seq, "Personalities : ");
-		spin_lock(&pers_lock);
-		list_for_each_entry(pers, &pers_list, list)
-			seq_printf(seq, "[%s] ", pers->name);
-
-		spin_unlock(&pers_lock);
-		seq_printf(seq, "\n");
-		seq->poll_event = atomic_read(&md_event_count);
+	if (!mddev_get(mddev))
 		return 0;
-	}
-	if (v == (void*)2) {
-		status_unused(seq);
-		return 0;
-	}
 
+	spin_unlock(&all_mddevs_lock);
 	spin_lock(&mddev->lock);
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
 		seq_printf(seq, "%s : %sactive", mdname(mddev),
@@ -8429,6 +8370,9 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "\n");
 	}
 	spin_unlock(&mddev->lock);
+	spin_lock(&all_mddevs_lock);
+	if (atomic_dec_and_test(&mddev->active))
+		__mddev_put(mddev);
 
 	return 0;
 }
-- 
2.39.5




