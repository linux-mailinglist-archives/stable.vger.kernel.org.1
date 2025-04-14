Return-Path: <stable+bounces-132371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03493A875E8
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 04:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3233B08DC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE61547E7;
	Mon, 14 Apr 2025 02:44:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F72F4A
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744598693; cv=fail; b=kGTH9sH9G7x8VgNn0Rl00W+uknh6f3a1+XiysXQyFbMiw3QMaEIqk0bLB/awU9npWsj7TvOcKDbpJZX57ZI/oRr+xCsWolvbuk2CxhUXCI4zeOWb4IAK0SaBZd57oYsTa3sucAsy2+DDy/1XQDlWCxWPMG18BS+6Dr4nU3xXBG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744598693; c=relaxed/simple;
	bh=xZJSq2rVUYyG0ETJaihWPIdzTGDDXw7wyQAwO8pbX9M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lrGEiBa1uO3EpCKmnfktZ7z1zafeYzBvpHMaCXEjSENx7Fwqt6d6DXNueSbcNEcK6r9e+YwTonM/G3gQpouQCOI+/lbMwCekoj8zCgrgRsGMQIfirP5x3VKWFolEezTLC2PrsgEY4es1GDlBlBy7Ore1t8HHRzGHLfRO136t1w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E0v6Ym025903;
	Mon, 14 Apr 2025 02:44:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1hkkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 02:44:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6GW3MANOdR4p3fK9eif+INWl4YhwqRlo5/WPzTAWt9om4mYcNbvq1dIR3MdbHw/PBp6JeoDr0K1XdiOREdEY7DLGNyNlCHcYLxx9WGHntd0jnnrNnCwoVdoF4YkbD5dRUgjjTKBCmNjNT4xmGd9jDIIxLRU5UFvRv6XuFfaNeJigSCvJSvbBez+prVKW0Fsvkpr8beHtb/XQVYD/r+RabcVxN7+i/DLHvlJ605jLlzrGDhPKgyeBZlnFiDFszfUN5ZNuBfItdRiYhsVG/gaW0+0bMWmozGOBEw4E/aSgJXYJZfaoG/iwCkaItSGIKZw+vj49EJdPAjnZqdd2BQzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dBwZ8sQtGON4/5k2wlujv+RjhoGWu6kfPxQiNCVYhI=;
 b=u/NgJf/UCnEnr4oA6+SIXHJ7IMJ6naqcFvroywHdGRd5zjoC7nBJZaqUf2LMNuv9+PHdRTnw32GoRCSjehvGvVwIv0uUYGnOm+pAj2SI0EUDaqwOGKgzXHKiiAV6K9vB/6sZljt0RAc7UTRyBC71sL+ANUHS1RyRLSblT5OKCk9UC9RScFKzpWYGwSWOldov071sOXXSvsR7fVU4gNWnOXkZ+yNiSuPFh5oFShFRWPPZ/nD972vwB7Ah4XP7a4UM/JfNvhjy2qMwg28Myb/AbzQcAEo1OrTxEKOrdF/v+vzv/aCWYOg23803tL3KBD1PsoyEbON7dILt1hTygidJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by DS7PR11MB6151.namprd11.prod.outlook.com (2603:10b6:8:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Mon, 14 Apr
 2025 02:44:09 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 02:44:09 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: abhsahu@nvidia.com, alex.williamson@redhat.com, Feng.Liu3@windriver.com,
        Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] vfio/pci: fix memory leak during D3hot to D0 transition
