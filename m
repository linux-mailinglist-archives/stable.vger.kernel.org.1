Return-Path: <stable+bounces-59473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972A5932919
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD9E1C221EE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AED1ABCAF;
	Tue, 16 Jul 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYcZuL0Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8BC1A0AF2;
	Tue, 16 Jul 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140167; cv=none; b=gJzDEjX4dYKCemKJca0sxFRs2eEEpF9cg8r/a5sFaBH94wmiF9xZ/xx4c+GNWV6bkbi9t8Q2TKnu93QCp5Jm+JRcpKuwfCJdI2ms1oDC7VAEnHuFbc3tZgsuVE3gexcwBqbf24vhOrOW3ZfACPom1ynKxbdvRc5Nm6RfkNJuGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140167; c=relaxed/simple;
	bh=4RX0ydbFNbj+V8SN3HO80ALFj8/x8YWqJfql8E+ekHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBlG38G0rSjO40oQoFViY4Ag7JYsZfdoE5z0ybBDrAMMnpcGQwv5LfU0Wava7nAlAJDXk4iPyLzD4mDnkWXtxwnpTL+fovotEuSr7ppu1hScMdmutzeJnEvirO4/sziWO7I3yRQihO75YtlVlIkVa2oDvZ07g5ZGqASiqgAVYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYcZuL0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47613C4AF09;
	Tue, 16 Jul 2024 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140166;
	bh=4RX0ydbFNbj+V8SN3HO80ALFj8/x8YWqJfql8E+ekHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYcZuL0YYhQuWYcE/xpSQSaqKMmFPmVlv1oDBQ8YH9N9DB1IY9loEY/MC98XHLpJc
	 FG5AGzJboCcuoxlvf0LQP+2ZMtYdTP6DRd7XkF5Ejy5WiuupTQdgc5Yqaa9SBiwlhO
	 Q6r0Ww+SHbbiyNyCpk/xwF1Bl9CyeoWtvf8fhq9Fq1Kr3lxYLNX34+O8XhtrWbPtjP
	 gKAY74b3hq6MNOf4/CDZI5RVUdveFVYiMHPsUM08eylTNzpD+iQ5QT+1m1jBIsPrrq
	 crOGakCIeDJEDpPg4UiB4mO6krsbY0U7ALB0Xw73vvoDf7BFhkfLZG5RLfLjp9FTuE
	 3WKCVXmIl1XwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anjali K <anjalik@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	npiggin@gmail.com,
	ruscur@russell.cc,
	aneesh.kumar@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	linuxppc-dev@lists.ozlabs.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/9] powerpc/pseries: Whitelist dtl slub object for copying to userspace
Date: Tue, 16 Jul 2024 10:29:04 -0400
Message-ID: <20240716142920.2713829-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142920.2713829-1-sashal@kernel.org>
References: <20240716142920.2713829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
Content-Transfer-Encoding: 8bit

From: Anjali K <anjalik@linux.ibm.com>

[ Upstream commit 1a14150e1656f7a332a943154fc486504db4d586 ]

Reading the dispatch trace log from /sys/kernel/debug/powerpc/dtl/cpu-*
results in a BUG() when the config CONFIG_HARDENED_USERCOPY is enabled as
shown below.

    kernel BUG at mm/usercopy.c:102!
    Oops: Exception in kernel mode, sig: 5 [#1]
    LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
    Modules linked in: xfs libcrc32c dm_service_time sd_mod t10_pi sg ibmvfc
    scsi_transport_fc ibmveth pseries_wdt dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse
    CPU: 27 PID: 1815 Comm: python3 Not tainted 6.10.0-rc3 #85
    Hardware name: IBM,9040-MRX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_042) hv:phyp pSeries
    NIP:  c0000000005d23d4 LR: c0000000005d23d0 CTR: 00000000006ee6f8
    REGS: c000000120c078c0 TRAP: 0700   Not tainted  (6.10.0-rc3)
    MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2828220f  XER: 0000000e
    CFAR: c0000000001fdc80 IRQMASK: 0
    [ ... GPRs omitted ... ]
    NIP [c0000000005d23d4] usercopy_abort+0x78/0xb0
    LR [c0000000005d23d0] usercopy_abort+0x74/0xb0
    Call Trace:
     usercopy_abort+0x74/0xb0 (unreliable)
     __check_heap_object+0xf8/0x120
     check_heap_object+0x218/0x240
     __check_object_size+0x84/0x1a4
     dtl_file_read+0x17c/0x2c4
     full_proxy_read+0x8c/0x110
     vfs_read+0xdc/0x3a0
     ksys_read+0x84/0x144
     system_call_exception+0x124/0x330
     system_call_vectored_common+0x15c/0x2ec
    --- interrupt: 3000 at 0x7fff81f3ab34

Commit 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
requires that only whitelisted areas in slab/slub objects can be copied to
userspace when usercopy hardening is enabled using CONFIG_HARDENED_USERCOPY.
Dtl contains hypervisor dispatch events which are expected to be read by
privileged users. Hence mark this safe for user access.
Specify useroffset=0 and usersize=DISPATCH_LOG_BYTES to whitelist the
entire object.

Co-developed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Anjali K <anjalik@linux.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240614173844.746818-1-anjalik@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index d25053755c8b8..309a72518ecc3 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -314,8 +314,8 @@ static int alloc_dispatch_log_kmem_cache(void)
 {
 	void (*ctor)(void *) = get_dtl_cache_ctor();
 
-	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
-						DISPATCH_LOG_BYTES, 0, ctor);
+	dtl_cache = kmem_cache_create_usercopy("dtl", DISPATCH_LOG_BYTES,
+						DISPATCH_LOG_BYTES, 0, 0, DISPATCH_LOG_BYTES, ctor);
 	if (!dtl_cache) {
 		pr_warn("Failed to create dispatch trace log buffer cache\n");
 		pr_warn("Stolen time statistics will be unreliable\n");
-- 
2.43.0


