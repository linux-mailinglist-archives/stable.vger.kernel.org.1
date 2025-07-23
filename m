Return-Path: <stable+bounces-164465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4ABB0F54F
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4A818970F3
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1DA18E3F;
	Wed, 23 Jul 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Rx+9AuCZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062228A40A;
	Wed, 23 Jul 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281107; cv=none; b=IiezNZuBas5xFa/qAhE3Xsnx7ih1mSdcm456bA12oLc4jYI6l7NnzD8gM5abjUdUqwwpHMYpaEpHlUAtDGd9SrujRCJx2CYoGbZVDfocbwvoDhhUwNhXKr4NdtTypWrBwFT4Yt84zXb43do8a1/KBc+s4gCulw4P5CU0SaH33wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281107; c=relaxed/simple;
	bh=w559i7lP3utZp0dD42OMBd+22gRjpxtrRK+Ak52fhnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=po6AtWfNt2LpIn1mN333/ddEqimZEpAb2Y7WHchcCxrXYev2fuJok8oA43tdJ92CBNvRQfE+gJO1S1oyezH1+VuJmOy8xyISAwzVfEGiAJKhmAZPhfZQSmIjW/mdG+sGNDo3jShCTHy34tPYz46ZcKbFSLOwj8g3kAgfNzsUonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=Rx+9AuCZ; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 56NDD9jv024181;
	Wed, 23 Jul 2025 14:41:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=I4cU5grOnj5Eszz3Ro/qg7rQXFNKBPCaFOjNapYWe+Q=; b=Rx+9AuCZEXcM
	OQnjbrplGqTxPmeAXUsTYS+/qrh1PHVlfczQRp9lQbALWcBMJ9cUTz02UBWTpCk3
	doRqk7oGluL0N0SDiLMU/Uy5xtCpbpKGbv5GVkXnX7nrXpXdfyWQ1QyutVuRNxwy
	6fcDkcKZN3vmo/RDeUW1NCeZT+jDcutZZwj4HT53XwlY1JcXt5FIEIVPKhvjlkS+
	HrxufYAh07IH8k5SJVwVWTYG1czqTkvRBjiTo0RMwDEQYn2zJtqrnNoi9NWvjxES
	e9vhLi9cYa85qNIR229ysyJvBSfhuSnI2T2ooXm4ZCDZPuzD+iaJOMyZfte+DT01
	e+L7oEiRmA==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 48301v8eyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 14:41:49 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56NDSAXm010632;
	Wed, 23 Jul 2025 09:41:49 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.22])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 480r8y19vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:41:49 -0400
Received: from usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:41:48 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:41:48 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id E38A915F582; Wed, 23 Jul 2025 09:41:47 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v3 6.6] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Wed, 23 Jul 2025 09:41:40 -0400
Message-ID: <20250723134140.2371189-1-mzhivich@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025072219-mulberry-shallow-da0d@gregkh>
References: <2025072219-mulberry-shallow-da0d@gregkh>
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
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507230116
X-Authority-Analysis: v=2.4 cv=L5cdQ/T8 c=1 sm=1 tr=0 ts=6880e69d cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=QyML1Wa_BHPz27VLx9cA:9
X-Proofpoint-ORIG-GUID: Vk1LIf8wgYArBc_1mfJxm1DZ9tFsbNGY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX3PeoZtMyi19G
 g4wNf2GyZ4sZOukyW2fKc+2nTIsiyh1nsWsVFRhkp3TH14bchrRTO28WcqOMpMhpdH+jLdgssn+
 ZkvoYqx+Xis8VuN5A576yOkLuYjiH8UUfIXFru9poP8OUsIJTLtMKy8jTOR2Htlfltx1tkXC/kt
 Gw71v9z6dsC1+M8tDt89lqUV60N8V/RyqZr/ddFeE/dn50niTIr20oO6QGdPm8VkgphczmY89zv
 9kLR2DvDoutu9zbkMvnlJ10lfoq6L/06u7CpLTlnS9l+xBfGUSRFNpcJXq780SZJLVflwFHFSUD
 SQVomJBFQJrSY54i/PihNQhQ7fTgAvEdSmNI6OTvhSWZgLiL0Zr1i1KBDH/saqgLfegDfo6QTc3
 QXqkZc3GcRRb9co0SP9vRtCYXch4YjZA9u+xA0yqjVdL1ra4Qh4aZ3a9KIKeu6brn2xC49du
X-Proofpoint-GUID: Vk1LIf8wgYArBc_1mfJxm1DZ9tFsbNGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=925
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230117

For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
field in zen_patch_rev union on the stack may be garbage.  If so, it will
prevent correct microcode check when consulting p.ucode_rev, resulting in
incorrect mitigation selection.

This is a stable-only fix.

Cc: <stable@vger.kernel.org>
Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
Fixes: d12145e8454f ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
---

Changes in v3:
- separate "fixes" tag for each stable

 arch/x86/kernel/cpu/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4785d41558d6..2d71c329b347 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -563,6 +563,8 @@ static bool amd_check_tsa_microcode(void)
 	p.model		= c->x86_model;
 	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved	= 0;
 
 	if (c->x86 == 0x19) {
 		switch (p.ucode_rev >> 8) {
-- 
2.34.1