Date: Mon, 14 Apr 2025 10:43:56 +0800
Message-Id: <20250414024356.1733216-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0183.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::12) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|DS7PR11MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b67300-584a-401a-53d7-08dd7afe3af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4l6uOriVLim/Z7Fuq2Be039hSuXcXRd1cjxPUwC2o51s71tT6j3N5msOhi8?=
 =?us-ascii?Q?6c2YBXi0uWFOD/KZtLNPzAfLp6SogbPJdKYr7b1vrBrK2Xo78J/Huhd5fN8N?=
 =?us-ascii?Q?ZEsZ6y3z+UL93XsyliBv+0xgwOunvQrvCcRA7qPh98H5yDwI1ohTmWfPQ2Zn?=
 =?us-ascii?Q?NXLip+mx0NA+zFlthbgfgUf6/YO8essXpyzquFBW/+dzrmzgbxXSq2p1UrnN?=
 =?us-ascii?Q?1lKcor4IEEI0S17ge/D+wXq86EK0+w8NYv58NLf3vgpGyhLqbHcv3exxJoD9?=
 =?us-ascii?Q?RXmFL2S09D4PpoJEfxgA2k353qPlaw9kLPInX9lHfTG87NB/y74CE5y7cqU5?=
 =?us-ascii?Q?VP3mEaV6WCaUH0jyO+Sqpok33+CtuDjAZgO+CyBdSbOqVWt8PUF7R3EKdJCy?=
 =?us-ascii?Q?2LV3GKERzY4V9/B5opMZOPJA5wmPbZP/AvBFU62d0Np3kqdr+lI31VtQtcXA?=
 =?us-ascii?Q?L89zsPoTk1LdKdwwnJyN1h31GmV85v+4Etu3UAjmw/8DoA5Z0zC+CW77pTF1?=
 =?us-ascii?Q?52a2+ruWfaNsinHkZQJygJnpW+s2E2cCOZhWhIwanpQYHPLCnSeRqNRG83fO?=
 =?us-ascii?Q?FmJold761oXLI30vRG1jl38Ox6QLSuxUGZ3edtApm4UoVKTlhXfYOTx2fpNi?=
 =?us-ascii?Q?TLxxwPWVLXT7Hm7gkM/ckZQoeiiRQN9nXAyT3vOs+58mmw54mrn2e/73nahK?=
 =?us-ascii?Q?4hPCfRGJu/VkPgsUXIcIrPv3B1RGwTa20lJ1MOlU5FvBzuuZZ4TLOQAG6fCQ?=
 =?us-ascii?Q?kFakPXoqXh5ukGmQXD/Jm3MN+PoP79+SlWsfP+vy10S8JDomGAQltjvNx5G9?=
 =?us-ascii?Q?Buj2+ss6TpkB38fusz047LGKg5a007rMinGVzuF1q2hKEI03ASYM09J6ERlJ?=
 =?us-ascii?Q?xg5HxonvI6CNtydEBmCTr0BOBG2ugJYObeV9sY9FlN4pobBQqCQDP6Ab+bSz?=
 =?us-ascii?Q?oaC2CNi8TlYjJx9oFTU4364hVyTXmXf7AzAuR/q4XuZFo0sWtsSV9tL61FdO?=
 =?us-ascii?Q?JyjlJLHgkQJt5g41LqvXPlb4/HHMnT7BZU6UgQE1I6mKaTlNrEoT7OCRgsg5?=
 =?us-ascii?Q?dsaG4xiGGcEc9mC7kkwA8Ve6gotKKZBfPhf7R3wXpNDxEMtiQ6TT2UXqMwFV?=
 =?us-ascii?Q?mWRTlohUwK8Wl0+O4auJRj1cYI2Aabl60RD2o6ErOKlPkuHr2leMlB4ZssMe?=
 =?us-ascii?Q?avmiuHlCT4yqW6B5CHoVxjxFZ5/t4IeB8CmIgvkAocO+VGPyHnjhxmgkGR9u?=
 =?us-ascii?Q?ZUhFCtzy7Ake7hU9KHYFJsvO82KNpdkXPj+Trkp3kYXSzfP6s7rjsLIlzJqH?=
 =?us-ascii?Q?6RizMBQKOS8g7kv6vSytCts+H5Eoyb14daeCmI51PePdiw6kGIaSx5bqOXwy?=
 =?us-ascii?Q?dR3zV8d4msgFBxfQJr1CIAMpda+cSFPysszn7+Ux7Z5lWr6Yd0XJuL8+DNz0?=
 =?us-ascii?Q?tmapoD316vHBJlyjzyYLJ21aqCTWmte1oOWjq+EtznBX08S+reJhPTQiOLWp?=
 =?us-ascii?Q?ymlJXvdVqs/P64E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZrPZM3OB4hE54UHkd2AgLVJGq68wXL+EaatrGK+bvijce3N+oX635h86wyW2?=
 =?us-ascii?Q?S/eX3+xG++nfvJmxK8qT7/ghu1z1eQ3yPl4OEe8b3aR80naK0yWyMkjnViMf?=
 =?us-ascii?Q?w1D7bwae+l83cr2lHeiIWVtBhFag8/XjQGXJj58ux/wkuiVydlAX6rgiCQ26?=
 =?us-ascii?Q?xKkkAu850hB6dhIE6ibqc2BMJzgk0ncPzDywNEqnj4GQw4FyXX1zb38fKApq?=
 =?us-ascii?Q?5S3AHzumqaioTcEHNqQYGzugqtm7GmWXIlAXcopSt42xh8Ksl+VPl6jp3h/K?=
 =?us-ascii?Q?LlGRte1fyxrjoIljMgD7VF4mVjRdZh5+bPVxnbOO6JTE2pRvIQydB0vFFlTd?=
 =?us-ascii?Q?qFVFNp1Ny/znyIkGf3hq79VMPua/f1qU33g4oLPusTPVmyUQBhUlptWZmz/H?=
 =?us-ascii?Q?pAqK4hmz1ytuteYgainCtA0MoETQOJgDDbkLuu0uIag0PIYST6/cP8cP4YDf?=
 =?us-ascii?Q?UrB88J6IXqGu06o6RCg1parrTPiaAMsD2+tiJeB7rakgBdcdvpsTAmcDmVyF?=
 =?us-ascii?Q?gtrjeQogCygOpxpu4CsspFJxvkhHT0R7iYINKZqsLtJONzyuMn7Zd0oS3+oG?=
 =?us-ascii?Q?nO3VIoXmNt4X7dz0jioQXduuNRTLJMwdcaYPnPrCxO1lSk6jEgrd+z853OdP?=
 =?us-ascii?Q?cj9p6vTyZeG6HRLQ9y7xqXXOCZtgdN/D38UWwST44pcvTZQW+BTuLj+k/Bsv?=
 =?us-ascii?Q?2cpljroekritWOZ4PhePYv8f0EuTlt2dqgmEMQQd6dXEtSLoTRsYdOqkjk77?=
 =?us-ascii?Q?uEXeTSA37CJZqFZPigEkPwcFjpF+ewfXQZ81dwa78PGNuCzcQDPt/viwOtoO?=
 =?us-ascii?Q?m1RkvCGlwbgFUT8jxGXGbtge9VSFe5tF6YekkjuY6FH+p70l1ALG3GOPW6KM?=
 =?us-ascii?Q?OiFr9dK7PgzlKpXa/U9CDwxeAJ3omdu111ROy33phfDY7l/GOnZmBGD81eKJ?=
 =?us-ascii?Q?Addstj0GpYQplB4d7JPkFYal/GKzul4DRlVxI4++wlzEw0VhH+/OWOD8r3cQ?=
 =?us-ascii?Q?c8IQIwhQejhYHTaO70owrH6MrlozZ84A1sG61++l+747U49aCXz+F9IpjU5S?=
 =?us-ascii?Q?2iCSatVfeVKqpSlmZhRY82LBVUCJe0Dg2vYOpNEJ7XHandQ4QsVLum1Crlk+?=
 =?us-ascii?Q?3G4RMW/10G4KBjVaGT+ApfcAdf9vOZm2LGTKuizdxNVlNtqVM/Q+KmkZfKUp?=
 =?us-ascii?Q?pokCPM9KbNi2pyvHDhCsiRz3D+UcSV2byieNhV2QFnaMSkETx/iYozL5/7LW?=
 =?us-ascii?Q?52ifBMb+BJbci2dg6OCwNCin2pEX9KmlmU4cWKCsIZHGldKLKWo+se0FhuPN?=
 =?us-ascii?Q?ThqKBrMAFwex54QFFSeohGuPrsmVtisnPIPg4OH8AvmQUrvXIWvM2z+KTdO6?=
 =?us-ascii?Q?6DQLUan/wm/VvfsVG99ntbuUVH+0oyiU1n5ewvPHWmIGz1OrNwOnLaVsLobs?=
 =?us-ascii?Q?WzB+Yxc6MjXPLGyeHfeivySExcrVt4LvykPCjq3AmFWU6BscuxrqyT2CV1sp?=
 =?us-ascii?Q?ZyrDKB+afd7wF2H85/j9QvlIiPCGY0e6BM0GvKIGlVf+BCBEsLtLeteqCeIX?=
 =?us-ascii?Q?u2Ie2dCU0Z1Vt564pGXjysO/qhxnkboFLQ5NFLzM?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b67300-584a-401a-53d7-08dd7afe3af2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 02:44:08.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1V/G7dD96LMbR92FQ60ORMI/x6rFtL1YLp2eXjxByP5zbmKufTEsn41PUA3IznPoJDzu94EDA5j3s3GwYFSvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6151
