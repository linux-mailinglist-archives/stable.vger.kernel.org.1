Return-Path: <stable+bounces-99121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE39E704C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8611E18863BD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EFC149E0E;
	Fri,  6 Dec 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PHYJS2t9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327814A4D1;
	Fri,  6 Dec 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496074; cv=none; b=d5RudhXpwCMTLbndj4jbeyLcWkga/+3r3g3vPV57uB5zrwzThd1IJmM0LBGtxEXyMtpYV2Jk7o9tojxi8uRxuXReXTLKUWP3PQ+bnb8BUbdocisUs3TdQXNsE3WgdhHJFkl7aqh4R+GfQi2om0WdTBgKT/SA4cm4JeKmtEJIM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496074; c=relaxed/simple;
	bh=GNphW4lpPsIfBFd6EfzzqfAeMk7M1zsejmzOuPSEiL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzWNzia/05Sq+Sw9IeTZN3JRkuiGVv0nyptPFXx4Cy5PAP+SLV7xykci7MaGz4qh8lBzDtGXhMsTmKJSiV6Swe6Lz44noco6j3iVc9EJ5cY5HaTGXi0k0/NF/4xhcjGkX/VFN6VgMBU/9ENvxyRploWDEe51CsRO+brz10u3iBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PHYJS2t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8645C4CED1;
	Fri,  6 Dec 2024 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733496074;
	bh=GNphW4lpPsIfBFd6EfzzqfAeMk7M1zsejmzOuPSEiL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHYJS2t92THKrPeJeF/efmlsbrfT83h7Zg4kgyj5C+XdRZqYazYqJuDn1CzvSVUa1
	 fYPwCq62d+RCPKHnZz/StgniFL08ahheCUURinyRv2zLHyph+6p0PR2fhWzrUpKOc6
	 ENvsBGXt0HqC2teZFKU1PCPuxxgCizlho25Vum1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 6.12 042/146] kunit: string-stream: Fix a UAF bug in kunit_init_suite()
Date: Fri,  6 Dec 2024 15:36:13 +0100
Message-ID: <20241206143529.284598907@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143527.654980698@linuxfoundation.org>
References: <20241206143527.654980698@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 39e21403c978862846fa68b7f6d06f9cca235194 upstream.

In kunit_debugfs_create_suite(), if alloc_string_stream() fails in the
kunit_suite_for_each_test_case() loop, the "suite->log = stream"
has assigned before, and the error path only free the suite->log's stream
memory but not set it to NULL, so the later string_stream_clear() of
suite->log in kunit_init_suite() will cause below UAF bug.

Set stream pointer to NULL after free to fix it.

	Unable to handle kernel paging request at virtual address 006440150000030d
	Mem abort info:
	  ESR = 0x0000000096000004
	  EC = 0x25: DABT (current EL), IL = 32 bits
	  SET = 0, FnV = 0
	  EA = 0, S1PTW = 0
	  FSC = 0x04: level 0 translation fault
	Data abort info:
	  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
	  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	[006440150000030d] address between user and kernel address ranges
	Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
	Dumping ftrace buffer:
	   (ftrace buffer empty)
	Modules linked in: iio_test_gts industrialio_gts_helper cfg80211 rfkill ipv6 [last unloaded: iio_test_gts]
	CPU: 5 UID: 0 PID: 6253 Comm: modprobe Tainted: G    B   W        N 6.12.0-rc4+ #458
	Tainted: [B]=BAD_PAGE, [W]=WARN, [N]=TEST
	Hardware name: linux,dummy-virt (DT)
	pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	pc : string_stream_clear+0x54/0x1ac
	lr : string_stream_clear+0x1a8/0x1ac
	sp : ffffffc080b47410
	x29: ffffffc080b47410 x28: 006440550000030d x27: ffffff80c96b5e98
	x26: ffffff80c96b5e80 x25: ffffffe461b3f6c0 x24: 0000000000000003
	x23: ffffff80c96b5e88 x22: 1ffffff019cdf4fc x21: dfffffc000000000
	x20: ffffff80ce6fa7e0 x19: 032202a80000186d x18: 0000000000001840
	x17: 0000000000000000 x16: 0000000000000000 x15: ffffffe45c355cb4
	x14: ffffffe45c35589c x13: ffffffe45c03da78 x12: ffffffb810168e75
	x11: 1ffffff810168e74 x10: ffffffb810168e74 x9 : dfffffc000000000
	x8 : 0000000000000004 x7 : 0000000000000003 x6 : 0000000000000001
	x5 : ffffffc080b473a0 x4 : 0000000000000000 x3 : 0000000000000000
	x2 : 0000000000000001 x1 : ffffffe462fbf620 x0 : dfffffc000000000
	Call trace:
	 string_stream_clear+0x54/0x1ac
	 __kunit_test_suites_init+0x108/0x1d8
	 kunit_exec_run_tests+0xb8/0x100
	 kunit_module_notify+0x400/0x55c
	 notifier_call_chain+0xfc/0x3b4
	 blocking_notifier_call_chain+0x68/0x9c
	 do_init_module+0x24c/0x5c8
	 load_module+0x4acc/0x4e90
	 init_module_from_file+0xd4/0x128
	 idempotent_init_module+0x2d4/0x57c
	 __arm64_sys_finit_module+0xac/0x100
	 invoke_syscall+0x6c/0x258
	 el0_svc_common.constprop.0+0x160/0x22c
	 do_el0_svc+0x44/0x5c
	 el0_svc+0x48/0xb8
	 el0t_64_sync_handler+0x13c/0x158
	 el0t_64_sync+0x190/0x194
	Code: f9400753 d2dff800 f2fbffe0 d343fe7c (38e06b80)
	---[ end trace 0000000000000000 ]---
	Kernel panic - not syncing: Oops: Fatal exception

Link: https://lore.kernel.org/r/20241112080314.407966-1-ruanjinjie@huawei.com
Cc: stable@vger.kernel.org
Fixes: a3fdf784780c ("kunit: string-stream: Decouple string_stream from kunit")
Suggested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/kunit/debugfs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -212,8 +212,11 @@ void kunit_debugfs_create_suite(struct k
 
 err:
 	string_stream_destroy(suite->log);
-	kunit_suite_for_each_test_case(suite, test_case)
+	suite->log = NULL;
+	kunit_suite_for_each_test_case(suite, test_case) {
 		string_stream_destroy(test_case->log);
+		test_case->log = NULL;
+	}
 }
 
 void kunit_debugfs_destroy_suite(struct kunit_suite *suite)



