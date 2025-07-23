Return-Path: <stable+bounces-164444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE4B0F462
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975C45440F1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B02E8E03;
	Wed, 23 Jul 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Jt/6Htpy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F082E8DED;
	Wed, 23 Jul 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278430; cv=none; b=WS/tVFTSz65d/NXwdrnMS9Z94b/Ne4yjU+2y8TYZD1sVFmWQ04XScpEZ1urkiB3xLgQMlWna47SZtDf12gnfiEbIJ5Wi9vaKaPUWv5vxFfSekIGwmBh4xxWJK40KSQ1jiyWqkj6uRAsXLc4h0D+YxJHyd2IDVSnAez9IHoASeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278430; c=relaxed/simple;
	bh=XGxnzDw3YNfZzn6FgKhNOoaK4MmC3pXM+/g85jBE3+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukfprVZR1lfF3JkZd7wNYAMPZ4DKYA4Tlhxc1a3j8N2cTGS710VjqvybWyXTZa5gNYjdo6aCz+ie6vFQwBX2PR2865ya3mywNCMo2B9DjoqlthYrGrzG7jk3IQC1/XGmDeweyBnxieSilvGWf2XbuDlkXRjeexCaO1IDqZu3hoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=Jt/6Htpy; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
	by m0050102.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 56NCQt5D018651;
	Wed, 23 Jul 2025 14:45:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=VsUgfZQbVMhypLf4VBQzUl/jOUr04LK/GdhtA+X53sU=; b=Jt/6Htpy1f+V
	SN9PbhqiUeMoDhQx5NFWP0PmZ54jqg8HxxHAoffxO0WnQqqpxX1NsIe23ajQtZdZ
	nImOpURtSJ1DbR71ZX9r1Fotcv0139hkVQclEd5jjQo3EQPKNOhrsTqjbgPxZ3Rm
	puXEvzXyQnxMKt8Y+uSNmYAz/pgR214QlWI4eMGjrsNWB6/TqjwyQMzut1upCkY8
	615zCgKUEvrsHi/FnreUS13l0jvVT1+Yn97ae1M3Rvry546wHYc4kcjFPnXKcgaN
	5+RKaWpfmWLC3Ky0JCjvO6m7OWEdItIWHEjgiremcbCGaGqDAE1V/fn99pxJMkvr
	vkxHQVl37g==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 482yr3s16k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 14:45:45 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCxXjM010187;
	Wed, 23 Jul 2025 09:45:44 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.21])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 480r8y1aqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:45:44 -0400
Received: from usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:45:43 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:45:43 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id 8478915F582; Wed, 23 Jul 2025 09:45:43 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v3 5.15] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Wed, 23 Jul 2025 09:45:42 -0400
Message-ID: <20250723134542.2371783-1-mzhivich@akamai.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX9n8wJKHax03F
 +ha7ueDqxx73uu7yhDT6tf7xFF8Zm7yQ4Ooge1JSZOVfKwHoUii+epuvQM69KOZoHcvbzDo4oiS
 yapZ9lyCobmkvbAk35WTw6cWvjeiysMU09l2rtATDahdcbuKRiy0mmZBIztFGCNNq07+fgdBQ14
 JYTn8E8JgxyCgteyghFTDn0XDCuVuZd1rdjXSMqODgNIH0THLkFhDc6OwRlDI2s1Rj3KfEQMuOx
 h5CM+wRc+Z3/TvfyYolVwQfjApADTux8PavyfnBwz7U8QnObwk16AFm3D/BVeHhdZ7zoG+ey9Ga
 FaJuiZvAeGNCUEe1a08/WsYVgBjZDcGreGYTr9G/s4AuVrtOgYwU8bvHa4TbnyU8E6EOxes7Dzg
 aRFmLrkPYNt1vTI6PrIq40AvRXuf+04c71mF0Il6AIMdGhORzdMKedFaYWafVJsdUCmf6XPX
X-Proofpoint-ORIG-GUID: _09UGdjFU-Nd300h-ktL72F1hp8btW_Q
X-Authority-Analysis: v=2.4 cv=RfiQC0tv c=1 sm=1 tr=0 ts=6880e789 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=QyML1Wa_BHPz27VLx9cA:9
X-Proofpoint-GUID: _09UGdjFU-Nd300h-ktL72F1hp8btW_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=937 phishscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
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
Fixes: f2b75f1368af ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
---

Changes in v3:
- separate "fixes" tag for each stable

 arch/x86/kernel/cpu/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 04ac18ff022f..3c7d64c454b3 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -592,6 +592,8 @@ static bool amd_check_tsa_microcode(void)
 	p.model		= c->x86_model;
 	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved	= 0;
 
 	if (c->x86 == 0x19) {
 		switch (p.ucode_rev >> 8) {
-- 
2.34.1