X-Proofpoint-ORIG-GUID: dLSUrahQPUWp2up22rWJ2KNGeXnKiEnm
X-Proofpoint-GUID: dLSUrahQPUWp2up22rWJ2KNGeXnKiEnm
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=67fc7698 cx=c_pps a=OxY2RB2sa7x8oI2LU21LDQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=Gh2SBA1N4qOeX0WauYYA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504140019

From: Abhishek Sahu <abhsahu@nvidia.com>

[ Upstream commit eadf88ecf6ac7d6a9f47a76c6055d9a1987a8991 ]

If 'vfio_pci_core_device::needs_pm_restore' is set (PCI device does
not have No_Soft_Reset bit set in its PMCSR config register), then
the current PCI state will be saved locally in
'vfio_pci_core_device::pm_save' during D0->D3hot transition and same
will be restored back during D3hot->D0 transition.
For saving the PCI state locally, pci_store_saved_state() is being
used and the pci_load_and_free_saved_state() will free the allocated
memory.

But for reset related IOCTLs, vfio driver calls PCI reset-related
API's which will internally change the PCI power state back to D0. So,
when the guest resumes, then it will get the current state as D0 and it
will skip the call to vfio_pci_set_power_state() for changing the
power state to D0 explicitly. In this case, the memory pointed by
'pm_save' will never be freed. In a malicious sequence, the state changing
to D3hot followed by VFIO_DEVICE_RESET/VFIO_DEVICE_PCI_HOT_RESET can be
run in a loop and it can cause an OOM situation.

