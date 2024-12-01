Return-Path: <stable+bounces-95900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62B9DF519
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FFB281212
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC584D13;
	Sun,  1 Dec 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IneNPRJq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACE35885;
	Sun,  1 Dec 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733045233; cv=none; b=sS+Jqfi+HfUjUQQn68lfvnH7ZeQD7orC0Svk8yLRPuVaRgewLloH+/p4ob+7SWetIPKC2jdW07H7isARkNXSrarSKn8hnHOtHf6td8lUiJKfxhXemVaE9O2dQucr4KTu/JZ8EeV1ucD31qPqoJndqtg1TJoWF3kHo1XVY7CyT4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733045233; c=relaxed/simple;
	bh=zcbZ5C94UpyjRTNgMJYOeQ/XAomR1B1C5ovJjWWHEAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gysslja+L6kkkWb/lDutr4XIv51rKzkCw8Gpek9hMgSShN6goFgF5PhXzOcT2xmp49qsCpkn/ZvqBEjBb+kJkbyyHbw2p3msB7VO8lhLeRfOXuBE/Zu3My+c1MYPb2/T3fL7K+gKltclF3Pz6Dge7WhyxoovkwoBBx1We8ZB7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IneNPRJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47036C4CECF;
	Sun,  1 Dec 2024 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733045233;
	bh=zcbZ5C94UpyjRTNgMJYOeQ/XAomR1B1C5ovJjWWHEAg=;
	h=From:To:Cc:Subject:Date:From;
	b=IneNPRJqcK80axyt5a+U/ificQI1XoBtFYspojqZP9+i+APgwkD/I4jWp11jOGKSA
	 gCbtcZcFuGRU0JgswHdE6UleDFdN8rSZyXOt2Z9U++ocuaqye2KBUXLBnpjMwueR5q
	 pfxAsoFrSZvP2L6n0Ha2DZAFbHNBpoRomt81ip7zMY0oWXI3QKm8yTFnQYn5otqgNs
	 3Fw40Qm2RCilaGF9q+kEIq3gTR6MRhEpZQdVlazf6LnJbghXwtRdAOTNQAasfSmrXh
	 0f9gZ52n2dAoGxJxyxzbkhymbVOWOEyq4aK/THaMPWOZeAOM3fN5+t4OAQHnbZ7f00
	 hDE2ApTEpcudw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tHgEQ-00H3r2-Uw;
	Sun, 01 Dec 2024 09:27:11 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] arch_numa: Restore nid checks before registering a memblock with a node
Date: Sun,  1 Dec 2024 09:27:02 +0000
Message-Id: <20241201092702.3792845-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rppt@kernel.org, catalin.marinas@arm.com, will@kernel.org, ziy@nvidia.com, dan.j.williams@intel.com, david@redhat.com, akpm@linux-foundation.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Commit 767507654c22 ("arch_numa: switch over to numa_memblks")
significantly cleaned up the NUMA registration code, but also
dropped a significant check that was refusing to accept to
configure a memblock with an invalid nid.

On "quality hardware" such as my ThunderX machine, this results
in a kernel that dies immediately:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x431f0a10]
[    0.000000] Linux version 6.12.0-00013-g8920d74cf8db (maz@valley-girl) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #3872 SMP PREEMPT Wed Nov 27 15:25:49 GMT 2024
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Cavium ThunderX CN88XX board
[    0.000000] efi: EFI v2.4 by American Megatrends
[    0.000000] efi: ESRT=0xffce0ff18 SMBIOS 3.0=0xfffb0000 ACPI 2.0=0xffec60000 MEMRESERVE=0xffc905d98
[    0.000000] esrt: Reserving ESRT space from 0x0000000ffce0ff18 to 0x0000000ffce0ff50.
[    0.000000] earlycon: pl11 at MMIO 0x000087e024000000 (options '115200n8')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] NODE_DATA(0) allocated [mem 0xff6754580-0xff67566bf]
[    0.000000] Unable to handle kernel paging request at virtual address 0000000000001d40
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x0000000096000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x04: level 0 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.000000] [0000000000001d40] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.0-00013-g8920d74cf8db #3872
[    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
[    0.000000] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : sparse_init_nid+0x54/0x428
[    0.000000] lr : sparse_init+0x118/0x240
[    0.000000] sp : ffff800081da3cb0
[    0.000000] x29: ffff800081da3cb0 x28: 0000000fedbab10c x27: 0000000000000001
[    0.000000] x26: 0000000ffee250f8 x25: 0000000000000001 x24: ffff800082102cd0
[    0.000000] x23: 0000000000000001 x22: 0000000000000000 x21: 00000000001fffff
[    0.000000] x20: 0000000000000001 x19: 0000000000000000 x18: ffffffffffffffff
[    0.000000] x17: 0000000001b00000 x16: 0000000ffd130000 x15: 0000000000000000
[    0.000000] x14: 00000000003e0000 x13: 00000000000001c8 x12: 0000000000000014
[    0.000000] x11: ffff800081e82860 x10: ffff8000820fb2c8 x9 : ffff8000820fb490
[    0.000000] x8 : 0000000000ffed20 x7 : 0000000000000014 x6 : 00000000001fffff
[    0.000000] x5 : 00000000ffffffff x4 : 0000000000000000 x3 : 0000000000000000
[    0.000000] x2 : 0000000000000000 x1 : 0000000000000040 x0 : 0000000000000007
[    0.000000] Call trace:
[    0.000000]  sparse_init_nid+0x54/0x428
[    0.000000]  sparse_init+0x118/0x240
[    0.000000]  bootmem_init+0x70/0x1c8
[    0.000000]  setup_arch+0x184/0x270
[    0.000000]  start_kernel+0x74/0x670
[    0.000000]  __primary_switched+0x80/0x90
[    0.000000] Code: f865d804 d37df060 cb030000 d2800003 (b95d4084)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

while previous kernel versions were able to recognise how brain-damaged
the machine is, and only build a fake node.

Use the memblock_validate_numa_coverage() helper to restore some sanity
and a "working" system.

Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
---
 drivers/base/arch_numa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index e187016764265..c63a72a1fed64 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -208,6 +208,10 @@ static int __init numa_register_nodes(void)
 {
 	int nid;
 
+	/* Check the validity of the memblock/node mapping */
+	if (!memblock_validate_numa_coverage(1))
+		return -EINVAL;
+
 	/* Finally register nodes. */
 	for_each_node_mask(nid, numa_nodes_parsed) {
 		unsigned long start_pfn, end_pfn;
-- 
2.39.2


