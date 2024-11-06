Return-Path: <stable+bounces-91497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC749BEE41
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A91F2133F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECCB1E0B7A;
	Wed,  6 Nov 2024 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PhMYYUVE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20A1DE2CF;
	Wed,  6 Nov 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898906; cv=none; b=BXsOoc3sqY478nAlZVLINxcFenyZhcK83tBuAGkl1NYGvE5HvmVmMg0F74a1nvXMtw3e+VExv170N0TzFTrIIlQQ2FVB6wXr9B9rIjhy0pYmG3VRbKbWR1Ef7ixFR+UodckeNJBnPvLXawGvu8WlhQSkABfaYpAxFT8ttMmevCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898906; c=relaxed/simple;
	bh=Z+l9ChJYgiIoZBbLLSGvVyJR6jlG7zIava7imY4NwV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNJsGzkzQUthWSKpzSVY1N8WBHZE6Xx9aGV/1+COsyqM09bp8kcCfqEXn0s1nDjbDEXF1fqkbHoSulTjq1Pmk+rWsm7FE4BgLUYBTH6m8HdEvXcDIGiYRoJNK8bIowZXjlXcol3yshXMEwgBBSy0H3LNa8i6H3Ki+NADfJwn0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PhMYYUVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0F8C4CECD;
	Wed,  6 Nov 2024 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898905;
	bh=Z+l9ChJYgiIoZBbLLSGvVyJR6jlG7zIava7imY4NwV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PhMYYUVEZoPiCdhKGIIvplzG8mqb1XOnNJDjxAeo1j3IJkPjh3E5+y4DUlcQU0FzX
	 QnvNHaEKEsTQIOMdbbVIC9F20T3hlocaL3l9DgERGnVUncC7MaqrZGBEc1exwMUyw0
	 urbpN53OMaKiXL/fM2kRNiq7kS8HuYVANA7oRCEU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 396/462] usb: typec: altmode should keep reference to parent
Date: Wed,  6 Nov 2024 13:04:49 +0100
Message-ID: <20241106120341.306111151@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

[ Upstream commit befab3a278c59db0cc88c8799638064f6d3fd6f8 ]

The altmode device release refers to its parent device, but without keeping
a reference to it.

When registering the altmode, get a reference to the parent and put it in
the release function.

Before this fix, when using CONFIG_DEBUG_KOBJECT_RELEASE, we see issues
like this:

