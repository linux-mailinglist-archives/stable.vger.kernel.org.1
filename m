Return-Path: <stable+bounces-20716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C775085AB7E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3FC1C217A8
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B944C93;
	Mon, 19 Feb 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QX5RP/be"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598C41A82
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368636; cv=none; b=L7wcEOBd4zE/kSOQu0l/K2seJR8sxkkNq1jlU/mkZa3GmMh9fHk0yiUppFOgjXSgyEzW2Fwn0Oa+E5/ZSrQrbd6hs3ZWXGjdhA2HsXKf1jmM69HZvroa+szvNtU04jcjicZNNXQd4LuwMJYxQ0PdsOq4noh5yO0xrjb5B8NOBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368636; c=relaxed/simple;
	bh=2gqo5D9S6b5LYxkmHj8BD2eQqnqHFWIBU/AGU3a15U0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IOR7SmbEvXb1nsQDfXpzrJlGpOrNnsN8WaGCJE+QXfmZn39bX2E2qHBkBZcgew//HubrfVMN834WAioiTy1RfYRYLWJR/aXk/++O30ZSyr+3nPB6sq9/vkjS/5IbBF9gOY3kxOX+fJ8cyVQ+ASZxUi0lY01JJlpcT09s0FxAT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QX5RP/be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B96C433F1;
	Mon, 19 Feb 2024 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368636;
	bh=2gqo5D9S6b5LYxkmHj8BD2eQqnqHFWIBU/AGU3a15U0=;
	h=Subject:To:Cc:From:Date:From;
	b=QX5RP/beNt/RPmFUSxJaDLAfVkhDIMmAqUcDxbMokJ7Y8caOtB0BfX5vdQ84CN7BA
	 8qbtjC3XvLRdyLO5Uzrp/TWDm3xcxYGvJ3nlwETbW3Gg1VOoWYhMmXYkTnkJMfN0ou
	 Po4VVnnahD62VYvhia3xNtmhR0olQdUNkybqUgAI=
Subject: FAILED: patch "[PATCH] fs,hugetlb: fix NULL pointer dereference in" failed to apply to 5.15-stable tree
To: osalvador@suse.de,akpm@linux-foundation.org,mhocko@suse.com,muchun.song@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:50:33 +0100
Message-ID: <2024021932-embody-commodore-0dec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 79d72c68c58784a3e1cd2378669d51bfd0cb7498
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021932-embody-commodore-0dec@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

79d72c68c587 ("fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super")
d00365175e09 ("hugetlbfs: use helper macro SZ_1{K,M}")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79d72c68c58784a3e1cd2378669d51bfd0cb7498 Mon Sep 17 00:00:00 2001
From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 30 Jan 2024 22:04:18 +0100
Subject: [PATCH] fs,hugetlb: fix NULL pointer dereference in
 hugetlbs_fill_super

When configuring a hugetlb filesystem via the fsconfig() syscall, there is
a possible NULL dereference in hugetlbfs_fill_super() caused by assigning
NULL to ctx->hstate in hugetlbfs_parse_param() when the requested pagesize
is non valid.

E.g: Taking the following steps:

     fd = fsopen("hugetlbfs", FSOPEN_CLOEXEC);
     fsconfig(fd, FSCONFIG_SET_STRING, "pagesize", "1024", 0);
     fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);

Given that the requested "pagesize" is invalid, ctxt->hstate will be replaced
with NULL, losing its previous value, and we will print an error:

 ...
 ...
 case Opt_pagesize:
 ps = memparse(param->string, &rest);
 ctx->hstate = h;
 if (!ctx->hstate) {
         pr_err("Unsupported page size %lu MB\n", ps / SZ_1M);
         return -EINVAL;
 }
 return 0;
 ...
 ...

This is a problem because later on, we will dereference ctxt->hstate in
hugetlbfs_fill_super()

 ...
 ...
 sb->s_blocksize = huge_page_size(ctx->hstate);
 ...
 ...

Causing below Oops.

Fix this by replacing cxt->hstate value only when then pagesize is known
to be valid.

 kernel: hugetlbfs: Unsupported page size 0 MB
 kernel: BUG: kernel NULL pointer dereference, address: 0000000000000028
 kernel: #PF: supervisor read access in kernel mode
 kernel: #PF: error_code(0x0000) - not-present page
 kernel: PGD 800000010f66c067 P4D 800000010f66c067 PUD 1b22f8067 PMD 0
 kernel: Oops: 0000 [#1] PREEMPT SMP PTI
 kernel: CPU: 4 PID: 5659 Comm: syscall Tainted: G            E      6.8.0-rc2-default+ #22 5a47c3fef76212addcc6eb71344aabc35190ae8f
 kernel: Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS GVPRCRB1.86B.0016.D04.1705030402 05/03/2017
 kernel: RIP: 0010:hugetlbfs_fill_super+0xb4/0x1a0
 kernel: Code: 48 8b 3b e8 3e c6 ed ff 48 85 c0 48 89 45 20 0f 84 d6 00 00 00 48 b8 ff ff ff ff ff ff ff 7f 4c 89 e7 49 89 44 24 20 48 8b 03 <8b> 48 28 b8 00 10 00 00 48 d3 e0 49 89 44 24 18 48 8b 03 8b 40 28
 kernel: RSP: 0018:ffffbe9960fcbd48 EFLAGS: 00010246
 kernel: RAX: 0000000000000000 RBX: ffff9af5272ae780 RCX: 0000000000372004
 kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: ffff9af555e9b000
 kernel: RBP: ffff9af52ee66b00 R08: 0000000000000040 R09: 0000000000370004
 kernel: R10: ffffbe9960fcbd48 R11: 0000000000000040 R12: ffff9af555e9b000
 kernel: R13: ffffffffa66b86c0 R14: ffff9af507d2f400 R15: ffff9af507d2f400
 kernel: FS:  00007ffbc0ba4740(0000) GS:ffff9b0bd7000000(0000) knlGS:0000000000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 0000000000000028 CR3: 00000001b1ee0000 CR4: 00000000001506f0
 kernel: Call Trace:
 kernel:  <TASK>
 kernel:  ? __die_body+0x1a/0x60
 kernel:  ? page_fault_oops+0x16f/0x4a0
 kernel:  ? search_bpf_extables+0x65/0x70
 kernel:  ? fixup_exception+0x22/0x310
 kernel:  ? exc_page_fault+0x69/0x150
 kernel:  ? asm_exc_page_fault+0x22/0x30
 kernel:  ? __pfx_hugetlbfs_fill_super+0x10/0x10
 kernel:  ? hugetlbfs_fill_super+0xb4/0x1a0
 kernel:  ? hugetlbfs_fill_super+0x28/0x1a0
 kernel:  ? __pfx_hugetlbfs_fill_super+0x10/0x10
 kernel:  vfs_get_super+0x40/0xa0
 kernel:  ? __pfx_bpf_lsm_capable+0x10/0x10
 kernel:  vfs_get_tree+0x25/0xd0
 kernel:  vfs_cmd_create+0x64/0xe0
 kernel:  __x64_sys_fsconfig+0x395/0x410
 kernel:  do_syscall_64+0x80/0x160
 kernel:  ? syscall_exit_to_user_mode+0x82/0x240
 kernel:  ? do_syscall_64+0x8d/0x160
 kernel:  ? syscall_exit_to_user_mode+0x82/0x240
 kernel:  ? do_syscall_64+0x8d/0x160
 kernel:  ? exc_page_fault+0x69/0x150
 kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 kernel: RIP: 0033:0x7ffbc0cb87c9
 kernel: Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 96 0d 00 f7 d8 64 89 01 48
 kernel: RSP: 002b:00007ffc29d2f388 EFLAGS: 00000206 ORIG_RAX: 00000000000001af
 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffbc0cb87c9
 kernel: RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
 kernel: RBP: 00007ffc29d2f3b0 R08: 0000000000000000 R09: 0000000000000000
 kernel: R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
 kernel: R13: 00007ffc29d2f4c0 R14: 0000000000000000 R15: 0000000000000000
 kernel:  </TASK>
 kernel: Modules linked in: rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) sunrpc(E) netfs(E) af_packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) intel_rapl_msr(E) intel_rapl_common(E) iTCO_wdt(E) intel_pmc_bxt(E) sb_edac(E) iTCO_vendor_support(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) rfkill(E) ipmi_ssif(E) kvm(E) acpi_ipmi(E) irqbypass(E) pcspkr(E) igb(E) ipmi_si(E) mei_me(E) i2c_i801(E) joydev(E) intel_pch_thermal(E) i2c_smbus(E) dca(E) lpc_ich(E) mei(E) ipmi_devintf(E) ipmi_msghandler(E) acpi_pad(E) tiny_power_button(E) button(E) fuse(E) efi_pstore(E) configfs(E) ip_tables(E) x_tables(E) ext4(E) mbcache(E) jbd2(E) hid_generic(E) usbhid(E) sd_mod(E) t10_pi(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) polyval_clmulni(E) ahci(E) xhci_pci(E) polyval_generic(E) gf128mul(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha256_ssse3(E) xhci_pci_renesas(E) libahci(E) ehci_pci(E) sha1_ssse3(E) xhci_hc
 d(E) ehci_hcd(E) libata(E)
 kernel:  mgag200(E) i2c_algo_bit(E) usbcore(E) wmi(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) aesni_intel(E) crypto_simd(E) cryptd(E)
 kernel: Unloaded tainted modules: acpi_cpufreq(E):1 fjes(E):1
 kernel: CR2: 0000000000000028
 kernel: ---[ end trace 0000000000000000 ]---
 kernel: RIP: 0010:hugetlbfs_fill_super+0xb4/0x1a0
 kernel: Code: 48 8b 3b e8 3e c6 ed ff 48 85 c0 48 89 45 20 0f 84 d6 00 00 00 48 b8 ff ff ff ff ff ff ff 7f 4c 89 e7 49 89 44 24 20 48 8b 03 <8b> 48 28 b8 00 10 00 00 48 d3 e0 49 89 44 24 18 48 8b 03 8b 40 28
 kernel: RSP: 0018:ffffbe9960fcbd48 EFLAGS: 00010246
 kernel: RAX: 0000000000000000 RBX: ffff9af5272ae780 RCX: 0000000000372004
 kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: ffff9af555e9b000
 kernel: RBP: ffff9af52ee66b00 R08: 0000000000000040 R09: 0000000000370004
 kernel: R10: ffffbe9960fcbd48 R11: 0000000000000040 R12: ffff9af555e9b000
 kernel: R13: ffffffffa66b86c0 R14: ffff9af507d2f400 R15: ffff9af507d2f400
 kernel: FS:  00007ffbc0ba4740(0000) GS:ffff9b0bd7000000(0000) knlGS:0000000000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 0000000000000028 CR3: 00000001b1ee0000 CR4: 00000000001506f0

Link: https://lkml.kernel.org/r/20240130210418.3771-1-osalvador@suse.de
Fixes: 32021982a324 ("hugetlbfs: Convert to fs_context")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ee13c2ca8ad2..d746866ae3b6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1365,6 +1365,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 {
 	struct hugetlbfs_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
+	struct hstate *h;
 	char *rest;
 	unsigned long ps;
 	int opt;
@@ -1409,11 +1410,12 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 
 	case Opt_pagesize:
 		ps = memparse(param->string, &rest);
-		ctx->hstate = size_to_hstate(ps);
-		if (!ctx->hstate) {
+		h = size_to_hstate(ps);
+		if (!h) {
 			pr_err("Unsupported page size %lu MB\n", ps / SZ_1M);
 			return -EINVAL;
 		}
+		ctx->hstate = h;
 		return 0;
 
 	case Opt_min_size:


