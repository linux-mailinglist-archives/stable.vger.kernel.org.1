Return-Path: <stable+bounces-223606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GR8CJCqrmntHQIAu9opvQ
	(envelope-from <stable+bounces-223606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:10:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAA6237A12
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BEFE300B991
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 11:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573BA399005;
	Mon,  9 Mar 2026 11:09:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C4392C41;
	Mon,  9 Mar 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054593; cv=none; b=QznwJPTC7/w4yi67LMp7dfgxNNnPr8mtYNXdLLYdKrVFQw2Be0r7M5QxF9beUrv/bsPkXqLiWD1hb3Hzksm+xwdfy9A1xki4FG1Z+fMkNFH5ntCSS4aUAJRWt1waX+6KXA9yAd0xnnbEop8gWvChLq2ETqiQG67TxkaPsPdZv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054593; c=relaxed/simple;
	bh=7drjKsfIEqTxqROoMU5+YC1Ry4jf+AcpQKsMwn77lG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VQE9I5e0tJRh5gl5uPZ0E18KXMSLdI1oqkSTaks1FpkGzVdHrvH7WqT9/dl7BWdVyztpQhkMkW5OpAyOFYbRWLa3zw4uBulUdujUH6gIBvQR+qryPwQVTU2Bqf63TnJjw/Bln3mAKnIS8mXdKHrbUOl9W1VNrD8SsSjuCFuC/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowAAHItlzqq5pnpElCg--.46862S2;
	Mon, 09 Mar 2026 19:09:41 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH 0/2] riscv: mm: Define DIRECT_MAP_PHYSMEM_END, fix
 ZONE_DEVICE
Date: Mon, 09 Mar 2026 19:09:36 +0800
Message-Id: <20260309-riscv-sparsemem-vmemmap-limits-v1-0-f40efe18e3cd@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCqrmkC/x2NQQqAMAzAviI9W5g6FP2KeBjaacHpaGUI4t8dX
 gK5JA8oCZPCUDwglFj5PLJUZQHz5o6VkJfsUJu6NY3pUVjnhBqdKAUKmDKCi7hz4EvRdo31lW8
 7a3vIkSjk+f4H4/S+H30e/7xwAAAA
X-Change-ID: 20260309-riscv-sparsemem-vmemmap-limits-4734f1f67449
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, Vivian Wang <wangruikang@iscas.ac.cn>, 
 stable@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:rQCowAAHItlzqq5pnpElCg--.46862S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48JFW7AF1fJFyUZr4DXFb_yoW7JrWfpr
	y5Xr1UCr40yr4DJrWIyry5Zr93GFW2kay7GFyxJw1Yv3WDCr1Utr18JFW3Kr9rJr45JFy7
	Grs8tr48KryUtw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Queue-Id: ACAA6237A12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iscas.ac.cn:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.215];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-223606-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

With HSA_AMD_SVM=y, RISC-V runs into the same problem as arm64 at one
point did [1], where it tries to use a struct page that is outside of
vmemmap. See log near the end.

On RISC-V, the actual mappable range of physical addresses is dependent
on the current MMU mode i.e. satp_mode. Define DIRECT_MAP_PHYSMEM_END to
expose this information to get_free_mem_region().

