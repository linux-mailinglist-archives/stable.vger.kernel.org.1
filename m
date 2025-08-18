Return-Path: <stable+bounces-170038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D7B2A032
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB618A25BF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0EC315780;
	Mon, 18 Aug 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WlXQxEgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019D315773
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515914; cv=none; b=Mgp1eCKQ6uDt0VSZ7wYb95bAUpLhKbol0c9kV3+vkaQ/V+htjzsTfh2ufc2SBhW9EzaruySZz1WD1zYBSPXMKNCd6gk8y8PsDmXnjZIgXm8ixSWxDIfcWqp+gwonMec90w4iCpvGLMuj4S6UVe6BfC1Z4bq1lud8T9490O42+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515914; c=relaxed/simple;
	bh=iRLYi9K+1UfaTDtqD+wXd5CBR0k06YBuSNupV9Ash38=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pfeVDjmzEonErl9uF1i8yX5Or5Xh5QHgAzKHXi9qbhfGuIXn79fDxaa7ZrXyxXfMggMoz74fh5UwFa0g6ygzJom8y/tqDXeQyTq/HiOUf7cRTt1Qp8s4P3SrC+DabUdkGH47wL8CMAOWooLrKNmgrxUM5p/fCSPYJhRF+Kfiwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WlXQxEgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64590C4CEEB;
	Mon, 18 Aug 2025 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755515913;
	bh=iRLYi9K+1UfaTDtqD+wXd5CBR0k06YBuSNupV9Ash38=;
	h=Subject:To:Cc:From:Date:From;
	b=WlXQxEgNpa3zGz2T1cWBdpc78bWFPhorPF/JAPjQ2JNjec145G/criQ9wA2TF7LEG
	 zb1u80HuJ/d5wM+3QlS9qPR/pM4xXChRDDzGtVLA23ZJd/luMhF/dTdm67oiSqrTaQ
	 jWlPaEB5VkQJJfW0LE2cc0Dy8g9B6Qe/LvfOG6d4=
Subject: FAILED: patch "[PATCH] ocfs2: reset folio to NULL when get folio fails" failed to apply to 6.6-stable tree
To: lizhi.xu@windriver.com,akpm@linux-foundation.org,gechangwei@live.cn,jlbec@evilplan.org,joseph.qi@linux.alibaba.com,junxiao.bi@oracle.com,mark@fasheh.com,piaojun@huawei.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:16:23 +0200
Message-ID: <2025081822-pebble-cinch-682b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2ae826799932ff89409f56636ad3c25578fe7cf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081822-pebble-cinch-682b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ae826799932ff89409f56636ad3c25578fe7cf5 Mon Sep 17 00:00:00 2001
From: Lizhi Xu <lizhi.xu@windriver.com>
Date: Mon, 16 Jun 2025 09:31:40 +0800
Subject: [PATCH] ocfs2: reset folio to NULL when get folio fails

The reproducer uses FAULT_INJECTION to make memory allocation fail, which
causes __filemap_get_folio() to fail, when initializing w_folios[i] in
ocfs2_grab_folios_for_write(), it only returns an error code and the value
of w_folios[i] is the error code, which causes
ocfs2_unlock_and_free_folios() to recycle the invalid w_folios[i] when
releasing folios.

Link: https://lkml.kernel.org/r/20250616013140.3602219-1-lizhi.xu@windriver.com
Reported-by: syzbot+c2ea94ae47cd7e3881ec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c2ea94ae47cd7e3881ec
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 40b6bce12951..89aadc6cdd87 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -1071,6 +1071,7 @@ static int ocfs2_grab_folios_for_write(struct address_space *mapping,
 			if (IS_ERR(wc->w_folios[i])) {
 				ret = PTR_ERR(wc->w_folios[i]);
 				mlog_errno(ret);
+				wc->w_folios[i] = NULL;
 				goto out;
 			}
 		}


