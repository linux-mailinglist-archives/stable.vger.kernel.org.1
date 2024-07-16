Return-Path: <stable+bounces-59458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF39328F3
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF7A1C20D27
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7A1A9069;
	Tue, 16 Jul 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWSrGlyc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249D19D880;
	Tue, 16 Jul 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140113; cv=none; b=ubKt4Qx42J2e3prXfEHF0PS2fP9lLhMGq2snzq54yn5Ss2wMG6ZwJGBzhqtOWfHHKiZB9G96zdHoG/5VjHmv6n6u+s+qHSjR6KH9gTJpYh+IHQiZ1I9PzBhMrMSDXueSmHaTPkmLMZYe/mp9Y/lB1f/WsQuKBkZusBR6FfWMjsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140113; c=relaxed/simple;
	bh=2nfcKS/R66m86WssifvIWsCcLDbXMbqERf7jcqzeP54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFPiKXj48j33komXd1cszH9+DnyOStnLYqmXAftTvHL335K+P4vgW1y2JA3CzsnJUNDd7Df3ziwZj8VWccmhtha5EvD8ywJ2Hov8xnVRBModNNq7JKG/NG8veoFT2S0p59Vh+swb7q0TlkG5Whl1U9SroiBkd8UBHnWphY+5Nlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWSrGlyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D9FC4AF48;
	Tue, 16 Jul 2024 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140112;
	bh=2nfcKS/R66m86WssifvIWsCcLDbXMbqERf7jcqzeP54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWSrGlyc/DBLer8kZTfSHhqkjdJV9VKrEQ4/YqwbOS0Hm67FaPsZSpfgCP4Vk6Du4
	 G6a8EF5yHc4AmjBZdlySQNqt9SiJqgdLfWdzBIKNEBOXTQRbhKrwgcavtnJcTjQSZX
	 KuI9M6CxK43xXWZiZVNI4YiRGf19J3/UrqEqkX3b5/MC2aPfQ9e3VQDpyy4a0FCjYa
	 ZdY3/8J8rKshaBK5f4OMpg3m6/pYH0LZw1nPwAqQ3TsT5kQyQN2kjFXqmLu/99IPR2
	 gqb96xFtuw8MhMpZE6Iuisw3rDhFWnFDoLsAW+h/kYBVder9U3laAZGsHD5gKTWfqm
	 EoF6mhVMumvZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anjali K <anjalik@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	arbab@linux.ibm.com,
	npiggin@gmail.com,
	robh@kernel.org,
	aneesh.kumar@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	ruscur@russell.cc,
	linuxppc-dev@lists.ozlabs.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/15] powerpc/pseries: Whitelist dtl slub object for copying to userspace
Date: Tue, 16 Jul 2024 10:27:59 -0400
Message-ID: <20240716142825.2713416-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
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
index a0701dbdb1348..09372361f1080 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -342,8 +342,8 @@ static int alloc_dispatch_log_kmem_cache(void)
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


