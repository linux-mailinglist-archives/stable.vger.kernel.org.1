Return-Path: <stable+bounces-256541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAU3CmBIGWrHuAgAu9opvQ
	(envelope-from <stable+bounces-256541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5A35FEEA5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B0F9300FEE5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06003A0E8D;
	Fri, 29 May 2026 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qz2qaSeC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C917D6;
	Fri, 29 May 2026 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041466; cv=none; b=uLrb3XTiK/Lk4oTx3jTbzlc+W1srXkYep4cYz0rCIzcvjfpobXLwH6HeRYDupDNtjU7te4NeUWtnsqNZj9VYt9C64HFM/eY4lPBE+TP74BSs4NAgCbG0/euGG/vZhGwkf5SeCh7AeQW/vvQTUqtFK7by0XfW2EpcCMR79PCGOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041466; c=relaxed/simple;
	bh=27a9o/Dhhbm1xUeY32/pVqlEI74X+P7N2lUA5x710PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwekjPbTSsmYd/4THORXsAgxkj5pEKtmuXSY/QZUych2f6fu0yaXw5UG+TuK/SlUq/RfgpCuQsq8lBh9vNQzfBLz6cn9uoECg7udTj1/wVyvekUNZcsC+ytZX2NipP0ePOUjQGqlclxiIFZwVvyk8h3W4hUWq7d3Fta3opWYWm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qz2qaSeC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLll9N2133353;
	Fri, 29 May 2026 07:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QaUBM/YJNHXzrLlWg/ae6LCzGZf2VSHi8tS7MKIlZ
	o8=; b=qz2qaSeC5LvfSGCWOAhcYJKgXAFPR22K0q7wpMV2ZHUCmTCJqceLJ8f90
	lGPVkopVhAlf/yya0Dui02qENISpQTEtWgpx6LQza79Nr0j28uMmlS6b4yKSgQZC
	sbLLZxEReLaIz8rvd88L9IA6vtOlyYFJ+BPfXAlt6kZdV+TCNEvgw2jvtoAR5oJ2
	isJb7GFL8wLyyaZOMxRd3PVFT+Itn35poMkGDMWuiZMcA2+XkHFL0SDOXz6EnzfB
	pYw6X7TGHTun3JB8I9BwgTQV9q605+Gp3XBpJftH7/t2IMS0STdsgrAYL68tNXtm
	VxeWPApAdbJ4Kh5tSVF/04YISMhvA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887q2d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 07:57:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64T7s9ht015980;
	Fri, 29 May 2026 07:57:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbvctj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 07:57:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64T7vMQe46596514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 07:57:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FDF920043;
	Fri, 29 May 2026 07:57:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2435E20040;
	Fri, 29 May 2026 07:57:18 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.221.69])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 07:57:17 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        mingo@kernel.org
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, venkat88@linux.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
        kprateek.nayak@amd.com, srikar@linux.ibm.com, riteshh@linux.ibm.com,
        stable@vger.kernel.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] sched/topology: Provide arch_llc_mask for cache aware scheduling
Date: Fri, 29 May 2026 13:27:12 +0530
Message-ID: <20260529075712.1181039-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a1946e7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8
 a=pGLkceISAAAA:8 a=-47l-NziEOCSl2LEx70A:9
X-Proofpoint-GUID: N9MsWTTA2OgFAQqDSN6GN4uceCGzPAFW
X-Proofpoint-ORIG-GUID: jd94O_QPmPdm8m04htMDSwhRKUKv57KN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA3MyBTYWx0ZWRfX7HaOgpR6LV/x
 o5XA8jIi7/LfDrSOpVhXiCAJ86QD5bof1TYXJwr13tgn0DxunZC1YAwL8eaBXipcPd88Ujy3VAo
 9p854gXdmKuQYqABi76ayel/cUh7Ges5N425GFmamjae80z4TyvILcIufMIlP/TmvX1sl2+1NHV
 xFXLTqzoRoHBB+TE28XfVd21sMFWg6ZXWfjE6JnkqfzFf0zqHXzjB+M6ISccb18iEpXmj8Sjhpc
 LeieH3kHbkq6ZfgWQkUlUXcMKvne6gi/ooNHXg0kaMPvu2Ylq/6TRQKXTsBG5uwiSRIIu0NMjzl
 eO9SVcBd8kkmJWFmIlRppRZpezcoSADoU0YLgTqqiM16zr6CvaluLhkfFDzucCWmaLv3dFod8OO
 pQPHApAQR0sG7e9x+rh1bD3GlDuxJceWF1rjil8Nh8Nqq1kgcz48eoQ6//z4Pi7sNB7JdqAnN0C
 uxPE2BBxElVshbNK0Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290073
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,csgroup.eu,vger.kernel.org,intel.com,linux.intel.com,amd.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256541-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 6E5A35FEEA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
b5ea300a17e3 ("sched/cache: Make LLC id continuous")

Stacktrace points to llc_mask being null.

NIP [c000000000e58504] _find_first_bit+0x44/0x130
LR [c000000000e58500] _find_first_bit+0x40/0x130
Call Trace:
build_sched_domains+0xad8/0xe50
sched_init_smp+0xa8/0x164
kernel_init_freeable+0x250/0x370
ret_from_kernel_user_thread+0x14/0x1c

On powerpc, cpu_coregroup_mask is available only when the underlying
hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
coregroup isn't supported. In such cases llc_mask was being referenced
when it was null leading to panic.

On powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
domain point to LLC is wrong. Provide a way for archs to say where its
LLC is if it not at MC domain. 

Based on tip/master at 5c89783224e9 ("Merge branch into tip/master: 'x86/tdx'")
Cc: stable@vger.kernel.org

Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com> 
Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Co-developed-by: Chen, Yu C <yu.c.chen@intel.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  6 ++++++
 kernel/sched/topology.c             | 13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 66ed5fe1b718..e3de0f3d8b86 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -135,6 +135,12 @@ struct cpumask *cpu_coregroup_mask(int cpu);
 const struct cpumask *cpu_die_mask(int cpu);
 int cpu_die_id(int cpu);
 
+/* Points to where the LLC is. On power9 this will point at CACHE
+ * domain, On others it will point to SMT domain. In all cases
+ * cpu_l2_cache_mask points to where LLC is
+ */
+#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
+
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2ceb54c970..622e2e01974c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2063,12 +2063,21 @@ const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu
 	return cpu_coregroup_mask(cpu);
 }
 
-#define llc_mask(cpu) cpu_coregroup_mask(cpu)
+/*
+ * Majority of architectures have LLC at MC domain level with exception
+ * such as powerpc. Provide a way for arch to specify where its LLC is
+ * if it falls in exception category
+ */
+# ifndef arch_llc_mask
+#define arch_llc_mask(cpu) cpu_coregroup_mask(cpu)
+# endif
 
 #else
-#define llc_mask(cpu) cpumask_of(cpu)
+#define arch_llc_mask(cpu) cpumask_of(cpu)
 #endif
 
+#define llc_mask(cpu) arch_llc_mask(cpu)
+
 const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return cpu_node_mask(cpu);
-- 
2.47.3


