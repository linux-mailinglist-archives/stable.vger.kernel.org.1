Return-Path: <stable+bounces-125847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63B9A6D4EA
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180EF7A5035
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5019CC31;
	Mon, 24 Mar 2025 07:21:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E6A197A68
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800874; cv=fail; b=VCfHzhGjx0KN9S6CbFMgyYAEyvUoS8Lq89PSF5GXWko+mISzmbcz9WljGKKgC4Cz8YDeFDmGtaa0+NS0jSKfTbcUPe1GazSOvUyuYUbcvgOU66aWMWP1ma0Q6C3tM80pbWg6aZKdKMikTD/pwCbiDMaB2520JKduJhvAqngrqa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800874; c=relaxed/simple;
	bh=Lm/o+WA1sVEmG1ZYiT2ROS+EQ+pfDRUhEjhL0tzvK80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epM/yyWX6oUGaJ9jwL2WdwM3VIJzZgS9rd4PGqwtYhlAT2dV4ySVlj9++J5KlCeiJLFLFh4lunhEfC6A3FCPLTEgMBwsXDBP+ThZVsg4dqKo6nQIiYzVk1SCfB79YSrkEcxiDgoTQuaxZAxy0b8vH8Bjvi38M3xX7K6gF+695jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6Q73v015713;
	Mon, 24 Mar 2025 00:21:11 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqk9ffq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 00:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnfr0pbDJ5Z9WZ9G1bns3rVwLHCcAgCIUwB9Ebhnc2Gjhph/Pax/wpGy6fVK5MxJtG+ShQzs1RDc8bmFfzXoo8oqWZEfMGkq0PXxCTbvoHmnQnzYBNN0suoTEMukxp4bE+OUf61qHGmvHgrPmsnwkQ2DTi1tIE3PEEnefQyjEwt3D4KO236jNJuPqhrEbS+JCv+m9d15GRfzpk/5muBmCsvb23ek2HKJ6CUd+p2zqaP11vZ+c/2adQRrwkMQsSH4V8jsPsfGPfXyOMFMQS7noe57qOb4Sv5/hiuw1PcQm5vsFOtRGJ3bHSVaGpQZFQHgdBlfjbsHT9V4a63u0RZTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYUAuPEIKn2yZ6IXUi77DgOUMRDr3XeXmP7hsl3e+BE=;
 b=aVUOeFB/zTq/eKt5/Z27R3Wd5OQpjwXdy2rpYcYx84ETMuV9FmSv9zuaorqXQCMte9tFYeSXJjUKlMu0pgcxrUIk57XoqjbLcPxokXicvznP+oKGdzgbYVzlklNcyA4bB11HoyzOdSq7aIPNb6GNYMQ+FhFPs8edmYQyXluJ6z+W6+TeX2pkLDbXdPn77YNrU2oM42+24hdfyNBXsXrWHclnBU1E2fqqDUis2HOCzd0NmbucvwPMkvOZPv8Qxm08X95Ri3UrkVqrBnrKqRukkNdJlNhpYB0I3MxaDslAogzqD9k009ejjCKsDVX1G8B0evwWop933U4GrEw3lkmELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:21:08 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:21:08 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: regkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org
