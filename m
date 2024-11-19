Return-Path: <stable+bounces-93894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546299D1EED
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99621F225B9
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB5714883C;
	Tue, 19 Nov 2024 03:43:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613913FD83
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987809; cv=fail; b=YVXUKb9vCT4yU20zQYySpVKGsSUWPI7MvkH0HxFfB1BmKpOgl92b9cFL9fGKVwBkDeYlWpkhsQ7lu6iuFzyXEKzFZwdpI3D1Ky5bNygdT8zZmnfqmk0IkE9nlm/WbyfNkjoPCYQZLNUd1M718WwZbGCYcNO6BYJe5UquDjRLQ9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987809; c=relaxed/simple;
	bh=D6ff5R0q+DNjnOQkoVYFM56t6h7r+VEGwYd6Fm57N+c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XikamOJSylo0cqPcQEpIRW/zdN7ZUJ85Afl5Ysrz6Yfnz/0rB+UK7SX7E9z7mJh8tkHcW1oVfjcZrdwKCQ/XHNWPuyri7uTYZPlY1KDNFIiB/MRnO6oePztGoDndfne3xJ3+oWRGiyC+9+w+RraYStmUWP54+wV3L8/Dgel5noU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ2xLDt005029;
	Tue, 19 Nov 2024 03:43:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8ajjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 03:43:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXeLuToW6Uqb+0Y+cbv/DV34AuEsPb7e9o/kYy2pLRTswfgDL7eoI6QHorM2+U5ODhxVTsekNXenBrdEZJ7GdxqUQvUFbVmVfLLOVy6MJCfMEVpSNcjwE0MB97YgYb27jcULVVqSzNu+agPOFmpP7THAwOWbUr+QkadNqu+9+VthyvLmABN1fqsyxngiOlTAYC8AYq3yiwifVIa/4+Hsi0iof417OUCB/IAI08RymLcBFx02Pnx4nNaLV3dIAMdJPdplOEwTFagqzmCBsplwrhwz5xGMWAS5bw9YXqanVWImKb61ZiiE2kLNtzyBAyDoM5ZWO3nH6uheOHlRDDxphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaZR+GNrhSVrxtsPHszE/2jYw+i3pzlSVwxay/4gmBY=;
 b=CHlfwkOMeEfxwPzse6pOruJI/cXdsP2h72zKW8tbAMQ5CBpB2w1TGKpo97tW+5h77uKt+j3e3fTrZn1Qv+uswNerB1Kg3hLwOgogLrw0U0RLO998KO2Syo1w6w/wsjJJXHBurIRqhLxCHB7G+5bPfLrZEGD/88ReJhHsStUldJzvIqzrICLBPz8lKQCbXDU43lORYvZNG2EbwFQfJgoDAR3IcjVH/0z9sAgmH4tCzypcA/2RM014laDnUn0ri3ReSZlxWqamA1STtR/6UQ87LE5ugyxySn/EDcO662x8tVQC3Uko/QVX1f1Sir4u1pmtMX3faGMmE+EL8a7y4ZGHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Tue, 19 Nov 2024 03:43:15 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 03:43:15 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: ericvh@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 0/2] Backport fix of CVE-2024-36923 to 6.1 and 6.6
Date: Tue, 19 Nov 2024 11:43:15 +0800
Message-ID: <20241119034317.3364577-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::12) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 97481668-7ec9-44a3-f986-08dd084c4cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dmdNmF0tlJLUkJr2ydN6HvDjfgpUL8JfifmQUkYbICLdv5HhrEOFheLI4EQ6?=
 =?us-ascii?Q?aRR5GJyKqDLiwBagVQ1SkoJqs66QjCs+UBTO0inK4mzcBVbejDrO0O0B3u21?=
 =?us-ascii?Q?NGxDom2p1VppZoks9bsUwytACbyugwkxGpgAd/WBKIFwnxtmQGa6Nuvl+JO4?=
 =?us-ascii?Q?bNg1MCCRPEfxLk4rVddSW3LB5g80GuYMi/iP3MOOMfybzBSc5jYRabMSjW+O?=
 =?us-ascii?Q?sBwtyu4j2sasV14umRy+zJBuLvfebQ0hZsGW5oRHqtOYrsDlRTVsziH1DmjI?=
 =?us-ascii?Q?mivJJPTXbMPSlAu0wXS7cdjFwBOppwkBocD22hgx0xzh7rFMOsv7bZpkhqtd?=
 =?us-ascii?Q?E0ACwgkdu0FtY1ua89byCrXGzvUtLmq2IiFhYnutgpY49xS6Rur4lc6JUF79?=
 =?us-ascii?Q?xjZWnLfjXEIsFnpdsFc5BZUI6vGMUNmoZt1UyIIKQFgayOAWjC8GV+mmue8p?=
 =?us-ascii?Q?5JAY0YJ6FG3G0kKW86CrSCK/n/JIFNAWgKYuZjYeCAVT6VgR44ktaeMB4+In?=
 =?us-ascii?Q?VxtxLMek9Luq74RAG8aBEnxj/hUNLiSK8ld1QXFwBa0AdALmwc3Z2lRRhScf?=
 =?us-ascii?Q?a4uQZKmTQybrDy83czUGYiyDflbTPrUXocxjLD+AZher2r5VkzJIEpOynMgZ?=
 =?us-ascii?Q?9X1j2OK57vxNRMqkq0daLmeVKmHmqvkSgq4b3a1Mr6f0amGekPKVkJfQiYh2?=
 =?us-ascii?Q?8k7/76sfwmwWdgPboDQKdIYw3807D7xKZdCv7r1n3ueQiqP5A7tf2wjExgt3?=
 =?us-ascii?Q?JY6HB0EusLNaZf1algezxRyUYsGmDhr77paEoJbO5t7PRw0xlw1PhKV8yldf?=
 =?us-ascii?Q?AwuOom9tI/W0ee1m2uObzpXdkFRgsJUojXG4ZWkUENTk2wyG+IgEfH4WuCai?=
 =?us-ascii?Q?AEtnDi4/p+dCl7dP3i0+TVHRjJm10/vGntBf1xlmrELQXANj/r0k04LXvLsJ?=
 =?us-ascii?Q?lrH4zhyFUuG3JJfbebhYUBFDDEI+PpOLExthyFLnCqbvDHCklJCdFIowJcBP?=
 =?us-ascii?Q?pW3hxTcMiaV4WEdqc8ZlRzD4ipIo1k1Rb36Qkm1VpjBgfo/i6cVYXy0bwYuY?=
 =?us-ascii?Q?XbSxFD6w7tkw8UETI5kFN08E46knQ7pD6PU7xYlqVO1U/GeDQ1L3I8hQJPyJ?=
 =?us-ascii?Q?VtU9t13NbE0kjmeYHe9hU07nt6C5zWIU2jZo69hKtPZfXYqA1cwm0BtnXZO5?=
 =?us-ascii?Q?jMHu42kGJ3qIr8JHxUb4dL/ZQ/YCKjG2MVxLCiicVBc/ADbxFWCgrl9rxg1+?=
 =?us-ascii?Q?YAxQnyspJfOE5lCYn2oHQ2pXcZg1CQWG7zlPgcTKCor+lJ8mwd7CpAPJ/K08?=
 =?us-ascii?Q?nQTFRXY0PL8Js+lMSrNzBUGfl+punv5FJlaLvXrccYL/CP5zS2LSQzBqvOsQ?=
 =?us-ascii?Q?0K9Fmrs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?flaFQJ3Nqp63MvxNr39W0R/xAyen8P2mTur3D8inD14xADbwbqRlH8ywwBMZ?=
 =?us-ascii?Q?IdKNsn/J9IOrB7cPvpsIBKuxJ4RK2+jA/rRA5kyf63NeooeVlRR67CUvO4Hj?=
 =?us-ascii?Q?DvVfC2LosRMl5usS5r/6VMIsXMw31oWM1kEDeopWb7vrhJIpk9B1HPTkunm8?=
 =?us-ascii?Q?h8IH36LPqI338Tffm/xZ3/T6wKSZI6rEzt5gpISdJFtoQz0CI2+rzwTM+myw?=
 =?us-ascii?Q?htiFfxvjLcVvvb1UkQDRcEvEjse6veAQT867pYozCYq0SMMJ1UXShWA6+wyJ?=
 =?us-ascii?Q?tIB3fGjjwRAVLrrJhiTybRHiIOSdA6+l8/Os/b1zNs0MTT0DjqNr5hwaOafP?=
 =?us-ascii?Q?wljlk7dLLWFxYNl211yyjwMewAajQUtjqoU9ObQhZyXkvdPwhHApfK7X0/3t?=
 =?us-ascii?Q?QkIhFRxbNyLGXDwcEQxw6SRMgMEeJ9bCkkbMnLaWAt6N6Y8YXN5sD3m3OIM1?=
 =?us-ascii?Q?ruIvdSPIISw+Iqb2q9BJzY3bCs47NINZ0mvEwqDxHW5V7QdZ34B1WJVbfi0N?=
 =?us-ascii?Q?2tB2AQO+R1FXO3MsFNyCjeDVFgxBm6yERJqZGqjV+nPYre9gqXPjZF8Osxz3?=
 =?us-ascii?Q?ViGm4O6ua+wY9+ViU9sszrMME2XCpKu0s2ePAw1nkvvcfeg7IVXlQ9COoZ6t?=
 =?us-ascii?Q?J3xl/09DC+T0owFOfT1/KSkfSQ7THfPSEjL1Wgwg0ETVoTN1Pczd3oXz6arg?=
 =?us-ascii?Q?moM2IBUPvlUyGkh4ZedVnNcdOmGw2u5r0z+9eDCz6WFbbPuwEFGnVtP531jl?=
 =?us-ascii?Q?BRzErEnuPqVSgcQf8x+LLbob0m4i4/I/5Skm8GrJYH6oLO0s0ygEm+Ufe5kT?=
 =?us-ascii?Q?uvcDzmrcdqvxxfw/3Xo0CY/xjQZMq0vwLk1DN98XoxCKpzPCiPJcvqpFqwBQ?=
 =?us-ascii?Q?l/qgvvA6+JbunB9RJHPMl/HhOGtYUbLJRRxCtIKHNnTLcWQp0YLa8AML7wQb?=
 =?us-ascii?Q?uc3JUKwBYzviO06Dv9Q0WWcJzWW9OpAE8d48iutcDf3htre13LIUktfWQfh7?=
 =?us-ascii?Q?ireBg8NAMWFHzYxrLz4J416vtdMJZGqaW0wd/MbQoth8TZAtLAzRNhSsbDsr?=
 =?us-ascii?Q?wl+8iXPgI7E39mrQ8bkamSUhgf6inYNLeBh7Ga4XiQPxRv56A7pc6VS5hGFw?=
 =?us-ascii?Q?zmSWXMDmFfVgtu4e94le/C2/L2HlU0K2U/TiBqhgvcia3BLQzZodbVJV6ju/?=
 =?us-ascii?Q?5kxbPWMzbs2N07f9kAq1erQXB2gg4UJWgla/4xOaIU9rW46JLhAfQ1ov3eiQ?=
 =?us-ascii?Q?WB89/uGwv2aA/SnGMKtUoXxgj5oEUOty/5Q76oVJWSRW6kCPB+q0UFNlADOi?=
 =?us-ascii?Q?gCND+sLC0f8DgewR58hnQ6BSxakdE0+uEt6tYGFmEoqwP8hPzyw8U/8lOD+e?=
 =?us-ascii?Q?JE9v7W30FJqButSGD4Sh3xTPMy+KEZwuMN2ef5fj2rYc/dTqJcZEJ/Cs5oG0?=
 =?us-ascii?Q?DvsPS/s07WGk8eJGwbPaS0xrrZyDsN3Prq/JJJAi+f9hYlB+33Z5oOIkfbHJ?=
 =?us-ascii?Q?lZFRoiVVDCAZ62gL2vqAeB7+ktZ1dfldYJRx0q2YtgGeYqveonxaSmwVX5Od?=
 =?us-ascii?Q?qHjLxT4Zv5hBIsllH+YrtNCPq45vKOwBKxsP9sTU5hnW2MAZskO51PjMDEc1?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97481668-7ec9-44a3-f986-08dd084c4cd2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 03:43:15.8188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2l0RkzyuJxRaHnjE28HoV3copZSCICfqVBjmEQF5kTYcCcgIOC1dxxm35kj82lWBgBFc71OY5fi87l5FXRB/yGDXM4L3oUouJaLGab1cGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-Proofpoint-GUID: Zt3kcRvFWIrtvENSTfL5XKTNtuhr7Syr
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673c0955 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=t7CeM3EgAAAA:8
 a=jOJ9hsW5_aW4b6qvCc4A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: Zt3kcRvFWIrtvENSTfL5XKTNtuhr7Syr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=571
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411190029

From: Xiangyu Chen <xiangyu.chen@windriver.com>

Following series is a backport of CVE-2024-36923
One for kernel 6.1 with [PATCH 6.1.y] header
One for kernel 6.6 with [PATCH 6.6.y] header

Eric Van Hensbergen (1):
  fs/9p: fix uninitialized values during inode evict

 fs/9p/vfs_inode.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.43.0


