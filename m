Return-Path: <stable+bounces-167494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A3EB23050
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182F9685AAC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1F92F7449;
	Tue, 12 Aug 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdxGwQpS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F5257435;
	Tue, 12 Aug 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021007; cv=none; b=gpmcVK4MpcPGo0rxBCYWhLkVSEpO0ImIiPJInQ62YeeiI7ccm9FJkMmOlj9MAOVcEfw47Icl3IDfeZ/A7cEYsmMvlkimm99oIsfobZjAZbFJ1rIegX/hwGFzkvgujQ+/NLWpmu2LvLVoOLq8MgrGIkGcUUxOxMszAl7QgItqhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021007; c=relaxed/simple;
	bh=b8qAHLcjRSwLA8VzTaTfV8m74IU+R10UXv9Ht5yHksk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7TtB5h71pCvj5VZVyiUIOfuZdIuwL7aob7e1G2XM+5/RTj0k3xNYiDyvo2YlERUmFqaiyQkiFUY4Caz8YSEILPysTaEFXunsn2lk9NsOtL3r+VRZ58pP455+H0jx0A901/bbhtXMLv0CyXGqMge/rf9+lx0uw5kWMlo+1W1blU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdxGwQpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D25C4CEF0;
	Tue, 12 Aug 2025 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021007;
	bh=b8qAHLcjRSwLA8VzTaTfV8m74IU+R10UXv9Ht5yHksk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdxGwQpSZaLFJoSRNFowHAwyueoNJROJLuC+/0Yy14Xvz9jxOTod6xMzWEm6XdSJw
	 sc3m4F2wFTEK7Rhlb5a085RSaXWLQoXOVdefgwcDUoWui/EeHnOSHuXlEk3kyN4xty
	 E/2eucpuPfKveEe9slkOdUommMnY9MmAsWYfp4Zo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 049/262] bpf, sockmap: Fix psock incorrectly pointing to sk
Date: Tue, 12 Aug 2025 19:27:17 +0200
Message-ID: <20250812172955.065410793@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 76be5fae32febb1fdb848ba09f78c4b2c76cb337 ]

We observed an issue from the latest selftest: sockmap_redir where
sk_psock(psock->sk) != psock in the backlog. The root cause is the special
behavior in sockmap_redir - it frequently performs map_update() and
map_delete() on the same socket. During map_update(), we create a new
psock and during map_delete(), we eventually free the psock via rcu_work
in sk_psock_drop(). However, pending workqueues might still exist and not
be processed yet. If users immediately perform another map_update(), a new
psock will be allocated for the same sk, resulting in two psocks pointing
to the same sk.

When the pending workqueue is later triggered, it uses the old psock to
access sk for I/O operations, which is incorrect.

Timing Diagram:

cpu0                        cpu1

map_update(sk):
    sk->psock = psock1
    psock1->sk = sk
map_delete(sk):
   rcu_work_free(psock1)

map_update(sk):
    sk->psock = psock2
    psock2->sk = sk
                            workqueue:
                                wakeup with psock1, but the sk of psock1
                                doesn't belong to psock1
rcu_handler:
    clean psock1
    free(psock1)

Previously, we used reference counting to address the concurrency issue
between backlog and sock_map_close(). This logic remains necessary as it
prevents the sk from being freed while processing the backlog. But this
patch prevents pending backlogs from using a psock after it has been
stopped.

Note: We cannot call cancel_delayed_work_sync() in map_delete() since this
might be invoked in BPF context by BPF helper, and the function may sleep.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20250609025908.79331-1-jiayuan.chen@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index c3169e1e6352..6225547808a6 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -655,6 +655,13 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	/* If sk is quickly removed from the map and then added back, the old
+	 * psock should not be scheduled, because there are now two psocks
+	 * pointing to the same sk.
+	 */
+	if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+		return;
+
 	/* Increment the psock refcnt to synchronize with close(fd) path in
 	 * sock_map_close(), ensuring we wait for backlog thread completion
 	 * before sk_socket freed. If refcnt increment fails, it indicates
-- 
2.39.5




