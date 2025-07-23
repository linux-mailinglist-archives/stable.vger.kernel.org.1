Return-Path: <stable+bounces-164442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6932B0F45B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AACD1C8195F
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEEE2E7182;
	Wed, 23 Jul 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="a2A/ySZj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED164CB5B;
	Wed, 23 Jul 2025 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278358; cv=none; b=DvHHP1pTNxq9H+sMgXWVI+fzm/BnVIDrdHVh28bM3Y34FHbTbsVRoTBS8dUTZ9qjIqwAEE300LUi9Nb9lPfe7hGWpZRXlTs0MujvN0VGE6ocjaE+GBLF2lSlZAHW7oZOJ5jxg/eNH3d/gHcJVs3ke85T4ipifLGyuIJ0HzZ28FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278358; c=relaxed/simple;
	bh=rn4fY3XIyWCF4zmZc8ml/ezpFjtNDCK4QprIq9gcSrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMLF11OuyajSy5B3bLiwJzrBRlEwHQM017F2IMk05VJ+0GzI7+1smvxCJRiyvAxiSQdof6DKV9nGn8Fl1a4xis3/IzXEq6gMz+WrQ2A1hQ4UoQE8w9Y5+a7Dj2twZpTuqcYg6YiL+LwT5Z3L+Tp+uo/IeXqyk+K0YiGH70tUUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=a2A/ySZj; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NDhaus003094;
	Wed, 23 Jul 2025 14:45:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=EVir28eF1p7kbrHktJsOgzIhHKeU5ir2V3FVm5jlrz4=; b=a2A/ySZjG7id
	mEZE7iJeebcp45mRiPxKJbl3BIkG2xi2W5l0znPse+//Z1VMEZKCaigaUuR91EEZ
	U+0PWWetlySHeCHtBhhIil9G+A/3BZuPEDAixXD3rtNnZy9teBUx5fBEksh9hNSt
	cff8SQx3dvIeliAQ2nRnHPvdyvoicr7wZ+Jwa6xsgSPrVd2JjvOYdMkVIwRPBnDn
	DLMK7/CLotZja6AuaGGbpfYZlIBullavccJr+fqIvCJUbFZjdZpGf31j7X2lCOHs
	8gVkJvANgyuPYNV/SrBdxNUoCVWMVhqzAVPjhVTBp339k0sn1RSctl5hOV3XijBw
	BbVmn15V6g==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4830q7r2yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 14:45:31 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCmm51001616;
	Wed, 23 Jul 2025 09:45:30 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.27])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4806px61ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:45:30 -0400
Received: from usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) by
 usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:45:29 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:45:29 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id 62D7F15F582; Wed, 23 Jul 2025 09:45:29 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v3 5.10] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Wed, 23 Jul 2025 09:45:28 -0400
Message-ID: <20250723134528.2371704-1-mzhivich@akamai.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfXyMhs4kzGJL9f
 pwC+x3rZ5uAm0vYUhINGM3UxHBKU7x+JbocJIYRM/ypq1n7CyTE2UVkXfek1SO2GiNfKe+942sj
 AU06FUaPFIiNp0PXsZQITegMp+PpAPGj4sKC0oFyukDapfOu8ElcQV+RaF7SlmgtqzZLf5QRKk3
 ax2Rqx4UFSYdOdbwY/02ZmlyfW3Ml4zn5BulAGWaFtStzVHupvApkD9regTMdWLMBCYQoerM9nM
 Fh5QCfDRxl9MxicJPaDxytteegVVrMy/dtlX5pB02rnKQath2aX0wJUAFU/DZJjlj3TH+n92ftR
 tVYbBYMCFuoWWl/9Kc3QWSzVFcFfnv0ghJHxFrJESSpKgTyKWh1hdlCSBjPsLbox+LhKS2hHa/T
 xKEksvWu4HNris0Z4vuFEj0J76RK8Id8cdnnJDenlMUAJC1c4KJtRT8HledwbWV106wV8M3p
X-Authority-Analysis: v=2.4 cv=Q47S452a c=1 sm=1 tr=0 ts=6880e77b cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=QyML1Wa_BHPz27VLx9cA:9
X-Proofpoint-GUID: Mayf9SbuCWdRorcEN7Zs557DueXlMNKm
X-Proofpoint-ORIG-GUID: Mayf9SbuCWdRorcEN7Zs557DueXlMNKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 mlxlogscore=937 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230117

For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
field in zen_patch_rev union on the stack may be garbage.  If so, it will
prevent correct microcode check when consulting p.ucode_rev, resulting in
incorrect mitigation selection.

This is a stable-only fix.

Cc: <stable@vger.kernel.org>
Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
Fixes: 78192f511f40 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
---

Changes in v3:
- separate "fixes" tag for each stable

 arch/x86/kernel/cpu/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index e67d7603449b..bf07b2c5418a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -599,6 +599,8 @@ static bool amd_check_tsa_microcode(void)
 	p.model		= c->x86_model;
 	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved	= 0;
 
 	if (c->x86 == 0x19) {
 		switch (p.ucode_rev >> 8) {
-- 
2.34.1

