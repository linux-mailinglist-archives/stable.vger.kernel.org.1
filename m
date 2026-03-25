Return-Path: <stable+bounces-230392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM0OLppqxGlEzAQAu9opvQ
	(envelope-from <stable+bounces-230392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:07:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B8F32D3DB
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDC53066896
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 23:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39331E83A;
	Wed, 25 Mar 2026 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="eTi8AR12";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="WrYZE4OF"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED71684B4;
	Wed, 25 Mar 2026 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774479870; cv=fail; b=al0OB8RHH1h8Bn7N0AjW0Km1rg/K+HzUEMFw2XcR1iRD2sj6SgXefODrugvvH14TcChqyy4jlYEFvgoEYfmKit90ZBd6plOXSEqLaLbwVjQkpX9u3S4wq1VnhcgJ3zVwZn6617VvC83HBzVo7UQhHCDVFz+N6aKsyoDG/loAXZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774479870; c=relaxed/simple;
	bh=nN9bMmQv84fZzA4A9vVlySLaYVu6hsfR6m/K6GwJoo4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fvI1gfif9L77yLMAvXQaJL+LoqljQUEx0cMMaRKDD/oPy85wGvWkGWg4+vDx0IxGw1S9eZANRsl2F8oDNGVgbwip8Q0h8Y5JQWRsmK1bXtCZOY33l8zgYEjciwhkFAvg9M2bwY580cnw82/tX/xta9qZueHNSMi5HTrPxCsB9Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=eTi8AR12; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=WrYZE4OF reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108161.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PLI2FI2428485;
	Wed, 25 Mar 2026 15:30:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS03102026; bh=kit6zOIJYs+x/W3FtZk8
	P5NWQklc2Ipc3jws59hSFCA=; b=eTi8AR12v0r4Hez2j+F40AjZVlYtYLkTNJxg
	4HLd3VSHdohkqTJRHSjqcbA7BFbqiy2brQMF7HHBnjblBv7Wy9DxhbnySfPGwU0X
	YzBFex1DDHweF1SXBljwPVKTWejY3USd64uEuej5f+3T6MoiUArdJEiuyUZ3DJ2e
	8qE6dro8IrDDHHbZUBkWiHHM3lMxMVLatDkGBiZC0WducQ+9E3QPmii3V9GP2fQa
	3TOdElUdcshTCphQRkYMw/q6mAW8k3k/NZG0Xs1YTOr8w3gVuAWPOwQbH65Ciujf
	KPcax0bZiE7JlUxtxNNnT9sGl+Tge62DzIhQdarPQLzI9ggC8A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 4d43jywgfm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3bgfsXSljexKW0TdpE1MOjYhbMOWEkulILrrOFiOyTEfSSINEscgPOIGbXlgULJpGpnJ+YCgVq0QsyBu4da7qMA2VxAUbuGmS95OdFPJWcmXwHw+nFnRQE5KCyGDu50/DPL/QU0AsdAuLE0pQyw023cDp1Ll31vvW8CMc978EIDF+XWwedV5TQk/OQDW4GZtQAPyDrHPhKkglnfbad1HOFbKMCaYABwIXvW8Z3g4PQdTdK/TWiCs4CTl+HcaveZknWAn+7kt49G6q71zQ8iBxCf/ABHoFRSgKAvVQEGtz8pDnQRJu2m24PxPYdJ2BcxQsQFWy0R+D2Z5mxhntah9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kit6zOIJYs+x/W3FtZk8P5NWQklc2Ipc3jws59hSFCA=;
 b=dciJKCsuir8DZQaCop2uJW7NAsfJEGwrJOeedARMnGvscsZqT5Mr+9hwQ5bJae8p9PFk4g91WB8MpoTiz+RdMvhA3MMnAiIoAKzoHGesj5s9p9R8uGvOxvCnz9fNVS9ixJBevB0UCq47o0DXyVopegM76jhvONUPbTZQCyyEbsh9XSAQm84Zso58j7y/9E32hkEmqUuy2uZld8zUjtrXAaP1nyw9QOSWjwV9GiPQLyJkw3ZWd1u6LEQ8YI+fjcatfQd7ucxYweVr16ZPtvrgmccOAHVwnLeDh2iS9vah0OcGtRQOkC9PUSLP0evyUP3467Mte4+zYdIUdSAGr9bPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kit6zOIJYs+x/W3FtZk8P5NWQklc2Ipc3jws59hSFCA=;
 b=WrYZE4OFpOJKRx3MGOr9qK43Iwr0LquZ+lnW+LCQP91zsMLwDL7FoQDEo4Wc3olBNnaK5yNzWQLRpqkTfhpQvQo1/vbMhnAGEZ5kveqFfUAQJK1N4LVCcbx21S4dZOZ3DHz+e0RNn/Cgs3qq/9a7bz32g/eMX6NWALchdA591vI=
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by BLAPR05MB7233.namprd05.prod.outlook.com (2603:10b6:208:29e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 22:30:48 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::24) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 22:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 66.129.239.12)
 smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.12; helo=p-exchfe-eqx-03.jnpr.net;
