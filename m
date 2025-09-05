Return-Path: <stable+bounces-177800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BDB455A2
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19FD5A1BAA
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0033CEB1;
	Fri,  5 Sep 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tt+W+/cs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832EC30EF77
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070266; cv=none; b=GgMg8/eR9KTQDEg8xuJJ/eYBbEQAJRfRuwk7lgfnxQiUiAoz/i8xyCRLf8LLsUeZvaL4IBzEol12yxriWJUaZBe2qq/WL4Q7cax7P5Yj68DTxONaHdBgRW9jXoJOA2TMGW3y6TPlCnFvsSZAvNspII0dgrgzgz9gYhWnn5WiEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070266; c=relaxed/simple;
	bh=vU4YEFuILN7QFf2RU/3jusdVfpK1kB3WUG/bf3qs+ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8UdADioFvXoxcyFw7UWzjD6jun53T36FbySynG8ICTaIf+7l8jmUADxBJS2dcu+BdgYI7+fXoAOcUFvA3UNCJS+TSvwc/eLMHdcPy4OebxCguk08lLeDef9B/UmQVKLnXHYMg5th/IGI3jE/grNOmA4RXCm0jd5cPJlrUtIrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tt+W+/cs; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585B0HOx027071;
	Fri, 5 Sep 2025 11:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ZN1GR
	ItdrLyGfBHR/RtZr+ztjsrt97BnWnFOvNkTMmI=; b=Tt+W+/csS48uC2tKAlnPW
	DJzyIwC5ORo52+wdlRr1afiQmm5ceZkz8XV+B4YSlNqpFFvusLldw28Xu4DsUkiW
	gpX/5POEiNA4gubhdhVllt02245KtVwf3lTZrbBRcc1UmPzWr1sYONPsStiY9T2V
	nQuxCYi1kWbCrt0wEVwqh3WAn+yUBtZeIbQhq9lvBisw2Ka283ANCz1QREX/NA0K
	ZAl/RZWUbY9JtnhY4jwGVoTI1G2ONcz2oGcqaJcMsYh25HlM8gP7mgGivLKLYTHS
	TPCxTB9OcRUDiuOXharLahHooIpIKutgmuacA9VYreJ6wTeWdTPDGGZGoCqhxqI/
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxkg80aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859Jc8J019830;
	Fri, 5 Sep 2025 11:04:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqr09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hE030057;
	Fri, 5 Sep 2025 11:04:13 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-3;
	Fri, 05 Sep 2025 11:04:13 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 02/15] net: dsa: add hook to determine whether EEE is supported
Date: Fri,  5 Sep 2025 04:03:53 -0700
Message-ID: <20250905110406.3021567-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNyBTYWx0ZWRfXxyYFgm+ZwLLh
 dr46oQqR1a8otjCWwZELoSaTgLzOLCE+UiL9jlxUwiUGNZVwt4fAVedwycgMOdYmvcm9cal0Mc6
 FAXXmEMb3wa0abRcT8LSvkWw+7KbtRcDHHP0nKz6AbSZdDxmqQBMRbOZ6qGKG2BfgaxZzt88KbJ
 HamjBuwkqvkqz9o9FKaH7XiiwkoP0z7QFoC+WPvdCF9SKD5UC/YmtEZ4+fkUGjSIgM75bqL/71W
 kxw1bSbr2N/+u0IFT2N8wjrD/bZXfsfJmZRZyJBNeeCOah6vX6/Dov0wjkgh9B76jMv+9DCoXdh
 OqSnhwsJ6e/cYSIp7xlf0Q2Kf6/XJ8TUi0wXCjGQOnCzb2MzVM+cIEoHFjnB1jHoXdoLVqVzHxy
 Ovk6/N5U
X-Authority-Analysis: v=2.4 cv=Zp3tK87G c=1 sm=1 tr=0 ts=68bac3af b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=bC-a23v3AAAA:8 a=PHq6YzTAAAAA:8 a=Q-fNiiVtAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=oFjJBNl_SBTEwtzdQKEA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-ORIG-GUID: LBlN8nPhsEiWzqnc6rtZnVN2CGmQYRAC
X-Proofpoint-GUID: LBlN8nPhsEiWzqnc6rtZnVN2CGmQYRAC

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit 9723a77318b7c0cfd06ea207e52a042f8c815318 ]

Add a hook to determine whether the switch supports EEE. This will
return false if the switch does not, or true if it does. If the
method is not implemented, we assume (currently) that the switch
supports EEE.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://patch.msgid.link/E1tL144-006cZD-El@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 9723a77318b7c0cfd06ea207e52a042f8c815318)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/net/dsa.h | 1 +
 net/dsa/user.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d7a6c2930277..fa99fc5249e9 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1003,6 +1003,7 @@ struct dsa_switch_ops {
 	/*
 	 * Port's MAC EEE settings
 	 */
+	bool	(*support_eee)(struct dsa_switch *ds, int port);
 	int	(*set_mac_eee)(struct dsa_switch *ds, int port,
 			       struct ethtool_keee *e);
 	int	(*get_mac_eee)(struct dsa_switch *ds, int port,
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 64f660d2334b..06267c526dc4 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1231,6 +1231,10 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	struct dsa_switch *ds = dp->ds;
 	int ret;
 
+	/* Check whether the switch supports EEE */
+	if (ds->ops->support_eee && !ds->ops->support_eee(ds, dp->index))
+		return -EOPNOTSUPP;
+
 	/* Port's PHY and MAC both need to be EEE capable */
 	if (!dev->phydev || !dp->pl)
 		return -ENODEV;
@@ -1251,6 +1255,10 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	struct dsa_switch *ds = dp->ds;
 	int ret;
 
+	/* Check whether the switch supports EEE */
+	if (ds->ops->support_eee && !ds->ops->support_eee(ds, dp->index))
+		return -EOPNOTSUPP;
+
 	/* Port's PHY and MAC both need to be EEE capable */
 	if (!dev->phydev || !dp->pl)
 		return -ENODEV;
-- 
2.50.1


