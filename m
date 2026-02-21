Return-Path: <stable+bounces-217630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL6GLDpamWnfSwMAu9opvQ
	(envelope-from <stable+bounces-217630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 08:09:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0275D16C52E
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 08:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF545300DE0B
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAE34252C;
	Sat, 21 Feb 2026 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JULpFgqO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2B27FB37
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771657783; cv=none; b=o+YdvQ8yDXOi/iDvL+2W5feYCs515LVTCTBQ2vMEiZteFKls3s2OgH1kQqwPyQpJpwXpi4kYSHpRe/X2keJeh+NbULnvBl8TZm3Fkpg0tZ2UY+rVeA70S74tVCCzljV46hOnNaeCSAZ5Zr5KM//ZELcB4MXcC5Bnh2olxsejrEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771657783; c=relaxed/simple;
	bh=xYvGWrZjsVZvEjTZQ4+ylTD23BKn43QTjfSK/3dX528=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8/smKD6J9POpEZoSeTqcNQCx2l9d0wsCcoGFFr/YY8RrBI4FD0DvlxgMSYAKb9pX8+W1bGvs9DmU5O4Z5QkI1N+t1e7D5KHr7F75jBHCGqJX74GhQxMXtc4Ticll8Vp19rhpHOjC6qZo9yPM3srhGXx4Po/yznhXDsFHsExZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JULpFgqO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61L2jpah2360246;
	Sat, 21 Feb 2026 07:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZF56T7zT8nSvsCDUg
	sBt150Mw9rljw3vzaQLRr+w8y0=; b=JULpFgqOAI8pLq/XhJlVKIaRUThtHhf6P
	dRU2zxFXJ2RfqtSqnH0h4/3OgZoHtbC7SwTrB98Z0XUm45KJYB6jggLF8bUY8uQL
	w9ctvMiKD9gNYY5lUYoZWMRuaVvmEYr0zVvReu/dyiI37bevUHLBJQMcDObF1x1j
	ZYMscqhaq9JeDTX5HrkRu+6J+holNX+Waa6Ssl6g3GZx4fOGXAl/qSdPnOjPa5GO
	Hj+VNaWhLRAydULzS/g3I35GJJYRxT/qnI52CDNww9u3hKDwBsvm64O2O2ZXXPKr
	sndGT9w0/P1RDwb3o1zhUdPn8jD0zn6vG9zxVZQpxklyJndb6Atdg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471gg78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Feb 2026 07:09:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L0f7ZI030217;
	Sat, 21 Feb 2026 07:09:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45kc20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Feb 2026 07:09:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61L79YSa49938692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 07:09:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D55A2004B;
	Sat, 21 Feb 2026 07:09:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DCD220040;
	Sat, 21 Feb 2026 07:09:32 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.162])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Feb 2026 07:09:31 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
        Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC PATCH v3 1/6] drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
Date: Sat, 21 Feb 2026 12:39:19 +0530
Message-ID: <f6b7f3e49ea54fc9c5c3f8dae607382ba9d6f58e.1771656655.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771656655.git.donettom@linux.ibm.com>
References: <cover.1771656655.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pMXeA6kUVahNXGtfMhVnLOOXkbx76t8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDA3MyBTYWx0ZWRfXw3xTSDEk9HVr
 i7zrB2ICWYZj3Mc8zVeUcCkmq0oqLPN7l75h8+3J9Coc7zAVYOh+8S3oCgjXAOcwZY5Y1QhgIj4
 +zgPyfzW1P+hlGOLKxhkVdz2Edtz0UsuTDJUhQO5DOjtUXGouI4hEOb56qlkOWzxSpaJm4/lnMu
 Y/dT+GlXhLQsTPaGeAJqMEiA4VcPsru58ordNhluMhER9epWMXbeH99rpNS0QsiYf79IXEP9iQV
 mvzRQK9TbgVeh/Y//F0y9sOiy+3eTx1oT1fe1oBgb+oC5CCiUuup91l0915N0OyRUCyJafcavhk
 f6aqoX3Z/p32Ah11PFB34PHja3hXGeyC3OoAzf/naJeJrsHHj2jwAfahzNmYxti8KXuGWzQnXSm
 yLU7d8nuCgFb06xTxKePPlzauAkZRFO8yTioCzCmRxKZB2FRNIX+L0wfLVawqR/9t8+ISGNtqYC
 dDOOEsNVh2aS72OBR5g==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69995a33 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4rmLHU1oXFswgLKNxjYA:9
X-Proofpoint-GUID: FExHyB6FzI9pB7yy5VALCnGTt_V40WkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602210073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lists.freedesktop.org,amd.com,gmail.com];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217630-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donettom@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0275D16C52E
X-Rspamd-Action: no action

Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
4K pages, both values match (8KB), so allocation and reserved space
are consistent.

However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
while the reserved trap area remains 8KB. This mismatch causes the
kernel to crash when running rocminfo or rccl unit tests.

Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
BUG: Kernel NULL pointer dereference on read at 0x00000002
Faulting instruction address: 0xc0000000002c8a64
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
Tainted: [E]=UNSIGNED_MODULE
Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
XER: 00000036
CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
IRQMASK: 1
GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
c00000013d814540
GPR04: 0000000000000002 c00000013d814550 0000000000000045
0000000000000000
GPR08: c00000013444d000 c00000013d814538 c00000013d814538
0000000084002268
GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
0000000000020000
GPR16: 0000000000000000 0000000000000002 c00000015f653000
0000000000000000
GPR20: c000000138662400 c00000013d814540 0000000000000000
c00000013d814500
GPR24: 0000000000000000 0000000000000002 c0000001e0957888
c0000001e0957878
GPR28: c00000013d814548 0000000000000000 c00000013d814540
c0000001e0957888
NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
Call Trace:
0xc0000001e0957890 (unreliable)
__mutex_lock.constprop.0+0x58/0xd00
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
kfd_ioctl+0x514/0x670 [amdgpu]
sys_ioctl+0x134/0x180
system_call_exception+0x114/0x300
system_call_vectored_common+0x15c/0x2ec

This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
ensuring that the reserved trap area matches the allocation size
across all page sizes.

cc: stable@vger.kernel.org
Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..a5eae49f9471 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
 #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
 						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
-#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << PAGE_SHIFT)
 #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-- 
2.52.0


