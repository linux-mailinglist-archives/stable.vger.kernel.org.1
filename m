Return-Path: <stable+bounces-177799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA7B455A0
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756035A173D
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532ED32143A;
	Fri,  5 Sep 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UMIqDg2G"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFF2C028F
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070265; cv=none; b=cC2VB0u0fpSZMkdjFTdKwgYbth8WcLpfEzIsZ7SzgaKBF3KceH3Si4EOIMrRTPxU7I9zoWva4k/KtiG9O1wbgjfUDE+wT77xXq8toQUcMHb2j+/juEw/QofJuY01gmxujEgW0Io98WnGFb/NnKHgArAoKSyElm8SUb5q811nnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070265; c=relaxed/simple;
	bh=3PllP3CdMjtcfGm308X4ODfWGDttf5RdYi/7Cf/5u1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egQREe3QCKMuxaOnFlGkxSwDpPXli59mWQ9p4ooyDF8imTlcm1egE/JqDg84aTNWw84zrIDlQAnxwaW9Ax46vqnqcRIbiJHpASE+nXfjKZO3IBSX7vFDgBm/R7zkUlDX5UBN/Dy7/Z0Kcpq3ltompWsQ37UK2opMgw1Ub5o5WHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UMIqDg2G; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585B0OZL027144;
	Fri, 5 Sep 2025 11:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KEPeMiyHHyLxYz76c6bgjxyE+6EiqL+4REbYoVbGrhs=; b=
	UMIqDg2GzPEgD4Ef/f5b6F24Xg44ATbwMaOaUOWp7rwvnAhlfSVS7DedSjEE4tGG
	GrN+2zUI3WEklLunLJuE7fndLr8VDOpZlRikFj4ya7Dv5O6cqzhDwz+IbprH1Tl9
	J9aHlY9Bi0NjSV4+JQ38o/T7VLDZdEcxeVdaIHVxUN+5OuKcnB23LCfJFto98UQn
	g9AMu4f6M+25V26em9+D7AzafkGCnj0K9C+iq7Ou8UtyFerCNSkpkCH10a1iBI5V
	hkLhYWr/8W5zF5LaPYvWyOS/mXlMywC8gVOjW1w0jsw1gHufDZvEOneFYvebzfPL
	Z3Xl20dq/b/kDt3cuKnCWA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxkg80as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JbYG019691;
	Fri, 5 Sep 2025 11:04:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqr5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hK030057;
	Fri, 5 Sep 2025 11:04:19 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-6;
	Fri, 05 Sep 2025 11:04:18 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 05/15] net: dsa: b53: do not enable EEE on bcm63xx
Date: Fri,  5 Sep 2025 04:03:56 -0700
Message-ID: <20250905110406.3021567-6-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNyBTYWx0ZWRfX73n7gXXBCHCj
 JGL6itiInra7QZTw3l4jMh4VtpL9B3bMDzzAE8HY0IbZhbEfMNH266dsBAHfCE6EufA2sj7fLsp
 u0DC2L0PEy3+y6jRCrqgyTW+rxc5NsegoZRw8jghbNDjbzxuL6u2qanQCid3XgLdIdXhkc9FFFh
 eXxNVoqNkHBJ8LNekUg138k5+Syc+o6sm1XP13ttB6wqFQozrj1ZXLYuplxaIL3prOKEw5Ej9b9
 bK9UkT1/9n86ml6u675c46aB2TimTSfezBoK8GMPcXY8sD5Qcd7XSWJYconzQB5lmIpJ2eQQcxo
 jw9Bx/Sghmls2SIryPVWvCs3WkaH6+kYr8MmWku6Q+t00vjm1l3UWoOiWKprLhS6yvOnVknj1iA
 7a3Zocot
X-Authority-Analysis: v=2.4 cv=Zp3tK87G c=1 sm=1 tr=0 ts=68bac3b4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=Q-fNiiVtAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=45_x3eWvVHesM1Js3_cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: lHJFqndw4b8KoeK9CotNMZLQtpaA_ayQ
X-Proofpoint-GUID: lHJFqndw4b8KoeK9CotNMZLQtpaA_ayQ

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 1237c2d4a8db79dfd4369bff6930b0e385ed7d5c ]

BCM63xx internal switches do not support EEE, but provide multiple RGMII
ports where external PHYs may be connected. If one of these PHYs are EEE
capable, we may try to enable EEE for the MACs, which then hangs the
system on access of the (non-existent) EEE registers.

Fix this by checking if the switch actually supports EEE before
attempting to configure it.

Fixes: 22256b0afb12 ("net: dsa: b53: Move EEE functions to b53")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://patch.msgid.link/20250602193953.1010487-2-jonas.gorski@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit 1237c2d4a8db79dfd4369bff6930b0e385ed7d5c)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/dsa/b53/b53_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index f9c1cf71b059..c903c6fcc666 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2378,6 +2378,9 @@ int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
 {
 	int ret;
 
+	if (!b53_support_eee(ds, port))
+		return 0;
+
 	ret = phy_init_eee(phy, false);
 	if (ret)
 		return 0;
@@ -2392,7 +2395,7 @@ bool b53_support_eee(struct dsa_switch *ds, int port)
 {
 	struct b53_device *dev = ds->priv;
 
-	return !is5325(dev) && !is5365(dev);
+	return !is5325(dev) && !is5365(dev) && !is63xx(dev);
 }
 EXPORT_SYMBOL(b53_support_eee);
 
-- 
2.50.1


