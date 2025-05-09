Return-Path: <stable+bounces-142969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853AAAB0A59
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F433AEAA6
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35926A0DB;
	Fri,  9 May 2025 06:14:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE67269D16
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771280; cv=fail; b=DHiCeY3Yl4TspnxAkrMRFuO0yb5iK9bAIkVgXgwjiouDf2CUa51nzjuDDsVjnO6JJnJ5ypBLiasj7t45mjHD+a2DZgAYpvrToA+5dJbEMWvvmTioPaq7vFR3lu+Lm4gQjs+5EpZLMU/xuTwKc4T/NX4e2WN3/rGYH1iUs3imzLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771280; c=relaxed/simple;
	bh=tBEtMCwBcs2pGOQHxq7ap9Zh5AhLcsCrVVrND0jO/Js=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YPfjE4fy5cZfTYVK5z9GSWMRcP5A+SR9dwPZFqzMYtv2Sk2yqsOyFekD/UpeaJ2u40HItmbtDFt2HDzJiIHoPYgrlXfNiL9qPAzWD2QaCb0qCobiuPHQAke/l+mTHRrjqnmf+2Vb+zfAXj6blyhZbxkCsLMU1SQ4VEJc+LtkEOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54955ce5015854;
	Fri, 9 May 2025 06:14:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46d8c170ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:14:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXBvFpN+si7wPL5sMPIVnwZeZEap6wDa6wd3g3MG92HUYG7dRYxPxjsVtHeYOn7XF2HYNROLfpxT9KmsY+VXR0g1ld+tfFMLBOjQGUKhtYeltqY2qFp7Tn3l6gWyXsocj7ILOl2lWEq6TjLQ7pVvE2hBXhWX7Y0ZzfnKInOyS/aPvoyiltd6dWUOKNcDlKHzhuwxSVnRsCgCEZg4Yh2Zvc1ZJhNANlbKMkSGrnU/SLmNpgfMQ85yLPahs3SccYYI17FMRmWtPPcuGBB2fiV9fqEtWvmHu1QVALWYelJBt+LI3084Hnk6mAwbgP9YItfANsWYc38e+T2+VQdOhxa0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCMRHd64wkE5PKdPudYkhPgQAAwxvRVuPIGk0sSre20=;
 b=VAKpkrDDCpYq0uJLdqZs9Jr7/Yv3Lvygah1N3B0kZQmFYnjBCEJL/fgXm3V3Rl3LBFprjArb+0JjBpLmcHdJBVT3bQhrsz2chgwhJxriBaQBaDlSCOMmKHLEAHHmIK40ljBGlvCEFEAB8lPE8k70FrrxrMBBeGpqnIuqBKJad4RWWtC2GpMVOuV5+tK7v+6bNIebLmKmH1kRLZAlNB8XpDIB5r8WBSRJtll4gpqxJTd5SqEmSV33KbgKtp3ZEx2ih6Z3WB31l0p9gm6GnjTSZB1JHyVS8ojGeK7yHCEgvoFwAhSAFCsNbhtLaJC3jOugzt7VqD9f+I0iNnbtYqoVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 06:14:31 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%5]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 06:14:30 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: adobriyan@gmail.com, kees@kernel.org, sashal@kernel.org,
        Feng.Liu3@windriver.com, Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y/5.15.y] ELF: fix kernel.randomize_va_space double read
