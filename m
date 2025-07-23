Return-Path: <stable+bounces-164438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EC0B0F44A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599383A48EA
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABD2E7F01;
	Wed, 23 Jul 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Km34D7Q1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32122E7165;
	Wed, 23 Jul 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278155; cv=none; b=gQG9y683ijXHscwRsv3p8YNgZZbsSfy7HsyF+jdiBkykOXqI0ftyuJZOOSaKWbP59qOrP4CNuvRQa49s74NY+wLyxi87+y8ubPZb/MgDsb/9iRE71EcxgIW+drYkTUJi0CNDTKe5HDlyF2a/Thbq+greRaoQObP6mwRsqcXa7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278155; c=relaxed/simple;
	bh=XGxnzDw3YNfZzn6FgKhNOoaK4MmC3pXM+/g85jBE3+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VS5R4g7pl51SaUfm8d3aNpUt0hiDN8BHVwEg2fwQ20NKNyxEXzMlzwHOql2GwE8h/2e/FfMMJUZLU8wT6LWbuTwQapaXKFVPWf55e7/MbhSl8aD5QBRLNSGh7/58ST+NITAiPxyXfWYbA0leb8UQ/4/budND9jDbhxB/AYpOyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=Km34D7Q1; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 56NDSruB015860;
	Wed, 23 Jul 2025 14:42:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=VsUgfZQbVMhypLf4VBQzUl/jOUr04LK/GdhtA+X53sU=; b=Km34D7Q1ks8U
	WU10pmh5JgwtMLg1teaqyb7Qn/tHl3uXhtwMc2EBy0kiw/NEdEmDaODD1tdV7nkc
	mAObm0Xif1M01gxOsiHRGMGLW1UIBOAibPB31tAnsFNT3Zv3EPXyA809BBNMAaIS
	JRCukFUzhuvBL+6yKr/TlO2GoJZaTdDyc41jaf3ejk8niGpupxYwC3ypfk3xMyQ1
	C+vrH16wTF5pStC/IyJl8NcD4ptX2I0Q4TwDeXMBBbj/jAc2Z04S71aVFd+3d3c7
	8kQN0H4UCrz7ZyTTHjDqxochGaY2ysXsRxkutQE2njRSnAfSjiaYdlkYOfg+Nv8f
	qwXeDoYo+g==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 48303vrpbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 14:42:12 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCeYB8000862;
	Wed, 23 Jul 2025 09:42:11 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.26])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4806px60q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:42:10 -0400
Received: from usma1ex-dag4mb7.msg.corp.akamai.com (172.27.91.26) by
 usma1ex-dag4mb7.msg.corp.akamai.com (172.27.91.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:42:10 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb7.msg.corp.akamai.com (172.27.91.26) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:42:10 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id D07EC15F582; Wed, 23 Jul 2025 09:42:09 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v3 6.6] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Wed, 23 Jul 2025 09:42:08 -0400
Message-ID: <20250723134208.2371260-1-mzhivich@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230116
X-Proofpoint-GUID: O4ig7qo9Tk0-RnnBgO1y5f6MWMBDZWJj
X-Authority-Analysis: v=2.4 cv=WpwrMcfv c=1 sm=1 tr=0 ts=6880e6b4 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=QyML1Wa_BHPz27VLx9cA:9
X-Proofpoint-ORIG-GUID: O4ig7qo9Tk0-RnnBgO1y5f6MWMBDZWJj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX3Tp06UMXX5sE
 3i1dEtK7rfZ3w5FKFz5+/BuMTw/hvgmgbCeC7VhrXI/vfuIwGJj4Fuk/Dh10p2RVsPd2k3+0uTV
 3NuwmlS5Q3lj7+n6wUPdjKenYVzbsHzNrHkgVUKIKUirV22vVD/5tlYRVUdHuzAEaDsnwy8KWX5
 tjBqSYKomSiwrvUbXaSARVt4E+MmqHIzFZyOC2wmz3mko1rLB7fKqxyENf/bJxglyjrBnH+Pbts
 7sKexWG9duM8gnAIsv472bbJ2SmSeQjF6Bb2DDKOUrnDGbv01yQdx/LFYEvBnajLhiM8E+AeoL5
 Hy6K6HQ4nIgr29gygfnC3XhUby14yettgFxSj9OxDehmZ9Cn/lJ/sS00rnIhMrKqpQBq49dPPYm
 AapZ86VCEidwKfTHlKDB+ZPrYpfJWPnWwhXpKVp0VwjY85RsHk1EP2H1QGfFrVJYy40JcUO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=937 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
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

