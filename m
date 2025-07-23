Return-Path: <stable+bounces-164443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1DAB0F45D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D301F3A2009
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341F23BD1F;
	Wed, 23 Jul 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="iKoD0HQL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09233DF;
	Wed, 23 Jul 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278406; cv=none; b=hE4rkRDzivbyarwkeuGoIrmoRmueB9v9cTuJHbtE0Kdv1CSMrMoTcVWjVAG3JuBbwLh/R4RA3sVPNcxmPa76uh17PBo3TXD9H4KAXpq2GUng4WlFMiupThPChafgFsbC+Jm4lZm+VdUnBJwL3vTjJEzjFMlB9wvOR887RGrEiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278406; c=relaxed/simple;
	bh=mIC1opv81Wco4JyPgoo2Z+5nQ0wEJI9iz7tolDJLRcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsYaHoN8Iz8JKlcGGBJQCuvYoWmWv20BU2Zaa/Ctq/TtXCx3mR3s0VimQ4159MUBgLsdjhqehSvbxcvFQk8+b5Xt8iiTs8C6JkWX1XnqcMKY+j8TwEI8nfOLAthi+uLMZ74sJWp0ZHRRGllxL46kZbZE6TuXL3TQCQX8V5xijug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=iKoD0HQL; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NDWaTa021520;
	Wed, 23 Jul 2025 14:41:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=PVjDwUrvI3ZKZ87UWt4KPxLzsVcn3p2xe6FThQead9w=; b=iKoD0HQLZ+Vm
	kdEJRBGGQEdmvJNV3NJzTUYxIIHuph9ZP6mmJordZhjaxpJgx9kHHTgJR7/gD/V9
	CuI/Uulpq89HVUeNpoGzNuLU0ZdeX2ah2ukszYrwl82XAy36sg3NoUidKSar8deH
	paiyTSa3PBAsBDeVlkHP1SxV+BXQA3nXxD4D3jmXipUIW2l7HW5gcSqwxUM8xl0I
	4MMrZaDKn3Sx/vu7ooLqlvV9opBrLdp31U0JNyWuld1ZboLiQ0pUGX8cpzbqX/vV
	Ft4MrY4KSTAxZdUaYPrucGKEYHNP8w7b3hWJrdZ+q4G/BnIt48t5+ii6dHUmB9Rf
	50ofzCHA3Q==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 482w3v305k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 14:41:24 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 56NAI7sK002777;
	Wed, 23 Jul 2025 06:41:23 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.20])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4809b9yqan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 06:41:23 -0700
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:41:23 -0400
Received: from usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:41:23 -0400
Received: from bos-lhvzmp.bos01.corp.akamai.com (172.28.221.177) by
 usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) with Microsoft SMTP Server
 id 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:41:23 -0400
Received: by bos-lhvzmp.bos01.corp.akamai.com (Postfix, from userid 42339)
	id C6BD115F582; Wed, 23 Jul 2025 09:41:22 -0400 (EDT)
From: Michael Zhivich <mzhivich@akamai.com>
To: <stable@vger.kernel.org>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Zhivich
	<mzhivich@akamai.com>
Subject: [PATCH v3 6.6] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Wed, 23 Jul 2025 09:41:21 -0400
Message-ID: <20250723134121.2371126-1-mzhivich@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507230116
X-Proofpoint-ORIG-GUID: he64b_cDpGyCobWgerWQiNMWly-NDy9C
X-Authority-Analysis: v=2.4 cv=bcRrUPPB c=1 sm=1 tr=0 ts=6880e684 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=QyML1Wa_BHPz27VLx9cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX8Vhx3Df7DvHK
 fH2wUpId9tPG4nPYNUJZIQDwWIXHP5TGhLupkQd6pcBenJQXYwhZDVU+YxyN1gNIZUmqCfw4/tm
 L0K3EFdT+cvmbAn7JKaSG7bSB/StMXvN2/pNCHRLX8N31YA4UQ8ZQ6k6gsh0ktvXByt407Jtv4A
 wuqSalUERj9HhjVoFuNjX8UuK4BwupgD46uv1i5tfM+Qf82M8V+tsfCv5JKkkTIJ8FMu4AlWNBp
 Kv9lZXHfdqTXOQLTw+D6EjvXE9O0Qeh+3qPrfftmuXHK7kjw36aoj1Pf7tlZHG7wCXSRH8PVws4
 Vr+4KDDLz4487+Q/CPu1GtiOmJd0j3rx2lQxhR3KYijN3bX//gvRpUc3PRz9ACktGAu3NZkepNw
 kPUkq+e2dA958lf+KfbEwcSnl5HqF3TyH3kRjYo25mhDkZ04XKm12NmBb7J8f+hsAFUmKsKh
X-Proofpoint-GUID: he64b_cDpGyCobWgerWQiNMWly-NDy9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxlogscore=932
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
Fixes: 90293047df18 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
---

Changes in v3:
- separate "fixes" tag for each stable

 arch/x86/kernel/cpu/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5fcdfbb792bd..b5a234eef471 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -549,6 +549,8 @@ static bool amd_check_tsa_microcode(void)
 	p.model		= c->x86_model;
 	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved	= 0;
 
 	if (cpu_has(c, X86_FEATURE_ZEN3) ||
 	    cpu_has(c, X86_FEATURE_ZEN4)) {
-- 
2.34.1


