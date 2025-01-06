Return-Path: <stable+bounces-106803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243EA02321
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E807C1885424
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006061A00EC;
	Mon,  6 Jan 2025 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="keBXkVGu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11742AE94
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159780; cv=none; b=tnZeEX31BGpT8CLzpn03bk5/b9/z5GxYyeDb4OSqTFYgkEuEGVwRwfdzCXEdrufb4ZGwtzJe7AkYNFAIhVkL8/OBxxTXvTviguQrRzAmcfz/Qt+HIZtSvFhonEuoU45yDAMhbnjaSKciN5G97frMYUhqyRUEQrpeq9Oe2Usi17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159780; c=relaxed/simple;
	bh=P2S1sLaEWQvAHVIP04b/Y0GgzGcqlET6sdg46kgTcBc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oXqdNp5gyN98SWeKSDarRTRlxn3l5/VYXSktMHl2Ry9kye92RizE/HMydXjca6Xp+KQHX7Hp0QdJr02E3iEIq/Fcqd0tsY0VE+vzgsPY4hcgCDOSMQIqEaBup/0kdz/dPBhlnkUhlvC4/qbIwKqoHxNQXcTbmahdv+vkSmqRh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=keBXkVGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95F5C4CED2;
	Mon,  6 Jan 2025 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736159780;
	bh=P2S1sLaEWQvAHVIP04b/Y0GgzGcqlET6sdg46kgTcBc=;
	h=Subject:To:Cc:From:Date:From;
	b=keBXkVGu+1BKjUv561S+3kjJJsElmcwc0/7Jl/somwgrnFV1Q4NsSvK9uJOmu7Qr/
	 aj1Lbt6qAMbi3tmT/Rp1y0tgyBd2Myd+d3dLRRPqrFr4Q9a9sFS8WzjI1/lxU8QpDM
	 hzMtlVB7i3fFI7W2OrAbCZwLRSrhg7O+463xCH2o=
Subject: FAILED: patch "[PATCH] ocfs2: fix slab-use-after-free due to dangling pointer" failed to apply to 5.15-stable tree
To: dennis.lamerice@gmail.com,akpm@linux-foundation.org,gechangwei@live.cn,jlbec@evilplan.org,joseph.qi@linux.alibaba.com,junxiao.bi@oracle.com,mark@fasheh.com,piaojun@huawei.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 06 Jan 2025 11:36:09 +0100
Message-ID: <2025010609-busybody-impromptu-d5f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5f3fd772d152229d94602bca243fbb658068a597
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010609-busybody-impromptu-d5f7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f3fd772d152229d94602bca243fbb658068a597 Mon Sep 17 00:00:00 2001
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Tue, 17 Dec 2024 21:39:25 -0500
Subject: [PATCH] ocfs2: fix slab-use-after-free due to dangling pointer
 dqi_priv

When mounting ocfs2 and then remounting it as read-only, a
slab-use-after-free occurs after the user uses a syscall to
quota_getnextquota.  Specifically, sb_dqinfo(sb, type)->dqi_priv is the
dangling pointer.

During the remounting process, the pointer dqi_priv is freed but is never
set as null leaving it to be accessed.  Additionally, the read-only option
for remounting sets the DQUOT_SUSPENDED flag instead of setting the
DQUOT_USAGE_ENABLED flags.  Moreover, later in the process of getting the
next quota, the function ocfs2_get_next_id is called and only checks the
quota usage flags and not the quota suspended flags.

To fix this, I set dqi_priv to null when it is freed after remounting with
read-only and put a check for DQUOT_SUSPENDED in ocfs2_get_next_id.

[akpm@linux-foundation.org: coding-style cleanups]
Link: https://lkml.kernel.org/r/20241218023924.22821-2-dennis.lamerice@gmail.com
Fixes: 8f9e8f5fcc05 ("ocfs2: Fix Q_GETNEXTQUOTA for filesystem without quotas")
Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
Reported-by: syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com
Tested-by: syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6731d26f.050a0220.1fb99c.014b.GAE@google.com/T/
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 2b0daced98eb..3404e7a30c33 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -893,7 +893,7 @@ static int ocfs2_get_next_id(struct super_block *sb, struct kqid *qid)
 	int status = 0;
 
 	trace_ocfs2_get_next_id(from_kqid(&init_user_ns, *qid), type);
-	if (!sb_has_quota_loaded(sb, type)) {
+	if (!sb_has_quota_active(sb, type)) {
 		status = -ESRCH;
 		goto out;
 	}
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 73d3367c533b..2956d888c131 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -867,6 +867,7 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 	brelse(oinfo->dqi_libh);
 	brelse(oinfo->dqi_lqi_bh);
 	kfree(oinfo);
+	info->dqi_priv = NULL;
 	return status;
 }
 