This patch frees the earlier allocated memory first before overwriting
'pm_save' to prevent the mentioned memory leak.

Fixes: 51ef3a004b1e ("vfio/pci: Restore device state on PM transition")
Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
Link: https://lore.kernel.org/r/20220217122107.22434-2-abhsahu@nvidia.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 drivers/vfio/pci/vfio_pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 57ae8b46b836..7835712f730d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -299,6 +299,19 @@ int vfio_pci_set_power_state(struct vfio_pci_device *vdev, pci_power_t state)
 	if (!ret) {
 		/* D3 might be unsupported via quirk, skip unless in D3 */
 		if (needs_save && pdev->current_state >= PCI_D3hot) {
+			/*
+			 * The current PCI state will be saved locally in
+			 * 'pm_save' during the D3hot transition. When the
+			 * device state is changed to D0 again with the current
+			 * function, then pci_store_saved_state() will restore
+			 * the state and will free the memory pointed by
+			 * 'pm_save'. There are few cases where the PCI power
+			 * state can be changed to D0 without the involvement
+			 * of the driver. For these cases, free the earlier
+			 * allocated memory first before overwriting 'pm_save'
+			 * to prevent the memory leak.
+			 */
+			kfree(vdev->pm_save);
 			vdev->pm_save = pci_store_saved_state(pdev);
 		} else if (needs_restore) {
 			pci_load_and_free_saved_state(pdev, &vdev->pm_save);
-- 
2.34.1


