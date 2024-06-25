Return-Path: <stable+bounces-55662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C49164A1
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70A81C20CBB
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E45149C58;
	Tue, 25 Jun 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LL+xfk5v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C101465A8;
	Tue, 25 Jun 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309568; cv=none; b=SaomIZk9HKpwwaM5eoEfr062m5hb3a+N83ofShhP9mYoUoPhJRmGy2Dd7jNFn8yD+JWqrw3ysO7dU8/JrI5eEZANXsXcGY4vm8DzlwBbiUfJgHLbafpviArGlpbr+ujHkMzf0sFvWQ+6c17u9GvgLOJydbhlpJ+mpLK7QxEOvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309568; c=relaxed/simple;
	bh=eA8gg5Kiv5k4eQMhFFyS4NY74wcDouuqkPpl/EnXYww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2etTMeYWNSvzeQ3g7Y/Crp/pIJGfF6S3gPyE98889ZUqry2IGZk29rayKs4F6MGghT149pz9GmkvRnVuJn8yPnTE+KV20glijLSirD4AkADzlk6P4VI2a+qG1mb/Pm3eyep1FuSFZ6KlOYK9nIr71ZkTSzl42qELU+8qDbcFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LL+xfk5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93899C32781;
	Tue, 25 Jun 2024 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309568;
	bh=eA8gg5Kiv5k4eQMhFFyS4NY74wcDouuqkPpl/EnXYww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LL+xfk5vFWY6kqssvNed6qgDEjzlpSqZQBicL2ZEsh8A1RMD8OhCMnjwGiOZ/PPOQ
	 06PA9fUhmwdSNuADq5lFa/8mW1VIj/ckZUrjSEGgngrJMfoqVKoSMWLnHtKYm3s9XJ
	 ataUgeUboOJNwZBHer76KpDr4aEyImamAsrw4BGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Haibing <yuehaibing@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/131] netns: Make get_net_ns() handle zero refcount net
Date: Tue, 25 Jun 2024 11:33:34 +0200
Message-ID: <20240625085528.191777801@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
References: <20240625085525.931079317@linuxfoundation.org>
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

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit ff960f9d3edbe08a736b5a224d91a305ccc946b0 ]

Syzkaller hit a warning:
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 3 PID: 7890 at lib/refcount.c:25 refcount_warn_saturate+0xdf/0x1d0
Modules linked in:
CPU: 3 PID: 7890 Comm: tun Not tainted 6.10.0-rc3-00100-gcaa4f9578aba-dirty #310
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0xdf/0x1d0
Code: 41 49 04 31 ff 89 de e8 9f 1e cd fe 84 db 75 9c e8 76 26 cd fe c6 05 b6 41 49 04 01 90 48 c7 c7 b8 8e 25 86 e8 d2 05 b5 fe 90 <0f> 0b 90 90 e9 79 ff ff ff e8 53 26 cd fe 0f b6 1
RSP: 0018:ffff8881067b7da0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff811c72ac
RDX: ffff8881026a2140 RSI: ffffffff811c72b5 RDI: 0000000000000001
RBP: ffff8881067b7db0 R08: 0000000000000000 R09: 205b5d3730353139
R10: 0000000000000000 R11: 205d303938375420 R12: ffff8881086500c4
R13: ffff8881086500c4 R14: ffff8881086500b0 R15: ffff888108650040
FS:  00007f5b2961a4c0(0000) GS:ffff88823bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d7ed36fd18 CR3: 00000001482f6000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? show_regs+0xa3/0xc0
 ? __warn+0xa5/0x1c0
 ? refcount_warn_saturate+0xdf/0x1d0
 ? report_bug+0x1fc/0x2d0
 ? refcount_warn_saturate+0xdf/0x1d0
 ? handle_bug+0xa1/0x110
 ? exc_invalid_op+0x3c/0xb0
 ? asm_exc_invalid_op+0x1f/0x30
 ? __warn_printk+0xcc/0x140
 ? __warn_printk+0xd5/0x140
 ? refcount_warn_saturate+0xdf/0x1d0
 get_net_ns+0xa4/0xc0
 ? __pfx_get_net_ns+0x10/0x10
 open_related_ns+0x5a/0x130
 __tun_chr_ioctl+0x1616/0x2370
 ? __sanitizer_cov_trace_switch+0x58/0xa0
 ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
 ? __pfx_tun_chr_ioctl+0x10/0x10
 tun_chr_ioctl+0x2f/0x40
 __x64_sys_ioctl+0x11b/0x160
 x64_sys_call+0x1211/0x20d0
 do_syscall_64+0x9e/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b28f165d7
Code: b3 66 90 48 8b 05 b1 48 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 48 2d 00 8
RSP: 002b:00007ffc2b59c5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5b28f165d7
RDX: 0000000000000000 RSI: 00000000000054e3 RDI: 0000000000000003
RBP: 00007ffc2b59c650 R08: 00007f5b291ed8c0 R09: 00007f5b2961a4c0
R10: 0000000029690010 R11: 0000000000000246 R12: 0000000000400730
R13: 00007ffc2b59cf40 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...

This is trigger as below:
          ns0                                    ns1
tun_set_iff() //dev is tun0
   tun->dev = dev
//ip link set tun0 netns ns1
                                       put_net() //ref is 0
__tun_chr_ioctl() //TUNGETDEVNETNS
   net = dev_net(tun->dev);
   open_related_ns(&net->ns, get_net_ns); //ns1
     get_net_ns()
        get_net() //addition on 0

Use maybe_get_net() in get_net_ns in case net's ref is zero to fix this

Fixes: 0c3e0e3bb623 ("tun: Add ioctl() TUNGETDEVNETNS cmd to allow obtaining real net ns of tun device")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20240614131302.2698509-1-yuehaibing@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/net_namespace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index c33930a171629..1d95a5adce4ec 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -657,11 +657,16 @@ EXPORT_SYMBOL_GPL(__put_net);
  * get_net_ns - increment the refcount of the network namespace
  * @ns: common namespace (net)
  *
- * Returns the net's common namespace.
+ * Returns the net's common namespace or ERR_PTR() if ref is zero.
  */
 struct ns_common *get_net_ns(struct ns_common *ns)
 {
-	return &get_net(container_of(ns, struct net, ns))->ns;
+	struct net *net;
+
+	net = maybe_get_net(container_of(ns, struct net, ns));
+	if (net)
+		return &net->ns;
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(get_net_ns);
 
-- 
2.43.0




