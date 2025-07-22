Return-Path: <stable+bounces-163702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E3B0D9A7
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98541885876
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827682E9EA4;
	Tue, 22 Jul 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="C/Oa7IzQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A652E2F04;
	Tue, 22 Jul 2025 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187375; cv=none; b=KaYqC6hj2ILCVJC2x0x8Czj3vRA7lLKKlwiPUBLXCuyHQYbaOi+aOExV+7vLYVrHSqK7dKif0KbJzpi3QIPhdTkafMBw3OBh0EY8U0cJJ4MNFLZ2rSgJrYnKxzxLPR+Nla6GQEiuyDgm7MQGdwih+BIjWfdEdFmUcTOOvjSw4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187375; c=relaxed/simple;
	bh=H6bvARozgPG1wqUKeZIQSmayUowJ0OhxNhPVUX87UPo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VmEepsrp+WXZM7kogcEnTiDmfEprxeHBofTNa2bxYNvH3qrb1RcbDroGNUtdPZoCZsFDtXSovVbAHNcQmtYLv1N7NoP2tx9fk66tiE3EgDrMUc8C9VHWbB4kue+rCN/3hsLbhSttTK7LWdiznRhjvltJk6NQ+6qkQMqgitvrNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=C/Oa7IzQ; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MC8Gvl025577;
	Tue, 22 Jul 2025 13:29:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=jan2016.eng; bh=iw9zjpJXKCZsEgNg5I4C
	o8x8E+jUJm1BJg8AN+fVQH8=; b=C/Oa7IzQHezJch+9gDd+fdmMblDbs+/VTrT9
	YRKYrHrvpuZrwQ9/MgZE1hR1bKs6P4kWP7/YPa5Xq9BGTRgw333PrdJhma4uTDSA
	rXPQL2xoo+CWXQg0xPB3IN3p09f3gqrUBikMApmI06h90p5/D0jIEL8+XYM7WC9l
	LiKUKxrvxMnBp7VgOeai3Ke+mlbYex73OxOn+p1t9eBRCjBQpbM3uJWkTV5yZzlY
	R90GyLlc6b9DSh1Pj/9Xy5uq5ON3OutUykndWK3D5nDPsguqz1ahH4wQsWlkykeB
	nqhOzKhinsqTNWS/JK5dhzFfsMOQxwHw9hGxWAvcfOPW4Pg7eA==
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4804980hqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 13:29:07 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
	by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56MAR5Zs022022;
	Tue, 22 Jul 2025 08:29:06 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.22])
	by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 4806px6fda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:29:06 -0400
Received: from usma1ex-dag4mb4.msg.corp.akamai.com (172.27.91.23) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:29:05 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb4.msg.corp.akamai.com (172.27.91.23) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:29:05 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id A323C15F582; Tue, 22 Jul 2025 08:29:05 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v2] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Tue, 22 Jul 2025 08:28:44 -0400
Message-ID: <20250722122844.2199661-1-mzhivich@akamai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwMiBTYWx0ZWRfX8wo69AXnXZdu
 HIjxXgqXVGoc3VZcxhXGIGTQ8URhBpcvUIdsx20z3vY/YDi6A7RS4ZVd5Opf8rQrNEEbYpfu/6i
 WHRi55s5WfPOjuO2/7vveQp4Y4krsO16vKcQaNFrKlVVl5mqrG8ys4d/LRPyVD48R8dtJ+Cy+J+
 ofgI9GHl8f1dQ5sSRr4/OxFgvtyY1jIVDkBlbyBaIjyQxgygEqYxOq083DqDe3AA8ojVU6A6sEx
 2Co4ETAVmAxnKHiO6DOrO19ma7iov0lQXe6CNN73YDM371zjZ4K1SPZfVJZ1vHPTB0vzkK/7iA/
 rlGVz+jCtm07QZxMONZrbEDCKrDKz3GVzMhzro6ZjAItVWNX+EoZ6YA00qDFUIYfxd8hgBNSJou
 v5cmsI0EhNUoeyFxVpkbpGzxqm5ebm+2ufC3iEiWuiY1AQXmwbOhM32U44s69aqnyxUkUr7s
X-Proofpoint-GUID: kcexfW2z2x8Rgo-taRY0L8EXvUTwYDst
X-Proofpoint-ORIG-GUID: kcexfW2z2x8Rgo-taRY0L8EXvUTwYDst
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=687f8413 cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=pmTPSbCVOfBdVNymtuMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=893 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220102

For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
field in zen_patch_rev union on the stack may be garbage.  If so, it will
prevent correct microcode check when consulting p.ucode_rev, resulting in
incorrect mitigation selection.

Cc: <stable@vger.kernel.org>
Signed-off-by:  Michael Zhivich <mzhivich@akamai.com>
Fixes: 7a0395f6607a5 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
---

Changes in v2:
- Rework patch per feedback
- Add Cc: stable

 arch/x86/kernel/cpu/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index efd42ee9d1cc..289ff197b1b3 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -378,6 +378,8 @@ static bool amd_check_tsa_microcode(void)
 	p.model		= c->x86_model;
 	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved    = 0;
 
 	if (cpu_has(c, X86_FEATURE_ZEN3) ||
 	    cpu_has(c, X86_FEATURE_ZEN4)) {
-- 
2.34.1


