Return-Path: <stable+bounces-36059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F48999B1
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA6BB2318E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA130160790;
	Fri,  5 Apr 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SGD5sqoe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C41DFED
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309909; cv=none; b=GMAGbsHjVO+enBdLrtrzVnR5CBgrNEOf40jMz+YrpXSJ4Sa8Pzn9OUwuBbdPCbGuMaIDhd5449qdkZZC29NBxyxI5H3Vbp7iBqhwKXqppjsYRO8rY1Hsi1fuvdToxDLw+e41ziOOh77MQBXWsJOoBYCwHD7Mi+9vYaP9e75shoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309909; c=relaxed/simple;
	bh=vDe9M1IlmS8Ac9JzlECu4bkoCLhxMy9PKw9a+hXtctw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fYOEO+pL9M+3+ZHCFdz+00Rg13wTzPEq4niHbFVKc1pF+yLBhMyd7f9Xufg0I2lgRlf7U2Qa64Ivt3mgPnV7Z+kHRxAslgUry3xZ6RJ8zn7IHolWHcYu1qCfxyAkQYDGtb3UaNYTkrJvpTjmtHSnqQnGfcj3MwD+VHXBUQcuDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SGD5sqoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A472BC433C7;
	Fri,  5 Apr 2024 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309909;
	bh=vDe9M1IlmS8Ac9JzlECu4bkoCLhxMy9PKw9a+hXtctw=;
	h=Subject:To:Cc:From:Date:From;
	b=SGD5sqoeMkabGJF+LcIkQKlY9/UzgwzGuBCue+9Qq/g3VXEyZYzfbDuRyUvhd3j91
	 OaGbi2lhsx+q1so+0FXS9A8tj32DLrxy6h+EgZ0N4PYFrkD6QJGINW7tmhhizH/5hA
	 v0ejVqEuFb5wfTCCHgnRCZ4bprJ/2ssMPG0uBGUI=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: flush pending destroy work before" failed to apply to 4.19-stable tree
To: pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 11:38:26 +0200
Message-ID: <2024040525-ripening-clunky-4fa7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 24cea9677025e0de419989ecb692acd4bb34cac2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040525-ripening-clunky-4fa7@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24cea9677025e0de419989ecb692acd4bb34cac2 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Tue, 2 Apr 2024 18:04:36 +0200
Subject: [PATCH] netfilter: nf_tables: flush pending destroy work before
 exit_net release

