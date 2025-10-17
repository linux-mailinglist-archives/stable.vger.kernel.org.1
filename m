Return-Path: <stable+bounces-186300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3535EBE7DAB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3A9D35C79C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361CD2D543A;
	Fri, 17 Oct 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ltITxuPv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2A2040B6
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694240; cv=none; b=MU0jLMFlldYuExfm+JDahghLRdewLS4DrqVdtzYqECiaVFR2KeN5Ktx6vrnSed3EloqQEfN5BCzwetEVA3co+eRg2tzt95UdBgK0Qwl928BUpGsIXOTvcqIvKD2bLroPYL8QLXygTmDG2MNkFu47SeuwE3A/KP3y27hmYGqI29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694240; c=relaxed/simple;
	bh=nR2YxMIgHdjCJYg+RgQm56qOoJ8KZ3u8h1UtRm6Ydxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8QXvIpSEj+4JHfgk+Nz6m73fLn+dMr6ScvyYpn1ve9LWH4KvInfZ/OjlgwFpJq2LY5MV+J5/moXxCynT2n4v4U1efyMFcy+crObzKiWZMDb/6yU+w80pMw5MeNpA/ZOppTJ+5VSXc+Ey8h25BGq6fJTZThXfzvgHi/OQmk1jtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ltITxuPv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8jPCO001388;
	Fri, 17 Oct 2025 09:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=94j7IMSXTwoXwi6fO
	Pj+dALhKJ+RNYsLbqRP2UoTEB4=; b=ltITxuPvIxhXT1t8RRHxhcCMVdPdL3TdM
	6J8MCLzi4gQ2WW9XMtlsC9hTY/Oh7r8Z+9f7GQ1Mf+GmE2y+8MQjUkWKt3yxrB+8
	8G4JGCECxJuW7dqDxdxjqpZFRwIvvI6739Xtc9TZLWfuM9K3N7uzdOcCT1uhis1j
	NiTTSbjo5DUc2nZqBy0dMQu20EyGG29Oyfs1rPONC5kVHaNiT4pLaTBm5Dr8d/1k
	hKmk0Y7yUpZz16YSREcCvVY2GpWgXl0MtyP5I0Vf5qJbe+sYnqoWr4aHtIrBa1Iy
	oCJjp6Y3b75rwmlvmP6sJAzBWu5qjnYJ/80yVOFLODAvlR2DOa/hA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8cs8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:43:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9ElPb003709;
	Fri, 17 Oct 2025 09:43:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xycp2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:43:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59H9hdxp57606626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:43:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E1432023E;
	Fri, 17 Oct 2025 09:25:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121262023D;
	Fri, 17 Oct 2025 09:25:53 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Oct 2025 09:25:52 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.12.y 4/4] s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG
Date: Fri, 17 Oct 2025 11:19:07 +0200
Message-ID: <20251017092550.88640-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017092550.88640-1-iii@linux.ibm.com>
References: <20251017092550.88640-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1sVxwNbMMxzLuPhCQQUSyMtOFXvdxVta
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX228tY/GaB8Pk
 486/Cy/lviBrix1f5KWMZQFTkW6aFYDzUZpLyqgq4xJVc7l+xWCUIZcW+n7yPACQnYgHitUS1rd
 XawoYE4MNEmPjVijdqsvfNbxMLST51KUDaK8MpAnixxh5PDbcMlRVLY4OOUGh1+qEr3qfCYb37y
 gd6/eLLi/9URVRcoD3/LFSTCy2coNCnJVPRnMBw79b1VJ50B7MvDhlJvfoQPFo0na+vNJkXkO80
 o1mNS6WK3gPZQJF12x0U+siIoEs2p+RIe3vmI3r0OCwvbQW6A9xHXMfDcyneVrKPUNXfSiHPJND
 KReUkA3FlVG8gotLDW0FZ+EwUTPRz+LfnPVUtMLPj1aybRpAmdLiCfCclfn7m0GGQQ3g/iONv5v
 OyEHceuENk0tyWYk6wSh7zXGBMWmsg==
X-Proofpoint-GUID: 1sVxwNbMMxzLuPhCQQUSyMtOFXvdxVta
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f20fd2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hWMQpYRtAAAA:8 a=PzRsl5-gkreILLghS_IA:9 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

commit bc3905a71f02511607d3ccf732360580209cac4c upstream.

The tailcall_bpf2bpf_hierarchy_fentry test hangs on s390. Its call
graph is as follows:

  entry()
    subprog_tail()
      trampoline()
        fentry()
        the rest of subprog_tail()  # via BPF_TRAMP_F_CALL_ORIG
        return to entry()

The problem is that the rest of subprog_tail() increments the tail call
counter, but the trampoline discards the incremented value. This
results in an astronomically large number of tail calls.

Fix by making the trampoline write the incremented tail call counter
back.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20250813121016.163375-4-iii@linux.ibm.com
---
 arch/s390/net/bpf_jit_comp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 2526a3d53fadb..f305cb42070df 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2828,6 +2828,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		/* stg %r2,retval_off(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
+		/* mvc tccnt_off(%r15),tail_call_cnt(4,%r15) */
+		_EMIT6(0xd203f000 | tjit->tccnt_off,
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
 
 		im->ip_after_call = jit->prg_buf + jit->prg;
 
-- 
2.51.0


