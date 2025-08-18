Return-Path: <stable+bounces-170037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45073B2A031
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFB618A2067
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6EE28750B;
	Mon, 18 Aug 2025 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I14Q7lQy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35E2C859
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515910; cv=none; b=i1SZc/p4cDSzudFh7MnLij4YuRDV516OIqc3GatSzSJG2vq9CXBYaLzBAqHHUXM46DyZcEUIRG/+9DyeNx3YWyxMWxMqYVY7OsWbqK8OX/HHRNn/x4CVTkMQ6ZazK/54jB3ZRKId2c347u6FdyVIcDpcCZt2AFGD9ddgmQQMVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515910; c=relaxed/simple;
	bh=oSfjQwMKkMUAX16+xo+KIq9jKcjzrb5j9CH+V85m/Cg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l5wiGGt1EOwBKI19xD6dA49BKglBcazNwu+h2Xi2LAhvjvXopNdQj59qK2iWHIQnD3IKpDlso4ZtbKHb3QWj1qZaHHaP2sL2oPAJpFExYhmQ9sjhDNGfGzcNPwppfXmZicK+6ijAWek2pQBZLaszjfAVRUBLj523qLsbleTQMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I14Q7lQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BF2C4CEEB;
	Mon, 18 Aug 2025 11:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755515910;
	bh=oSfjQwMKkMUAX16+xo+KIq9jKcjzrb5j9CH+V85m/Cg=;
	h=Subject:To:Cc:From:Date:From;
	b=I14Q7lQyzXq3RsHgphKwIkYXW+9bDzzPQ8FjC4h/kkmVcL8blVfnxpPVyPbUGGa6U
	 Ba8S+tnsh/D/XuO9ApMdMrqPyeCn2FUwXBLKXZEIxcEr1lOUxyiuyfTOH5XkVxc0Di
	 g0dnwGutXlYVaL+YeYhk8oKT72VTYlooO9F8q2iE=
Subject: FAILED: patch "[PATCH] ocfs2: reset folio to NULL when get folio fails" failed to apply to 6.1-stable tree
To: lizhi.xu@windriver.com,akpm@linux-foundation.org,gechangwei@live.cn,jlbec@evilplan.org,joseph.qi@linux.alibaba.com,junxiao.bi@oracle.com,mark@fasheh.com,piaojun@huawei.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:16:23 +0200
Message-ID: <2025081823-exuberant-trace-6385@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2ae826799932ff89409f56636ad3c25578fe7cf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081823-exuberant-trace-6385@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


