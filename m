Return-Path: <stable+bounces-116969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77ECA3B149
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502827A2503
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749741C82F4;
	Wed, 19 Feb 2025 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVpAb7pk"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C81C726D;
	Wed, 19 Feb 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944823; cv=fail; b=uPE7i0RDHFsiOfMy6WMYGlKCGWFaJ4RKfaG3Wa6+j7ia+2TdXdUeN6YnQb5zM9A0pyDfWQ7hzyGZLbykmZAOAAnzCKV/deyeGn3SOpEvphxq+GJi44pMtX+KhS/Iiz9j1K9DI+cWSxHH8/MmpQ0qyFNqRTMCgCP3VCNY+jTOPkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944823; c=relaxed/simple;
	bh=TK8zzb6lcx/7EwiJ6LgbkUB1e++wKy3OMXfT4gTWDT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j77KY2UYC/bHrcCmUt1WDwUiCMGVpJU5QUHLnrWtr/oGosaLR4F+88Nv2i7k9ZQ1cmp9q+zok+aETw9bzwjRWraPNG5mCeKYaxpJc6kXQGpGKz+LJIynSBk23NU18SK8G9JebaQGph0IaiKadKBHJ+pbdnPzddLbkaqKJmskYm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UVpAb7pk; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFH5/uTAcBO3o2xB7Fn9GjGg4EJm1b0vGfrjeetkiOZb8s6fbX2XkBRtWBfbUuNtomdHsOqmm35r6nW03X3zkIEpPQhlHvVDrBilVxqVDqpzetPp4l5A07jbRTyNlY/ExV/NDjFCHgzUgdT+NdOuXPNyaG3H5kbqonJRRDTdjQv7DasCk3mE871YGAVGAHpu+XWahnH5EdCWsc932+oYKH5e3uS7o1b5KmFeHYexADbx20XGEx5M8KPe2zdMpmNbhd5xNc9lwAuHPQVQVHahlomUIEMnMjOpEl2pkrhhM7SOREu9gusogW3dbmr4HjHbMZoYA0kqaiOSdavpqfepwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhIb1Li+AuFtuyXvissZeJNMe2D6w6MVfz0Fj6OzTZw=;
 b=XV6bL3AAjij0Pb0jwx8xdp5Hcitc+pornmXOkJltkaq8t9LxAt9RyciE4qb7Ic0A6WChx1diNEeVmgjJxDoNGmGkwqn8xzBZsHaeLOQ0cJQkn4QMhyFKjjyUzuAecXfzgCTMuG2zF+N1ESEH5o8xmqHNtT5FDdjA5ZPxVOcEzrFov0dxqtg3CX3zt5ba34HxzsvZ/A4YM89spoliz94IEyc8TkefFCmGdXtv03VawfJfYU+KXbzk++FWpqtaadvLdGrb3edbiEqrBT4aasuE/IYnVkRTyx4kC5aqYtcIsBJ8ctTeg9Qxr9n/Zk0hlZGb3daXdRYQzy/2aMQrmSMAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhIb1Li+AuFtuyXvissZeJNMe2D6w6MVfz0Fj6OzTZw=;
 b=UVpAb7pkDOXtxaTg6unYD+XUOCWcNvn5M96cpk1dHrOpxHKwZ0qrfdT+cq1a6j/c1gC5KdHg7rhZJXGCPKO7P8/InB9fLzolXjLcuXAjHWzqaW00pq+4kt3+r0Gcu+Xyqh6B6vlGAmMkCfVQ8ovTsjZuQSv8aih787ZeV5YlR1JWQUe+y3lf+wpOXdxiq05VpQjD0+aegX4F2jHodxTlYGG8OyOH+1t/d5CqpD6pZCbCH3CxLUqnISB4aXjDeQb1TVRWSz0c5aA9VEU3KUSaN0rF6kPyCziErny45XTW03V2g+wfFlY1jofx0TJuGQ0+dKUUT/qI+2EBxAqL5XjQJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 06:00:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 06:00:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 net 7/9] net: enetc: remove the mm_lock from the ENETC v4 driver
