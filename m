Return-Path: <stable+bounces-145732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC3ABE928
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABCD17B598C
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791801A5B9D;
	Wed, 21 May 2025 01:32:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161B28682
	for <stable@vger.kernel.org>; Wed, 21 May 2025 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791138; cv=fail; b=Hp3PPcXv9ewQrU1JErINGIEcrTnYLGiFkwwdDFIfGSY/Ho9Cb0eC46+07HA+G2ZZLxyVyBYdMf4vt31WNT1mVGjtJAlc48WmvBkIRyWjx8800SI87OFsuXCRkJ2551sz/TrUK/RO+8U73wrwYx39vUF/DE6m3+idq7SBYiDz8rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791138; c=relaxed/simple;
	bh=jpEQZ6U8rVtWS3W1zdPhg+Bsyg/feLJqS40cfvhAXaU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E/JCDw8FzJB4VRFZ5j4BPoHAhk9MxX+2287cOH/iFkpZppCc8P8jeokW7akr2Wn2BpDPjAGFMiKCec24cDK5tEsDxAQXWeUc9TWja5JBRwrLVb4qQNPipmBjurNVr2ILjUgiKz3MnHS6Eb7ZlL2OL5kNcFopB6D8/bszXM06d5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L0cZuJ004020;
	Tue, 20 May 2025 18:32:07 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfr8m9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 18:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw3qHeJvs086JRgAoSQXL36bpgw9N/f8LVt4S1v54flJ4e+jL0orv9j9DNa38qD3UCMTLq4sIUAHWXXtktgdvOfBcWC5QrUYSk75mSoo2JbXVQhpOC8+MuRRYPS0oQQC+7Nj4v1RL3JK5EGYHDBkVIKdkUgv6u3cdn6i+Wppd2VZKlgn4tGYHZ8wBNmiLVW/V6Q60IJllxJWr/SjrZ3vna4gTFjWpQo0AoDEEdk9OX3jPLE+g7qzYfauXvtnn5ixy2Va9NTnolPUPpe96Ihpmz7dpJ61hlaUploIDQ/M/GfacxfBkQ/0WDaY4WQECEXeKYShGz76PArP3kTBf1QiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk3rAx1cuGL0W0oMD9JZQl2uukzrjT9vAG4ejRzljlQ=;
 b=nTlXxqnziZ0piQleZNmljtGOgsQtVwyjnJBXWluIAfpB2Lx48exJm5Gi9Tt+T65tgKCEGt9H28cQBgCI0y4JTArykolkZMXdUe5KK72HxQwCSvbZcnN4ZQJb6fQMCAEk34Fc8hvKblb+TYy4bjVuxaCaHCrikoR/s0CGcMrtPgIJJUddAFURVbHCASoT7ctbrpB3bRCyqJpd0QflZCN09V/wRtMhPA1NdgmjYs254xkOJ6dFiN/1HyJQC4c60nUtgi9WRa1UABvOxPcZukUw/33u6X4Rydo90bWtyhCWDGIOnHEewoaujeQBAKEV0z6ntc0yeiQ9jLUn/fONGhj8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6965.namprd11.prod.outlook.com (2603:10b6:806:2bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 01:32:03 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 01:32:02 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: wander@redhat.com, bin.lan.cn@windriver.com, peterz@infradead.org,
        juri.lelli@redhat.com
Subject: [PATCH 6.1.y] sched/deadline: Fix warning in migrate_enable for boosted tasks
Date: Wed, 21 May 2025 09:31:47 +0800
Message-Id: <20250521013147.3339412-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7dbb09-70d2-429f-de3a-08dd980749c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ne9zhltJfq37IcTHVeimICGk3cZRH5a1DwEDFnFRS5AQWKkUf8q9ORKioemO?=
 =?us-ascii?Q?HsXhmG77t4ICrv6SH2edUKIeRvmaBWE9IVSmi2UKLnz3RLLIkI23dPs4d7SG?=
 =?us-ascii?Q?eQ2ZsNy+hlE1Y6Gnw6co6NtACJMsqQObAEAzGbFQPjqvu8sbkKrfK5SKAZ/6?=
 =?us-ascii?Q?cBzMIuCCc6bzccC56FDwCSQEetef1I2rRREPMuZ1t0zH/R7KOAAf0jRkYi03?=
 =?us-ascii?Q?e/47glHPjuwggH7OwsfO1v9KE4Q8ZKbCwe3WhgcSpMjfDDwi3/jl3a6krfMu?=
 =?us-ascii?Q?DQ2l5AVMuduqugf8crXaY806oiNZeJCyYDdv2Jz3cWBDHBT2JafcDE7b8Rbn?=
 =?us-ascii?Q?2eecxCvJmW/HiHW5M1wbOgn/uQm+kCVShl0wnxXSZc9hSOdW57VjHXq5ohEu?=
 =?us-ascii?Q?KzS0IRjkuzIHKYbuzFiRcm4emk+dVMaRId+zj4GvOdLtT8KOBTR2IYck8acB?=
 =?us-ascii?Q?cius/zinVSE8yGz3SgHQ3Nsg0P6592ICHBseB2kiH20XMemLBrj3BCBaD3Bw?=
 =?us-ascii?Q?YmsbFNVpydFwlhrt2/htSMQLo3D2020hbCzOIH2yLp1Ij5g6Z8o3sP28D0JG?=
 =?us-ascii?Q?KXRapPpbHb2lCS3c0DMcQcNmk09/Gz7D4L5+WKAcrpt0VoHbZ52nEBixXuVi?=
 =?us-ascii?Q?2Qn3RKdaxduT/fWuAANJnVtNptNmddDxCSK4xk86SjiMqnGoeO8Pa5euO5uU?=
 =?us-ascii?Q?TCNIvV6Ei+BMaY36QFe6SPGIDh+eJykXWwBcBGazVlSSen0mm2q8SQ6kuFTW?=
 =?us-ascii?Q?Nt86+Z6OG5PiUeRPmoApwKic+J5BRyxG/sVsbTymaUXFcyZjdLSqmj/URxC2?=
 =?us-ascii?Q?fcFgiMUJOxuV76albj9Vf/ZBs/FhBxYqgKyBtt9vxCdwlX/CGJICD1aVOXHe?=
 =?us-ascii?Q?ygXrnHNTLAl1MBDpW+v53azlRb8LgB9JPjq20txWtBZeRMCfyQwAeNVZycv8?=
 =?us-ascii?Q?gSRklbOWR0zyD2xgomZHoylS1dpSCyKgR7IxkTyywT8Axqllos7UD64Krvuk?=
 =?us-ascii?Q?ssYfnZhQqfqilNGQN441+shxiP/tGH3Uo34Z/F4oBJmj6d5IB6edlPO1IuXX?=
 =?us-ascii?Q?jPyOD83a1CXh5f/n5IVmpGeLitrw0xk27OPV4aTJqKYY+dEGn93OlIplv3E5?=
 =?us-ascii?Q?O217oifDaT4/y5TMY1w1nI4nmU9z0epUCNYMCBk4h/JP4edvCDquGmtfQVEd?=
 =?us-ascii?Q?m7nuTA/HATWp5DbDndt54SeqWRXu/mwJrlQ7Qq26h/s+ZTZtVyEaz6hNEvzN?=
 =?us-ascii?Q?vt6pBf/BehS5NDBHGLARc73aVye9lEIkltfn5aQ+otHU3z+DrddEA/OY86fL?=
 =?us-ascii?Q?CfsxIkBhiBHUX/tPO29pcHAzW+CKl6pdTtrRn2j73f3ANepMM5DkhmUaA5U2?=
 =?us-ascii?Q?EGWbeVBwmQyiR7EfVdYnxmPaD5rmfa8+lB0mNRjrdujPXXMJbkESMroZ2/n3?=
 =?us-ascii?Q?DF9eWcI9XfE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5LUTMdDG+YXSViZHkfC22FzBwFGOZz243NXRmBhFrBkTJzLrG8rN/7lWP7OC?=
 =?us-ascii?Q?VGugi4zvJurMC07GvWBKGRer2dp6kBQao1Xzw2DHZrNbmJNbhGR5GX4TJsTQ?=
 =?us-ascii?Q?UA/e5jjJokehfluhpwkqxiekPnIS5u8PaoxsoNPeDP1ah4Y9pWP/5nOifPsJ?=
 =?us-ascii?Q?F+gH94ORtq23r3Zsi7q8Kb1Y91QCg6hjNnaXtiT5qETeI/oEvvoMCb4W7Tlp?=
 =?us-ascii?Q?gWkTue4jXSIDoV5xI2TUvzOB9uEWJTntNlrvAKsemRX1yyQ1oTdYV47zZXuJ?=
 =?us-ascii?Q?2M1/KBdsCscZ8V11Vs8rFb9Lc4PcfkbA+LRoG75NW9Me0Knr/93Qn4q/KaXs?=
 =?us-ascii?Q?6c3UC7wYCm9Xu0sf4YJrkrR5GHiH8WqJtqEZ8S+vOUO7nrL0nP+k0PoN/PiN?=
 =?us-ascii?Q?uS2KIBJlOhQcefY9VmEtWScakXEc77LWxBhDXiSM/f23IRgSC/qpA/3Ba3PX?=
 =?us-ascii?Q?M7Yq7gAUpNxidMo+YVRzjzZzIyBnajAR3u7L922KEdjfEKwU2a8S0Kn5MBz5?=
 =?us-ascii?Q?AkNZiK7FV1ao0m93UHniWUPTS2v3vMCXdAd7W8qYRYcdcikObJhPOyL9OJMA?=
 =?us-ascii?Q?3wAYut/VVFOyGiRxU2zpc+OcxrkRQZPN6FSu0ZmqK9InvDDt4Bg/BIjHiykf?=
 =?us-ascii?Q?DmsBGpEbG5ti1MoC86ghrUGv8uDTcfi7xSE3+Bpdu4lIwBxlYPf4z1xzncfo?=
 =?us-ascii?Q?UAeBuEIh+8GQFlxL4Px4PvFGK5fM4BXFGIftoZn7kdd8RPIZ5F3ef2+Yg1mQ?=
 =?us-ascii?Q?c1r5bP7l/U7ylt/naibqMLN60BUBlWtk8Ep8L8uRnDAbp9WVN6yvyGbGjnPg?=
 =?us-ascii?Q?t38syrp9HZthc8CzduIH0lHk8np8P2uU6bWn1VuFFFsKwfMITVGUMdiDRKF0?=
 =?us-ascii?Q?C0kjWd0CC91wZWxWiKh+GSj6d6uKjKKa0t0+Uu6F8Rf3Osj+VxGut6YSL4RW?=
 =?us-ascii?Q?Kst0zZsnjWEpyjxq2kgEcxtRm9ZUNdfGhcUK1696shZ3Nnzbdxm6R9WcdY8G?=
 =?us-ascii?Q?7TfDb7BMzJUeb03bnQNTBTUrEQVfKrqY7p8VbOWVXm2l8mZr8UWD/3ucevH9?=
 =?us-ascii?Q?RXuvvZrCf7DYYfYKKRfgcWOrY+QAQQGfhhuSKQi5PrAsq7hA3TBrspVbkNPY?=
 =?us-ascii?Q?32LLyxOYffEb2E9gIUgmLwJUv7bsfQqjHhFaMCIbXTdeWJ5jG7Mbnl2K4qqC?=
 =?us-ascii?Q?0Kbssp6Zh9BKfOr0ug08bjGIgog641+oxy/w/8t1jt5WNPboYdeqOLAyMHgL?=
 =?us-ascii?Q?HfKoa1rSydU3YnvaJVhOUe6J+v4LYt/5sx6reZ17RgqJIn7re5LarKfPNrGb?=
 =?us-ascii?Q?GLL8l4yEH1Il+7PcHFP0VxGwD0V5q2+hzwPDAscjFlkiezFqZwsOAqay5dgU?=
 =?us-ascii?Q?4+bLmRaEaYGHLI2uUz4xdPEEAA5refUCI+ePnwuatXGiauxFeaHwEo5Ce2mm?=
 =?us-ascii?Q?0CnbYQp86RsGYCnSO7zcfBbmlod1hNmMcE+KwN0+diLuB1ua/adGarK2WXDm?=
 =?us-ascii?Q?JdLvAT1RjqK9lfW9j9TJjLLssuuF5Y0J8Xw7CNoPE+Z7LP4R0zkN7HHwcxzK?=
 =?us-ascii?Q?Xfvuk44wM0PvnXnXRDePcSCTY4++wsUEtxP3907LGr6Vfkn5MW4dD4QoOIRt?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7dbb09-70d2-429f-de3a-08dd980749c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 01:32:02.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRSBuPm6XEjtLKnZbvaFS10Zn5Z5DBHMzr3hpImMjK/o1i1JarXsOdHiGXiRfGcK55Tlsvdp0tPrzHG9ZE5wWzolbpeD08yOqv/HW8DCYbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6965
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAxMyBTYWx0ZWRfX9Sy4sYREoCsP Q/ir+27aezlcp0Zg4Qx8Wra160CpaE3N1kVjEPu0RiD52GMnAS571unkY6++3hZ5eGfdJFpZFmH HkvbbFVputvO0XgtKicsiVyd/SvnnH6hpISDJei7AF7kpl9sE6T7uATr2YEvYnl3UUqg82OuPlM
 KNDs3ESC6aYFrJGnQIc81cDtct+6a2/5GApQxB/4fVWDdcEqGj1HlrpfYUAaywKWaMV3BuYnMw3 o6EAQkzc35lstfVHh/1mWCxTzm5mu6QDcI8B6A2V6xkpGrAD+XT0Q32jZgtp97fsnijn0eiYDaU x6ho7Pp93CGApVDw9XdCwMDk5ogviZt2daAQ127+5mlWFniezlJ5Hm4TQ42rfh+Q7l6xedI99Xi
 DEgNhyCvtnRZad6nEanol5ZOrEgF9wEywN6TkrSWQYL0zKTdfqDUFFAJ5pDTETT6umiLhm5L
X-Proofpoint-ORIG-GUID: zhJ3tcQOhDRSIs3eSHUsGXV3exR7ZDyc
X-Proofpoint-GUID: zhJ3tcQOhDRSIs3eSHUsGXV3exR7ZDyc
X-Authority-Analysis: v=2.4 cv=TrPmhCXh c=1 sm=1 tr=0 ts=682d2d17 cx=c_pps a=zzjaJ2HwkiRAih7KxKuamQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=t7CeM3EgAAAA:8 a=TXSmb4N2Zo2ZqIVaM4gA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505210013

From: Wander Lairson Costa <wander@redhat.com>

[ Upstream commit 0664e2c311b9fa43b33e3e81429cd0c2d7f9c638 ]

When running the following command:

while true; do
    stress-ng --cyclic 30 --timeout 30s --minimize --quiet
done

a warning is eventually triggered:

WARNING: CPU: 43 PID: 2848 at kernel/sched/deadline.c:794
setup_new_dl_entity+0x13e/0x180
...
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1c4/0x2df
 ? enqueue_dl_entity+0x631/0x6e0
 ? setup_new_dl_entity+0x13e/0x180
 ? __warn+0x7e/0xd0
 ? report_bug+0x11a/0x1a0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 enqueue_dl_entity+0x631/0x6e0
 enqueue_task_dl+0x7d/0x120
 __do_set_cpus_allowed+0xe3/0x280
 __set_cpus_allowed_ptr_locked+0x140/0x1d0
 __set_cpus_allowed_ptr+0x54/0xa0
 migrate_enable+0x7e/0x150
 rt_spin_unlock+0x1c/0x90
 group_send_sig_info+0xf7/0x1a0
 ? kill_pid_info+0x1f/0x1d0
 kill_pid_info+0x78/0x1d0
 kill_proc_info+0x5b/0x110
 __x64_sys_kill+0x93/0xc0
 do_syscall_64+0x5c/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
 RIP: 0033:0x7f0dab31f92b

This warning occurs because set_cpus_allowed dequeues and enqueues tasks
with the ENQUEUE_RESTORE flag set. If the task is boosted, the warning
is triggered. A boosted task already had its parameters set by
rt_mutex_setprio, and a new call to setup_new_dl_entity is unnecessary,
hence the WARN_ON call.

Check if we are requeueing a boosted task and avoid calling
setup_new_dl_entity if that's the case.

Fixes: 295d6d5e3736 ("sched/deadline: Fix switching to -deadline")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20240724142253.27145-2-wander@redhat.com
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7f378fa0b6ed..e1371227a3bf 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1656,6 +1656,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
+		  !is_dl_boosted(dl_se) &&
 		  dl_time_before(dl_se->deadline,
 				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
 		setup_new_dl_entity(dl_se);
-- 
2.34.1


