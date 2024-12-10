Return-Path: <stable+bounces-100287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541179EA4A2
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 03:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D20828265A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 02:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8662AE93;
	Tue, 10 Dec 2024 02:03:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83063233129
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796199; cv=fail; b=Gq+/GAlKXgnU9KDGhnI+D6Q4WYaNsWZl0QgB9vbi9BPSlf20pjqEiK5vrncxR5Xoe9Q3m2QeSApyHMtq0GUqDDyrXTznq+yzSzIQ+Zyo56ecevOAY6ARGxe5FzJ9eP5Q9RKwduNrteDLJ5fP6HGdpurRJ8ggnkuxigyGPAXNm3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796199; c=relaxed/simple;
	bh=7E5ykwjS72gzTrNmVIoQB7KLF08+kpwvwC3ehdCsVY8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a5upwEZIUiRu8zRbK9FR3qujFdCILGveO38z9AQ5KZxuoIkHGMMwhZKmjYUzbDqzgAdQsjgDCpYtAf3tTaZi8NB+q19Al6cb8tpcmVEdKjw2gxxMKPFLeMnkJvo6vTRcX43+kooE+lSfd0eJ5kHYc3bMe5KfJaMPZ1fMVEIR/nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA0YVq6025417;
	Mon, 9 Dec 2024 18:03:15 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1t5vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 18:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg++VdvIgCYARisA1Krwiqu2k20ESnHFi0T+tUEycRp3lxxx3eIUo5m3vBwPx0bPbu/PQraUdd+lGGiyVEx15VY5KEWxki5X5Z9+ug/tfCFTNKYcVXoLBcbepOD5M151RGh8M06hRFL8XVspP4Oe2IioLsellx1ReFgwSqtwZH34LOWmMAATPurH9H2iFOOzVFXV7mQ79+nxOfFW1O6Y0RngPGHNiiqshUVPTYaRpLMhCdkoeYPa58ifnuV3q4Jh/XZ9+JIYgII8C7NH+KA+k8LqdLlPnRZ7gYLL1QkcJFmbq3j3pdt83itA8jw4UKA1V+wx2GGN0e4TGDweQggMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E7HrpWVzmb7RjwFrsySjYL91Y7hEGEtIsb2DiNu0Q0=;
 b=k+jgQWoYd1jNgry3QMzT0BfJqz80S/5jRc7s6DAvAN1wSGD8H8hBNNaaehchbJjR8bUyd/Tl1q5YEHmU+cDDmXxRCk14FIzBsm10/sFLEcX3KEtDZRXZEm2WZhR83bw+HEZXyCDaVpaz+6nkwCDRv6vle9WzftQaSgGmn6zmfi9l2mFfHV36yioVMN3c4YbMNLl2t7eoaI+IVy+bXxCfcnqZTNv+oOewtq9tSQN1KMpzzQYvnnfeMywQ+80thBeaK9DvpnATYewxcXy4O6kWUENWg+Kb0+ytSEq/lNlbqaJkQzGoiUqx7PEaBO0gcJVbOuGHl9vKNg9KnuW5IveMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 02:03:10 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 02:03:10 +0000
From: libo.chen.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 5.15.y] ima: Fix use-after-free on a dentry's dname.name
Date: Tue, 10 Dec 2024 10:02:52 +0800
Message-Id: <20241210020252.3221904-1-libo.chen.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024061919-angelic-granny-6472@gregkh>
References: <2024061919-angelic-granny-6472@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To BN9PR11MB5354.namprd11.prod.outlook.com
 (2603:10b6:408:11b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5354:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe37034-cd8f-44bf-2d30-08dd18becbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yVR3q+ZWZ/VHSOeAb78j7pnVG5zbdbsWSI8KjsYhIeM3KmSi4h9YBMyq0zNT?=
 =?us-ascii?Q?UHlv/xy6hqblc4NVZH0ekNsblSHZ/TUsSgs5KSRtyFhRRAvQr0b9ScXZI1tu?=
 =?us-ascii?Q?sQMTNzsK3Zm1bAXJ4AjZQzkH4OAJWoOhu8fjxsNgl8WEIaKl9CGHnJPeUT0Y?=
 =?us-ascii?Q?Vw4R3HyQ6giBHKCq1n5VT8bvdV3q5vTOifo7XLtB+pDxwUcuHiGoFQrKtiG4?=
 =?us-ascii?Q?kL12W/beeyJNgqUwYIxAoe52GcDB0gX2rjzw6Fh77yo74xRbAPKipDkEuIwq?=
 =?us-ascii?Q?hxHJkLGFk+jM6DoBgH3hTwlErLtrK46AyvD8KfNc6SyCHy2LUIhTbX4rUrdG?=
 =?us-ascii?Q?NM4DOTuiiLtIF+LLH+YFOAC0YbPweuLkKNDiX5pFJFXECRbRgLxWRbhocMGR?=
 =?us-ascii?Q?eLTdXHr3PhtzqpFyT+Ot6Na25Un31jddD26kADC95lfSohEKYHJ0Nhkkimgp?=
 =?us-ascii?Q?9JylLGR/NCYuu+Fy2A7rXBzSI09LqW2aGY4JddhQVRmly9iZuFqmuTOMgOXd?=
 =?us-ascii?Q?f7Mh+JW285bbKMmQWEtBNG8sX6s9ZOsys8qH5ESRl15v9ex8oMO7QIY5pRYv?=
 =?us-ascii?Q?krSIU/ttjvC/06udjd5tGbbes+D/OAzfl3+NCAmxmiRSTdRwxH32N+rwQEtn?=
 =?us-ascii?Q?BbGt+N0H1PWvmqJPIJB5vzzrdr4VkrRmPrsEQ9qrHaoecMUOgho4x0Oq+To7?=
 =?us-ascii?Q?+eIQPjc6ZMZHi99+ltzsMsmYMdB+RpiZp4ZTTfzwP8KtJHIWfTYrd0XQcA4v?=
 =?us-ascii?Q?W3aq63TWtfWdJEbC2z4jNtW6cCWmjUiXlGsDJbJMTdndRlMfMkzerGLRiGhB?=
 =?us-ascii?Q?+cu11Y25lkhNcS0uSP0vPaGv/7ROgGXrbOgw+JspWdY96KpDdQ9oIX7Btmqp?=
 =?us-ascii?Q?TGYp9sslF90ykZYlz81sOzFBFoQoPVQsWEr6txD+RpgcjyCMp9NlA/4qaUI8?=
 =?us-ascii?Q?/9Y4cPkBSwnPfgUB5wMgo9Ooqh4w/5dhopjmEHYdOBwim0Eu20VZ33FFU8O2?=
 =?us-ascii?Q?b+SjhFaIknZo8ByBqY2NdHCXjK+C3FZ+IQWxRgczYGemrJte5DNzdguA4/hz?=
 =?us-ascii?Q?U2JkVNO552PRWgMdSPiOilTC5PO/r0L+tYiXvLSCIQNwBp347MLQTna30pPB?=
 =?us-ascii?Q?LPAVUqU1A4dl/YS4M+Zp4PBBRzdWJJ9LHCf4/lIzMkKJbAtkEKcgA3zYVo38?=
 =?us-ascii?Q?tC6secB9vqIqQ9XOTD0qXZT5mNSoWdIe44GDKhwd25fwbT1tzjumai4c6kQP?=
 =?us-ascii?Q?RuxG9qhdM/0O5DQVnaVsmfC+qg48Mp+BcNQ6TV6CojBir8JrU9E/Gm2uT6Wb?=
 =?us-ascii?Q?c1AhAubb/1IoxlzoPHu7yxCBduU+KQshEtZ1p/KVg5NqbnWETn0GfV5iiiHA?=
 =?us-ascii?Q?IdWLQAnvR6jQZ6nJ2lezpt6/vEQAnD3gzU1N2aiihFBRY8Pkmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cciI/4mLBe+1LmaaKr/77enS3o+fMFubnO2n5CgbY9GIsMruKpa5rdTBbymX?=
 =?us-ascii?Q?PjcnswXaaZ/sO41T8cHwpKlRhkrt2kAVQ7F9OnWt2P5L06M18oq1HXLdll80?=
 =?us-ascii?Q?lKiSdc0fQErJA0xwz06wztXAYxWIwt0FLKB1jtXR3GoOXEWIK1f1iBtJpzRP?=
 =?us-ascii?Q?C4ClSu0nDe7eX+BcI101Bb9xk5NUviQn1mPJrqWZfNlO1cZRwBzNsmPFcycA?=
 =?us-ascii?Q?QG+hpDQHboFzLltflEThBj0T6tigXdx7DI0Zgrnpdv2fnw1kUakhwxTPTV1t?=
 =?us-ascii?Q?QWMVquJDQ3cDT/Rf0gNFx/Zp+iRYm763mCW4imHryo5EmvbRRns3SGzvT53o?=
 =?us-ascii?Q?fEjqRKofp6dh+kwb4w9tFXgM9SmB141LtlurD22g/ZiagM1wE0YMu2hLbi0/?=
 =?us-ascii?Q?ufWD0uR/8e7Sdf8WjyAFiEMUhb5tIl9pDwqh9UvBHkW5nJxtT+LEZgdnArFP?=
 =?us-ascii?Q?DcE85RLis3UvYGZfDbxlV7gTMhXVObG2SRV9tHI9vVx7WSkioo/BNPnJXT94?=
 =?us-ascii?Q?qS2JXOOJQ/SbnWDgYkw8KfsOGprLTGLnOsgZquJhipJ0COHoIwAlBpqMQ6OL?=
 =?us-ascii?Q?WfQfMJZmtqjww/bGrDQk89KL8qH9UpD+/qXq2nsFYRbFwte6pARBdxtr8znh?=
 =?us-ascii?Q?gD2UEcF7G9p85YIqHkwk508nSDUQY9SnTrB8DoR4abo4BJASPqbmaHJVRsvd?=
 =?us-ascii?Q?mfFM4xezL8vXBpJdIVfIiil16mUN44QkDc7XrAX1zSpy3JrLAz5g456zvFbn?=
 =?us-ascii?Q?wKpxfN1LMxwt1GtCXJme3db3o9coBJD3t3Q80QUsgZLZFkgZ2x0yxdV0FQSm?=
 =?us-ascii?Q?BZCKSj5iYJKCj3RYsDaRtjsDzWNcVjfvl6QKvD0IUILSEsUN6MouHSPYTFJs?=
 =?us-ascii?Q?SmS/4CFiA5a36ZxWDdhS1PaOxz7hh0+wAtB+QrVPfC9+HckZUNtrEgrAyPxE?=
 =?us-ascii?Q?RAXM0IagdZ3hG8tGCsm+JpPt4JCb7MBoTopWCNGHCqZ2NmcMQanQvyw1voVS?=
 =?us-ascii?Q?4zp0urY5yFSR9OcsEt7rGsPU8pdwN2/haONDdq3FflBgynpD3JpU3uggaTTO?=
 =?us-ascii?Q?/DfxUWhImsRHsu0CufaoFLSDmEY9C38Ld20upg7dl01myJig0IloWxgILVCR?=
 =?us-ascii?Q?0LQyqVyFDOuqNtrjtJgCQahYksZKeaT7R9hbG+M3dbgaH4GARLCtbl67aBG6?=
 =?us-ascii?Q?rGqbgvK6uuKxY6nAs4rJhksT+bvTuOY0jWVsw0laB6yAo+RU12PVD7BTLomX?=
 =?us-ascii?Q?UcCX7WBV/HYfqUUDj1T3XD5yXL93+GgyKHTk+zWM77fYRtjH8aga5KVt32eK?=
 =?us-ascii?Q?6HQgUaxuEjyChZqJBzpyxZSM2i1JET0PD/DY8Rw54hn/gycwUGqsIKIjJAz3?=
 =?us-ascii?Q?Np+8QEHoDga1o2rJKqWmJZqP7qtr0to/W7xXlHNR104PlXvQ6K73a1G/sANj?=
 =?us-ascii?Q?HlBDtI/SFv01Z8SMUBFlr56HiwnTvvbvUYJ0GxCE43qj+NxgJpQhayGYxShL?=
 =?us-ascii?Q?IlMAiB8Rpdhs6FeUA5UiTSbBIN0nYU7+pvT82V5PCQe+5eNW2jE45GN07pLg?=
 =?us-ascii?Q?NWKTQKI2wKntLqwKjgaOBkpLEeZnTOFU9R00e/ttSryG+io5HWK637lhYly2?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe37034-cd8f-44bf-2d30-08dd18becbe3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 02:03:10.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zetoul+zMqLTZPftqn7S48yDbG3rsuIeEiIQyOSddGhMGNVU1QCW3UjLp7GutkoeEJPi4jilQTSjN3VlmrPnbetRbT3kPTiGKVEMvL9aPS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-Proofpoint-ORIG-GUID: _9b7QVKmTmg64MEDwoZSl1ccrwH5kjqJ
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=6757a163 cx=c_pps a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=drOt6m5kAAAA:8 a=t7CeM3EgAAAA:8 a=Ln24RqLUxJUgtsCh-VwA:9 a=RMMjzBEyIzXRtoq5n5K6:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: _9b7QVKmTmg64MEDwoZSl1ccrwH5kjqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_22,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100013

From: Stefan Berger <stefanb@linux.ibm.com>

[ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]

->d_name.name can change on rename and the earlier value can be freed;
there are conditions sufficient to stabilize it (->d_lock on dentry,
->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
rename_lock), but none of those are met at any of the sites. Take a stable
snapshot of the name instead.

Link: https://lore.kernel.org/all/20240202182732.GE2087318@ZenIV/
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
---
 security/integrity/ima/ima_api.c          | 16 ++++++++++++----
 security/integrity/ima/ima_template_lib.c | 17 ++++++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 04b9e465463b..fa7abe4bde61 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -217,7 +217,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
 	struct inode *real_inode = d_real_inode(file_dentry(file));
-	const char *filename = file->f_path.dentry->d_name.name;
+	struct name_snapshot filename;
 	int result = 0;
 	int length;
 	void *tmpbuf;
@@ -280,9 +280,13 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
+		take_dentry_name_snapshot(&filename, file->f_path.dentry);
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename, "collect_data", audit_cause,
-				    result, 0);
+				    filename.name.name, "collect_data",
+				    audit_cause, result, 0);
+
+		release_dentry_name_snapshot(&filename);
 	}
 	return result;
 }