Date: Wed, 19 Feb 2025 13:42:45 +0800
Message-Id: <20250219054247.733243-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219054247.733243-1-wei.fang@nxp.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb710b1-5132-4adc-1a2c-08dd50aab01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RweNm2m37S3UBf2Du7GIoM5CJGzDKz4TJnce0T81WpR/bFVRbdtfyeUqlLgJ?=
 =?us-ascii?Q?AXL4Cqmfz5DaV0VBkel8dDzao4qshBdoOT2qHG+EPedUN5REAvf0q46gZ6lL?=
 =?us-ascii?Q?T+IBv2uglrqxLfQI1oWeKBMyqiVEwa0RW843w/nkBZC/Shs/cpkvsjwXqMp/?=
 =?us-ascii?Q?BIZZ8bIvESYuBMelLBJfNbkKYQBeenjQgXrF+EqG6maYV2CIldfs9WvrBFto?=
 =?us-ascii?Q?dQoosD2HOvZvdZZrneBD3r+UqFLvVTveYFo3kMJcqwW6qmtgx0J5xqrSCgGA?=
 =?us-ascii?Q?O+uZbPqXKJh5GljUCRc45eXGYA3WWj45ojUGYOz7OjGGquf03SQ7BNC4Iv00?=
 =?us-ascii?Q?jU91gatAHq0XULtHEvpWJAw8ZMwX+LLniQoX8FgoCzswjSxjsd6YsGwaGwlH?=
 =?us-ascii?Q?oSX2zQnjsIGNw5Thn4/1citoYl3X6RVvxzLmG0Ly6hhJimLCG+Lv+2luSBjp?=
 =?us-ascii?Q?+59UyZJ+1Mx+NdWhCpsv5l4FmneGUiCwiyEQJICSNeLkEP6kA+/Jd/Witt23?=
 =?us-ascii?Q?l1yY1rd0ssp/UEZA3aaISJQZRyuxFlW3KXggtiHTVyBhjo+6sBVpmZWPS2tv?=
 =?us-ascii?Q?BquAP6DTUrD81cjkTZ7soYbLP6FqRW5JpLRIwlIso1nYXQZfsf2x5f6iU3Vw?=
 =?us-ascii?Q?D23/N6zpy/eHqQKDbK2bqI/NXcoOCuZ5bRNctMQPJPtf/MhvnQ4fQSRluIyp?=
 =?us-ascii?Q?5sPym93lC0tqaEBdqv9+bqpvKxHCF/X6FV8vImQGD+88r5Jv+nW7uDCx05sV?=
 =?us-ascii?Q?st00j+Lyvr8KU0xMaO6QU+VAyDHQWehn6kS3OSWAC1pv3G4dZGalzFjh5XKX?=
 =?us-ascii?Q?d0fWSt6tfdNe3D4G/yebt/lzqG2ZoUF+rAmP9p8wxSw5Rf5W2MbKXmRzSiWy?=
 =?us-ascii?Q?WIhYPR9mSXtMTLrqbk6oJ+J5M5GSgX5YHdFxfRWW/qfMBQPaoTHcBRUSglUo?=
 =?us-ascii?Q?nG1Q1k+gsmHFVFeBv9vDUohnreWjHzOt09IX1ooVnVSiQclUwT1ArdN9O6Rd?=
 =?us-ascii?Q?zXKLaxMqJ/TSpNpnLb/Ezx+4Nz0AfXLlgPW7NAfOTCWgY92fQtmG/IL0ZfJu?=
 =?us-ascii?Q?QyDnOXnj1Wfe8se2aYqZOhViGzJ58W/d2H/urV21x2ewsQfIx5UGKiIp2IBH?=
 =?us-ascii?Q?PN2bsU19Vqkb6bzKHyXCPfO+h5u1gO3ecw+DijMqLsbnYAGG3Js23J54UEcr?=
 =?us-ascii?Q?D+bAn/TbaqnI6NPkKAOIVA8FGE9k83nYqlMHKMyND5h8JKDE9MabVhkWXuGc?=
 =?us-ascii?Q?wTY15Mirb8ZxYgPKCuS7BPra4VwfCgtMZlLPBd1xdOJTm2hfT9hARRLzb/qS?=
 =?us-ascii?Q?s3Msfn/BDkGCUTq2KVMTzNnvQCIuvJQmEblsS0hTQgVvkuOPZxZtN7aYIwHP?=
 =?us-ascii?Q?KuShgtqiWHClrl8BRVqGa3YN9E0A41jroRQi3PvbNVWiwLBGHT8AlEgJKm7D?=
 =?us-ascii?Q?L+X3QmibOXqWV5bn4hJuNu6TPExa12Be?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEbycySUGuFNcWjU1a1NoO2UPIgWmVZASjQPvBI+fau0aPRV5k1EhT/Gf0SQ?=
 =?us-ascii?Q?jO1hRgvIDQkU3wAwTfUHLMnZrVXndETWYCshSUpblDpFWoRWL69J1nBNa9+3?=
 =?us-ascii?Q?vzG92dXoYgBHujqFrFZCwAfYjr8zIkzrUX4cJij2Zrg+R17veJN+vsBE7Rud?=
 =?us-ascii?Q?izccJylNl7biHdobtZZ/vgbLgRYN4oc1nGuwaiDHP/V5VjiNJzCnGqJ813m5?=
 =?us-ascii?Q?UeTYNGaOCeDXHT/bkEvtP9mxhh2dgjNLQRneNk3VSyUkDplKKPhcAjGatHHf?=
 =?us-ascii?Q?YddffHka0/q1pKQL9xd0BeufSVSnbrrlwR0nlGRC45WmCYtzO618mcJ4CbHa?=
 =?us-ascii?Q?cJC4NlkHS1TFGqlG19wX7owHAyZhqsHoiw54sTMW4s+KNlmdLbqjDeRq0eGn?=
 =?us-ascii?Q?h+fHyrUJnmILZLQBvQVGDM5TnVG6u+VOmxR0QRPJTugD0fVJx17AMI8TJoFv?=
 =?us-ascii?Q?qzIVstPvpS8Vw9XQ2c6CdcD3ZzXfRDQDu0JNkRlU9o4/bEmTsYolm0N7zwGA?=
 =?us-ascii?Q?PYOLD2wItEHT7pg8nplvKEFLi7FHk33ZAHx+Ozmo85Td6DnDlq1nFgQeL8ho?=
 =?us-ascii?Q?P8Ggo96v+IRlJgSz4RwnYbH4CYl5msK5HdTxkl5zmvur9/7rFOKFNGehns+P?=
 =?us-ascii?Q?HUYSohIsfxMcYV4yrguzh48MeEFHxdYr+Fws+aqYYFWLJU5y6lGF0oaL09OX?=
 =?us-ascii?Q?2xisn2gx27DcvFWAEKq9UwwK2m0gmy+d1L2x0Rih/oP9Q02m59bAjqxFF3Hj?=
 =?us-ascii?Q?pldHq2HUh+iWIovNDTtzgjU/0bVXY4X/d0dlz1FyoL2tghscDB6HJ4NGVKCh?=
 =?us-ascii?Q?+xpSpJ/l4fSJ27XCezV5qWUk54OOMVmu42+NaZW9AM+F7xu3BADqHoh705kG?=
 =?us-ascii?Q?vS8a3EcH+JTosHPu+7m7ulKZo7/DRnmQp58uyOMv19laSJkGxHptQTZc29mu?=
 =?us-ascii?Q?RiCJ6jtG9Pwb9UUYXFnXG4/LH0Z7Y9Crz18Uwxf3mbZQSAZWw5AeaT55I+HM?=
 =?us-ascii?Q?odmuEF01bTheO9Ljzm6ZCh+7GbPxI+0OIffUATIcq5LYDA1AiD+WxU7oFh9n?=
 =?us-ascii?Q?0rIK8N18spq0wDP0FWYNEv1nvlsdyqvgMbcLhnQKZXMTHgoFyfaYaKl1bObS?=
 =?us-ascii?Q?QuyjWL4smU2X3OXUH+t6W5/broUv4ZhbB4jnbdda/64gcMEqkPyi8FM0KH3W?=
 =?us-ascii?Q?jV/7qqlYZ8FUxA3gM7LeFHI3V0ZlJ0oUrlSRmHJhY1iTKzyB9CvECo+enHR9?=
 =?us-ascii?Q?uS89njF2hzPg3eCSWf1IQ0M/ERd26iJgbvbG1pJ3DpQipsfDqREPHEPcTaMr?=
 =?us-ascii?Q?N9uHARse/TDRhptPz8LmUVwNeZvFOYtVjquNypDAgYz1DC/YedNUo3wGJw12?=
 =?us-ascii?Q?RzyNmsclNLu+A2q9KzfTZ7EkYSm3EBEXRCtt3TTZB7W5UcVrnqDnbwmS4az1?=
 =?us-ascii?Q?Lnh+5V845ixQPTiB14qu27fID4tmhG4vkkBT3K5kiufu48BN2QgeqJNfX2ze?=
 =?us-ascii?Q?MTy5EZbyE+3bduGwZsGGtebMM3cKEKZ2SsCC5pvmAQ5SwRACH9O9iMEMEZjN?=
 =?us-ascii?Q?QpHRHpTmXIvIAD3JSsHIdeHDZZHb1+8fX91DNgyj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb710b1-5132-4adc-1a2c-08dd50aab01f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:00:18.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7Gs3FfX3/cfNiiEPKeakBxuHVVldh4KvWmdyOmSkzKCj9+EVECtsnUKt1NtWF1K68SSks347WD5pMvSrNKlNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

Currently, the ENETC v4 driver has not added the MAC merge layer support
in the upstream, so the mm_lock is not initialized and used, so remove
the mm_lock from the driver.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 48861c8b499a..73ac8c6afb3a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -672,7 +672,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 err_alloc_msix:
 err_config_si:
 err_clk_get:
-	mutex_destroy(&priv->mm_lock);
 	free_netdev(ndev);
 
 	return err;
-- 
2.34.1


