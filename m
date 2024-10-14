Return-Path: <stable+bounces-84768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5497A99D208
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5407B26047
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4B31BB6BB;
	Mon, 14 Oct 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iUnFYk3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983CD19E7ED;
	Mon, 14 Oct 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919147; cv=none; b=ZD4BercLKqEhIS+Pxz2/Or2UZUxtUY3ZyEwcsiU14mHpESQbE861nRSUugmt5ys+m/jUpHTZQkgU7OdBCsgLDk/0qRcMVc7eokKM+/7Iso47yFZeMILhNAYSNef98FKzk1meJ6chXIjHWjeQGzHeqHnCBbUjl0xPjqVNb5xmAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919147; c=relaxed/simple;
	bh=+fTDXqyN41RsroQ3i8xC98GMzo9wNbyxbwZUcdNNoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMdicJ0luFvnHxNsqebJ4PgHOveMBqd0pA8TOEaK3hdxp0nRwiosclnZjDBjaj1c+X25IlAM/BdkVn1B+OwGKd/2iYVPz9TmeZc7gsJLn3Jcdg4pbqQ+wLCtSJtEEDlfKnarlGeFLTfgnsRQTCDN51QHFyGDeUQb1I6o7DMnsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iUnFYk3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09134C4CEC3;
	Mon, 14 Oct 2024 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919147;
	bh=+fTDXqyN41RsroQ3i8xC98GMzo9wNbyxbwZUcdNNoWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUnFYk3dje2W4QuiKoqoZAcXGaPKsopg43xouOntk3EI/VjfgESKSMf1zurHVO5kd
	 1O7bmf/AihbmQUFHrRkYv9sBaMaQOAPE0wyujo1+t4zcJuBIIDeMFHIEJBlS+7wtE7
	 EsFucF7EsDRXWJYs34BUz0E240DWpOLpJOzDm7ZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zach Wade <zachwade.k@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.1 524/798] platform/x86: ISST: Fix the KASAN report slab-out-of-bounds bug
Date: Mon, 14 Oct 2024 16:17:58 +0200
Message-ID: <20241014141238.565742332@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

From: Zach Wade <zachwade.k@gmail.com>

commit 7d59ac07ccb58f8f604f8057db63b8efcebeb3de upstream.

Attaching SST PCI device to VM causes "BUG: KASAN: slab-out-of-bounds".
kasan report:
[   19.411889] ==================================================================
[   19.413702] BUG: KASAN: slab-out-of-bounds in _isst_if_get_pci_dev+0x3d5/0x400 [isst_if_common]
[   19.415634] Read of size 8 at addr ffff888829e65200 by task cpuhp/16/113
[   19.417368]
[   19.418627] CPU: 16 PID: 113 Comm: cpuhp/16 Tainted: G            E      6.9.0 #10
[   19.420435] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.20192059.B64.2207280713 07/28/2022
[   19.422687] Call Trace:
[   19.424091]  <TASK>
[   19.425448]  dump_stack_lvl+0x5d/0x80
[   19.426963]  ? _isst_if_get_pci_dev+0x3d5/0x400 [isst_if_common]
[   19.428694]  print_report+0x19d/0x52e
[   19.430206]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   19.431837]  ? _isst_if_get_pci_dev+0x3d5/0x400 [isst_if_common]
[   19.433539]  kasan_report+0xf0/0x170
[   19.435019]  ? _isst_if_get_pci_dev+0x3d5/0x400 [isst_if_common]
[   19.436709]  _isst_if_get_pci_dev+0x3d5/0x400 [isst_if_common]
[   19.438379]  ? __pfx_sched_clock_cpu+0x10/0x10
[   19.439910]  isst_if_cpu_online+0x406/0x58f [isst_if_common]
[   19.441573]  ? __pfx_isst_if_cpu_online+0x10/0x10 [isst_if_common]
[   19.443263]  ? ttwu_queue_wakelist+0x2c1/0x360
[   19.444797]  cpuhp_invoke_callback+0x221/0xec0
[   19.446337]  cpuhp_thread_fun+0x21b/0x610
[   19.447814]  ? __pfx_cpuhp_thread_fun+0x10/0x10
[   19.449354]  smpboot_thread_fn+0x2e7/0x6e0
[   19.450859]  ? __pfx_smpboot_thread_fn+0x10/0x10
[   19.452405]  kthread+0x29c/0x350
[   19.453817]  ? __pfx_kthread+0x10/0x10
[   19.455253]  ret_from_fork+0x31/0x70
[   19.456685]  ? __pfx_kthread+0x10/0x10
[   19.458114]  ret_from_fork_asm+0x1a/0x30
[   19.459573]  </TASK>
[   19.460853]
[   19.462055] Allocated by task 1198:
[   19.463410]  kasan_save_stack+0x30/0x50
[   19.464788]  kasan_save_track+0x14/0x30
[   19.466139]  __kasan_kmalloc+0xaa/0xb0
[   19.467465]  __kmalloc+0x1cd/0x470
[   19.468748]  isst_if_cdev_register+0x1da/0x350 [isst_if_common]
[   19.470233]  isst_if_mbox_init+0x108/0xff0 [isst_if_mbox_msr]
[   19.471670]  do_one_initcall+0xa4/0x380
[   19.472903]  do_init_module+0x238/0x760
[   19.474105]  load_module+0x5239/0x6f00
[   19.475285]  init_module_from_file+0xd1/0x130
[   19.476506]  idempotent_init_module+0x23b/0x650
[   19.477725]  __x64_sys_finit_module+0xbe/0x130
[   19.476506]  idempotent_init_module+0x23b/0x650
[   19.477725]  __x64_sys_finit_module+0xbe/0x130
[   19.478920]  do_syscall_64+0x82/0x160
[   19.480036]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.481292]
[   19.482205] The buggy address belongs to the object at ffff888829e65000
 which belongs to the cache kmalloc-512 of size 512
