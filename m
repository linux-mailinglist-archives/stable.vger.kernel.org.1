Return-Path: <stable+bounces-230455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PBlJj4nxWkU7QQAu9opvQ
	(envelope-from <stable+bounces-230455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:31:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB372335380
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D6123112462
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788753F7ABD;
	Thu, 26 Mar 2026 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="crP9iCPu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC03B8D40
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527713; cv=none; b=baEOc8/sd0caruFs7XzTCfgcGKXmWLqMgVnLEzvS+D6D7bRgyuRpctXAOh59LBuHDS0yUtAYMMbz38rxxMYpVHaoEE3ga5Ms8SFLmHwFleLB2jKIu9/lzNQBVlu4hW4zNYRG/wiuMUUhV2OcjP17e/cTQFggqVbNhtFKZ3/k4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527713; c=relaxed/simple;
	bh=Bs6KOmEEtRRmu81Fl2bfkDBIiEi3XXwBFInsJJ9pG6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mtsv/QN8NVMXY9dmNxon52sKtMZPIeVHDCCdymdAf0bNC/tHi7eSgg1UvLCkGboPlyH3TJT+2N5fjMlfMhxGy8qkJpiH4VtPYgrtu2IoSkXSkt/mH+pP8BXxNsjpRyTMKd/LizQKEo/fuS0vl3xL4QHworoFgM6fO710Ii5X4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=crP9iCPu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PKj5IB4104871;
	Thu, 26 Mar 2026 12:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UOWNud
	N2+O/c+RqsYL6dIajOKbDkXBnSjoy+JjhnDg4=; b=crP9iCPurAjwFP2wlIFhjq
	3Yw2pMom1e2DkIgY9/Ca8tGNifnPxHA7Q/4tcZCo0N1EypMwNiKyKNbumyK3mh3m
	UvyQfCXaaunj4pkO9/Vs5MKiEb2M+spzvuLm+DD/2lyPRrMKIz7bfdQFtoHhHEud
	FufT/heQK2FJu6AIVw7eV16cZrPNe8gnXD6bwVIY9i3NHFd9t1xqT6oj6fJWFOE7
	Hti5RKjxnAjpM/hTHjI7fFdOMmnIkfDMgSbgSbg9EUWTlnqeM8/WkW4fGa7C6o+n
	NIRn7AWXzdGYFt4iy7XeaXF11TygwNGnPD3BDb+gEhQU6GwdYnOKahkDMCpdPiLQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqn60j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 12:21:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QAq2hM009118;
	Thu, 26 Mar 2026 12:21:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nntw79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 12:21:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QCLgVG29753790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 12:21:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 630A920043;
	Thu, 26 Mar 2026 12:21:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78A2D2004B;
	Thu, 26 Mar 2026 12:21:39 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown [9.39.29.115])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 12:21:39 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
        Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com,
        stable@vger.kernel.org, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v4 1/2] drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB
Date: Thu, 26 Mar 2026 17:51:28 +0530
Message-ID: <2e3d4c1dafc6d2780ca502c9d78e8ac250122d96.1774521183.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774521183.git.donettom@linux.ibm.com>
References: <cover.1774521183.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 4pX9GP-_vUBGIZyxzJMYYBq5ZjpSTiAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4NiBTYWx0ZWRfXy9gZzaimke36
 WFbMIZfW1VsD/65DNfoAB4P0Vega98tumukqktxvReIjVnsAXlxWMGk0z5aeHdzRm9zRbF+TZLn
 UMyCZnDML0F+A82Ag7l0nzTHPuAQyB9i+62s29w2q+O+4/ybMScwKhDXK1Z3tClrlA4T8SC+zy4
 DotYWU0fax0H+5Uul2Y/4y4jSD9Yf2AyjMBjiJzxy3QiHnO4mWHA4wq+qx1Zzwsurek2LcOu54w
 U9HlYTKHmx+1IHP7Uk2qelpdyQrk83waes/+E+2inzqXN4CNvnYz3Bco5pJWBB1puAX8IjKI4W5
 IaEyy/FB4CGWRWNkzhM6vTPyYyj8/tg+yRz1npphfgwiMxkZ2DRuE7vOKvtHqLhDPHCHwiUGGMV
 wCyxI+gEIxA1KTO1xcYmpedxHp11hrooIX3C7tPyfMF7OXbOiZqBTcJkLb358AB2ZCeq0OBXk+h
 LU0gr468YdpI464/ELg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c524dc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8 a=eWw-uJ2SO74ajMguZ_YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: T0MV1SaMlgY8sms2QFbjigdAZPz2AIHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260086
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230455-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lists.freedesktop.org,amd.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donettom@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EB372335380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 64 KB and
KFD_CWSR_TBA_TMA_SIZE to the AMD GPU page size. This means we reserve
64 KB for the trap in the address space, but only allocate 8 KB within
it. With this approach, the allocation size never exceeds the reserved
area.

cc: stable@vger.kernel.org
Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index bb276c0ad06d..d5b7061556ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
 #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
 						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
-#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE		(1ULL << 16)
 #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e5b56412931b..035687a17d89 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -102,8 +102,8 @@
  * The first chunk is the TBA used for the CWSR ISA code. The second
  * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
  */
-#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
-#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
+#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
+#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)
 
 #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE		\
 	(KFD_MAX_NUM_OF_PROCESSES *			\
-- 
2.52.0


