Return-Path: <stable+bounces-163634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7AB0CF22
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 03:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4181889D19
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8338B1A3A8A;
	Tue, 22 Jul 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bb0xv6ox"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57119F115;
	Tue, 22 Jul 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148053; cv=none; b=AXoecsVybVuXamSMoiGwmEWWBBgRcQLDll19g8IJUPJbYf31wEznHuUn5R3LOXY10lzVsfFtiq3gR/Ipjifvg+OfLS5FZdlIRQiyAHtUN5EqlwHQtU5cIsGVkUr9c4K6hIkt87MQS7iPrY6eURLLpMntmD0X+vIDVvScasflF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148053; c=relaxed/simple;
	bh=cJw1H4FYY7/LFWZ4+/6MWLJUz4HQYSSXFAxGUaQwUtQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SXbTzl0MUIwHhDU/NOc0YFLk5t8EkHLpK1FPJtN3muiND7U9JH4Zn00oi9H79H86Ct0AiR+wwVNZsFOv4vSmuEznyB0KU1fNsowOrstty1JImEq84AxjlTT2a2e9X6qxXPF95qNhhbK0FlhhLN8HH1Z1ghL0rBDonHmCSnw2ZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=bb0xv6ox; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 56LJXqXQ021696;
	Tue, 22 Jul 2025 00:07:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=jan2016.eng; bh=E8dmWZVMW0TSe4saxubP
	Ve3bDfVlb9XG51viFGrrZqs=; b=bb0xv6oxII0BtN7f85N4kBdimvybqHHclORU
	uOfYtXtxqxpz+NRhycp54jUSIcqzarMEw/Cztq/9T882x6Cc17cgcan1CiTx8Xaa
	Ge+JjDuhsuA9O1KlfMm3/m3jc120AaAiEOtVmoLe5s3S3pqL7yfxj3hTglklqxxV
	yR1ZCNrEZHy25Tg7distSunlaUGMesAQ4tSBGVVfjqXl0YAq2tpCmvzAeCJRHGYK
	13Bd+wJDIl000DOyiRVXRFUasELkkKs0LMDsm+iIBXRYQvmus0SEyHn7N3ZHTZkX
	YRTW21cnHhA1O/dfDHaZxs22KSEn3gNc6r9+A3H3ATkPL4GK7g==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 481h01v9q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 00:07:46 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56LKUI8G002574;
	Mon, 21 Jul 2025 16:07:44 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.22])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4809b9rs8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 16:07:44 -0700
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 19:07:44 -0400
Received: from usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 19:07:44 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 19:07:44 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id F22F415F582; Mon, 21 Jul 2025 19:07:43 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mzhivich@akamai.com>
Subject: [PATCH] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Mon, 21 Jul 2025 19:07:12 -0400
Message-ID: <20250721230712.2093341-1-mzhivich@akamai.com>
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
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507210206
X-Proofpoint-ORIG-GUID: B9yRAJi6xzflLXEGNVxNTYiEzBLFLcBt
X-Authority-Analysis: v=2.4 cv=Ca8I5Krl c=1 sm=1 tr=0 ts=687ec842 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=Wb1JkmetP80A:10 a=X7Ea-ya5AAAA:8 a=oT9pP-C_ruO3kQmKR0IA:9
X-Proofpoint-GUID: B9yRAJi6xzflLXEGNVxNTYiEzBLFLcBt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDIwNiBTYWx0ZWRfX7XNdW0d7ONtO
 7PBb940S71yfkLk1mSKuMgfxSYD1kRFUkgapisGx+gUfGU+MGujm5NNeTTa9tkYi+qi1tfT2hOv
 oDMLt4OZ4ziNQyulJNCa/Fo+10VR4CD2htcVgdYltO1yJBRsv0a1a6jCfip3g/nkeNfGNAq2h5i
 iT4IMhbIhjjB15cBt9NLfVmC0zr2w+v4vX7sU2EH9LOuLxu+eU+Vz/kosAuq06LNgMiZjR/cNc9
 4RYGicC1JGmfXVJ3MFQsY8DguHYJpOUKKkl929yuks43klKDQIfoFANOBP+5OBaF7a6J6aQTeHV
 VkNTrOlC5o7Vm4Um3oRNU46AAmoFjBptIMycaJV/pf08ks6so/x2DydrAh6vhs3l78PeP29bDjT
 4dYXxRVXdgY/nK0jDj/tx1TJVxQYMEuyVvw8E5TRsJhjizTBrCKsdjvXrnGUh4w1XGe2PRjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=842 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210206

Note: I believe this change only applies to stable backports.

For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
bitfield in zen_patch_rev union on the stack may be garbage.  If so, it will
prevent correct microcode check when consulting p.ucode_rev, resulting in
incorrect mitigation selection.

Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
Fixes: 7a0395f6607a ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index efd42ee9d1cc..91b21814ce8c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -371,7 +371,7 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 static bool amd_check_tsa_microcode(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
-	union zen_patch_rev p;
+	union zen_patch_rev p = {0};
 	u32 min_rev = 0;
 
 	p.ext_fam	= c->x86 - 0xf;
-- 
2.34.1