Received: from p-exchfe-eqx-03.jnpr.net (66.129.239.12) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 22:30:47 +0000
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchfe-eqx-03.jnpr.net (10.104.9.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 15:30:47 -0700
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 15:30:47 -0700
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 15:30:47 -0700
Received: from buildcontainer.juniper.net (qnc-bas-srv058b.juniper.net [10.46.0.148])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 62PMUjwX013442;
	Wed, 25 Mar 2026 15:30:45 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>, <stable@vger.kernel.org>
Subject: [PATCH v4] mfd: core: Preserve OF node when ACPI handle is present
Date: Wed, 25 Mar 2026 15:30:24 -0700
Message-ID: <20260325223024.35992-1-makb@juniper.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|BLAPR05MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ccba57-2d15-476a-b8a0-08de8abe2961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GH3ip3iCGfSCkLWmx8mG3B8oQ44CIOQyQ+XnaFHHk85VEIaa4sZnbaCRdtoKOhVlntapLN0Cdp/iEveSu6IKznJ2Fhg7Q8nzgR4lnIf+INa50DOi5TmNVRivzY1hCxx0Zh+TU66Vi1UmNwQ5nFLDOLbQ+/wgbt2NzsOGSDbSmm0jLw1nt/1U06msdsXqoSalyrZVI+vvy5GVRlqZGiXlfWcSmihstV4Uazp/pJz4tOPLTir2s6Ht42QfmCm7vDGGuPJmXpkmMXmXNH3plD3c27eqlmWSa3iRR1BGDd65HGXp156oxRSN8IZp7K603bM57cVSzRKp8sZgagfCik/rNPn3YwyET9CqcoKD2BIqfpVZmN18vgAe+skAgJfbWg1Awtv4EiQ6dlMOffREBYgG6XkY1CwgP+dbWC/QbIy80sVD1kD6atDXVIypYQD1QqdPzwtMuKAV6VVwwR7OTLwgpR0nkGfv7NBwkmLpRIzXRphAopPOibNNM0UGeL2uAJR0WQCm2bl6jCHSlA4c7/0xA/7zPtVXiod/7al1d0N9iIsWr7RYK+18Do7vE8Cv+tUfN7QWQ3hU91EuHVaRZfUUUiTKpdgSWV1dgn+AIgA5dQKQZnuRzBrPtooYcbC8BF4847VUdGm1Ntd+N1nKI3expNwSr4r6ftx2UBa4HRJhSdAv7DOOWxsTwF8TVPDvtcxthyugbQvyWObPuyUTHCHOrkQr0x8QBgiCCT5CmiJu7Iud62GMHiZht/MK9nvJLOklG0Nq4vTKuuntz5+HUXZX7Q==
X-Forefront-Antispam-Report:
	CIP:66.129.239.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:p-exchfe-eqx-03.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kvuMSk04cDbk83DfPJ0UtimCsYrkRzN5hBbFj/3JvG/qfg7zQ1DvyEioMcVJe9aUca3QGedFvZmN/du2Sm6Uq7WwsnYPdFsvz17rmf0dsraP1WtfhMX5Vt7+MMhzDBga9gDbDzGPEuiKIzR/vaDJNpG2kKKZBbQdnuupJS9yIo90xK2wTxI2A0ROVeo/tOsnaUpyB9HjSmV9o7VgRq7lNk/Y7AvupPGv1jWXH6dt/LOakJOWkxduBw6zcToXsQ+qzSPIm8TLDcYmyNF1U+A7+yVmb7ULKZZV4qlsE9YqYGNMOx5rWFbtDzCG1QC3USTC5jItnPIee4OBZiSamxGscQvqBQK+MR708p5lQmkr0+KyBg3nwd5U0HS1o7f4XxyvZALUD/ud8+Mf5hGhp/WGPNT5+KFJc7VqaswkAS7Ebs71Oy2re3M1icG6K3ar2trX
X-Exchange-RoutingPolicyChecked:
	YCipxmx97F/GZfYx8u+PQUqi4rI3Q+9mm/VjgrLdoRzZOusMDaguQLIgNpCryvV0Pdm2GqGo1FI6e2PsuURAy+pHVTPgyXKMqdIOnC7HZ9o3CdmVzAAE+PomO8Md99RT3Pw5WV5JVcIrZdiSncQ1Z8+1+ITKqZKS/QHRmyw91hzQIdWixmIUgNLHkxwWAFkLMMQJlU/XbQHo66xrWJ41Uget9nP3M9bAhIK9hZiuGcKqaXJBbYvXJUkUi7zB2RxDx9Qhg/5DjO3e3nQoCoXGARoEEf8ZYEOYIMViVy1bfP0dpHXmsqiYHLpDlNE6Y6ZEIzodo5FzsBTBhkDbpvxJ5w==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 22:30:47.5728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ccba57-2d15-476a-b8a0-08de8abe2961
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.12];Helo=[p-exchfe-eqx-03.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR05MB7233
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE2NiBTYWx0ZWRfX3Dgn7HGlHtHz
 DM/WnoPafYFo/bmlLN/yZXMuH1QpIP5LRzHDf4POfbp6lmDWgbWADCKwEtRg099cOw+QvJ3J6tZ
 jqQYcXHBcep3Mh07dyPU74vNLn41bYUA36MVxtCUVQR3pYAZqqhuWQUVJRq99MGEYj6uQxganYi
 UIspvWNunjz2Xg+oLFJ2VuF327hTqzlMLXJwTDJ9draiGxrn/jVkKkGUEvfcU8OsWljXgHseQZX
 gw0UQc7bzp/uVSxeB6I5Jvtxnrv+QpuSXBblnT48QL6j+ED1LMuhMNjUBWI/obiI4XtyixLJ4py
 C4JmPjn3vkhxAuhdeyNNGvpbIS58bqpaQuYJlfcftePzKAXR9HoYwp6o1RHb0soukuhktgRIiDi
 yvw2JKvFdBQfuUFtqNbkOlJnDJZcgnF9+GBydyIhdYstMmKtVKvHXhVJEDCv5OrFtuGqHT1fdJ3
 GwvawY8/BWXcDbz8JhA==
X-Authority-Analysis: v=2.4 cv=d6b4CBjE c=1 sm=1 tr=0 ts=69c4621b cx=c_pps
 a=KH9ZsF1Q5Y6vOSsawDVSsw==:117 a=1Ye5qg0S7hDxASgOkGT/HA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7vL3O5uBSuztJ3xaqtyr:22
 a=3yS7yMrOVflTMqpn9XM3:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=OUXY8nFuAAAA:8
 a=1m0Mplif2iitoPYi-QgA:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: QsExxiYty512FlQ98TDztyY6yHtAjiUS
X-Proofpoint-ORIG-GUID: QsExxiYty512FlQ98TDztyY6yHtAjiUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_06,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250166
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[juniper.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[juniper.net:s=PPS03102026];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_MIXED(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[juniper.net:s=selector1];
	TAGGED_FROM(0.00)[bounces-230392-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[juniper.net:+,juniper.net:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makb@juniper.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: E2B8F32D3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
does not overwrite the of_node with NULL.

This allows MFD children with both OF nodes and ACPI handles to have OF
nodes again.

Fixes: 51e3b257099d ("mfd: core: Make use of device_set_node()")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Brian Mak <makb@juniper.net>
---

v4: Switched to use ?: operator.

v3: Changed FIXME to NOTE, as this will not be addressed in the near
future.

v2: Use open-coded logic for clarity and add FIXME.

 drivers/mfd/mfd-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6be58eb5a746..7aa32b90cf1e 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -88,7 +88,17 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
 		}
 	}
 
-	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
+	/*
+	 * NOTE: The fwnode design doesn't allow proper stacking/sharing. This
+	 * should eventually turn into a device fwnode API call that will allow
+	 * prepending to a list of fwnodes (with ACPI taking precedence).
+	 *
+	 * set_primary_fwnode() is used here, instead of device_set_node(), as
+	 * device_set_node() will overwrite the existing fwnode, which may be an
+	 * OF node that was populated earlier. To support a use case where ACPI
+	 * and OF is used in conjunction, we call set_primary_fwnode() instead.
+	 */
+	set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
 }
 #else
 static inline void mfd_acpi_add_device(const struct mfd_cell *cell,

base-commit: d2a43e7f89da55d6f0f96aaadaa243f35557291e
-- 
2.25.1


