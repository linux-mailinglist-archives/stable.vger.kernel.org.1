Return-Path: <stable+bounces-94192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBBB9D3B7D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499C41F21921
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED651B5328;
	Wed, 20 Nov 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hUIhACP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA341DFEF;
	Wed, 20 Nov 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107544; cv=none; b=QyA26qjiri+Tm/5qNCF31+tWxH0olLWbPr4OsBvQEebsZu+U4DzRbCvhPvZjVUB1g6eVd/RcJptGk669Mo5qBU+ypDThnWXZyC0PqGjDNQqb5opCo9jNQj5y4+H+qNbW+qahVLLqfdmfT/Z2VWojVN//BHiBD8dxLbqtpofiUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107544; c=relaxed/simple;
	bh=Q1Bgpz1DgwTBrtATz0jIHqFCTwuYx+SjQ7g4QqkS+0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHfhLnA9UBHpiS0caqs2KhNQ8DW4gZB30AIqDDlmX5GoSJcBUG+EcnXxN2Rsg0KX9dPdborSXxMAWHfgkGo0pZ+94nlzvFgnJptsznwkoBQ+/nEO6gHW3Fydgei7SdaNDSS68lQLJVOh2x+Ix4rJnRTioaJ+OxCaS5tuovdogTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hUIhACP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3ACC4CECD;
	Wed, 20 Nov 2024 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107544;
	bh=Q1Bgpz1DgwTBrtATz0jIHqFCTwuYx+SjQ7g4QqkS+0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUIhACP4m8mv1u2eNVs756ge0wGMyUSQhA/sB87LhIjcWZbgX2KxaQJapw6xNHFB9
	 WQ2rKl4PP52cmCkg3by+lDEYR5HNxTJSe65cjfYUwoK/Zd4gAilUrwuQgmPXcC0Bm4
	 H/HYs6xXSra3eqrx+vrBlueAV0wNDXj2drnjAtUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Joel Becker <jlbec@evilplan.org>,
	Mark Fasheh <mark@fasheh.com>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.11 043/107] ocfs2: uncache inode which has failed entering the group
Date: Wed, 20 Nov 2024 13:56:18 +0100
Message-ID: <20241120125630.646327352@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
References: <20241120125629.681745345@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

commit 737f34137844d6572ab7d473c998c7f977ff30eb upstream.

Syzbot has reported the following BUG:

kernel BUG at fs/ocfs2/uptodate.c:509!
...
Call Trace:
 <TASK>
 ? __die_body+0x5f/0xb0
 ? die+0x9e/0xc0
 ? do_trap+0x15a/0x3a0
 ? ocfs2_set_new_buffer_uptodate+0x145/0x160
 ? do_error_trap+0x1dc/0x2c0
 ? ocfs2_set_new_buffer_uptodate+0x145/0x160
 ? __pfx_do_error_trap+0x10/0x10
 ? handle_invalid_op+0x34/0x40
 ? ocfs2_set_new_buffer_uptodate+0x145/0x160
 ? exc_invalid_op+0x38/0x50
 ? asm_exc_invalid_op+0x1a/0x20
 ? ocfs2_set_new_buffer_uptodate+0x2e/0x160
 ? ocfs2_set_new_buffer_uptodate+0x144/0x160
 ? ocfs2_set_new_buffer_uptodate+0x145/0x160
 ocfs2_group_add+0x39f/0x15a0
 ? __pfx_ocfs2_group_add+0x10/0x10
 ? __pfx_lock_acquire+0x10/0x10
 ? mnt_get_write_access+0x68/0x2b0
 ? __pfx_lock_release+0x10/0x10
 ? rcu_read_lock_any_held+0xb7/0x160
 ? __pfx_rcu_read_lock_any_held+0x10/0x10
 ? smack_log+0x123/0x540
 ? mnt_get_write_access+0x68/0x2b0
 ? mnt_get_write_access+0x68/0x2b0
 ? mnt_get_write_access+0x226/0x2b0
 ocfs2_ioctl+0x65e/0x7d0
 ? __pfx_ocfs2_ioctl+0x10/0x10
 ? smack_file_ioctl+0x29e/0x3a0
 ? __pfx_smack_file_ioctl+0x10/0x10
 ? lockdep_hardirqs_on_prepare+0x43d/0x780
 ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
 ? __pfx_ocfs2_ioctl+0x10/0x10
 __se_sys_ioctl+0xfb/0x170
 do_syscall_64+0xf3/0x230
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
...
 </TASK>

When 'ioctl(OCFS2_IOC_GROUP_ADD, ...)' has failed for the particular
inode in 'ocfs2_verify_group_and_input()', corresponding buffer head
remains cached and subsequent call to the same 'ioctl()' for the same
inode issues the BUG() in 'ocfs2_set_new_buffer_uptodate()' (trying
to cache the same buffer head of that inode). Fix this by uncaching
the buffer head with 'ocfs2_remove_from_cache()' on error path in
'ocfs2_group_add()'.

Link: https://lkml.kernel.org/r/20241114043844.111847-1-dmantipov@yandex.ru
Fixes: 7909f2bf8353 ("[PATCH 2/2] ocfs2: Implement group add for online resize")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Reported-by: syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=453873f1588c2d75b447
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/resize.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -574,6 +574,8 @@ out_commit:
 	ocfs2_commit_trans(osb, handle);
 
 out_free_group_bh:
+	if (ret < 0)
+		ocfs2_remove_from_cache(INODE_CACHE(inode), group_bh);
 	brelse(group_bh);
 
 out_unlock:



