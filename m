Return-Path: <stable+bounces-94497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077079D47EC
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 07:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04DF282650
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 06:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838C1A707E;
	Thu, 21 Nov 2024 06:46:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFA1AA1CA
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732171562; cv=none; b=GxxKXeol8WkszRJJ0reUVvTO8AbjgI6bfpER7HJ4nyMBYoF95DhVWvpOvqymWBJghsPz5rtUvBOU7lBIpeZbUHLX8jnPqe56qiaTgiR+xbzyiaMYzu3BwJ8h1fM71P/wAhVJy993OTfkurG/PyrpmB5JQMzBYckuRyumxkXWqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732171562; c=relaxed/simple;
	bh=SWH99v5JiRbkudjjDsSMRFBlCoihkbvVkHqAyrMjeDg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sD5dWLQw3NPPSxC/8icJ5IGp2eSVvbVCokUCkt7vQb+F364c6+aJYj8PVCJQEf01guHujDU1QghwW5MS1M+IX/XPb1SbShgUmWti2gi176UImHmLN7EVMJmQaQFW3rPDaw+OcUWkbrKg7POiV7Knl+tqBb54wWiiJy9rSgtM68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL5JKVc022259;
	Thu, 21 Nov 2024 06:45:49 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8d71r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Nov 2024 06:45:49 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 20 Nov 2024 22:45:47 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 20 Nov 2024 22:45:46 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>, <kent.overstreet@linux.dev>
Subject: [PATCH 6.1] closures: Change BUG_ON() to WARN_ON()
Date: Thu, 21 Nov 2024 14:46:07 +0800
Message-ID: <20241121064607.3768607-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: t5J1EskqMOomslu53G1hw4dTqE3LOapI
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673ed71d cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=5JWfVcWoufYuLB2yhE0A:9 a=zOBrXZkVpCoA7Q2jQD7Z:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: t5J1EskqMOomslu53G1hw4dTqE3LOapI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_05,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411210051

From: Kent Overstreet <kent.overstreet@linux.dev>

[ Upstream commit 339b84ab6b1d66900c27bd999271cb2ae40ce812 ]

If a BUG_ON() can be hit in the wild, it shouldn't be a BUG_ON()

For reference, this has popped up once in the CI, and we'll need more
info to debug it:

03240 ------------[ cut here ]------------
03240 kernel BUG at lib/closure.c:21!
03240 kernel BUG at lib/closure.c:21!
03240 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
03240 Modules linked in:
03240 CPU: 15 PID: 40534 Comm: kworker/u80:1 Not tainted 6.10.0-rc4-ktest-ga56da69799bd #25570
03240 Hardware name: linux,dummy-virt (DT)
03240 Workqueue: btree_update btree_interior_update_work
03240 pstate: 00001005 (nzcv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
03240 pc : closure_put+0x224/0x2a0
03240 lr : closure_put+0x24/0x2a0
03240 sp : ffff0000d12071c0
03240 x29: ffff0000d12071c0 x28: dfff800000000000 x27: ffff0000d1207360
03240 x26: 0000000000000040 x25: 0000000000000040 x24: 0000000000000040
03240 x23: ffff0000c1f20180 x22: 0000000000000000 x21: ffff0000c1f20168
03240 x20: 0000000040000000 x19: ffff0000c1f20140 x18: 0000000000000001
03240 x17: 0000000000003aa0 x16: 0000000000003ad0 x15: 1fffe0001c326974
03240 x14: 0000000000000a1e x13: 0000000000000000 x12: 1fffe000183e402d
03240 x11: ffff6000183e402d x10: dfff800000000000 x9 : ffff6000183e402e
03240 x8 : 0000000000000001 x7 : 00009fffe7c1bfd3 x6 : ffff0000c1f2016b
03240 x5 : ffff0000c1f20168 x4 : ffff6000183e402e x3 : ffff800081391954
03240 x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000a8000000
03240 Call trace:
03240  closure_put+0x224/0x2a0
03240  bch2_check_for_deadlock+0x910/0x1028
03240  bch2_six_check_for_deadlock+0x1c/0x30
03240  six_lock_slowpath.isra.0+0x29c/0xed0
03240  six_lock_ip_waiter+0xa8/0xf8
03240  __bch2_btree_node_lock_write+0x14c/0x298
03240  bch2_trans_lock_write+0x6d4/0xb10
03240  __bch2_trans_commit+0x135c/0x5520
03240  btree_interior_update_work+0x1248/0x1c10
03240  process_scheduled_works+0x53c/0xd90
03240  worker_thread+0x370/0x8c8
03240  kthread+0x258/0x2e8
03240  ret_from_fork+0x10/0x20
03240 Code: aa1303e0 d63f0020 a94363f7 17ffff8c (d4210000)
03240 ---[ end trace 0000000000000000 ]---
03240 Kernel panic - not syncing: Oops - BUG: Fatal exception
03240 SMP: stopping secondary CPUs
03241 SMP: failed to stop secondary CPUs 13,15
03241 Kernel Offset: disabled
03241 CPU features: 0x00,00000003,80000008,4240500b
03241 Memory Limit: none
03241 ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
03246 ========= FAILED TIMEOUT copygc_torture_no_checksum in 7200s

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
[ Resolve minor conflicts to fix CVE-2024-42252 ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/md/bcache/closure.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index d8d9394a6beb..18f21d4e9aaa 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -17,10 +17,16 @@ static inline void closure_put_after_sub(struct closure *cl, int flags)
 {
 	int r = flags & CLOSURE_REMAINING_MASK;
 
-	BUG_ON(flags & CLOSURE_GUARD_MASK);
-	BUG_ON(!r && (flags & ~CLOSURE_DESTRUCTOR));
+	if (WARN(flags & CLOSURE_GUARD_MASK,
+		 "closure has guard bits set: %x (%u)",
+		 flags & CLOSURE_GUARD_MASK, (unsigned) __fls(r)))
+		r &= ~CLOSURE_GUARD_MASK;
 
 	if (!r) {
+		WARN(flags & ~CLOSURE_DESTRUCTOR,
+		     "closure ref hit 0 with incorrect flags set: %x (%u)",
+		     flags & ~CLOSURE_DESTRUCTOR, (unsigned) __fls(flags));
+
 		if (cl->fn && !(flags & CLOSURE_DESTRUCTOR)) {
 			atomic_set(&cl->remaining,
 				   CLOSURE_REMAINING_INITIALIZER);
-- 
2.43.0


