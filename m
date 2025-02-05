Return-Path: <stable+bounces-113107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D19EA28FFF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD5C1888463
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D53D14386D;
	Wed,  5 Feb 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jvXLwdL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16B7DA6A;
	Wed,  5 Feb 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765845; cv=none; b=hIroiaaTA8bDEPAxRFspRuwDAS7EAwXDTVkgzMQnjH9ANUlO5bhSPNg84tkBj5JtwMZEP22qAEcWbo9rmv0N6cpmXCZvVzuEogUnXocdVZWpeQmQkXfS71Bh61z8jY7HP/L+GYIbJ3bPiPa2/4wvMoiZzkiQd2VxQU2kbHDYDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765845; c=relaxed/simple;
	bh=0iPRKzKih1pquTPRbq7J62Hk/do/vdm/nr8K2CpdhNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg2PHz0fmMMJlciFW3baF875HyQFJTFDdU/QoWLaZIIPWntt4epyiV3XdB9lL3vQOqUaa71rs+hDq0LF9W6fy9UnEUFRl5boZc17U48/0p7rMdEX4Gm7O37WNaEv+Sjtg1g+DtC7kR4ExZSgKVrotLZ2a20WQ1x+ALeYel5aKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jvXLwdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92F1C4CED1;
	Wed,  5 Feb 2025 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765844;
	bh=0iPRKzKih1pquTPRbq7J62Hk/do/vdm/nr8K2CpdhNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2jvXLwdLQuDv+6BXM8CPBQE7Z28LVtSnBK6TpeNrMp8KGDXRHLGCxFnhU6tQGcdD/
	 4jZgUp5xbhpUUycZs06zaUVokgcH85Y5jcpppALKVkwEGOlp+QPRSArWTnA49MqK3W
	 kffLkyLdTUTgZq4mUa+ZYsO9kgUTp+C0S3Q7884E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Yue <glass.su@suse.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 305/393] ocfs2: mark dquot as inactive if failed to start trans while releasing dquot
Date: Wed,  5 Feb 2025 14:43:44 +0100
Message-ID: <20250205134431.979294561@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

From: Su Yue <glass.su@suse.com>

[ Upstream commit 276c61385f6bc3223a5ecd307cf4aba2dfbb9a31 ]

While running fstests generic/329, the kernel workqueue
quota_release_workfn is dead looping in calling ocfs2_release_dquot().
The ocfs2 state is already readonly but ocfs2_release_dquot wants to
start a transaction but fails and returns.

=====================================================================
[ 2918.123602 ][  T275 ] On-disk corruption discovered. Please run
fsck.ocfs2 once the filesystem is unmounted.
[ 2918.124034 ][  T275 ] (kworker/u135:1,275,11):ocfs2_release_dquot:765
ERROR: status = -30
[ 2918.124452 ][  T275 ] (kworker/u135:1,275,11):ocfs2_release_dquot:795
ERROR: status = -30
[ 2918.124883 ][  T275 ] (kworker/u135:1,275,11):ocfs2_start_trans:357
ERROR: status = -30
[ 2918.125276 ][  T275 ] OCFS2: abort (device dm-0): ocfs2_start_trans:
Detected aborted journal
[ 2918.125710 ][  T275 ] On-disk corruption discovered. Please run
fsck.ocfs2 once the filesystem is unmounted.
=====================================================================

ocfs2_release_dquot() is much like dquot_release(), which is called by
ext4 to handle similar situation.  So here fix it by marking the dquot as
inactive like what dquot_release() does.

Link: https://lkml.kernel.org/r/20250106140653.92292-1-glass.su@suse.com
Fixes: 9e33d69f553a ("ocfs2: Implementation of local and global quota file handling")
Signed-off-by: Su Yue <glass.su@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/quota_global.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 0dffd6a44d39d..24b031dc44ee1 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -749,6 +749,11 @@ static int ocfs2_release_dquot(struct dquot *dquot)
 	handle = ocfs2_start_trans(osb,
 		ocfs2_calc_qdel_credits(dquot->dq_sb, dquot->dq_id.type));
 	if (IS_ERR(handle)) {
+		/*
+		 * Mark dquot as inactive to avoid endless cycle in
+		 * quota_release_workfn().
+		 */
+		clear_bit(DQ_ACTIVE_B, &dquot->dq_flags);
 		status = PTR_ERR(handle);
 		mlog_errno(status);
 		goto out_ilock;
-- 
2.39.5