[   43.572860] kobject: 'port0.0' (ffff8880057ba008): kobject_release, parent 0000000000000000 (delayed 3000)
[   43.573532] kobject: 'port0.1' (ffff8880057bd008): kobject_release, parent 0000000000000000 (delayed 1000)
[   43.574407] kobject: 'port0' (ffff8880057b9008): kobject_release, parent 0000000000000000 (delayed 3000)
[   43.575059] kobject: 'port1.0' (ffff8880057ca008): kobject_release, parent 0000000000000000 (delayed 4000)
[   43.575908] kobject: 'port1.1' (ffff8880057c9008): kobject_release, parent 0000000000000000 (delayed 4000)
[   43.576908] kobject: 'typec' (ffff8880062dbc00): kobject_release, parent 0000000000000000 (delayed 4000)
[   43.577769] kobject: 'port1' (ffff8880057bf008): kobject_release, parent 0000000000000000 (delayed 3000)
[   46.612867] ==================================================================
[   46.613402] BUG: KASAN: slab-use-after-free in typec_altmode_release+0x38/0x129
[   46.614003] Read of size 8 at addr ffff8880057b9118 by task kworker/2:1/48
[   46.614538]
[   46.614668] CPU: 2 UID: 0 PID: 48 Comm: kworker/2:1 Not tainted 6.12.0-rc1-00138-gedbae730ad31 #535
[   46.615391] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   46.616042] Workqueue: events kobject_delayed_cleanup
[   46.616446] Call Trace:
[   46.616648]  <TASK>
[   46.616820]  dump_stack_lvl+0x5b/0x7c
[   46.617112]  ? typec_altmode_release+0x38/0x129
[   46.617470]  print_report+0x14c/0x49e
[   46.617769]  ? rcu_read_unlock_sched+0x56/0x69
[   46.618117]  ? __virt_addr_valid+0x19a/0x1ab
[   46.618456]  ? kmem_cache_debug_flags+0xc/0x1d
[   46.618807]  ? typec_altmode_release+0x38/0x129
[   46.619161]  kasan_report+0x8d/0xb4
[   46.619447]  ? typec_altmode_release+0x38/0x129
[   46.619809]  ? process_scheduled_works+0x3cb/0x85f
[   46.620185]  typec_altmode_release+0x38/0x129
[   46.620537]  ? process_scheduled_works+0x3cb/0x85f
[   46.620907]  device_release+0xaf/0xf2
[   46.621206]  kobject_delayed_cleanup+0x13b/0x17a
[   46.621584]  process_scheduled_works+0x4f6/0x85f
[   46.621955]  ? __pfx_process_scheduled_works+0x10/0x10
[   46.622353]  ? hlock_class+0x31/0x9a
[   46.622647]  ? lock_acquired+0x361/0x3c3
[   46.622956]  ? move_linked_works+0x46/0x7d
[   46.623277]  worker_thread+0x1ce/0x291
[   46.623582]  ? __kthread_parkme+0xc8/0xdf
[   46.623900]  ? __pfx_worker_thread+0x10/0x10
[   46.624236]  kthread+0x17e/0x190
[   46.624501]  ? kthread+0xfb/0x190
[   46.624756]  ? __pfx_kthread+0x10/0x10
[   46.625015]  ret_from_fork+0x20/0x40
[   46.625268]  ? __pfx_kthread+0x10/0x10
[   46.625532]  ret_from_fork_asm+0x1a/0x30
[   46.625805]  </TASK>
[   46.625953]
[   46.626056] Allocated by task 678:
[   46.626287]  kasan_save_stack+0x24/0x44
[   46.626555]  kasan_save_track+0x14/0x2d
[   46.626811]  __kasan_kmalloc+0x3f/0x4d
[   46.627049]  __kmalloc_noprof+0x1bf/0x1f0
[   46.627362]  typec_register_port+0x23/0x491
[   46.627698]  cros_typec_probe+0x634/0xbb6
[   46.628026]  platform_probe+0x47/0x8c
[   46.628311]  really_probe+0x20a/0x47d
[   46.628605]  device_driver_attach+0x39/0x72
[   46.628940]  bind_store+0x87/0xd7
[   46.629213]  kernfs_fop_write_iter+0x1aa/0x218
[   46.629574]  vfs_write+0x1d6/0x29b
[   46.629856]  ksys_write+0xcd/0x13b
[   46.630128]  do_syscall_64+0xd4/0x139
[   46.630420]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   46.630820]
[   46.630946] Freed by task 48:
[   46.631182]  kasan_save_stack+0x24/0x44
[   46.631493]  kasan_save_track+0x14/0x2d
[   46.631799]  kasan_save_free_info+0x3f/0x4d
[   46.632144]  __kasan_slab_free+0x37/0x45
[   46.632474]  kfree+0x1d4/0x252
[   46.632725]  device_release+0xaf/0xf2
[   46.633017]  kobject_delayed_cleanup+0x13b/0x17a
[   46.633388]  process_scheduled_works+0x4f6/0x85f
[   46.633764]  worker_thread+0x1ce/0x291
[   46.634065]  kthread+0x17e/0x190
[   46.634324]  ret_from_fork+0x20/0x40
[   46.634621]  ret_from_fork_asm+0x1a/0x30

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20241004123738.2964524-1-cascardo@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/class.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 371e010e0e859..c30740165b364 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -471,6 +471,7 @@ static void typec_altmode_release(struct device *dev)
 		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
+	put_device(alt->adev.dev.parent);
 	kfree(alt);
 }
 
@@ -520,6 +521,8 @@ typec_register_altmode(struct device *parent,
 	alt->adev.dev.type = &typec_altmode_dev_type;
 	dev_set_name(&alt->adev.dev, "%s.%u", dev_name(parent), id);
 
+	get_device(alt->adev.dev.parent);
+
 	/* Link partners and plugs with the ports */
 	if (is_port)
 		BLOCKING_INIT_NOTIFIER_HEAD(&alt->nh);
-- 
2.43.0