Subject: [PATCH 6.1.y 1/7] binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()
Date: Mon, 24 Mar 2025 15:19:36 +0800
Message-Id: <20250324071942.2553928-2-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250324071942.2553928-1-wenlin.kang@windriver.com>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: e618daf4-f318-4188-3738-08dd6aa4729a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxHhHbvcptDfAN2aogZmKBoxbBEg1/Gej7QqXYNooFd2khtAKj1X0+QnBYYn?=
 =?us-ascii?Q?SWHigSHrBfqRt5hbisN8P2wS0rFYpxQIrzShFwE9GzUwVi2SGqedxFZg3Noz?=
 =?us-ascii?Q?5kAGq61nI2rhtujaUcwbjrwWdD3OVryEpWhzkxT5+HRl1Ly8ierhyZsRbHTs?=
 =?us-ascii?Q?WH1WFxx/572NDkbPfMchbh/jHuY9D4Q7z2SMI+W8j3bc1OIM7p32SnSZ44wz?=
 =?us-ascii?Q?UBZCMOg7wOvkXRrz00iTeIRVEPsJZ0S10hkHYG/2zxM1HaenSm3ojPN2+4qz?=
 =?us-ascii?Q?k7rViIlxJx+9JNS3edFK739yOTbQJZ4AHXUDP/5a5UPa/AeYDiRVG5j0Znkk?=
 =?us-ascii?Q?wqsrn0JyRGTB70Y2X6sevIe1SsiYa1Xd4pXYmbDIOa1jE9kXlgv6kkM7afO9?=
 =?us-ascii?Q?VG2ehzid6g6mBIDLjdIanXIV4iXvdQiB481KNJ2RN+AJKS7Ag6I4290v0/ee?=
 =?us-ascii?Q?fGkMAQJpxlBTqCapwPpS9/LIZ6jX6mj30JMQrGowKFnO88Y0nVgL/laFFQi/?=
 =?us-ascii?Q?bWdid+gfCkR9aW3uqCmZ3EBK86n7xfwuzAF2udAm3JAu3DPbNtJe9jH2v+rs?=
 =?us-ascii?Q?FVVPrDoAh/fGw6n3eJetJs/pV0QwoJ0hCQoCCcjVl5A2GWgcwupoSMr1TaUu?=
 =?us-ascii?Q?7sWtn5z3cYoMkqNHaWt3QS1ikqYQDNPsVFyMU99RjObQSM6E7CLxODBlLjk9?=
 =?us-ascii?Q?fXo5d+XYc8+tTDueKWZqEpHiwfmTKhzBx2gmnZ/IvEsT0d1uXRDoN08p//Uk?=
 =?us-ascii?Q?r6V6OA1ygx3UIEbCerhG2lbTreISoIkeejdT3XrRmNTHGfcB1yvZgsVnJNN9?=
 =?us-ascii?Q?gx91oX6HOu0x5GKXc1VYeMrIZgg5Oh1D3kn3mPGvg5VEiL3ZYYGVy3Cd6zV+?=
 =?us-ascii?Q?8CTTAb+GGCASWQwr5fWorZTmUamAs5DFmTYd8lWQUdU682UkCJuyW582QPlP?=
 =?us-ascii?Q?3hqsvISRUDUSfJFoXprtx9hqLMMsmhZRX1wgWtz+nsNJWJ1WUbsvgYw8j5m2?=
 =?us-ascii?Q?v+vxO8HK9PaO+JYwf5/5Q9c667UidGgstmS7gt56SQcr1fr27nIdBydCp6uD?=
 =?us-ascii?Q?fYgR+Ssy+aKmiy4+3eGpzhVK5OWdIPuGhCUPnsPIB0ytX4p2VHMPzYx2JnWU?=
 =?us-ascii?Q?oZTrCxlwcvo7TZEZA4v6xzVZil7N98yXUMa+ZwkbvfyP4bmg029SYnTvd+ab?=
 =?us-ascii?Q?Rbp6Ww/UuA9YDjG87kqgdrSHOzFIO/himKjZO7OY3kE/fWWfiLNs7ZTPW7YK?=
 =?us-ascii?Q?N4FjLrATeFRdC4YGM04s7oV8N7eTwXBEB+tucWCGHeD5BWIuVjx4AmEb8LRG?=
 =?us-ascii?Q?TE/U8nh8DDIx5D6/vAh0Px7E1Zz9bmd90tNavGGZbti7XuhPNUVafzt+I97A?=
 =?us-ascii?Q?creOjqDO9bMn6ArpLd0kYUmExmuBpxnZrgnts0rpFcbytJ2uB0gX2en2+D1j?=
 =?us-ascii?Q?oIeAo3tsg4fQqCDcV+fWCYfrky8KmxH1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kuwAWrumFm1Bg5g2kodtvy0nQUORpM7mQZHOIJ08mh3aOWRrIAGDdwBnlYf?=
 =?us-ascii?Q?/jhcq7n04DcGtOoTRUlNLeRGvo9lkS5D9eRYEkqNeEhj2yqwLwP6AEutfDRC?=
 =?us-ascii?Q?aoUQNMa3OvV6PjpG9JEATvYRgkeP6+gwNirvb9+Os6TdphPfGFOzu/QqqknA?=
 =?us-ascii?Q?jxWmQ30MsAhfiDU0ZyrvlCZdkiwjs/grsr5bQw4GHy09roPJPC+3zF3EWejY?=
 =?us-ascii?Q?NnBumhjy67H1nrYGlo1937vzD2Tkbd5Em7vinrp/FJgbVFs1Bh1JFBXXdwAJ?=
 =?us-ascii?Q?XsSBd4zkphpVRTOFgxk9r26S7loUnUWY6HVB1ysk2Dr/O1SObA17dlgPRAsI?=
 =?us-ascii?Q?+rb+rSdSWMOOdV+c8vKEN2o2vAdjqektYFuleRbgujf9BzT15UWx4fuWOGnt?=
 =?us-ascii?Q?Nn8rANbrXTrfCq7UFjKZyZZzL/0B/+3j9upFdXlEGu4YqUS6k0Vmf4FbLIFx?=
 =?us-ascii?Q?wJUxp46R15pWbvHLqJaDuD3BGUq0eTuG4i8bG/FJp2XtQMo84iUVq0DcS9/6?=
 =?us-ascii?Q?Gw9j5DNue5ihGXSrpXl2xEzdBwEyV8C9BXiW5vq3pqyd5ZKiBr3y2r9V9VtO?=
 =?us-ascii?Q?d2YBRTzt5b0FUYJOF7XcumiDEyZyXOBZDruVvuFaYGv2a6up64/nx8OreZKS?=
 =?us-ascii?Q?N+0T2iV0BnxvqSxcMjSWV/2auk7YmPNyWOgj40v2VXWZQfHniGDpkmcMYzPY?=
 =?us-ascii?Q?nAzMFVdVhiRP96oDFphyXt/iWzo1CO9IVC9ovyUjtLLsJQYUUOUyT11FMNnr?=
 =?us-ascii?Q?M1KxkrcpK42qTzMqQprJD6/KeaIvUrSwEUzvwr9RYNAevgxOSMv3buGHCpcj?=
 =?us-ascii?Q?fC8vzmrGuIOIaLyYUmbrimeh/W5gHg6jec/8yiD88WqAzFC2EN9Smxkh0LL9?=
 =?us-ascii?Q?/v3HJi7dBE5W7U9GJXQTDeutEQ1RcNYUkpQ40udBMayyPVrDvzpVcPT9eB6u?=
 =?us-ascii?Q?1DUhJIr5H3RNVkPOhOBhck5q6/y6iCuHX3EqR6SZmnR+rJ9nsZPbeXYK1OTh?=
 =?us-ascii?Q?nDRMf046J/ZTnpuI4HJwr6v+Yf8mAcEVdYS2tj0qUCxY0G7JtWH0A6YAiptc?=
 =?us-ascii?Q?+ZAVCGdieoGKliEkEuMEdUKg+sdk0ugDX2VvBWzrEXPSTnq0PMXGt7JBnrm0?=
 =?us-ascii?Q?wQyMkCldPS7KrLrEbtO3SMBfqKcvAexdNyRlSjb15yC7fvrG7oELam7hZ/a0?=
 =?us-ascii?Q?t8DO2K/5P/qifUof4EKtMTefE2vuRCznlLpbPHkCQNGeQQVEPcrxpng59fOl?=
 =?us-ascii?Q?QlDoUrFa8TuVqiS4vJHMg0QKm01C1eiOExK0Hn7Dyrxgi0wV/CjFBhqWP9K8?=
 =?us-ascii?Q?xnQ5mH1c92V+c/fVYvGshenDMrsRoRD22LwOXXU8LiuqUadtDbUcsZljpn5H?=
 =?us-ascii?Q?emz1A8PPxb8fHuTKrO4LDt7avxdpJJmqOfd4wcawozq1Vyi44us2IVH3ZpJi?=
 =?us-ascii?Q?pVEH9dGlWPNvaMl0lksfdCyJrpWJ/Ki5+MOwBidGz2I8sN3tSXv7Bd2hmOdc?=
 =?us-ascii?Q?/xfdhYE7lb+ijcrC9bOwxu0Mg+UcE5OPzfS4VOATBX6H3zB5KuWdMFpmAkP6?=
 =?us-ascii?Q?JyBjsYxYZuT54xlX491UV0PvP9aJvY78EG+wYym2LYElYZ5C9U8LvHhhppVH?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e618daf4-f318-4188-3738-08dd6aa4729a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:21:08.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2QbdpfcAQ9MhXV1QmkDwtasb0xVNcgm3zv1+EvIVYUfflHxFy7Ck9hgrI9ZGfgAzJXQhy0fohCOP5XM+qz6x35oj9Mfhcg5dun4CZRObyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e107e6 cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=F_93P0QhAAAA:8 a=cm27Pg_UAAAA:8 a=t7CeM3EgAAAA:8 a=J6lJRGZUnOFGzfQkC3UA:9 a=v2fne3mUlQEKA94IZ0Od:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: XcmxpNSbG0uW9NLCfpFoVhE40Z65FdkJ
