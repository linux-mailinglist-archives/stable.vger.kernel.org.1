Return-Path: <stable+bounces-164439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C2B0F44C
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F14D1C8110D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE72E7F07;
	Wed, 23 Jul 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="SvCzW4cx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C122E7165;
	Wed, 23 Jul 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278161; cv=none; b=csKzrZ6gYDYxcN9xd1k8kdZNdRhkQaMHHBqDKB92QhNixJNU3PyqBno54TMa81DZPVZKLIAh1mSOXK7HYFYPXspjxisGqAL5bh2W6wZBLi1CVq/v5k5aqDFXSWiaQJ/IjKOu/C04t8UXGgHvMyR8gribrwwXHwhDEe0aVGAzrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278161; c=relaxed/simple;
	bh=rn4fY3XIyWCF4zmZc8ml/ezpFjtNDCK4QprIq9gcSrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rE3/bC0gr4QjqkMyGDx0QwdYfZL+ud20vwPJAuSYoT9Qr4V0l5cGQP6eyiuNVcjMK/AHEZnCQTVYGQGzE6Z8ilWBqrppt8mT74Z2p8I5gc5iFe5B4CV+2q3ABWY44Dc3Cb+30gsRmFbMZgDG6EDl15dWHXzuLD3IYLR5fBPGCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=SvCzW4cx; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 56NDSr3v015880;
	Wed, 23 Jul 2025 14:42:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=EVir28eF1p7kbrHktJsOgzIhHKeU5ir2V3FVm5jlrz4=; b=SvCzW4cx7/8/
	e8aHLJoy+LP07nEPUVIe3B5dCxL0fICqEETJVQEpsbIvQ5zU9eVG0AR8F4At9V1Z
	BF57uJQzE9Vz5rl/1F8sp/9M4KxZUqMCgdtXPi7IxXIax5YwL6CWqV0ej6nAn7Gq
	FFMW8ziulu4pPPz0bOQ7+N63L84+SKvG/OVplAJS3ZlUxwj+v8Wow2nE4o7KhQKP
	1Ey9xYYOtpvP9agJhSGqW0y/mG3ItzUgT9NG2viaiUekbgpTPRx18t4IG9NzgrH6
	KRYjhYnpa/6VTidS6mPJXAC7XJPbvS0ZWqDQU5MWMZawbrHy/02Kdz7NQ1kGPJkn
	KkMNVOHhmQ==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 48303vrpe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 14:42:24 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCG2cf011575;
	Wed, 23 Jul 2025 09:42:23 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.22])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 480r8y19yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:42:23 -0400
Received: from usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:42:22 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:42:22 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id 5140E15F582; Wed, 23 Jul 2025 09:42:22 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v3 6.6] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Wed, 23 Jul 2025 09:42:21 -0400
Message-ID: <20250723134221.2371313-1-mzhivich@akamai.com>
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
X-Proofpoint-GUID: WITi8dSf-_AkBKAcVpEnLgEs30VaTlXj
X-Authority-Analysis: v=2.4 cv=WpwrMcfv c=1 sm=1 tr=0 ts=6880e6c0 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=QyML1Wa_BHPz27VLx9cA:9
X-Proofpoint-ORIG-GUID: WITi8dSf-_AkBKAcVpEnLgEs30VaTlXj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX0OOt8vtOmuwT
 cDle+bunQnmWRIzhCTer6PyKzGXA7lzqdsz3KeGjvIv3Wbx8NmWHke7+N09k3i090J9lJbzpgAH
 /j3jMtiBItTAtrlujK4fiLYIqRGznNJXPk3IatXJPkHVCZGySZ6YrrWnkyMheWu0hXVVSHxKYZV
 TdhyfyTrVK9pCWGtBTgd1hfFVJpU0bvchOWNebwxyM8N3yOi2jjSlbOA7NDWODIhZsrDsyFDkLW
 Pv7Y/LQlltAyxp+aRY1YtMqDyVayjFsDZnk9IEL0hpBMs005hCWnOkt6VYKMSo5bk24IU1w3VzV
 v1IkUyu9Qbuh5H6jtXxQYlJnd/6B8xoh/G5fssekZSGkOc5y3dIKvIPVDk6Cp9NTc74s32xOhGU
 lw0brTEvpdLi1+oHPhjUq+XW2qyQUcYZI5nigo6PguYRaDoVO8bBbDqqyYsWwsdViJdBaizf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=925 phishscore=0
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

