Return-Path: <stable+bounces-35261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D3E894326
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACAA1F26EED
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8D482E4;
	Mon,  1 Apr 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2mpGCjV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11761BA3F;
	Mon,  1 Apr 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990821; cv=none; b=jVaFyGCH9Ar9F6N/VTSIWQiwOvIuOkbZ4W8ckKDkHqpdm24FwpD6yO3er8cBDNaoTt+9DyWDCQxY1leAboMQneOpvpHwtNG6EZRR/ZN4DoULrI5dakTIr0+T1PhLKSN0nAkM60woAzyW0xAZScFRPzhiPYBege3gFiFPyXy4D5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990821; c=relaxed/simple;
	bh=xx5PC5+O/22ycLdeQ1ONRmB0LKlR0ytPCwsFE3vxsN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDAta3stP3gUJ+qNYPOlr3voN55wvDQxoZ74Kqnoc3if/fNPaASB+INLfJd/BrbSzljtA6e+w2Y2saukjeNlYj63DRX0XJsjnVWEqvfyUr8w2IY7YRz7g4iy2/s6dRDsPOBqmxtNNjCkBTjfhzvo6tjxrfQnD+yuIW1h+Z4S4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2mpGCjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBF5C433F1;
	Mon,  1 Apr 2024 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990820;
	bh=xx5PC5+O/22ycLdeQ1ONRmB0LKlR0ytPCwsFE3vxsN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2mpGCjVPzj03PeApZ1xT77fIYgHNPPSA284xm0I6cipKS/puEIQj42Np30HVoJIM
	 FA50IjMNG2jM/7ok8YkdN8aN7UeHCD2tOaRsn3xgpJsTGhxwImSqpc4ATxHI4PLifl
	 il+ZFSfpg8LSP0SbrbNQYcEsfRK2xn0X7URCo8Q4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Xiao Ni <xni@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 076/272] dm-raid: fix lockdep waring in "pers->hot_add_disk"
Date: Mon,  1 Apr 2024 17:44:26 +0200
Message-ID: <20240401152532.939683615@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index bf833ca880bc1..99b4738e867a8 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -4046,7 +4046,9 @@ static void raid_resume(struct dm_target *ti)
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




