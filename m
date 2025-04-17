Return-Path: <stable+bounces-133126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3BCA91E52
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81155446FA6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258D24C096;
	Thu, 17 Apr 2025 13:41:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64024CED7
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897319; cv=fail; b=RdlpSgs1Fn4TMrjdDA86bBZ72EY4cgxLquSFK4sOrsPZnvUgepodwYNGXQksNZu943L4GTmLbY9RtNGHFnNL41OHGhS+GDINrysTFDESzTS/M63SuaSr97W0kR3QEg5rRk2dt2CxwPAeUlHktTXN5aE3bMsIloKN9GTemF4YQLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897319; c=relaxed/simple;
	bh=B3vdALYxMEMztIm3TCVmTFxKqkTB85n8kTeeoWRV4jc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DdY5Yyjgq39YDeQLCR0UW306cyd806amOufTcbjyyx7TQRRQnOpVTyArbjxPUh/b7l7SE7PXEPooc0Wk6C25P23QTLy2NMMPJ5oQNiHSNBpzmRANDmSajDFM26a2UxumViBBpOEXyRTKAZX7THmHpTbEzsn1bmbCEY6ZSLYXJQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6AZmm015888;
	Thu, 17 Apr 2025 13:41:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1pbea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:41:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0xw6jeEe2R3J4yXy+PUXf/DrShtHXHbaGNRbC0nvnbgTTJnnMDYMOXsgUG9AHmWuW+Q1BwuwW/qu6chli+926L/IQwrKdkiruEE1LKfRiiZey/m6tApCQuja72Fauq9XHypLNoTQ3La6vTHXa5wg+FsE7la0rPfeuMpyKAk248tLE5XZBSZQf5w+O3jzwCPkCWLVmXgkU4rNMiBVI6qckgDeWAr7BQGRzYcFI1W2fMzAGM2iM1l0qpIkVSdWuwZBHG9SReXvWY6bS2rhwut3S5Iez7CwV3q1O6eha3wnGvLL/hgSFJ7WZWpOKasvR2al/5kRhm3SSedYBbkc8NQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzcqzlddDub/xIcMVD/jiFl1qLrJNTHazFDwsVNaWKI=;
 b=V2sd612aRzh1LAs5lWc5kn47BmqfrESeYalqeBJUa/yprHtKt9eB5roEZX2zJ1xUdPloy0kWE9TxHclJdKyiWjVaJWk4sWcXRO8JO1OafTB6v9cMVPI5hJFSKg0EAG4MFUTQQxj27kcm89gyePhp97Occ0ZVzm/ANRm2KybL3lXKT0qWND71i6r9K/1aX+1v12klZR9dvWMqDrINFtuWbozfAhidwD1fTaTmzRTcOoiGR8S7X9l5kDKk1rDIUeMbdkZz0hVlWj9mpxdOYI1Oc+1beP2bBjoEfM1ALtY1mwe9xqNVqn/RKMunL+VS+QEv/ANOvzX7YyDWz5zIwJ0dpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 13:41:50 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 13:41:50 +0000