Similar to 2c9f0293280e ("netfilter: nf_tables: flush pending destroy
work before netlink notifier") to address a race between exit_net and
the destroy workqueue.

The trace below shows an element to be released via destroy workqueue
while exit_net path (triggered via module removal) has already released
the set that is used in such transaction.

[ 1360.547789] BUG: KASAN: slab-use-after-free in nf_tables_trans_destroy_work+0x3f5/0x590 [nf_tables]
[ 1360.547861] Read of size 8 at addr ffff888140500cc0 by task kworker/4:1/152465
[ 1360.547870] CPU: 4 PID: 152465 Comm: kworker/4:1 Not tainted 6.8.0+ #359
[ 1360.547882] Workqueue: events nf_tables_trans_destroy_work [nf_tables]
[ 1360.547984] Call Trace:
[ 1360.547991]  <TASK>
[ 1360.547998]  dump_stack_lvl+0x53/0x70
[ 1360.548014]  print_report+0xc4/0x610
[ 1360.548026]  ? __virt_addr_valid+0xba/0x160
[ 1360.548040]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[ 1360.548054]  ? nf_tables_trans_destroy_work+0x3f5/0x590 [nf_tables]
[ 1360.548176]  kasan_report+0xae/0xe0
[ 1360.548189]  ? nf_tables_trans_destroy_work+0x3f5/0x590 [nf_tables]
[ 1360.548312]  nf_tables_trans_destroy_work+0x3f5/0x590 [nf_tables]
[ 1360.548447]  ? __pfx_nf_tables_trans_destroy_work+0x10/0x10 [nf_tables]
[ 1360.548577]  ? _raw_spin_unlock_irq+0x18/0x30
[ 1360.548591]  process_one_work+0x2f1/0x670
[ 1360.548610]  worker_thread+0x4d3/0x760
[ 1360.548627]  ? __pfx_worker_thread+0x10/0x10
[ 1360.548640]  kthread+0x16b/0x1b0
[ 1360.548653]  ? __pfx_kthread+0x10/0x10
[ 1360.548665]  ret_from_fork+0x2f/0x50
[ 1360.548679]  ? __pfx_kthread+0x10/0x10
[ 1360.548690]  ret_from_fork_asm+0x1a/0x30
[ 1360.548707]  </TASK>

[ 1360.548719] Allocated by task 192061:
[ 1360.548726]  kasan_save_stack+0x20/0x40
[ 1360.548739]  kasan_save_track+0x14/0x30
[ 1360.548750]  __kasan_kmalloc+0x8f/0xa0
[ 1360.548760]  __kmalloc_node+0x1f1/0x450
[ 1360.548771]  nf_tables_newset+0x10c7/0x1b50 [nf_tables]
[ 1360.548883]  nfnetlink_rcv_batch+0xbc4/0xdc0 [nfnetlink]
[ 1360.548909]  nfnetlink_rcv+0x1a8/0x1e0 [nfnetlink]
[ 1360.548927]  netlink_unicast+0x367/0x4f0
[ 1360.548935]  netlink_sendmsg+0x34b/0x610
[ 1360.548944]  ____sys_sendmsg+0x4d4/0x510
[ 1360.548953]  ___sys_sendmsg+0xc9/0x120
[ 1360.548961]  __sys_sendmsg+0xbe/0x140
[ 1360.548971]  do_syscall_64+0x55/0x120
[ 1360.548982]  entry_SYSCALL_64_after_hwframe+0x55/0x5d

[ 1360.548994] Freed by task 192222:
[ 1360.548999]  kasan_save_stack+0x20/0x40
[ 1360.549009]  kasan_save_track+0x14/0x30
[ 1360.549019]  kasan_save_free_info+0x3b/0x60
[ 1360.549028]  poison_slab_object+0x100/0x180
[ 1360.549036]  __kasan_slab_free+0x14/0x30
[ 1360.549042]  kfree+0xb6/0x260
[ 1360.549049]  __nft_release_table+0x473/0x6a0 [nf_tables]
[ 1360.549131]  nf_tables_exit_net+0x170/0x240 [nf_tables]
[ 1360.549221]  ops_exit_list+0x50/0xa0
[ 1360.549229]  free_exit_list+0x101/0x140
[ 1360.549236]  unregister_pernet_operations+0x107/0x160
[ 1360.549245]  unregister_pernet_subsys+0x1c/0x30
[ 1360.549254]  nf_tables_module_exit+0x43/0x80 [nf_tables]
[ 1360.549345]  __do_sys_delete_module+0x253/0x370
[ 1360.549352]  do_syscall_64+0x55/0x120
[ 1360.549360]  entry_SYSCALL_64_after_hwframe+0x55/0x5d

(gdb) list *__nft_release_table+0x473
0x1e033 is in __nft_release_table (net/netfilter/nf_tables_api.c:11354).
11349           list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
11350                   list_del(&flowtable->list);
11351                   nft_use_dec(&table->use);
11352                   nf_tables_flowtable_destroy(flowtable);
11353           }
11354           list_for_each_entry_safe(set, ns, &table->sets, list) {
11355                   list_del(&set->list);
11356                   nft_use_dec(&table->use);
11357                   if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
11358                           nft_map_deactivate(&ctx, set);
(gdb)

[ 1360.549372] Last potentially related work creation:
[ 1360.549376]  kasan_save_stack+0x20/0x40
[ 1360.549384]  __kasan_record_aux_stack+0x9b/0xb0
[ 1360.549392]  __queue_work+0x3fb/0x780
[ 1360.549399]  queue_work_on+0x4f/0x60
[ 1360.549407]  nft_rhash_remove+0x33b/0x340 [nf_tables]
[ 1360.549516]  nf_tables_commit+0x1c6a/0x2620 [nf_tables]
[ 1360.549625]  nfnetlink_rcv_batch+0x728/0xdc0 [nfnetlink]
[ 1360.549647]  nfnetlink_rcv+0x1a8/0x1e0 [nfnetlink]
[ 1360.549671]  netlink_unicast+0x367/0x4f0
[ 1360.549680]  netlink_sendmsg+0x34b/0x610
[ 1360.549690]  ____sys_sendmsg+0x4d4/0x510
[ 1360.549697]  ___sys_sendmsg+0xc9/0x120
[ 1360.549706]  __sys_sendmsg+0xbe/0x140
[ 1360.549715]  do_syscall_64+0x55/0x120
[ 1360.549725]  entry_SYSCALL_64_after_hwframe+0x55/0x5d

Fixes: 0935d5588400 ("netfilter: nf_tables: asynchronous release")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0d432d0674e1..17bf53cd0e84 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -11575,6 +11575,7 @@ static void __exit nf_tables_module_exit(void)
 	unregister_netdevice_notifier(&nf_tables_flowtable_notifier);
 	nft_chain_filter_fini();
 	nft_chain_route_fini();
+	nf_tables_trans_destroy_flush_work();
 	unregister_pernet_subsys(&nf_tables_net_ops);
 	cancel_work_sync(&trans_gc_work);
 	cancel_work_sync(&trans_destroy_work);


