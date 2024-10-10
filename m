Return-Path: <stable+bounces-83303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD0997D99
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 08:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AB11C2279C
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 06:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811631A38C2;
	Thu, 10 Oct 2024 06:50:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE118BBB0
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543025; cv=fail; b=AKNc5UGO4iHtF1L6MjIy5vbNJ1pBt/Mggu8jCZBPGTmP/coot/o8Fv4Z0M0eubSFbMmyIi8o5EQxE5MIfDtTxEwfrI19KP5vCb+iTYweTkhI2YSAudHbEvh4rlKm1tJrzgIyFRovF3+cCzibZmbCBUYga2nvPgonqYf0GOyCuXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543025; c=relaxed/simple;
	bh=JjcdcmEwnw4iEAZUlc8nJ8n8oE1eMflWTLwuf/iecng=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ApdpkTyMJ7d5eWOzChMd0km1snCVwBdv5uueVFTuPHa4Z17ibfFUFXZ4bxO1ciLPbDlf2LHkqaK1A1/8XyoDZEZ4UOjZdMLqs3SgGnVyTzZMkzYL166NHB9cFY1uTH82qA4SZ4fHzPm3mUgkQO2XDa0LoCPjw4EeWSPyVxcaqYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A5jBhL019621
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 06:50:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 422tp45enp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 06:50:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRdXD13wKDGtpFKj+4GOn6pGEI0YI7BzGPtLqSLdVCjx7q3+yZsCAtgYY7kVlamSHzrNz2Tz/zGK7k2O12IbNG78zlRM+E/INk4fCiedDUJwvfKIZejPzDLK2+1Ps0J4Add1u8U2V4dh6y9V7lssvSEk/R3QmEoFnez2jCjdToM6ZnnJxqo2TX5kOXYGAemBGq2hAQ+eo2xM4uw+p2pfB1Nuh5mgcAOFi5nr/kC3gdmx/wXaKTMBdvasGLWBhBtATgfghiJK/YmSiZP+yXopOkYPMW3dUFXMYQ7XMKNTWGA7LwA+gA8Q4etW8eduAW0ujUv0QRT64FWlga9G+q8TIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOJPNAmDVjxej+g/QxjHRfysdpCqLhA/QPFsLKUXf4I=;
 b=TxLufkBlrKpzlVPBwhHsaIVIOOAuyso+GYQt/s+IkgyNvFpcUYGgeoTLZ4PxbZdTvGU8ZsdZN3/BqGbR7Tk9rnchTPGizngyrvNDCfjmZYvOjnHBvgFNs7lrxH0KYjsOzdWoNebP4W5hGPO5QxfaI0ZRPY+zW47VN5J7dYPKGRR5lZYaSnYEZV0O39v6Ll7U6WrVmjD1oQZAJTaVv+PHMq/5gdmYtjp9RPt1KyeUK9vVTaJnZySWU7+Pn37II3p87jJ3H0fFGuOVkZuOvQ4lOCZ/xqmd5iLjYxJXU6wuO8FLbdHbGjSmQRXUwGAp6qZx5GQ6lNAaTswOK1mvZ4J8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 06:50:11 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 06:50:11 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH v3 6.1/6.6] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Thu, 10 Oct 2024 14:50:09 +0800