From: He Zhe <zhe.he@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH vulns 1/2 v2] CVE-2024-36912: Fix affected versions
Date: Thu, 17 Apr 2025 21:41:33 +0800
Message-Id: <20250417134134.376156-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: da76b5d8-deaa-46d3-1598-08dd7db59add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RGuUv/G9GDOgdykaImrS9B8pWTPhCXMNq+VgED4dxmtvXOuxtd1l+kVAlLor?=
 =?us-ascii?Q?ABx4jYESJuJmOpV4imwFHZHcNTa82i/IJcetyHmSTSGfLux75cGu/ANDapeD?=
 =?us-ascii?Q?mRx+tMg9KqI77R2n2OHzHiIu1HA0Z3fSjZN0wyWU74pXBxTVk3RxsoVsoAfm?=
 =?us-ascii?Q?uVFyZdz7xxJM9bPPSWhjCVSD2+9775A9G4kodPEUsBgV5nYmtZFxr+37UnhS?=
 =?us-ascii?Q?BYWhZU+3LgxN5uGc2gVO9I/pSAq/C5N2wXu4NnOxfiV+DuljDz6YHQHGDbs6?=
 =?us-ascii?Q?Gt3y6q7zSTuFfBUdMFWYIuQ2yE2RJG2GOv2dP2kQscYDDRPmGRGlfe2qJWkZ?=
 =?us-ascii?Q?NzIBD61nCYMukyPYnz3FwHazKw87SDCF6/z1Os8m3wuZ19/C/7p2M7ApgSze?=
 =?us-ascii?Q?1iHKnh/uH056iFq3fdXN0GOlKPZ2Hbvbs97msycdhB0bG+dcKlhKFkPSd5CG?=
 =?us-ascii?Q?Y24tAA+6CM91NUHA/ZGwx4J5A7CZfQJW+M2wCo2ojpIKryG5dt0ZbPDB+3bZ?=
 =?us-ascii?Q?0vV/6l1zomt/VGW+aLY0x1nEKShHm+xhZfyWaOgTAV231mJ+oNawzILDfiGp?=
 =?us-ascii?Q?XckRY6IFx2Y7oHFU2dV0CY9kZfhuVzZ0EvNmpmBYbJnt+qDDv9gbXSVD2d/k?=
 =?us-ascii?Q?7GgnYDh6xSuo1/CmJWTLMMNAGuAYVYg3WVdTDESnG07j13san7dDGB+GTw5p?=
 =?us-ascii?Q?W+Gd/pbDhrX/feABn4SzJxMYJm6DC+vdnN0UnxgOUjcRmzCCudN0VjpG5LM0?=
 =?us-ascii?Q?cP7DhIoJ6888+burkukY5m3UD8MtwJ7+JYlxLD6CJ+jyg7VBacdetvv4WTLe?=
 =?us-ascii?Q?4BPivQ9xSd/Hu8AsrA1Dv0IqVe4iZVw/PLsrDY7hiW6e4g4TVLP1ECmTtTEl?=
 =?us-ascii?Q?obsbfe1opYxdFEteoN4rTd89b/C8YWMHqoF2EmbGxTfBFRiHBHa8sWujOIDV?=
 =?us-ascii?Q?KAYTccO/kYhiKDnWRu7QnTIgtpvI1iLQs7wIv3dsjxuRpOr22ryJxHZXPwQt?=
 =?us-ascii?Q?bE7IWLdHClclP6op52cn4AiKecnXD+zMhgrR0XHJiSVwiAK8c7xlqzW3uZFx?=
 =?us-ascii?Q?ReAbG/6YtZJ5w4MeDOjc/QynByda3/OqDpaYLnZEo+E2gkhuFzssYUfBN+Tj?=
 =?us-ascii?Q?xsrfDQsIa55nyRqw2G4g4Ndm1rl0rTFVK0YAiIr8UkPlxcokPO6IPeAYR1Kp?=
 =?us-ascii?Q?wT/R6bPhNfMDIkvrTjKxANz35aq6u0niQzyvfeI4rn3hejwtUliV//ickLi/?=
 =?us-ascii?Q?nyM2FkziptajJOMiwI7MCju8hmn07Cx4u/03iE/RFKpVp3JK/3xijgmK0vsz?=
 =?us-ascii?Q?ChjzpUyIS7xWmMdSG7dYOtE6f0BrBwwgDJJ6hZ4J1JpaJVC+ILi4yJqzTw43?=
 =?us-ascii?Q?KD9UxlYaLWvuVXtFjWNSbF89cx+UuJzgM5suP9as6BQgNUrCWt/F0tNAHPD8?=
 =?us-ascii?Q?R8fN6u6+t3uXlZScSc4uAFyPhED98H+3M571Mf58G5Ez11P0XJOPjYNaYZBr?=
 =?us-ascii?Q?uVfJ1gQLhWZGSQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OG0evR5aL4/dbWOgpnus5N1U9y76ocWPS/i+Ol3VY2UBOfO7ffEF3WS4PGMP?=
 =?us-ascii?Q?IRefPRpgxzZPZJdygji90synAIk+SThGntv146snm78PTzVhkfkFd8IQ/UV/?=
 =?us-ascii?Q?pGo24Un0BsOug01+QCqZUyWKn/MJnWSxj33wYPcqqXADsML2c0N0CsTY4cQA?=
 =?us-ascii?Q?EKKUo2S4YYkw2q2X3lkm1A6TUOsXpka1RkCnMX1r27/yacTFlgVJ7eOy5Z2r?=
 =?us-ascii?Q?4F4GGUH0oz7Fo3ZCcQ3v4m1bH/R1B/PBh4OAsrfpk4X8QTsxHw0Rsv0XDzFe?=
 =?us-ascii?Q?9iMYmSOOfD4ZLLeribGVlTDSYcXrWPTJeE+ztUG18oyXrAYVswEaii24M5o0?=
 =?us-ascii?Q?Oa5KeDrkVIS/iKO1RhyPfVZx89e1IFKD+2ZOsq6yGhDO+UzizY3nQYjpI4w5?=
 =?us-ascii?Q?pWzTYuZZ1fR4CCLt3ib+ykm3joXcYYq/qJra5nkEaw8JX1SX16ON4Q6NkeEo?=
 =?us-ascii?Q?reJhZLqve5yK1mBEKFi4//KY/zyjwxmwUftKKGS5gyVDM+aZPf79eyZByYDx?=
 =?us-ascii?Q?490aWoC9vq5Bf57YNz/bri2M0mffaYMpXQaU2RPIWKBLf9fhqlgEofdopCom?=
 =?us-ascii?Q?uXJUB+qzu3UFFYuMimhNg6mJ/sm1HPw6z5jRAEtrrEOK9DOkD/cWaCYCwluL?=
 =?us-ascii?Q?IVXfLiYMKF5myo+ENNORAxeSAw/hjVl+dxo2QyHqzETLOONcgQouodhiCkqT?=
 =?us-ascii?Q?feZx7fwUrW77NPCeinEJ5HPisGZMY5n3Yn7yHdt2GeRdBE1E0UrgPWkUxlYK?=
 =?us-ascii?Q?WxgaH28VbiQgMhoji77oc+/CXP7se0LkPaaSt5X5G530/Nhzl7+3yB3hoZyt?=
 =?us-ascii?Q?e+zXT0ml2wMH5ouFIKfrbL7q5jSHJOO4R2nJQ+IA8D0eQngtHMbMUdT3/G4I?=
 =?us-ascii?Q?4EQuQEgU4JZUSLCrwTLadnXFmHX1KduOEea+gkSqNS4PDYUhrONQaiK8SbDx?=
 =?us-ascii?Q?VAFwFIg19mqtzcRbRLa+9hSNY6BieZA7f9GvHaJbj6lnHz7SfCy0vvfN/wJw?=
 =?us-ascii?Q?s6nLelwDomDNGI+Ekh49z+G8WISQapQ7cZH4ULfNpFUQBi1b1CbslGSki0Y8?=
 =?us-ascii?Q?xGywKcOIFhwIOg47ZkKm02T6+QoEzZv5uw0NQVNQwboHRuDMvXBBddVzvmLf?=
 =?us-ascii?Q?NCreXfGKtjS+gMAeVNCR/DoW08Y+MlGqfrc/xUdQwTCxc+S3O9mFiR9t9AAa?=
 =?us-ascii?Q?d5+jz4b4PYzP4IJa7KFdzVn93Csuw+2RU5WhFIlKllfzCnWfYUOIifPKEKhA?=
 =?us-ascii?Q?X0DdK06jQJS/ukPICMuptCTOqDhnXw7mQChgMJZJ+fg7sAQJ8NhQ4P5qyNes?=
 =?us-ascii?Q?ftJBFQ6FbTb1yXkTqQA03CGosc60dvtU9vwJ9mLbkjY0Wo7MyayugaXZuPWl?=
 =?us-ascii?Q?i/8adB+JowZAfqt01r7e+0lh21MVlcfU0CQfEveAYSwSEdHJcYCy1Erj0prk?=
 =?us-ascii?Q?jmVQOz2Octkm3AOQ6mE36yawNoUYfw0qlRZlVnE18rDN7zc3W+8TWISKz0yW?=
 =?us-ascii?Q?WlIVJCXmYJXAydrfK8aR2ZWoayoNaepLrxUiUaxE81mrD+dIl/XUeKi9FOhq?=
 =?us-ascii?Q?oOrn6BVKFolv6pt4mHcLa9jElUu1VujeSYqmi86U?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da76b5d8-deaa-46d3-1598-08dd7db59add
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:41:50.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DC8ugCRY+M7zwtQ7IpbRIdOuVc1SKwwI3YoPylw9KL/uYaNNttaukJHvBYRMOO1+N4nNawdDtrU2IdlSPIX5AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-Proofpoint-ORIG-GUID: VH1xxnAL8TfEaRIsOa4W9NVjK8QGvrng
X-Proofpoint-GUID: VH1xxnAL8TfEaRIsOa4W9NVjK8QGvrng
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68010522 cx=c_pps a=5b96o3JgDboJA9an2DnXiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=t7CeM3EgAAAA:8 a=JlKoGYRGfjBZGDWtW-YA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=883 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170102

The kernel is affected since the following commit rather currently the first
commit in the repository.
d4dccf353db8 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in Isolation VM")

Link: https://lore.kernel.org/stable/SN6PR02MB415791F29F01716CCB1A23FAD4B72@SN6PR02MB4157.namprd02.prod.outlook.com/
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v2: Add commit log

 cve/published/2024/CVE-2024-36912.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2024/CVE-2024-36912.vulnerable

diff --git a/cve/published/2024/CVE-2024-36912.vulnerable b/cve/published/2024/CVE-2024-36912.vulnerable
new file mode 100644
index 000000000..ffedf3da8
--- /dev/null
+++ b/cve/published/2024/CVE-2024-36912.vulnerable
@@ -0,0 +1 @@
+d4dccf353db80e209f262e3973c834e6e48ba9a9
-- 
2.34.1


