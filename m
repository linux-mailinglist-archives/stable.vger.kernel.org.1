Return-Path: <stable+bounces-164445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA6B0F46B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FAD1C82904
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901F2E8DEF;
	Wed, 23 Jul 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="n+LSOkZg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C12E8E1C;
	Wed, 23 Jul 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278462; cv=none; b=mBEbVeKpSghKElkKISeNrLahnQkcI+g4BMjEwtbbJyQGLb8h10P4ipuhTnNFGpvypBtLFwQLR4yuT+c17me4gsh0Ftx+PFgkir50Yiv4VvY7lVBhZCOGOvhQ3TY0RVscm6kSThIvHMWMrREGGV4szTzGbNJy4/bE8fZdmoMFOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278462; c=relaxed/simple;
	bh=w559i7lP3utZp0dD42OMBd+22gRjpxtrRK+Ak52fhnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5XQaZmWaSVZX0gKsdkGBQxnbO9o+eyymJ6P1CAqWQWuRrL1whXocpmX8gBMrBjiCiA+0YoiduouDgb8/DupxDHQDKsYaembzFGjOyy97DMBiqzZMng6+rauljpimVCwi4SleG0uc0oJqaPDPPMWPGpfyesMiNlWn5lodqT/bZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=n+LSOkZg; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ND8xgP008138;
	Wed, 23 Jul 2025 14:46:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=I4cU5grOnj5Eszz3Ro/qg7rQXFNKBPCaFOjNapYWe+Q=; b=n+LSOkZgXJG3
	zTnvYjdKrwxf+7fsndKMlNRFY6jS6g3Gy8J5VRKUXybhmtEXRnXzKkZKfCr6/+nj
	i8K4Cv7w4FlgAdir1tLCZHnBCKF/VkPPhTK6wpl2532gjArjp/HB6wk41ekWeRHf
	Q0AGom+8QW7BZh8cC6kU8N0x0gkWeUNWwSSCr/iM28UpdIONX593f7NEYy+up//l
	HdPcTL2ZXLNztl1xS6pvrJctXghgSsORlae0QdQnvO0Fawkw8r2rtr2i4fGKjCqf
	M+EklRZsJEuOlgwTqwsW2QAkMtsJZSKY7SRo8s+s7RDvJogg4AAtbgkBi/Elbm3S
	1fn4R4PaMw==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 482w3v31uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 14:46:28 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCp7xq010652;
	Wed, 23 Jul 2025 09:46:01 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.22])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 480r8y1art-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:46:01 -0400
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:46:00 -0400
Received: from usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:46:00 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:46:00 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id 5D9F815F582; Wed, 23 Jul 2025 09:46:00 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v3 6.1] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Wed, 23 Jul 2025 09:45:59 -0400
Message-ID: <20250723134559.2371838-1-mzhivich@akamai.com>
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
X-Proofpoint-ORIG-GUID: DstfN6dF6kf8NuCzCA9UQffWcOYX1gtZ
X-Authority-Analysis: v=2.4 cv=bcRrUPPB c=1 sm=1 tr=0 ts=6880e7b4 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=QyML1Wa_BHPz27VLx9cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExOCBTYWx0ZWRfX+z8YB25sRlgz
 D7n6BHcqiNVzufALrTc2rrhSjWa1sXdbF6Af9r832qfe7DMTkrQOTsvs53Z6fYiiWSu8NyQwsVQ
 yXldZOMVia676uO6L4Pu6JEavSfp+2tgHbhEF9jEDmnzxmy6052Le/ST/TFjm8l9fyMATDIvGW7
 nddKL6v/UJ8DUy81c4dh9Zk15hxL7Pn4JtnxQqu0WyIPzothB6G8uqq3ko4DsWSabWjtJff1pid
 T095yXySrgWzQuXbu1IZwKwGgKxk9wvtMAgYNLxE+IqdGcDwPyROLH36TD1uSFf70cP6/3Ya/LX
 2PvYoS8zLJCxTOHl1lOL+ijzAmdqqU77I9Yqfn8rEkQoQE9nVK2N2gxXRXyJHz5zia4yeLg6aOq
 ecf1qH10XVdkimMyrPU9hZVIoNCZbylgg+paCR0iXx8+8fsDxD8opZfw+XZjgnpz792LXmBW
X-Proofpoint-GUID: DstfN6dF6kf8NuCzCA9UQffWcOYX1gtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxlogscore=928
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230118

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

