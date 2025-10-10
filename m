Return-Path: <stable+bounces-183966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B5BCD383
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B0D540522
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58AC2F549D;
	Fri, 10 Oct 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zexLsh5S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A562F5472;
	Fri, 10 Oct 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102493; cv=none; b=dzwSnQK+tZGETS6ClQK5C7XUKo+r7aq1AfnLUgtEZZsePC13q0Bjjc6dbfjXzJDXHPG0pibdvVVVEn17ftnRgRv/c0PGpqupf8XR2RqBe86SRyL6ee8jC06S0JM03ng35MCALiMhe94odM2DSrnGDbHUy++HTj3fiZLX3Wi4vLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102493; c=relaxed/simple;
	bh=1wVQRnx1RGnGuYGBwAjRTxmrmYIHTRjbRXbTBnF0Dsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6GCvk3LoJXr22cb3+Lp8LHisosTBZUn6pznpkJ1CmOaF9G6vWxzdQHSKDh8MGvsZmK3H3ZBz7IHE7pNKwUutZWGVAlFOl+l3V8BlBXny037t8K4DO8/F8KSOSMT2P2zKOHGNVFI3Hsxt7WsKiN1iTHX0IgNBuM6t3f+jFRk0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zexLsh5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1546BC4CEF1;
	Fri, 10 Oct 2025 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760102493;
	bh=1wVQRnx1RGnGuYGBwAjRTxmrmYIHTRjbRXbTBnF0Dsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zexLsh5SEj7uOd1aIl0ERGCQqfU5+i9JXr674M7sTZdp4dassFzXaVe8WYw6XwAnV
	 eBCkwWExBcpNx6SYIfK+VsIebVI86987ZhWIERhNQU/OfIMZKI49PsAdyMzGl+HWPe
	 dyiI9XhpYStpP6Gvi5d6KGA/FIx69obU1oH0a3ps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 6.12 34/35] net/9p: fix double req put in p9_fd_cancelled
Date: Fri, 10 Oct 2025 15:16:36 +0200
Message-ID: <20251010131333.017863798@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
References: <20251010131331.785281312@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>

commit 674b56aa57f9379854cb6798c3bbcef7e7b51ab7 upstream.

Syzkaller reports a KASAN issue as below:

general protection fault, probably for non-canonical address 0xfbd59c0000000021: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdead000000000108-0xdead00000000010f]
CPU: 0 PID: 5083 Comm: syz-executor.2 Not tainted 6.1.134-syzkaller-00037-g855bd1d7d838 #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:__list_del include/linux/list.h:114 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:137 [inline]
RIP: 0010:list_del include/linux/list.h:148 [inline]
RIP: 0010:p9_fd_cancelled+0xe9/0x200 net/9p/trans_fd.c:734

Call Trace:
 <TASK>
 p9_client_flush+0x351/0x440 net/9p/client.c:614
 p9_client_rpc+0xb6b/0xc70 net/9p/client.c:734
 p9_client_version net/9p/client.c:920 [inline]
 p9_client_create+0xb51/0x1240 net/9p/client.c:1027
 v9fs_session_init+0x1f0/0x18f0 fs/9p/v9fs.c:408
 v9fs_mount+0xba/0xcb0 fs/9p/vfs_super.c:126
 legacy_get_tree+0x108/0x220 fs/fs_context.c:632
 vfs_get_tree+0x8e/0x300 fs/super.c:1573
 do_new_mount fs/namespace.c:3056 [inline]
 path_mount+0x6a6/0x1e90 fs/namespace.c:3386
 do_mount fs/namespace.c:3399 [inline]
 __do_sys_mount fs/namespace.c:3607 [inline]
 __se_sys_mount fs/namespace.c:3584 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3584
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

This happens because of a race condition between:

- The 9p client sending an invalid flush request and later cleaning it up;
- The 9p client in p9_read_work() canceled all pending requests.

      Thread 1                              Thread 2
    ...
    p9_client_create()
    ...
    p9_fd_create()
    ...
    p9_conn_create()
    ...
    // start Thread 2
    INIT_WORK(&m->rq, p9_read_work);
                                        p9_read_work()
    ...
    p9_client_rpc()
    ...
                                        ...
                                        p9_conn_cancel()
                                        ...
                                        spin_lock(&m->req_lock);
    ...
    p9_fd_cancelled()
    ...
                                        ...
                                        spin_unlock(&m->req_lock);
                                        // status rewrite
                                        p9_client_cb(m->client, req, REQ_STATUS_ERROR)
                                        // first remove
                                        list_del(&req->req_list);
                                        ...

    spin_lock(&m->req_lock)
    ...
    // second remove
    list_del(&req->req_list);
    spin_unlock(&m->req_lock)
  ...

Commit 74d6a5d56629 ("9p/trans_fd: Fix concurrency del of req_list in
p9_fd_cancelled/p9_read_work") fixes a concurrency issue in the 9p filesystem
client where the req_list could be deleted simultaneously by both
p9_read_work and p9_fd_cancelled functions, but for the case where req->status
equals REQ_STATUS_RCVD.

Update the check for req->status in p9_fd_cancelled to skip processing not
just received requests, but anything that is not SENT, as whatever
changed the state from SENT also removed the request from its list.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: afd8d6541155 ("9P: Add cancelled() to the transport functions.")
Cc: stable@vger.kernel.org
Signed-off-by: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
Message-ID: <20250715154815.3501030-1-Sergey.Nalivayko@kaspersky.com>
[updated the check from status == RECV || status == ERROR to status != SENT]
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/9p/trans_fd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -725,10 +725,10 @@ static int p9_fd_cancelled(struct p9_cli
 	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
 
 	spin_lock(&m->req_lock);
-	/* Ignore cancelled request if message has been received
-	 * before lock.
-	 */
-	if (req->status == REQ_STATUS_RCVD) {
+	/* Ignore cancelled request if status changed since the request was
+	 * processed in p9_client_flush()
+	*/
+	if (req->status != REQ_STATUS_SENT) {
 		spin_unlock(&m->req_lock);
 		return 0;
 	}



