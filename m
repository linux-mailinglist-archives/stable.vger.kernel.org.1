Return-Path: <stable+bounces-177801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECED7B455A3
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958731C8858D
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EA340D91;
	Fri,  5 Sep 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Twaxryb9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0732144A
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070267; cv=none; b=mjApsPuS330hF/Ivht393lcQUD0EmMCNf1rbK/sqNIuVIjkdp+0bJI9TZgv6xHuqt0AqLVMO2A1MK5EBehighrow2jDrWdElBYiTFAsXUk5xkqTPCVJyJXkIVayqsVU32iQ1TX4aO5pGay58GQBYCU74l1Uwu7c2uFpOF7Kiwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070267; c=relaxed/simple;
	bh=OoVL726NjDQLCOp762z2Gw3KpYfvTNfY7kURg6HFXpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gtum82NNsWO1Xo4T9VU/2Zl+YToYvh/lXBSL7yTfIANdejnOjWLNXeh7K3Uoy746H1p3RdlCfQo7k7Cm8RBN+2Zu5afqLeBTYOepUuEvY6uPiTL5M98cJKCw5d8NAQ5PGQnV+JUAni+Dm5k6ncUrvQRyZRa070zSoaU6IG05Sfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Twaxryb9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585Atpsv006187;
	Fri, 5 Sep 2025 11:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OlOeR
	XQ8Eo0FvdrV4E1eXl6OB+vDgmFRcHGZv1C753I=; b=Twaxryb9ba5xA2GPudo7b
	hLL1DlYVVJ6aHOd7LPOHdCgTkqe8JkuY+uWEbEIxbkHwnAuooEj8ACVsvp7gSxXc
	HLprbvvhTqhCInQIVDoC/KSuhbJpXWVkkQLqjq9z+h5VvPbiiAp6VqcRGp4XFUPm
	ez68rH9RiTBIZOy1tyDatULfB1jLf5wQBuwzHgVx1njFj58Yenp4t3SXzdXJDik2
	t2bfAUtdzaBMeiJ5PsW/8T6qOhGizUDmU/Tsvrq1UxjDlYvmzJKlFARH07diQKjq
	NYcVzf1nCKzE1hxqtfcP7SpvaPiYiyUiOCEJqNOyBcXDmkIb7T3+Yp0jaBx6l/5z
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxa58125-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JbIp019646;
	Fri, 5 Sep 2025 11:04:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqr3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hI030057;
	Fri, 5 Sep 2025 11:04:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-5;
	Fri, 05 Sep 2025 11:04:17 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 04/15] net: dsa: b53/bcm_sf2: implement .support_eee() method
Date: Fri,  5 Sep 2025 04:03:55 -0700
Message-ID: <20250905110406.3021567-5-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=eJgTjGp1 c=1 sm=1 tr=0 ts=68bac3b3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=bC-a23v3AAAA:8 a=PHq6YzTAAAAA:8 a=Q-fNiiVtAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=PyzwKKzMLFAmzmeAzCgA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNCBTYWx0ZWRfXxTQPkps3ftm2
 qD6ew8gFyMAK9oM+BUNB8gvtu2CTrBwZVABd6k+11nrFrr+33aahAVeDJFBsWgfFSGT1TEyNJdW
 UAKemQD0uqwypzjyKOfZu0js264rp1L2PeMIQJ295te7RnSXlBNKvqoQ+fLpwi2h2ODD3EjSVqb
 nqyOWOO3SJfjoZmUlXaF+T3Bk3efSeNtZfsRC1m+uzYAD5vgQSD2Y6CeI2sJlouxvRKMPL7qndi
 v8orbb8VUp1KiaLa0X5/OojxC3LFzcL0AqPrqvFJQ2vETgxRo6iHDq6RNo8Ub+kBw1HJsdNrywL
 xhAXZ7r61lv4h67HCIPyMFTz2rdeyjWDpZ2gDEDuYVyha5gvesVvKmP9fjllbpBufQA5agmQ3HD
 eUXSVLaz
X-Proofpoint-ORIG-GUID: O-Dyn95qE0VeNTfnLqHaT36H4MBWI0JJ
X-Proofpoint-GUID: O-Dyn95qE0VeNTfnLqHaT36H4MBWI0JJ

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit c86692fc2cb77d94dd8c166c2b9017f196d02a84 ]

Implement the .support_eee() method to indicate that EEE is not
supported by two switch variants, rather than making these checks in
the .set_mac_eee() and .get_mac_eee() methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://patch.msgid.link/E1tL14E-006cZU-Nc@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit c86692fc2cb77d94dd8c166c2b9017f196d02a84)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/dsa/b53/b53_common.c | 13 +++++++------
 drivers/net/dsa/b53/b53_priv.h   |  1 +
 drivers/net/dsa/bcm_sf2.c        |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 844cf2b8f727..f9c1cf71b059 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2388,13 +2388,16 @@ int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
 }
 EXPORT_SYMBOL(b53_eee_init);
 
-int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
+bool b53_support_eee(struct dsa_switch *ds, int port)
 {
 	struct b53_device *dev = ds->priv;
 
-	if (is5325(dev) || is5365(dev))
-		return -EOPNOTSUPP;
+	return !is5325(dev) && !is5365(dev);
+}
+EXPORT_SYMBOL(b53_support_eee);
 
+int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
+{
 	return 0;
 }
 EXPORT_SYMBOL(b53_get_mac_eee);
@@ -2404,9 +2407,6 @@ int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 	struct b53_device *dev = ds->priv;
 	struct ethtool_keee *p = &dev->ports[port].eee;
 
-	if (is5325(dev) || is5365(dev))
-		return -EOPNOTSUPP;
-
 	p->eee_enabled = e->eee_enabled;
 	b53_eee_enable_set(ds, port, e->eee_enabled);
 
@@ -2463,6 +2463,7 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.port_setup		= b53_setup_port,
 	.port_enable		= b53_enable_port,
 	.port_disable		= b53_disable_port,
+	.support_eee		= b53_support_eee,
 	.get_mac_eee		= b53_get_mac_eee,
 	.set_mac_eee		= b53_set_mac_eee,
 	.port_bridge_join	= b53_br_join,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 4f8c97098d2a..e908397e8b9a 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -387,6 +387,7 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy);
 void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
 int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy);
+bool b53_support_eee(struct dsa_switch *ds, int port);
 int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index c4771a07878e..f1372830d5fa 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1233,6 +1233,7 @@ static const struct dsa_switch_ops bcm_sf2_ops = {
 	.port_setup		= b53_setup_port,
 	.port_enable		= bcm_sf2_port_setup,
 	.port_disable		= bcm_sf2_port_disable,
+	.support_eee		= b53_support_eee,
 	.get_mac_eee		= b53_get_mac_eee,
 	.set_mac_eee		= b53_set_mac_eee,
 	.port_bridge_join	= b53_br_join,
-- 
2.50.1