Message-ID: <20241010065009.594077-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0213.jpnprd01.prod.outlook.com
 (2603:1096:404:29::33) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: e3cf66cd-9c1b-4ac1-6f1c-08dce8f7c97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QbsPmz1GetNV8Ig3wxa+PeTjqHHics9F7R2JEsUExSF+pDzFg9Co5IeP+7I5?=
 =?us-ascii?Q?YUds+AJvLAmRVmwV5QFce8lDhUvszrFKYQ3DWR+C8x8hxVKUTPwUZ3LKhRsO?=
 =?us-ascii?Q?OvMTAmQcPTza9AKfn5TG71zS8QYtqoqwlmRIdd2dwvs/I6sMP5T45AfW3GL+?=
 =?us-ascii?Q?PBDr+GoX+nJIUAk8WeqKoJC3V3ptk9t/ktk/T8nD3zf6WnLOYui5F5uGEi5k?=
 =?us-ascii?Q?SLF8sHYxSdTRMKng55CJe9aylXlcdrQsvSEYpOh9LdSIbDgGabaXkPiuUpIM?=
 =?us-ascii?Q?OWj1tlqdi5aJM7huqIx1LI/4XEJKYd9ZjHnGCvb6XPqFAGE1jl75uRBPbvts?=
 =?us-ascii?Q?Q3HLav+o+HlQs3GZxFBOs/6TQH35yazNSffpswGg7EHERpHzdAFwzGaA7G9M?=
 =?us-ascii?Q?ZCuNVqfFIlqMDseo4A86lCODrPS8kZREypnbR41iGAjNRnRf1VVd4MgNU0ws?=
 =?us-ascii?Q?N+zPMyZFGjDZsWCHbe1jy160YcQ45SUrj4CN88Y6ahOwWYO6VjtZcc+QEmQU?=
 =?us-ascii?Q?wTMy0xJbIWbwNv9JUNmmAEwGXncdUBABzjBqGP+EC1bXR7IO81HjvHsF7EoZ?=
 =?us-ascii?Q?45SlEwWXGW4vixgV1rv5nDLNBBubMP6Ws/7cZXFdqv0URRmLeae2g4XEEsIf?=
 =?us-ascii?Q?03V22gI+/urZzEBclGND5kojUlObOZgA/bY65Q0iurk2tHV5IwgeIE6g5gc4?=
 =?us-ascii?Q?WTPw0vBvhPPRSNmZo5L93DOoeOCl+3JhNFYUwD9BKIu9mAgDUfd7CnVkrWLu?=
 =?us-ascii?Q?DMsOTyjTjtCjpoiz8rBPKiN4kBTpWeHZclcMuKHuB+aIqBocG4ZvVQCnUqMj?=
 =?us-ascii?Q?2k3Dt9jFzB3BG8NTufOTxLWx0lz/uTWo1EcGbX6AcqNXS+YZMVpe74DZe+E3?=
 =?us-ascii?Q?8dE31G7HnsazvwKsv60+zASMXgv5DZF1qplUsHIzHWeQLr5i6WDiHghXIDGR?=
 =?us-ascii?Q?ekkjqrO2tA/H3g7TFJvDZNefAP1FbOx4SlwcWYVHp0fTT0AyANHf6c6qEEVs?=
 =?us-ascii?Q?A+gQholuw7EVyFwmwPrQhp/LyK5/nv9KIWXClL03MJa0dIMZX2RRA0fjMIP+?=
 =?us-ascii?Q?1nm9aV3tNMhk/ScutXHt9rV84sci/Hf09nb/Xq31qSjNcaRzp9sg5cdG8Fim?=
 =?us-ascii?Q?J30erQUyNMEzrDtBQ29e4VWu5LJ6XXC/nFlZKG+ktiiVRHqUEaRVjqex7MB0?=
 =?us-ascii?Q?Rt5mxi4n36gd0fK4aTpXCNXi0rAPLUo7u/Xbt3M7QpIZj31GcdV/Lv55EuJr?=
 =?us-ascii?Q?Ka5XLuIWslv1klbNPCIYpbe6bnSJPbDUb538C/WLMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SlSYNSoj1xJN1zAVdAqlTnZ9QL3N+3WABh8h808DQFYXqOXx3wztSkMOnWT6?=
 =?us-ascii?Q?/oSGyUWIrto4Df8ACdbR5tB1OEHU8B4fin8Zfx3yqjl6Cxf5mIQ6ul2Vj8iu?=
 =?us-ascii?Q?Ed0yql7OS7bLInJfQ/9GtR5KXOw76HE9Q53ROevTmyQcdYu6kYpABoBWt/cq?=
 =?us-ascii?Q?HcbyxAjCuH+wpynPDeF8T28xAJ4lmsiXkyAyamzRypZPinFdxkeK2LCKnMVZ?=
 =?us-ascii?Q?Jte5bAGC/H3C2H4IVvzDSeOA/cHoXEoC5G5LH3lOIpdsYux6nAAcinHj5uVc?=
 =?us-ascii?Q?fDeRB7fA8qKV83VWzUB7H1iTEQtqIIgFBYH7u6N4THl9mWlREn5hwFeIzjB5?=
 =?us-ascii?Q?EiKgAQenuYLVPbzJq2pMOU3zSU7flUmpYuRjMcZQFq5WEjBwpoY9gVnumxE0?=
 =?us-ascii?Q?DGM2HlJYabSpc/Q5Xsc3kfzxoVM3vcPGBwPqE82wxILV4UHPONpfAUP9+nVa?=
 =?us-ascii?Q?7gDUPDTcGuIDc3C0uJ2Tk5pnIWadtFjdyhN4tW/6FcOazAk+9qVED4Te7sZ/?=
 =?us-ascii?Q?XCTyrF3sPohkEMixe7s181JNMYueu0+0WfrXou3cf2ZjeTaFh9ryf2aKNRny?=
 =?us-ascii?Q?ZUZyLqLbz4e1g2cK8ArVHA5jy8nd+RpWl1z/B302yCmFU34rbi40Zrm0MyJf?=
 =?us-ascii?Q?w/NvwNlyTXN0kN3ZgHP0bflsN8jzX21QciAS+HhnqPV1kO3oG91dzP910zjU?=
 =?us-ascii?Q?Im+yALhW/8dkA89nzbsJhFsSvKV21FSjaM288c14SgNH3wXn+ACSQebP5oLv?=
 =?us-ascii?Q?1ilcAvjHNlpTh5mAypHOES5ULVv/tzyIZKBbkkqkwVMZX+xR0cJOkjCi5+bx?=
 =?us-ascii?Q?dcTHvkYmcdczM+b5i+RhZqldrAdYtAVxdnwuZZCq9mAb3FyGo4OVLR31kIy0?=
 =?us-ascii?Q?KZzyd+fNYl2mK5Hc8Gq8s0HR50LCtlBIuRShNWkYAqfmetK43Z5K0+w93KqW?=
 =?us-ascii?Q?th2lPWIleZv9PuxzZl3UpmovPh8jKJzRpHAgskA7dTp99F/8IwWNPTHov/40?=
 =?us-ascii?Q?DXUuNGBq7DxWGlZijNHiDUaLbKM3prdwpVYzovTim+EbBgn0p1rgJFEW0Huh?=
 =?us-ascii?Q?0o0w1UhiT8yAWzXaEllcN0dfJGQgH2rv670fzkzVseCKypWrc2ttMX/NxHHP?=
 =?us-ascii?Q?LdqWaM9t41mfzgiG0uKteYWiWMHuziW6M/cVKiZGaQoQEp7u/JvDX/oaWzOV?=
 =?us-ascii?Q?0m87HXUQEwfzMs/oZxdFEij8Z8MaY4I9bYh9oR9QXOmdTQz+A8JR4dNCyFnx?=
 =?us-ascii?Q?SraAGVAcE/GBHw6ncJHK5fMykTRmO/kIXVB9tXlNA675ftUxcg1TNJRVEd8a?=
 =?us-ascii?Q?/CwlQh5/0YTzTlceIAgfMzKFFN8sR18jCyWB/6kEeHr91W8b+6tsv0utGtT2?=
 =?us-ascii?Q?Zp1GNWT6mEtgCGI8GOBgVj/9d7KKvr1qzXP/aGBnQRznTNjiK7p1UK1nBjCZ?=
 =?us-ascii?Q?PxQ0hfBfwxgVj/DwQtUvaoouDri69BdLo0a74FuIPUy2/Gay9384yMqTe25I?=
 =?us-ascii?Q?RZ/RRz5Nrce952Z7CNMA/IcSjZHNj1SPG7TLsotpoeNZeFH19phhDVW5KWjS?=
 =?us-ascii?Q?ZvR25Rnk5djGbs52aQSV8VVITNqsAG/QJFUtquret7CcBctbhhj5RY+Tk+Pt?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cf66cd-9c1b-4ac1-6f1c-08dce8f7c97a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 06:50:11.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5ToEnuePEB0zxTxgcYYD4Z9VDEDWHWXZyt2VCjm6jXftd8NgkS3a37pClffeBtBSMZ0sym2y7UstcfqSwiPELEgljyNxnk1/tBnqMb7A6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-Authority-Analysis: v=2.4 cv=XPtiShhE c=1 sm=1 tr=0 ts=67077927 cx=c_pps a=mXs27GP3B2XOU+bPH1EGlQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=7mOBRU54AAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=cN9O5nbwS3Kv1SZHnJYA:9 a=-FEs8UIgK8oA:10 a=wa9RWnbW_A1YIeRBVszw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 7r6bjxmPi-w8WNWWix4EMT-l6-FZsbCf
X-Proofpoint-GUID: 7r6bjxmPi-w8WNWWix4EMT-l6-FZsbCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_03,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=885 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410100043

From: Kenton Groombridge <concord@gentoo.org>

[ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Xiangyu: Modified to apply on 6.1.y and 6.6.y]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
V1 -> V2:
add v6.6 support
V2 -> V3:
add commit id from Linus's code tree
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 62c22ff329ad..d81b49fb6458 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -357,7 +357,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -367,34 +368,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.43.0