See also commit eeb8fdfcf090 ("arm64: Expose the end of the linear map
in PHYSMEM_END") which fixed the same issue on arm64, although the
situation there is much less complicated.

Patch 1 copies a check in vmemmap_populate() over from arm64, which I
have done to debug this problem. Patch 2 is the actual fix.

[1] https://lore.kernel.org/all/20240903164532.3874988-1-scott@os.amperecomputing.com

Crash log:

[   19.228335] Oops [#1]
[   19.230607] Modules linked in: amdgpu(+) [ ... many more modules omitted ... ]
[   19.309895] CPU: 2 UID: 0 PID: 844 Comm: (udev-worker) Not tainted 6.19.3-ztest #3 PREEMPTLAZY
[   19.318587] Hardware name: Sophgo SG2044 SRD3-10 (DT)
[   19.323632] epc : __init_single_page+0x16/0x78
[   19.328079]  ra : __init_zone_device_page.constprop.0+0x28/0xd0
[   19.333997] epc : ffffffff802ff1be ra : ffffffff80d10de8 sp : ffff8f8002ef3450
[   19.341210]  gp : ffffffff82290cc8 tp : ffffaf808f526c80 t0 : ffffffff800231a8
[   19.348423]  t1 : 0000100000000000 t2 : 0000000000000002 s0 : ffff8f8002ef3460
[   19.355636]  s1 : 00038d7fe6000000 a0 : 00038d7fe6000000 a1 : 00000fffffa00000
[   19.362848]  a2 : 3000000000000000 a3 : 0000000000000000 a4 : 0000200000000000
[   19.370060]  a5 : 0000000000600000 a6 : ffffffff82305608 a7 : 0000000000000001
[   19.377273]  s2 : 00000fffffa00000 s3 : ffffaf8091258028 s4 : 0000000000000000
[   19.384485]  s5 : 0000100000000000 s6 : 0000000000000001 s7 : 00000fffffa00000
[   19.391697]  s8 : ffffffff81708b78 s9 : ffffffff81708b38 s10: 0000000000000001
[   19.398909]  s11: ffffaf8091258028 t3 : ffffffff822b43c0 t4 : 000000000207ffff
[   19.406121]  t5 : ffffffffffffffff t6 : 0000000000000000
[   19.411425] status: 0000000200000120 badaddr: 00038d7fe6000030 cause: 000000000000000f
[   19.419331] [<ffffffff802ff1be>] __init_single_page+0x16/0x78
[   19.425071] [<ffffffff80d10de8>] __init_zone_device_page.constprop.0+0x28/0xd0
[   19.432285] [<ffffffff80d11140>] memmap_init_zone_device+0x108/0x278
[   19.438632] [<ffffffff803f6a7a>] memremap_pages+0x262/0x6b0
[   19.444201] [<ffffffff803f6ef0>] devm_memremap_pages+0x28/0x78
[   19.450029] [<ffffffff053f9370>] kgd2kfd_init_zone_device+0xe0/0x1e0 [amdgpu]
[   19.483691] [<ffffffff059a6df0>] amdgpu_device_ip_init+0xa68/0xad0 [amdgpu]
[   19.517108] [<ffffffff05120f6e>] amdgpu_device_init+0x1a5e/0x21e0 [amdgpu]
[   19.550497] [<ffffffff05122e50>] amdgpu_driver_load_kms+0x20/0xc8 [amdgpu]
[   19.583900] [<ffffffff05116dd6>] amdgpu_pci_probe+0x236/0x6c8 [amdgpu]
[   19.616947] [<ffffffff807b2c10>] local_pci_probe+0x40/0x98
[   19.622439] [<ffffffff807b393c>] pci_device_probe+0xcc/0x280
[   19.628091] [<ffffffff8093527c>] really_probe+0xa4/0x3c0
[   19.633397] [<ffffffff80935614>] __driver_probe_device+0x7c/0x158
[   19.639483] [<ffffffff809357d8>] driver_probe_device+0x38/0xd0
[   19.645308] [<ffffffff80935a3a>] __driver_attach+0xaa/0x200
[   19.650873] [<ffffffff8093297e>] bus_for_each_dev+0x6e/0xc8
[   19.656443] [<ffffffff80934996>] driver_attach+0x26/0x38
[   19.661750] [<ffffffff809340e4>] bus_add_driver+0x11c/0x248
[   19.667317] [<ffffffff80936d1c>] driver_register+0x54/0x100
[   19.672884] [<ffffffff807b1f4c>] __pci_register_driver+0x54/0x68
[   19.678889] [<ffffffff0430e0a8>] amdgpu_init+0xa0/0xff8 [amdgpu]
[   19.711387] [<ffffffff80013a02>] do_one_initcall+0x62/0x2c8
[   19.716960] [<ffffffff80127ad6>] do_init_module+0x5e/0x260
[   19.722445] [<ffffffff80129d1e>] load_module+0x1bd6/0x2388
[   19.727925] [<ffffffff8012a730>] init_module_from_file+0xc8/0x128
[   19.734012] [<ffffffff8012a9d0>] __riscv_sys_finit_module+0x1e0/0x338
[   19.740447] [<ffffffff80d0d62a>] do_trap_ecall_u+0x102/0x3f8
[   19.746101] [<ffffffff80d1dbb4>] handle_exception+0x154/0x160
[   19.751852] Code: ffd2 0013 0000 1141 e022 e406 0800 8a0d 16fa 1672 (3823) 0205
[   19.759334] ---[ end trace 0000000000000000 ]---

---
Vivian Wang (2):
      riscv: mm: WARN_ON() for bad addresses in vmemmap_populate()
      riscv: mm: Define DIRECT_MAP_PHYSMEM_END

 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 ++
 2 files changed, 12 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260309-riscv-sparsemem-vmemmap-limits-4734f1f67449

Best regards,
-- 
Vivian "dramforever" Wang


