Return-Path: <stable+bounces-164437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4CB0F444
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486E47B0C05
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD62E7BC8;
	Wed, 23 Jul 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ZwL68YgC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0372E7196;
	Wed, 23 Jul 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278101; cv=none; b=HrZaiCTGxb+LqsFQoPEOhG9j8nR7d/b9o15trH4WpGeWY8NcVu6hsBwKK/toAtqpoX2X8+nFrmG0rdYRyqdGZenzfwXwgROfb97cl2sIUjH7HrxokHDkGClB364Ny06Pue0wfaOvbDBEWM7pGWTsooyajgkInQUVmIttL5PnbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278101; c=relaxed/simple;
	bh=Fe1DptJHaGCM5CkASpgFnW9O9iShBZfMWlsENeeszII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bls4/dfE7zkuXfr29KKqtL2g5BWbJ1aCfCboXDSQdtJ7yjCTXFdHDUKAMP7BXKFgC+y4QZf3WLcu8wz6pPyCoUKxs3qCUjFgVoELg9uYL+4c1NCNCea15YGMbRTXwrW8naDcOvA2WevkHp58xiB7fLwx1JlJvPA8zHhx67jEfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=ZwL68YgC; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NDagNT032404;
	Wed, 23 Jul 2025 14:40:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=WHVTH4XDRN6t7jYshd3rEKyXqq+qwGThczpMYeU7gdo=; b=ZwL68YgC9Hga
	n5cFrm7zxaLqZkkONSYvt7SWTZx7z77sbUGAa92JSMIv26mTzwLIknr6wzF5GJ4i
	A6ZqNCOltPYM5rfov0Khd3QuxRaPmAUYcQgTbPCKoIVlFntlWXViUDi3m/gyuHu4
	uQq1jY9QrmToEPzpuJg8iNG7VZueXRC51RLuXxACrHJTX2DFXA/z53g86i9l6igA
	hikby8o2AzwC9AN3kjoa/AsVY8OuggT5t+jCuqPJ6/1SISTtKaiBwz2Lfk1AyW/n
	A7onSfdcdU3DuCNw60Ezj7P8qY/6FvbPBglv0HGt/FQu9wqmdrV/Nyq3GAzLsopt
	+oJvrfcvDA==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4830rv82a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 14:40:42 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCeFhs001565;
	Wed, 23 Jul 2025 09:40:41 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.200])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4806px609g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:40:41 -0400
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:40:40 -0500
Received: from ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:40:40 -0500
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) with Microsoft SMTP
 Server id 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 06:40:40
 -0700
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id 2E9DC15F582; Wed, 23 Jul 2025 09:40:40 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v3 6.12] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Wed, 23 Jul 2025 09:40:19 -0400
Message-ID: <20250723134019.2370983-1-mzhivich@akamai.com>
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
X-Authority-Analysis: v=2.4 cv=JbS8rVKV c=1 sm=1 tr=0 ts=6880e65a cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=QyML1Wa_BHPz27VLx9cA:9
X-Proofpoint-ORIG-GUID: fMVNwE0PsDw6dEpnzGx03j0sSRa15-nk
X-Proofpoint-GUID: fMVNwE0PsDw6dEpnzGx03j0sSRa15-nk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX3XK6VeT7jWIX
 fYydU7v/q5nxH4eF8h1RAyPDnutiiouVEV9iH1S1aoPx9RfVlAKGz6VfR3huPHWpSbQBBkQX3Wa
 aKZ7k5CUyzcFAuRXu4Ur29LPV6TzHuCASkba5tkJHaRcP+qJAPX8BenaMjqb5Rb9qNcrNQ7++CF
 izS+w4MKj5u6rduaw7zo2KtIyYIt1jRHCJfvXDPBGFjGy/2eAx2CqTre8VofuaOhzfVqbyF4WQ+
 QmLyacPvRm/KIpk+ZZb8t5NYOlSEkAs+1jppQ8OYgrWgfrcy0hCyc/Se603BXA/l/uESLC+GhiE
 M+4L+BuuCzFd5wY9ROx94hKnP8MLGTFGSEeOUq5rF3kVzMI7zuxpEZvk2ALxkTxuROZQwcw9etK
 Inmay8hzEIv6Ta7uDG5CFZMqbZSc/FFykOCLVpy8DSnLqTSkDx6oao0ZlPPK2Kmo4bpkuRUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=971 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230117

For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
field in zen_patch_rev union on the stack may be garbage.  If so, it will
prevent correct microcode check when consulting p.ucode_rev, resulting in
incorrect mitigation selection.

This is a stable-only fix.

Cc: <stable@vger.kernel.org>
Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
Fixes: 7a0395f6607a5 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
---

Changes in v3:
- separate "fixes" tag for each stable

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
+	p.__reserved	= 0;
 
 	if (cpu_has(c, X86_FEATURE_ZEN3) ||
 	    cpu_has(c, X86_FEATURE_ZEN4)) {
-- 
2.34.1