Date: Fri,  9 May 2025 14:14:15 +0800
Message-Id: <20250509061415.435740-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::22) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 606c12fc-9a7d-4fd3-09d3-08dd8ec0c235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3wpmL8dpdyA3rC2vUtJC9SvYASmYEhmSKts85Q7ZToz3RjgwOXmlUSqLFEXP?=
 =?us-ascii?Q?p8tl30lSyDv/DJuKbejOmK5bCfxESBPrA/IvAbthcibJEySfbyT3ZTGo9FeO?=
 =?us-ascii?Q?/oexL4EASzhk73/b6eUkzjsptQCzuvFbilexPusTRPVbRDMeFtx7YoOM7dlM?=
 =?us-ascii?Q?x3Y2QcX+4Z87EsVDcjCtnnSGj0fD9mOOJZzHabeIJSd2mYgBPpYubHGPuMwQ?=
 =?us-ascii?Q?crDsz5xqTvyXCBD+SvrQXv1ChsepAN8Mr4BGAODxGrTGROD/Ujg0IYxzP/Lm?=
 =?us-ascii?Q?107R9Z2+sHPR4UUEu7tUJfqsWyOFgCVVeasSht0/j41s+1V5NOeia+XWPeUR?=
 =?us-ascii?Q?5Wtm4KwTExEwh3xhDBsyXopw8OpDAHoz15DT7/kagf5zIggJbiglLRh5Wynb?=
 =?us-ascii?Q?fppArpMlggyMUWsuQNhl3Cbk4A3OAbAvproOlnPoAaa6+Ynx7eVOEop6QCJX?=
 =?us-ascii?Q?nC93hixb77cAA87IPNtcHWtJHGDNy+FdXPeHztFTqQHZ7VSkVDnrcnPTa5vg?=
 =?us-ascii?Q?muobkAyLZAzQzueD7w39R9p5299uUmvKnK7ifOaCipgDfyOZW0hj+MkswxDF?=
 =?us-ascii?Q?FGCotUnQd4i2nYvz8KwAUEzBx350Bv9EsGFirTUwiYyqNW1qEUWmVhWL5Upk?=
 =?us-ascii?Q?iABYo0sk+6UZJ2paRak51V304rEWIyrEeqey+Ue4VcCeLp7c3Ruw4HsXYrUj?=
 =?us-ascii?Q?bRCBFk4pNnxlloKmd2u+8zqaWTsad3tsuRo17ngOkZnm4gj98ds/QV87cIDy?=
 =?us-ascii?Q?XgN+5ClRiaLhjlNznyVqXnwOf+u1cre+97FATHASh5sApUNiEHxZeiQd9uEu?=
 =?us-ascii?Q?ho08Wvp+dpWe5/6TkG50UsYg/XCWI4w2iBaGpKs98GHd3eOdGRoDEbsbcBNg?=
 =?us-ascii?Q?SKqxs3AoXR7GsFxc7Y4HXbrS9N/TkoVKvfk8S3YFReSwWJ5BvGhH096i2Fb1?=
 =?us-ascii?Q?HffqLlWQ7HQhaE9bIYQ+8aKFHRgBilTnfYTwiYjyj4OoNDMgKGq4EF3NI70Q?=
 =?us-ascii?Q?+Cm16/X3Gwpta8Cg2HPrMM99W4FWO3SxDtGiFKwS/O8MxO2bfbsDCUoeTWsY?=
 =?us-ascii?Q?UcskzmE4bee/5A5eLeLdmDkZewSjuXsiYXt0DDeTGNBYYdshvl6yct1eYsJs?=
 =?us-ascii?Q?p7rQ1TPMvxsQDAofi8jtQCqECiZP9ZJvolHbUMjSVc9irCrqyNKcRAOVQQwC?=
 =?us-ascii?Q?VCNhHWR2aR5yAJmMTelLToBudkCNRmo4j75A0kavMS+5qWnzeFQBz4R3S6/5?=
 =?us-ascii?Q?9DBOwhZvo8Wd7S7lrCtNqMGCTuRnNIv9DcwEBlnS/gyiJ7HaEv9SmvQIFUPN?=
 =?us-ascii?Q?9xabDb7izTAuv0z4MZEBtT7N58KRdx2xs1vBWzK2kWp0oUrvM+ZhcA4aLaHI?=
 =?us-ascii?Q?r9u/ayBc2hiJv/mOi8S8OIt+Qu+Xgrq/En1M0eqmoObBAVeabyQvoMhi+h3q?=
 =?us-ascii?Q?FW11PW6SSP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCoPIo9Vk+F+O5Z6GwnIed8987W45tNE9nkVDc2fez7TLeps+eAhvODahP30?=
 =?us-ascii?Q?YqHsWUx5G5kit8n7DafKTRIH/bq+fokeEEt4GydjNwUeM0gVkneeXDF4rAOr?=
 =?us-ascii?Q?SsfnT60RK26vkJt2IRmFx0vwzTiXxJ+NcfQMd/WsQBxDl/UaXrh/sIiFf7/S?=
 =?us-ascii?Q?KbTakmYKE3H0IvWDlea6U8eDXnifuL+VW/iqsccqDhh4ZYgq2IUo8Xr6n+SO?=
 =?us-ascii?Q?S4+rgOQ72hn4N5JLW8zW4TLg2CSki2qpeNnuU7YFS8r93volY97aGNLNZObC?=
 =?us-ascii?Q?JJ/+CBlYmcz9a0iTILYvW3oTuIntUDkmcYwmohM5wDbEKLJvKu/51jv2OgJO?=
 =?us-ascii?Q?eV4gEr5GF/0RLMzVWMP2AW5ERDLPILwwk2mLI0IC2h39bv1LCYt3AVIZg5Zb?=
 =?us-ascii?Q?iTlnExTF2LVUuv8GkWwR3SktXT7iKpOWB/v2le6umgUBpWVzNs/VEW7va6/w?=
 =?us-ascii?Q?9Mq8nm8jbMDO1Sw2enejVCEVg5PWUkDfjWH3kG+i8kzaEUwMajqPfxmijxKw?=
 =?us-ascii?Q?8dYpCOKzljnj55CvNGPfTOWzJcShFUo05vARIDbWv+0jaGlZvXl222L3Afqd?=
 =?us-ascii?Q?yc/ORipHfk1Vdr1NuzhoRMusfyCzCuQ8iQJl5a6Mi76hNW4YaIO296Y+qeYy?=
 =?us-ascii?Q?9JCaV6YwNU+8J9Ocdlqnl5hscb6jHL2Sn0+1YfXnU/K0TSP660u34aF/56C4?=
 =?us-ascii?Q?Kh+DGq2m49og6F3v3HerPZB/bo06Oouu7BrC2lZRohlTj9ON9oc3yrhfgepI?=
 =?us-ascii?Q?nTcqLXCsmWMlrGrhSW+jK6VqEEN/Rw/+pIggvrq7eKVFpWdBYIbNazf9BrOF?=
 =?us-ascii?Q?szrjS2V2E4Cwia+eldLMYaQ+QzDt0wUszc5RMIh6bgMonIYBqn/IruRHaK3e?=
 =?us-ascii?Q?NCLhZb/zhkS2+/Ywfxq++5ZaSdRLCc9uaIpIT6EqnUnbOMDOxjGE9h3ikuc0?=
 =?us-ascii?Q?JB6ZsOpFnt9CWGWbq4HmQLUyuvquZPT6nhxHazu//8N67NEpkIAY7BFbqTZv?=
 =?us-ascii?Q?Ju4p6v034uHG2vHq+jbAFlG/2CW49f7ezUkyPxYJ4I7gndpxdCUJEvyr0rEe?=
 =?us-ascii?Q?IKQ/GfaAVlBN3OG77ILQWMRZFC4v82a7uWg++5tMsvNvfJGm64vS9JrjZ8Ex?=
 =?us-ascii?Q?aN+LtJiO3+1jljgQioE0BbSj14lY5PgFDJ6UP0f0+VvwO9W6VhS8WdwdztiE?=
 =?us-ascii?Q?II4qTV+OeGWEYeCKyZmBE0scC5ogBEesjQSgpoA5nVtuIwr/cSe6zqv2bvqM?=
 =?us-ascii?Q?onpOEpSZ+8JekStlWtsC1AbulwR2egWwq0bzTr8pLCjgwzML9l9Ca51EnS3x?=
 =?us-ascii?Q?RKdCGsFF5DVDiUebdSxpn14Lgh36diV2icuHsAZyADqb2OWD2HaFQn9+BnZ0?=
 =?us-ascii?Q?zSupppfA/vPWYsUvf3Uyf1h87mFoL6kuFmawK8QA9NbR1O2+NFFpXUB+XCwE?=
 =?us-ascii?Q?jMPWZ2ENaQS0eEVwC492oWPY+SztQxbmk3c2RGP4leBrbj2HsgY5CnPNdPs3?=
 =?us-ascii?Q?OhgG/UU2tx1XDCsbGRKcSpztG+/UER1rlQTFnMY0NQTTy60BQFV7Szaex0sb?=
 =?us-ascii?Q?lMl7NeRo1GXM8KMViRaCPGqT1o10zVb8NFrloi/i?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606c12fc-9a7d-4fd3-09d3-08dd8ec0c235
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:14:30.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /osLiVc+xMVFrnZy7cLqyLk9QNbDGCpqjzfnRFxQ5UEuDtZWy7CDHCcnTrewacuLGykIanBcRwxwVcGx3M2AYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-Authority-Analysis: v=2.4 cv=NIjV+16g c=1 sm=1 tr=0 ts=681d9d49 cx=c_pps a=rPWB9DPlu1VaKM/QD/CSBg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=bgYl3rnbyDVgr-BkJFoA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: SdThFtwlSHLeG03oso2jZNa0euZ0r97b
X-Proofpoint-ORIG-GUID: SdThFtwlSHLeG03oso2jZNa0euZ0r97b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA1OCBTYWx0ZWRfX6gfixU45PtBK 78tJFC0SXHucDyixMgfhIoKRko4CxhiClkOtd1iphZBlEYIwmJKC11+DmBAPlizGfT8lHSLqEBL 4ihGT2ixcgFKt4huhYf+IIdZBTrqcd5PVrbuvUxdRq3ISknDiTyEIV/LxSW6bX3LNDP73JA0mvV
 kfepX+U8JPlmzfiL05+HnG9A3MgGqozZ+YOzh1Odg0I889X8nY+hcPN5TaiQXuJZqAyJUPhR7qm MoT2rXqcNNxYVQdkqX0TJ1Suve8jUJXI0mlt9oj16WZf9NbPJzpd2RVyCu/2/czvrJPTc04NDdD 3Ox9v1ktQRW9KJSDvcJxTqB3pEQmdyV1qk9n8pmXF218TWip4HVd3nkmxvUcGjYjAvalDODbp8L
 dAaVCW9DFx9/wNf9tEfF0iRMTc4Nl7Bkob+jlbqKFIIUszx8W81BjVkKXpdI8SyxzLum0jD3
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090058

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]

ELF loader uses "randomize_va_space" twice. It is sysctl and can change
at any moment, so 2 loads could see 2 different values in theory with
unpredictable consequences.

Issue exactly one load for consistent value across one exec.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 fs/binfmt_elf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 11dc833ca2c4..a1f0dff2f818 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1008,7 +1008,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1278,7 +1279,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
-- 
2.34.1


