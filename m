Return-Path: <stable+bounces-94089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F39D328A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 04:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72048284017
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607615623A;
	Wed, 20 Nov 2024 03:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45043155CA5
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732073348; cv=fail; b=EJQiJUsvBOcSasKf3bq3+xcqy1OsKHnt9WhfUje/GNntEjv2sfNkJi0W7/bBU52wsLnaazNdit2fCysdP+WsaYkgSeg+hboBcPFmWBq/JGBCn4m/hcpqEroEp5HA4CB6WWf1SswONg1h+Ug8AL3Pp5hQccGq70x2BgW1q0bObjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732073348; c=relaxed/simple;
	bh=/ypJp9ZZDj+JbgbSHbqQjbyWxzriLSwhoOSUmaSjJlo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cUo3JiWlYiG/+ar7bl1wFabrih18Ha+sUxtHOU8M3XAuguzymoKicj4bkYk6mXQZMgiZoXK+7C8oDSUErYAmzkpHddIoOfFoFHLofcBNR9tU8jyj2oYFLICWwrEMyLqFZEA91/ehlRbolUIAwKSu1FLPqxmTPpmdTh8Mroe4vEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK1Fe1p006125;
	Wed, 20 Nov 2024 03:28:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8bshp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 03:28:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9upOfiaBa0njursL1iQ4s4uGKGyD9G2PllbgLDveOxnVs921CME2F7xfpa15lv0gUyD9o38c7YBe+UckbuFfot4yw+w/ZK07Zr9VOXNm0Sp6tvXSMY9lc60tdlK1Fub34OZHx3WCATu+1zxIG3fc2c2EpJW9FEg7LPoZl8994fRIKE6O07ZY6gnVAKuQIZK1y+wrBg9YR07a8psSYY4NGFHXBcdAFoDGn9TIaVTdLg0VJ8NW8R9DRP82w3nEIBT+1u0xckA9ERfHq8/ochn11DuDhW/itORwEMd4n8Tmht7BIh8NaldodvPUa5OFk1LZXC45Hqh+4r/SPKawghdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e48abbqUVMlYhWKfjWe0Xc34w2RcEHbGjjyWjT7QvE4=;
 b=J/4zRMjvA0j1WPc+lqn5hDjbuoMPurQw5RCVPk+51yDEChAKFGV5ggXD9RTvPm9mJzx627Q9GH592TIFSx4Y6qHXT1UbUtBgmGqUXeKa7PR51m9XfmuIbRBdM7ZTkuVEGSALztZzKWtnXiZBau0T1AnFinRElVAexkm56yd7gAw3v60xDc9auYfDMXOzlOx0bZLdOk+mwj3+9Y/FReCoR66jZ5lEpptReTV41JlmxXdfINlTh1Cz4vpfe4p1oTETKj1xAkDEydvg9vpUbXhI59MsB4PaE3b4ul8bUI1vq7m9spis3Wc1/J+TRwl0WtHNjQEm40jvhuHIN2NuN7pUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 03:28:42 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 03:28:42 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: yukuai1@huaweicloud.com, christophe.jaillet@wanadoo.fr, yukuai3@huawei.com,
        dlemoal@kernel.org
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH v2 6.1.y 0/3] Backport to fix CVE-2024-36478
Date: Wed, 20 Nov 2024 11:28:38 +0800
Message-ID: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 092561b2-06d3-4f52-f2cb-08dd09136e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iVzd3pagJi+3TVbyXJWK/yPQPlNsF3bw7umgK298/C3YphOm1YPBB5gpmGT0?=
 =?us-ascii?Q?5k+FA15QVB29xyZwq5UeXYjn8Lmzz5OdwxsJcG5ZEc6Ldfs79GgzphNWkmjr?=
 =?us-ascii?Q?BtzngbEIEAcsGoUF3bRH/HYfjuMtrfPTUkV40Iglrt2BskM7gPquk8wGOYu9?=
 =?us-ascii?Q?fa23XqwxuENW7YG+ejEqHa5p0q9ceL1eQ55Bl702udMVVrM+DG3ueWOxGPIv?=
 =?us-ascii?Q?YNlBNr9cRGqMGQK5Nzhj0Oyo8IKOpYOJdAFn6ijwEaCTRqDATGg835UTQfls?=
 =?us-ascii?Q?pCQloISYCSd9WTEMXZkYQB5yHHdUYp/3845+rDzyW00YuRPnwE4CS49uaLRG?=
 =?us-ascii?Q?2k+WeM49TnL9VGHmH/Vckd0BI3P7GFd1UcGOPoJqoC8QY6tQkv/B6Ksg9/ZI?=
 =?us-ascii?Q?b1n6McjKbnJIrVJlQOwJ+96m+61KCx+ye+39P0qrFpwqrgczco+/JN1t4kSt?=
 =?us-ascii?Q?hp4e+zPpzbxTbCp9frfsYiam0K0NQmhG6CvwSTZ0/Dyq9eulY682XxxE8nQW?=
 =?us-ascii?Q?dSf3Uw0jW2AlFW2W62iwEOrgW+mf5J4+XQLNu50Oh0QZkC/aaF6xEupVfFxz?=
 =?us-ascii?Q?B/t+lrovjqumlfgIxgjhU6ldd7HLGDpfHkylNuF8OJBQM1+fmqaEWqe/XKtY?=
 =?us-ascii?Q?sHlM+IHzCvMN42wtMhOg7Xl4R7/4R0nrLJAVaOqJuYJrMktg5l+L7X+48tU5?=
 =?us-ascii?Q?49jOqJGMdDj2oROK3ugqCUIbIcyzZko6aYiys+4qchvL/nVBehvmqjA+tZEn?=
 =?us-ascii?Q?HLmxsIgdFb1qviOceEv0XkLVw6cfuCal2a7aYkc8olwKMQCDGw9Ct51lKYnf?=
 =?us-ascii?Q?UNOJBOjroQ6RvAyGgCDr+7w5O+1oUpPgfaKnL09jn0FmceL6Kn725rmb+97C?=
 =?us-ascii?Q?FAQiFWav2PF5GZTKYaX/sb1ogiVrzu0GYkwsQ+vGHVqHtbZWeBmdMoxPnS9N?=
 =?us-ascii?Q?i8pJjbMp/oimFH530XhhvY+Ckz/aUIKrh4x7eCSIZyzK46qCd+C0T25YrcQt?=
 =?us-ascii?Q?QEQS0GS0a1G2I4K4CZ8Bg17tKWfGf+7zwC6eboAd1uRSEei5TleQPxJLZp9v?=
 =?us-ascii?Q?gK1hDdfOdH210QlI6Eu7zf+fpX41d/77ERm9/5bx856vi4lTOSFMhmM4bQct?=
 =?us-ascii?Q?nzwb6Pu/fzVgXY0qf2JbK9c4yfeD1qbKow/R+G/bu3N8tE5BX1XhtLRng2ty?=
 =?us-ascii?Q?3pGdOtPPUZB32BA8gm952uxHFmf73v3onufrKd3M3KvnKGbjJiIMzcPB64gV?=
 =?us-ascii?Q?6m/ADJmG0HFQwuappAeTlHdB0feVrlEVv8tEmpHBEUz5Lkqbvbis7OYI+ryE?=
 =?us-ascii?Q?d2gWmoGVj6kMzUj1mco22q2wyXk/mijh1o950hOEYYPhOKXlvjpwRRcQwdJy?=
 =?us-ascii?Q?Voqo970tucNslz4lXaCivCR6dO1a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7V1q9ymc3kTbEkvCETbiIC8gUKpNTULyWXIyGTdIcK6XTIHR9dmGhlqZ/AO?=
 =?us-ascii?Q?I4ARq4iRif6l9DQ/z0Go6tCFw601eIuOh2quebTw059S/fU6M56JcaL5WDHa?=
 =?us-ascii?Q?YtiyroyNzKdTXPAg9ICSLiyt0lRn8JPTEPOYTfU3nbeKwxVtdms1ZovePdif?=
 =?us-ascii?Q?kdU58nS8FcgvdhDVmUoCiU8jeA+Cfr5dhi0SMZKMBP+j0kIEnksrTljms2qK?=
 =?us-ascii?Q?Z4pA4Ft6NKwl9s1+9N41LfDkQYe69eO9kznwZbxMT+WTSkW2cgl6YHzmmybq?=
 =?us-ascii?Q?RCLK5/t7Rx3/2YTzv6PVU2ajigYn+sb13wE+GhW9b2mpsQtd1Cd6XgBnWk89?=
 =?us-ascii?Q?4KO0IleXVZ0LedOXP6xh+1JYeD+CK20EitbcmNZLw6gv5GkZoQXE8XuEK8Yo?=
 =?us-ascii?Q?Tvkgwix+elLfrmRXQgoUELMnj31e/GRhLr3CbNSjWAfsxAiNG1o6riUpGCPo?=
 =?us-ascii?Q?1NuAeHsYjsl+IQ3mE76dkYaEqBqQWNY51QoOcjtOht+t6FXzgyckkSW8h9wH?=
 =?us-ascii?Q?ZjM3QEIB7ODy4hQ9+O5Fad3xTLxeL4lY3pYmFOFEFyshAQ2QXx6KPhtlyM4e?=
 =?us-ascii?Q?zzB9jfHVD4NqMrfqhi+41ANrWqrOeIaNftrQuSWKrg260P3tjDUgNVx77DZh?=
 =?us-ascii?Q?rnoJqkUJRY/1TxL4cqY8aowTqs6fFMc+5tsqNLztWOWDXqI5iFHJfeNVDC96?=
 =?us-ascii?Q?ADLPOqv5DCLEFD2qhDh6d7DOY2VD2HmboFJKD2i2jjSbr45UJEN+vBHjw6bR?=
 =?us-ascii?Q?KTtgbWC5UZPz5MJUJyqI9XKRaN9DnX7A7pAfjoCFiUqd4PSHeeXcGqBFSYtX?=
 =?us-ascii?Q?m4jR2+ik8bGewq5SshrAvCMhc9EiSDXzd5OyyUuZFVTkuTfmQjy5wOtzZC+W?=
 =?us-ascii?Q?SZk2aZWTm5k0TN7gHlNT3Im2FMmneHMkAlFCNdiOBR0WT7jP02oP1bc49GoU?=
 =?us-ascii?Q?U/6hf2qBwnIqfuIrQBaDXG9VxgigFUi7O00HCy8ed9F9vf9XKvo9Yiwxrxgf?=
 =?us-ascii?Q?+58LIqnsXuLz02SxKRx7s9DeHDpD/mvUEhKQxLQtaSLoAnEAG+6kF10rHIJJ?=
 =?us-ascii?Q?LVGk0enU+3zR7XL+4J5cJIVy6Ft99C5DrxcAVydUgQZizzdF/+HtSl0MWyEg?=
 =?us-ascii?Q?mq3o9PBabk/BxnmBQAzkVPZPqzKJR+rxphbAoOl0PyFz64EqiaOcROaDBHPl?=
 =?us-ascii?Q?a/a2fqmBS1gIHpxhw+1Le2OEuY6tt36s2oQMbznuitGvuBHyfSjfYLb8HgIk?=
 =?us-ascii?Q?8GNDYLI7hnxrCcTrnFP82uckDd+ajPupjO3l9ve1l9MeyGsi0i4QwjwmXtk0?=
 =?us-ascii?Q?k9+DPqrcv9SjKjdCFNNVpjpNZjfwOOLeiPn2aribR9PAITiJLxK77EjkpSYJ?=
 =?us-ascii?Q?rUVhis4Ajrt9d//wswFp7nvBP81VSuc/RhfM2nI+Bu7PM5eVT+5SK5Y2vco/?=
 =?us-ascii?Q?Ka3+4VWY+rsEhbQLLfUQOiABRTkKR2RggZqk+jKaTbGt72l0LfJCu/PUFE19?=
 =?us-ascii?Q?AQ7xyEpvEKerBhnhwQIYB9Y+w1SX+LJOwnbL2XuCm4uBeEeuyihoW8KMk7tD?=
 =?us-ascii?Q?iZTczMKuYTP98+K3Yfc27OczL0ARjOw8/V2hQuA5i8Og1ErQsmBBvIFR+qyp?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092561b2-06d3-4f52-f2cb-08dd09136e84
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 03:28:42.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjnBAm5/cDQMY4FiNxUo6KwZzwxciyks9H0sUZoSt1RYBBEqWByCNPqOnVzoTlXwGHl1GTHfWDoIV86X0nK/aapjPq9pdMe0nVszV1Pmxt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-Proofpoint-GUID: b_6vFKxZk6WulqhLxYM1ydbkh-8Co9oW
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673d576f cx=c_pps a=o99l/OlIsmxthp48M8gYaQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=ifpdVBqWFMikVErx1-wA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: b_6vFKxZk6WulqhLxYM1ydbkh-8Co9oW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_16,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=832
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411200026

From: Xiangyu Chen <xiangyu.chen@windriver.com>

Backport to fix CVE-2024-36478

https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36478-d249@gregkh/

The CVE fix is "null_blk: fix null-ptr-dereference while configuring 'power'
and 'submit_queues'" 

This required 2 extra commit to make sure the picks are clean:
null_blk: Remove usage of the deprecated ida_simple_xx() API
null_blk: Fix return value of nullb_device_power_store()

Changes:
V1 -> V2
Added the extra commit Fix return value of nullb_device_power_store()

Christophe JAILLET (1):
  null_blk: Remove usage of the deprecated ida_simple_xx() API

Damien Le Moal (1):
  null_blk: Fix return value of nullb_device_power_store()

Yu Kuai (1):
  null_blk: fix null-ptr-dereference while configuring 'power' and
    'submit_queues'

 drivers/block/null_blk/main.c | 45 ++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 16 deletions(-)

-- 
2.43.0


