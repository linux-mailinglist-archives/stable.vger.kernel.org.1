Return-Path: <stable+bounces-59482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB493932931
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E90B1C22A41
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A681ACE65;
	Tue, 16 Jul 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv8ytWVB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AADA19E830;
	Tue, 16 Jul 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140200; cv=none; b=bxf6/OW9INh4Ahcd2pQAN5vJDi6a0/z0dp5Pe0F5ooFHtYIwTYikDly9gXrh5qkWpMIjzClTDdKsAzBs0ftJF7z2iquFbStrkoE0Y0pTg+ohf3Vu1k71Utr35yYfJ1p3OjD8qj3oMlNXBg/zoHiEpShjCJRTHnzMNBF2zL8TOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140200; c=relaxed/simple;
	bh=K2JKgD1RDkD4AEy8dcdJAc7GB4xg+TF5zojeEf1Xg7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxU2B1zukpWGRQ1FYgblEdfNInpPualElZfWT3UOWJLGTuPlMsDL+V+cTB/nAoVVQ1ZNDLBJRfvSRv1iKAinszc2IJThOQSltD/2FW+AKfZB7fnAehrN2FFqfol5AKWLiHeiMNldRMLdjWDfoJ2LAbyu7hZjb7wKXzOU+FK+G1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv8ytWVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E43C4AF15;
	Tue, 16 Jul 2024 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140200;
	bh=K2JKgD1RDkD4AEy8dcdJAc7GB4xg+TF5zojeEf1Xg7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mv8ytWVBkYFY4969HtQWDyXrrWdE4/DPGPLCoyjMsiuDlpXkFbchlVTN5IdOnV/LN
	 oiD44RuNBgbwl5HMagGCUeO49YiiFXqXYV/Lu0f6p6jmS9ITeQegKdnY0nZCIrNmlW
	 fkP50JVjt+mzqu7qUa3Gyec+eERs3PyIs1JMT5cigGztC/PELDLxHLA2jt70O6+8VX
	 zcFyStYGdfxGvR4/j29di+MD239d7aoLgjGwBJ+WpeWjCSIiXLRM+blnvWXxagzTJt
	 IKAsS/00eZXGgWahMVab6zR0SbY4gza1JWPxl1O7gHghhIycFLAYbpYVK+IPdHFYSK
	 MJyNUtcPTd6CA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anjali K <anjalik@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	robh@kernel.org,
	ruscur@russell.cc,
	christophe.leroy@csgroup.eu,
	npiggin@gmail.com,
	aneesh.kumar@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/7] powerpc/pseries: Whitelist dtl slub object for copying to userspace
Date: Tue, 16 Jul 2024 10:29:42 -0400
Message-ID: <20240716142953.2714154-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142953.2714154-1-sashal@kernel.org>
References: <20240716142953.2714154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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
index 822be2680b792..8e4a2e8aee114 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -312,8 +312,8 @@ static int alloc_dispatch_log_kmem_cache(void)
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


