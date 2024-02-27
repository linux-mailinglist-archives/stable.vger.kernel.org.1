Return-Path: <stable+bounces-25202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46620869836
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F090A294DBD
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F10145B3F;
	Tue, 27 Feb 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jYv0to5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17529145B37;
	Tue, 27 Feb 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044145; cv=none; b=oGHGefmlFb0EYVjQRLdBargwO7OI32nujWAVcWwGwhbObduWhYlyCTj60w2v/5a03qrFmSgJ5RR13a2Rbw0pDWLZuhyHRMyNhYF44xXA2qic9KE2eY1mRFkD7MxsTw8LOvLYpizrpukttev7xjR9WJAPHvDzdFmbibEwCSvqQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044145; c=relaxed/simple;
	bh=0RDkk7bdLJRw9Humqx+lEbLmEzaUPeqls0A3ZH3BCQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlZV/klLrzlTwImcEN19UiZ/3YIelYeXWjA4bLcytX1UslM/c8QSKAZw2ZITkOTkj7fWEa3R3rY2hjMSvAquYqKHHLjafwn9uJJn76vljoOU3HnFRqiBWbTyE8Gb+usZGvXTnYrgUKl31GHbdri4dOtWqW/GflWhoBSlV4lDNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jYv0to5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC35C433C7;
	Tue, 27 Feb 2024 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044145;
	bh=0RDkk7bdLJRw9Humqx+lEbLmEzaUPeqls0A3ZH3BCQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYv0to5f2fpfgAs6IS/Pq1+DqqqXsArXV1a1JwcG66BLVLJa15x7p8K/LcUoXyF/J
	 oQKuNGpR9peEB3mp0Txk4F8s9hVv+83skk5hPNvU/zFSh1s3FzjUXh2HSSpkPF/7uU
	 cAkjcRPaAE6TXT7UyNKtj1iEh/Zid02zUbGFO80o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 079/122] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
Date: Tue, 27 Feb 2024 14:27:20 +0100
Message-ID: <20240227131601.290702458@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
References: <20240227131558.694096204@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasiliy Kovalev <kovalev@altlinux.org>

commit 136cfaca22567a03bbb3bf53a43d8cb5748b80ec upstream.

The gtp_net_ops pernet operations structure for the subsystem must be
registered before registering the generic netlink family.

Syzkaller hit 'general protection fault in gtp_genl_dump_pdp' bug:

general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 5826 Comm: gtp Not tainted 6.8.0-rc3-std-def-alt1 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-alt1 04/01/2014
RIP: 0010:gtp_genl_dump_pdp+0x1be/0x800 [gtp]
Code: c6 89 c6 e8 64 e9 86 df 58 45 85 f6 0f 85 4e 04 00 00 e8 c5 ee 86
      df 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80>
      3c 02 00 0f 85 de 05 00 00 48 8b 44 24 18 4c 8b 30 4c 39 f0 74
RSP: 0018:ffff888014107220 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88800fcda588 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f1be4eb05c0(0000) GS:ffff88806ce80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1be4e766cf CR3: 000000000c33e000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? show_regs+0x90/0xa0
 ? die_addr+0x50/0xd0
 ? exc_general_protection+0x148/0x220
 ? asm_exc_general_protection+0x22/0x30
 ? gtp_genl_dump_pdp+0x1be/0x800 [gtp]
 ? __alloc_skb+0x1dd/0x350
 ? __pfx___alloc_skb+0x10/0x10
 genl_dumpit+0x11d/0x230
 netlink_dump+0x5b9/0xce0
 ? lockdep_hardirqs_on_prepare+0x253/0x430
 ? __pfx_netlink_dump+0x10/0x10
 ? kasan_save_track+0x10/0x40
 ? __kasan_kmalloc+0x9b/0xa0
 ? genl_start+0x675/0x970
 __netlink_dump_start+0x6fc/0x9f0
 genl_family_rcv_msg_dumpit+0x1bb/0x2d0
 ? __pfx_genl_family_rcv_msg_dumpit+0x10/0x10
 ? genl_op_from_small+0x2a/0x440
 ? cap_capable+0x1d0/0x240
 ? __pfx_genl_start+0x10/0x10
 ? __pfx_genl_dumpit+0x10/0x10
 ? __pfx_genl_done+0x10/0x10
 ? security_capable+0x9d/0xe0

Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Link: https://lore.kernel.org/r/20240214162733.34214-1-kovalev@altlinux.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/gtp.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1410,20 +1410,20 @@ static int __init gtp_init(void)
 	if (err < 0)
 		goto error_out;
 
-	err = genl_register_family(&gtp_genl_family);
+	err = register_pernet_subsys(&gtp_net_ops);
 	if (err < 0)
 		goto unreg_rtnl_link;
 
-	err = register_pernet_subsys(&gtp_net_ops);
+	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
-		goto unreg_genl_family;
+		goto unreg_pernet_subsys;
 
 	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
 		sizeof(struct pdp_ctx));
 	return 0;
 
-unreg_genl_family:
-	genl_unregister_family(&gtp_genl_family);
+unreg_pernet_subsys:
+	unregister_pernet_subsys(&gtp_net_ops);
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
 error_out:



