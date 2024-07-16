Return-Path: <stable+bounces-59910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F76932C64
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC673B2422F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7219E81D;
	Tue, 16 Jul 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ypNquRKn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8619E7FF;
	Tue, 16 Jul 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145280; cv=none; b=GoVzs74VnzIMcsRQ60xXR+CRsi9SIEelO+n0mR9oYBaosZFFkMRfaiywQ6GWwZ4AJ19r2o/5mZjBlaTgQNg4gxFJdUlp4p9lrSp1sX/UhABWO70zIQV5cpIecfZekeTcurmIE3x7hX3qvzq3My5ZFyit7I5AJyK73rTMRB56VdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145280; c=relaxed/simple;
	bh=XQrgh7586fcNmMnktbOrPEJHmDl4/uB/vcIKXGSIygI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHS62v5sELxrXUM2gwvT9pEeJZK+hHXJmH7ruDgUjF4Ie+p3OJYC+iCQS/uFSibOM52GxZVaryTYH8/XzshowfLUipg/HE/ED0lWrQkuB1WDK4eq5p/TD1U64KwDmhLCyEyuGde9rbHjZNBazE9wesPyJ8EShnrK/uf6p9CR/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ypNquRKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA072C4AF0B;
	Tue, 16 Jul 2024 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145280;
	bh=XQrgh7586fcNmMnktbOrPEJHmDl4/uB/vcIKXGSIygI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ypNquRKn4mQxbrXeYU5S/jDUwOCY6yjU7s5PKFtmmxPw8X0O02M224nDKo0pJMR86
	 W0YVIsS5RE69ORblKNCYmjZ320ryasiiEPy86fCf1ySjelRU7WIUjXqvYORL3Tsf+D
	 C11wATIMula5nJrFl4nWBqa++eZf6sfVxncPfhsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Fastabend <john.fastabend@gmail.com>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 14/96] skmsg: Skip zero length skb in sk_msg_recvmsg
Date: Tue, 16 Jul 2024 17:31:25 +0200
Message-ID: <20240716152747.065949618@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152746.516194097@linuxfoundation.org>
References: <20240716152746.516194097@linuxfoundation.org>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit f0c18025693707ec344a70b6887f7450bf4c826b ]

When running BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
platform, the following kernel panic occurs:

  [...]
  Oops[#1]:
  CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE  6.10.0-rc2+ #18
  Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
     ... ...
     ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
    ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
   PRMD: 0000000c (PPLV0 +PIE +PWE)
   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
   ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
  ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
   BADV: 0000000000000040
   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
  Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrack
  Process test_progs (pid: 2824, threadinfo=0000000000863a31, task=...)
  Stack : ...
  Call Trace:
  [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
  [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
  [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
  [<90000000049aae34>] inet_recvmsg+0x54/0x100
  [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
  [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
  [<900000000481e27c>] sys_recvfrom+0x1c/0x40
  [<9000000004c076ec>] do_syscall+0x8c/0xc0
  [<9000000003731da4>] handle_syscall+0xc4/0x160
  Code: ...
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Fatal exception
  Kernel relocated by 0x3510000
   .text @ 0x9000000003710000
   .data @ 0x9000000004d70000
   .bss  @ 0x9000000006469400
  ---[ end Kernel panic - not syncing: Fatal exception ]---
  [...]

This crash happens every time when running sockmap_skb_verdict_shutdown
subtest in sockmap_basic.

This crash is because a NULL pointer is passed to page_address() in the
sk_msg_recvmsg(). Due to the different implementations depending on the
architecture, page_address(NULL) will trigger a panic on Loongarch
platform but not on x86 platform. So this bug was hidden on x86 platform
for a while, but now it is exposed on Loongarch platform. The root cause
is that a zero length skb (skb->len == 0) was put on the queue.

This zero length skb is a TCP FIN packet, which was sent by shutdown(),
invoked in test_sockmap_skb_verdict_shutdown():

	shutdown(p1, SHUT_WR);

In this case, in sk_psock_skb_ingress_enqueue(), num_sge is zero, and no
page is put to this sge (see sg_set_page in sg_set_page), but this empty
sge is queued into ingress_msg list.

And in sk_msg_recvmsg(), this empty sge is used, and a NULL page is got by
sg_page(sge). Pass this NULL page to copy_page_to_iter(), which passes it
to kmap_local_page() and to page_address(), then kernel panics.

To solve this, we should skip this zero length skb. So in sk_msg_recvmsg(),
if copy is zero, that means it's a zero length skb, skip invoking
copy_page_to_iter(). We are using the EFAULT return triggered by
copy_page_to_iter to check for is_fin in tcp_bpf.c.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/e3a16eacdc6740658ee02a33489b1b9d4912f378.1719992715.git.tanggeliang@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 8b0459a6b629f..746d950de0e14 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -433,7 +433,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			page = sg_page(sge);
 			if (copied + copy > len)
 				copy = len - copied;
-			copy = copy_page_to_iter(page, sge->offset, copy, iter);
+			if (copy)
+				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy) {
 				copied = copied ? copied : -EFAULT;
 				goto out;
-- 
2.43.0




