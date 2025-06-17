Return-Path: <stable+bounces-153226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C3ADD333
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004693BFF30
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7C2EA145;
	Tue, 17 Jun 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQ4aKNMd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F082EA140;
	Tue, 17 Jun 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175281; cv=none; b=EABT1TdkyoQlg55NyGcVsO+e0IxVAEufhg7ib6SaB6/AQhEdqJtnpeyh7U7XV/5pxjtnw6nhaSuNLede6sajsBfum4xNbHA0BU2FsM+v9AmZzdouEP+tb+/rnCctOjKiqMWHx/dIczQoycKZjymw/quvGWAvt3Mbl2CKy4HU87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175281; c=relaxed/simple;
	bh=m1voqT4z37XEcioiHzj4Hcb3Ar3nu+5tVvIL8UOh1L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVoaWgSigVTDE5mr/X/9dUDlW+sZiLQBhJ2evErW35v0l6y/bYEVfDMuhzuTQx9Qd+yc21ynwg4AIZLIE/MXl9CyaAmgR6toOf7/wz2bXKapkcPJgMaxlkbrF3tDTkbGNG/iLZJRuEIkjU0VrU2EVkXseficGOUETfMeh3db+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQ4aKNMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74443C4CEF0;
	Tue, 17 Jun 2025 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175280;
	bh=m1voqT4z37XEcioiHzj4Hcb3Ar3nu+5tVvIL8UOh1L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQ4aKNMdAb1bQxZRnw1hdXDtzT2hR20cOv4fpyOlMqzxgQ8qlX8wQjvyGbkaOcC4s
	 7gSIaQRc5AgLeUx9bgaJar+KSNIWIzvgzkHjp2KnMPQBPS63yL2ga/Wfu2lrlwXc9I
	 GNliLjk+UdoBtO8ZHBoqXxKTjKlDLFaLdw8SqUeo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 111/512] bpf: fix ktls panic with sockmap
Date: Tue, 17 Jun 2025 17:21:17 +0200
Message-ID: <20250617152424.086639859@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 54a3ecaeeeae8176da8badbd7d72af1017032c39 ]

[ 2172.936997] ------------[ cut here ]------------
[ 2172.936999] kernel BUG at lib/iov_iter.c:629!
......
[ 2172.944996] PKRU: 55555554
[ 2172.945155] Call Trace:
[ 2172.945299]  <TASK>
[ 2172.945428]  ? die+0x36/0x90
[ 2172.945601]  ? do_trap+0xdd/0x100
[ 2172.945795]  ? iov_iter_revert+0x178/0x180
[ 2172.946031]  ? iov_iter_revert+0x178/0x180
[ 2172.946267]  ? do_error_trap+0x7d/0x110
[ 2172.946499]  ? iov_iter_revert+0x178/0x180
[ 2172.946736]  ? exc_invalid_op+0x50/0x70
[ 2172.946961]  ? iov_iter_revert+0x178/0x180
[ 2172.947197]  ? asm_exc_invalid_op+0x1a/0x20
[ 2172.947446]  ? iov_iter_revert+0x178/0x180
[ 2172.947683]  ? iov_iter_revert+0x5c/0x180
[ 2172.947913]  tls_sw_sendmsg_locked.isra.0+0x794/0x840
[ 2172.948206]  tls_sw_sendmsg+0x52/0x80
[ 2172.948420]  ? inet_sendmsg+0x1f/0x70
[ 2172.948634]  __sys_sendto+0x1cd/0x200
[ 2172.948848]  ? find_held_lock+0x2b/0x80
[ 2172.949072]  ? syscall_trace_enter+0x140/0x270
[ 2172.949330]  ? __lock_release.isra.0+0x5e/0x170
[ 2172.949595]  ? find_held_lock+0x2b/0x80
[ 2172.949817]  ? syscall_trace_enter+0x140/0x270
[ 2172.950211]  ? lockdep_hardirqs_on_prepare+0xda/0x190
[ 2172.950632]  ? ktime_get_coarse_real_ts64+0xc2/0xd0
[ 2172.951036]  __x64_sys_sendto+0x24/0x30
[ 2172.951382]  do_syscall_64+0x90/0x170
......

After calling bpf_exec_tx_verdict(), the size of msg_pl->sg may increase,
e.g., when the BPF program executes bpf_msg_push_data().

If the BPF program sets cork_bytes and sg.size is smaller than cork_bytes,
it will return -ENOSPC and attempt to roll back to the non-zero copy
logic. However, during rollback, msg->msg_iter is reset, but since
msg_pl->sg.size has been increased, subsequent executions will exceed the
actual size of msg_iter.
'''
iov_iter_revert(&msg->msg_iter, msg_pl->sg.size - orig_size);
'''

The changes in this commit are based on the following considerations:

1. When cork_bytes is set, rolling back to non-zero copy logic is
pointless and can directly go to zero-copy logic.

2. We can not calculate the correct number of bytes to revert msg_iter.

Assume the original data is "abcdefgh" (8 bytes), and after 3 pushes
by the BPF program, it becomes 11-byte data: "abc?de?fgh?".
Then, we set cork_bytes to 6, which means the first 6 bytes have been
processed, and the remaining 5 bytes "?fgh?" will be cached until the
length meets the cork_bytes requirement.

However, some data in "?fgh?" is not within 'sg->msg_iter'
(but in msg_pl instead), especially the data "?" we pushed.

So it doesn't seem as simple as just reverting through an offset of
msg_iter.

3. For non-TLS sockets in tcp_bpf_sendmsg, when a "cork" situation occurs,
the user-space send() doesn't return an error, and the returned length is
the same as the input length parameter, even if some data is cached.

Additionally, I saw that the current non-zero-copy logic for handling
corking is written as:
'''
line 1177
else if (ret != -EAGAIN) {
	if (ret == -ENOSPC)
		ret = 0;
	goto send_end;
'''

So it's ok to just return 'copied' without error when a "cork" situation
occurs.

Fixes: fcb14cb1bdac ("new iov_iter flavour - ITER_UBUF")
Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20250219052015.274405-2-jiayuan.chen@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 7bcc9b4408a2c..b3cae4dd4f499 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1120,9 +1120,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
-				else if (ctx->open_rec && ret == -ENOSPC)
+				else if (ctx->open_rec && ret == -ENOSPC) {
+					if (msg_pl->cork_bytes) {
+						ret = 0;
+						goto send_end;
+					}
 					goto rollback_iter;
-				else if (ret != -EAGAIN)
+				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
 			continue;
-- 
2.39.5