[   19.484818] The buggy address is located 0 bytes to the right of
 allocated 512-byte region [ffff888829e65000, ffff888829e65200)
[   19.487447]
[   19.488328] The buggy address belongs to the physical page:
[   19.489569] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888829e60c00 pfn:0x829e60
[   19.491140] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   19.492466] anon flags: 0x57ffffc0000840(slab|head|node=1|zone=2|lastcpupid=0x1fffff)
[   19.493914] page_type: 0xffffffff()
[   19.494988] raw: 0057ffffc0000840 ffff88810004cc80 0000000000000000 0000000000000001
[   19.496451] raw: ffff888829e60c00 0000000080200018 00000001ffffffff 0000000000000000
[   19.497906] head: 0057ffffc0000840 ffff88810004cc80 0000000000000000 0000000000000001
[   19.499379] head: ffff888829e60c00 0000000080200018 00000001ffffffff 0000000000000000
[   19.500844] head: 0057ffffc0000003 ffffea0020a79801 ffffea0020a79848 00000000ffffffff
[   19.502316] head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
[   19.503784] page dumped because: kasan: bad access detected
[   19.505058]
[   19.505970] Memory state around the buggy address:
[   19.507172]  ffff888829e65100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   19.508599]  ffff888829e65180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   19.510013] >ffff888829e65200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   19.510014]                    ^
[   19.510016]  ffff888829e65280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   19.510018]  ffff888829e65300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   19.515367] ==================================================================

The reason for this error is physical_package_ids assigned by VMware VMM
are not continuous and have gaps. This will cause value returned by
topology_physical_package_id() to be more than topology_max_packages().

Here the allocation uses topology_max_packages(). The call to
topology_max_packages() returns maximum logical package ID not physical
ID. Hence use topology_logical_package_id() instead of
topology_physical_package_id().

Fixes: 9a1aac8a96dc ("platform/x86: ISST: PUNIT device mapping with Sub-NUMA clustering")
Cc: stable@vger.kernel.org
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Zach Wade <zachwade.k@gmail.com>
Link: https://lore.kernel.org/r/20240923144508.1764-1-zachwade.k@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -306,7 +306,9 @@ static struct pci_dev *_isst_if_get_pci_
 	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
 		return NULL;
 
-	pkg_id = topology_physical_package_id(cpu);
+	pkg_id = topology_logical_package_id(cpu);
+	if (pkg_id >= topology_max_packages())
+		return NULL;
 
 	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
 	if (bus_number < 0)