X-Proofpoint-ORIG-GUID: XcmxpNSbG0uW9NLCfpFoVhE40Z65FdkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=657 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: Bo Liu <liubo03@inspur.com>

commit dc64cc12bcd14219afb91b55d23192c3eb45aa43 upstream

Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
instead.

Signed-off-by: Bo Liu <liubo03@inspur.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20221115031757.2426-1-liubo03@inspur.com
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 89e7e4826efc..584b446494cf 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1167,7 +1167,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
-			retval = IS_ERR((void *)error) ?
+			retval = IS_ERR_VALUE(error) ?
 				PTR_ERR((void*)error) : -EINVAL;
 			goto out_free_dentry;
 		}
@@ -1252,7 +1252,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 					    interpreter,
 					    load_bias, interp_elf_phdata,
 					    &arch_state);
-		if (!IS_ERR((void *)elf_entry)) {
+		if (!IS_ERR_VALUE(elf_entry)) {
 			/*
 			 * load_elf_interp() returns relocation
 			 * adjustment
@@ -1261,7 +1261,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			elf_entry += interp_elf_ex->e_entry;
 		}
 		if (BAD_ADDR(elf_entry)) {
-			retval = IS_ERR((void *)elf_entry) ?
+			retval = IS_ERR_VALUE(elf_entry) ?
 					(int)elf_entry : -EINVAL;
 			goto out_free_dentry;
 		}
-- 
2.39.2