@@ -395,6 +399,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
  */
 const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 {
+	struct name_snapshot filename;
 	char *pathname = NULL;
 
 	*pathbuf = __getname();
@@ -408,7 +413,10 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		take_dentry_name_snapshot(&filename, path->dentry);
+		strscpy(namebuf, filename.name.name, NAME_MAX);
+		release_dentry_name_snapshot(&filename);
+
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index ca017cae73eb..dd7beaa0e787 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -426,7 +426,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     bool size_limit)
 {
 	const char *cur_filename = NULL;
+	struct name_snapshot filename;
 	u32 cur_filename_len = 0;
+	bool snapshot = false;
+	int ret;
 
 	BUG_ON(event_data->filename == NULL && event_data->file == NULL);
 
@@ -439,7 +442,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 	}
 
 	if (event_data->file) {
-		cur_filename = event_data->file->f_path.dentry->d_name.name;
+		take_dentry_name_snapshot(&filename,
+					  event_data->file->f_path.dentry);
+		snapshot = true;
+		cur_filename = filename.name.name;
 		cur_filename_len = strlen(cur_filename);
 	} else
 		/*
@@ -448,8 +454,13 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 		 */
 		cur_filename_len = IMA_EVENT_NAME_LEN_MAX;
 out:
-	return ima_write_template_field_data(cur_filename, cur_filename_len,
-					     DATA_FMT_STRING, field_data);
+	ret = ima_write_template_field_data(cur_filename, cur_filename_len,
+					    DATA_FMT_STRING, field_data);
+
+	if (snapshot)
+		release_dentry_name_snapshot(&filename);
+
+	return ret;
 }
 
 /*
-- 
2.25.1


