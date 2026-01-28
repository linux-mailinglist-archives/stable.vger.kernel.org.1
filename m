Return-Path: <stable+bounces-212103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP08NyQuemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:41:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB80A433F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBAE930E6CEB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288C23EAB7;
	Wed, 28 Jan 2026 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TRWycd7B"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9113B7A3
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614408; cv=none; b=Y3rtyW34aFtWJGzQz69RwPSKCGJCNY/QmKihzyGFSRASDAzS/r0gCWQVjq4eE9ngJAPTDv9bSgQKxFPgMx56VBkLQRNtFQY3Fa11DKFzX3vjagVlhQ7+39F5cY44JIkfigUvzR5vhk4EwT3MWrcAYfpq8BSsk2QCUKNFOikwDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614408; c=relaxed/simple;
	bh=eWVL16fl9H3RP9fLRTNLm462woClQf+zlvpgCmQKVRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY50ia5/I/1BlWYBAt89idZ0iJJJmGBfMFjSrG5+pziqVAUXfNf5sna3duR5cUotYOPKU6tYeujOFOKEXafpSDdXUy08HN/XeAn04XMMRmqUuIzFQXVNcMSL7TAhwU7S/NpP1Lx7Vp2hynR3Ink6b2zcCuPyHoBw54FqIn3O9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TRWycd7B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60S9CRCg021454;
	Wed, 28 Jan 2026 15:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PoNKF+gcSgVNWNQxf
	nj7JYJL6ntu8J7c2GhbZ+QoFo4=; b=TRWycd7BvpGK4e1+jhtK9KKi2uGDg6IXm
	zl8Eaa9hfIi36nmhABiob9ZSwNm9hjdp6qlC9u8dudsfVTOiaDf1AZ/ta6qxpPrg
	lC7wsIUwXQ6ItkKCN9QLzOU6HOlk3osAHZ1QOH1nvEPCaPBSUYe6p0HUDXSk6YWa
	VlBqpm6cVyKk83tJuX+HdXG/GsICSlAR5nDfn7PsNqxzutoZZZ8BXPQ6Sm6VDSq1
	wQbMLsiAbBlQgF2EL7ERDgWZIHDVUW0Ya3z7gO6fAl8JRhZyu+ZanRd6SvN81q3G
	9EWo/w6hiBLiX8ja1FkTNcKRfTZeAZByGf0WVCY+FE4/YqNpHSyjw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk747r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 15:33:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60SFGC6I004126;
	Wed, 28 Jan 2026 15:33:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk747qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 15:33:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60SBoYgC031030;
	Wed, 28 Jan 2026 15:33:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dsnycy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 15:33:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60SFXIDc58458432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 15:33:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61FFE2004E;
	Wed, 28 Jan 2026 15:33:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B44E520040;
	Wed, 28 Jan 2026 15:33:14 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown [9.124.209.179])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Jan 2026 15:33:14 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
        Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC PATCH v2 1/5] drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
Date: Wed, 28 Jan 2026 21:03:02 +0530
Message-ID: <6d376a1631bb0af56124a47a5bab42704b3fa063.1769612973.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769612973.git.donettom@linux.ibm.com>
References: <cover.1769612973.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mHbFlMwE8WZMS6MlicxXfFttnzsn4wLB
X-Proofpoint-ORIG-GUID: Rg-4pp3Z-tVEA2KIgyW06gKa5FuyU_eu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyNiBTYWx0ZWRfX+BYrli+7cM8m
 ruJoetjrETbabB8xxVoHhSJ9T+exPBCLHZB8KZXBwGhkww1ZOS7dEhj5qCLiTCyXjF7OhqE6uxQ
 MDeQfdZV5c4mSB7/rX/DfK+pWPtwF92SiZdMARYh4bwpHYmET7+VgNSOD9TZNbO+TBuFo9L6jsb
 XbXWKSHWjNOAz0ilhlgEjqJwU4uO3B51AslyYK78Gkdq1xo5H0nuIrbacYQKZPbsrrD29iRhRkA
 FAYdNq4hXCC84154AEoyyBFGHvznJozCEMAfeUEiKch9R7yLsVz596Kr7toRwXSTSOlPMcvjbad
 goR0Vf+153O2XrJ6Rqa4Hg6JFcQN6c1XjCJ5+WlJTU3g0vjY1hR6G31jBWasDVP8bH7WRmJJETs
 tksLusmYv47EMLDU5068u4FXQ4oryJvAdvM5Nt8Uk/d/Q09PMV+vuO49DML7+c3ytnulPxZYww6
 q1EKFCw+2p5g+KI1hrQ==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=697a2c44 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4rmLHU1oXFswgLKNxjYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-212103-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lists.freedesktop.org,amd.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donettom@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AB80A433F
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
index 15d757c016cb..c1d75a22ef26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -172,7 +172,7 @@ struct amdgpu_bo_vm;
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


