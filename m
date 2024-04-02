Return-Path: <stable+bounces-35591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE36895136
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF862B26DEF
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125877F11;
	Tue,  2 Apr 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQ/QZzXd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6E76048;
	Tue,  2 Apr 2024 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055523; cv=none; b=DF+dGpviY6NZvZYyfqiqMIWi0K7+GjgJuIX4lU1vh/h5TWGdzubCdhprhwN4zgyQoal1sbuqMrHRaUxEP8D6P4RCzaSPzXKDxplVJmG4SMs39SwrdaU/XLbMKxGlPWLkN+E/SC1/OEuFPsW7O40ABZWeoLvOJ8V+L7o7e4QRA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055523; c=relaxed/simple;
	bh=+Ydi6LkKPpIwGCjEGUPKUAynMc6uP14NLPzukWdFjm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9YbR/kYWvr+G5fOyjheTLgWRlKfMtrr79aDUjN67uqlLKpiK/oO+ZO0kVaLQd7jR7SlSjCiovbhSIcrVOTFxwV3Ug4KMEVBxPdJAU+eL2ymf5NE5KSHthj3MXnizueuec1N2/+WgBPuaeG9O2nBTz+ijoid5x7zYxZk1Kg8oVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQ/QZzXd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432AM04L008981;
	Tue, 2 Apr 2024 10:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1ww2COLBTJ7bgaqnVHBGXC4jLJucs8Cb646lLA0cG04=;
 b=qQ/QZzXddIXh983H3uImULbsCLmIgChfDaoNO8dVbcBOiqsDI4TC7nrxFwdxKzbpQVsK
 t3peLKBDNP2o9foNzRzQ5+gR9CppF3KUVA0/6fdqTMAjOMuJUNJeVVRBuQZ2iXP11tPQ
 2S0yfDKVPYOMqo2sDU1VZfVaH+wTjdm0lCRT5Roo9xHXvQW8P/APS6sDXP3aj1YiERgQ
 GyKaD3Rb403KSsw2f2Q9PDS1WJH0xeHFfWzMSu7HsDibfQX8N0fNzStNxAL07JU4KGkC
 f75fChqGSgZs0R8rE3NVlMqFs2A6Hkw+bg9y6A1nSFQV1vUcsOw0M3P0YVPFZzSNeJQ/ ng== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8eyagbgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:58:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4329B4JQ015207;
	Tue, 2 Apr 2024 10:58:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6y9kwmqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:58:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432Aw9oH47186180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 10:58:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E1F20043;
	Tue,  2 Apr 2024 10:58:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45E0520040;
	Tue,  2 Apr 2024 10:58:07 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 10:58:06 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, stable@vger.kernel.org
Subject: [PATCH v3 1/2] powerpc64/bpf: fix tail calls for PCREL addressing
Date: Tue,  2 Apr 2024 16:28:05 +0530
Message-ID: <20240402105806.352037-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V-_q5Nr3V6K8HGWUHWkNp2QfkgIABNiX
X-Proofpoint-ORIG-GUID: V-_q5Nr3V6K8HGWUHWkNp2QfkgIABNiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020079

With PCREL addressing, there is no kernel TOC. So, it is not setup in
prologue when PCREL addressing is used. But the number of instructions
to skip on a tail call was not adjusted accordingly. That resulted in
not so obvious failures while using tailcalls. 'tailcalls' selftest
crashed the system with the below call trace:

  bpf_test_run+0xe8/0x3cc (unreliable)
  bpf_prog_test_run_skb+0x348/0x778
  __sys_bpf+0xb04/0x2b00
  sys_bpf+0x28/0x38
  system_call_exception+0x168/0x340
  system_call_vectored_common+0x15c/0x2ec

Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")
Cc: stable@vger.kernel.org
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* Changes in v3:
  - New patch to fix tailcall issues with PCREL addressing.


 arch/powerpc/net/bpf_jit_comp64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 79f23974a320..7f62ac4b4e65 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -285,8 +285,10 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	int b2p_index = bpf_to_ppc(BPF_REG_3);
 	int bpf_tailcall_prologue_size = 8;
 
+#ifndef CONFIG_PPC_KERNEL_PCREL
 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
 		bpf_tailcall_prologue_size += 4; /* skip past the toc load */
+#endif
 
 	/*
 	 * if (index >= array->map.max_entries)
-- 
2.44.0


