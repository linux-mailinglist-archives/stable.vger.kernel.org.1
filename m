Return-Path: <stable+bounces-34059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F63F893DAF
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAED1F21E24
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10E14BAA6;
	Mon,  1 Apr 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RElyfGWa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA84AEDF;
	Mon,  1 Apr 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986870; cv=none; b=Na/dDP7bLDCD8cv0FquX0B5lqex+VQAczZOzNC/GdufbT7YZ9gmROzVfBLT6kgH1U/gpc7TflhAWsTeF9w0u/V68mjYSsDFrce07MnVe9TxFdSUT5fFAyPUhhTxz3jGb/tff1BqFxx5nSGCqBG0Eo+PxGrDtSywe8jq6KaSXgJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986870; c=relaxed/simple;
	bh=Xq7GzSCz7Vs1K8e5j7VNHQNMUCif213jDG9t7qObqFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raYPQbJH4WGmN8cAlquiz4E9pYLbBkGaUgkOInRsRRkkb+8iDZwqaxikAtS9lNtjJHMLm603s4N3l8tD42+AmtSJ1MEHhKRmBeA6p+z9RF9eUd90dRLq9avNxiogUnT7Zn2SXMuTi5L790FyhDLqcg6sQhWOnJxtQwgKkbyqg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RElyfGWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA929C433C7;
	Mon,  1 Apr 2024 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986870;
	bh=Xq7GzSCz7Vs1K8e5j7VNHQNMUCif213jDG9t7qObqFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RElyfGWaJW6PTBvPCOSpgHTP97Cd56HLRS4nRAjpCYmJXbHbfUlmULaA9JHr6oYOf
	 xqFkpHFIDI1riA15fzOn4qmUt5c17hdkdU2tRN8t6+8Fz4CahsZxGwuwf+Z++z1mGC
	 A/UE7PM2tVowszDoFpcst18jQ+Pv6wkNeOQD8kP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Xiao Ni <xni@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 112/399] dm-raid: fix lockdep waring in "pers->hot_add_disk"
Date: Mon,  1 Apr 2024 17:41:18 +0200
Message-ID: <20240401152552.533634115@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 95009ae904b1e9dca8db6f649f2d7c18a6e42c75 ]

The lockdep assert is added by commit a448af25becf ("md/raid10: remove
rcu protection to access rdev from conf") in print_conf(). And I didn't
notice that dm-raid is calling "pers->hot_add_disk" without holding
'reconfig_mutex'.

"pers->hot_add_disk" read and write many fields that is protected by
'reconfig_mutex', and raid_resume() already grab the lock in other
contex. Hence fix this problem by protecting "pers->host_add_disk"
with the lock.

Fixes: 9092c02d9435 ("DM RAID: Add ability to restore transiently failed devices on resume")
Fixes: a448af25becf ("md/raid10: remove rcu protection to access rdev from conf")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240305072306.2562024-10-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-raid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 063f1266ec462..d97355e9b9a6e 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -4091,7 +4091,9 @@ static void raid_resume(struct dm_target *ti)
 		 * Take this opportunity to check whether any failed
 		 * devices are reachable again.
 		 */
+		mddev_lock_nointr(mddev);
 		attempt_restore_of_faulty_devices(rs);
+		mddev_unlock(mddev);
 	}
 
 	if (test_and_clear_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
-- 
2.43.0




