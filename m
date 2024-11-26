Return-Path: <stable+bounces-95522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA69D9627
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F7016716F
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C601CDA04;
	Tue, 26 Nov 2024 11:23:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AC13CF82
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620201; cv=fail; b=q9PWtDd3YtfbMmpMTeEMbolXQ36ghoBKP2T4Hwt/fs+oXsrgLN6kjp/Ti/onbWWrhsH3eqhxxxcPLe+R3+aZnRHkbbOsLxnL7rAAsEqcDOizfVXhXwaMT2jHZZr8TzyXqNvVOLIbZyyj8JcmBB6zKx46cr7qjhwaiOotqtVfPPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620201; c=relaxed/simple;
	bh=fi6TGRgOJx7GaUP8Z3DQzppuU/ixQcfqrWx/uljninI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZDxr/DXtlUt2zMg4V4bThvabN++cOBRsg7a5/owwXL/PQFOxJKMGSwJA1TtIwIgZ9y1HGbjPeP42oECHLR6Kn6iKMJDfC/A4K6lyfl0pJNX7lzA1Lfag6A/LXzZvedBO1UVnaJaZgayM06PUt4OC7yRdi07j9jLLhI8Jxe1P0fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ8O0c8011751;
	Tue, 26 Nov 2024 11:23:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491b6mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 11:23:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eluh4GBmNGh5mPw+rvPkpJgaOHfVFLyVY6b12S9huhPig3rhkBfHxXqcmpUfixIKdDNquH4NTHJ37h6MaqDEILG8iDC9wMLUtokA8G7TXTY/TTWrIgRoPBWoBWy5+0sQmysrHepgeUNVeEivM278Tb8nHm7aFj0P8VSGOKwlAw3IqrON9SnQAGRO6jWjaVQH1ewNudtTv/yrVtmenflUy6sS3X2tZm4OZ3BnokLk8/FiV58W5S1dqjkopqQr8jLD9ixJBXY+zAmbWIh4M8JCHNoN1Ct+wCmACSGlfldfC+70zVR9WPWOQ7mDTpNUhqXz9+ZqabxTvXXKgwmyCV+vSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWG+sdmcP2IYSb5jyEA16husfOVn6oyVWl+XgeMemCg=;
 b=zVWP/e4FQaHAPCFK3aHCXHtGa2MnAvmEebA4JLvWZ5kaqcen3Sp/NubpR1qkwd2z+05/yQnQfxOOJULoAyu9b97Hpkrj3eE8Jkkiwg6V6HtzRKxpam3JaAfbWqKRk+Uip08He7Hcg3VT+88Q/+wh5k8bxdyLjrH77S3mW05CwzDCNKqFuPdCJr+ZmDD+01Ott74rNTwbU4ha2ZfVyzZI+NePpNsxVbRgEeHJHncHmlhjpnqO2RtR+G7+1Ix2O1rtlphh3YhqRRSDvPHjaXdsXwnfujs2l/4NTzHZruGHU+7ezDrmQFX59cla2sdDhnF02bdoZik/wJTDLCDFQuApqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB7106.namprd11.prod.outlook.com (2603:10b6:930:52::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 11:23:10 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 11:23:10 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: alex.hung@amd.com, nevenko.stupar@amd.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1] drm/amd/display: Check null-initialized variables
Date: Tue, 26 Nov 2024 19:23:25 +0800
Message-ID: <20241126112326.3844609-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CY8PR11MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a271c14-d2c3-4e7e-3b58-08dd0e0cb581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XO6qpI1xQKLuSuSqY/F0ptfByrfFcwILe2HN7jwZno6cG3kCyfkhy3Sw761N?=
 =?us-ascii?Q?JUc3EQ6AAbp6FLq/Msm7GkYM9C6MkxwwxqX3A32uhGyObM+KU0kSS/V319i8?=
 =?us-ascii?Q?AG5VYcGUtY3cwnEYJZbdbzPGsgcJ6cd9yy4LgIKZrNiacxENcz+hTGRzEtud?=
 =?us-ascii?Q?ZFMsEnYnykCr+n0azmmQ6sq5x4V4kXM/DHznGCajU2O9GmcMH5x5RdfTFseV?=
 =?us-ascii?Q?AIH7Mdxbjhv7GA312lk5bmf75gHIyPHfSWvwG71BXfIknrQDHo/vwVt+IHtA?=
 =?us-ascii?Q?OM6xkuUDuGdP8es+YtHyGxSiMpEkEb4TAMwi3XVfepzpiRbiCWSFn/CuhB2N?=
 =?us-ascii?Q?EzVC7KnojwPp1JWFnJ/UCtrDM93KEzmSF4mUzgJLUIhd4dDvD1ISErGW+5by?=
 =?us-ascii?Q?SpM6ZNcT2jkl/I8rjxqtPexBsqM8NSuTeRbD9wR94p8v7thYvr5hRUWnXmD1?=
 =?us-ascii?Q?AaVH2uONMtUpSBFJ0UOMRNdabbXsLqtbFY/fDrI3RsfSG2JFuVXRVSdv0mgP?=
 =?us-ascii?Q?Lea/eeHpFYdBtb2ezSS2BRE8J/j2J+Yi+kh7fNvC0blLq8MYJmnGlfSAlcWE?=
 =?us-ascii?Q?ouU4vUrHLEVcJXHiZrAa1lqrjyyJZHSmG8OwyvKfd1lqr86gd8Ef1QrXvXkU?=
 =?us-ascii?Q?l+shA9tnrrz4cjusDrOMe8wtZyyOU09/J7COaBBY/faQANT/PfqdzQyZHJko?=
 =?us-ascii?Q?HdeDE9+C5Iv0433IAjqKJmT3J3JNvFOqXgOVU4m581odGxKelMBnf1Z7GZ4q?=
 =?us-ascii?Q?zIsvo1tuCtTFkvraHA9ksQI3s2dr8mReKRy37pQbYXIVuDztVTGsXZWCOB+Z?=
 =?us-ascii?Q?CfFZqT90GwamINgXH5Rs9/WOFIT1/Z6Ebv/Y5fN+aUOhN1dg9roT4jx2tzrE?=
 =?us-ascii?Q?ohuJpBjAqt8ljE1Sp3XsX+VEeju15jna7OU5jXgYWthudE35c9LzIHeZeulM?=
 =?us-ascii?Q?LgoMpCVr/Yn4M6zEtiu+BrNZPBQFrZTnzuPovHIzxeiEk3TUW+ifWynYdWv4?=
 =?us-ascii?Q?uggqHJtcznNNuLCqDoiXO+DU0yVa/esSuiDsHNlYOBYiVpfBgKO0kDuKFqs2?=
 =?us-ascii?Q?lsU6F/6RXEyWPwyEONiLLwbHHkXBPKYgBFHQeviI+hRXi2EP+5rwh1fNvI9w?=
 =?us-ascii?Q?lLHOYpRKaTJdi228Gnyh1vXlgojJTRtMs//OI2bwOddzOQXPte36QhxHHo0P?=
 =?us-ascii?Q?bnOvDak1a7J4RpbeMYxmKf8KkD28rFDpx75KOfVFKbXqzAZDjwttrVp3s910?=
 =?us-ascii?Q?jRsAN5l6wjm07zaXA5808eDwz9MG8UjAFCM62iXaJtypLAmtRB4OovdXYpWa?=
 =?us-ascii?Q?VxGiMTNz5xrJN1U5LP6UX7ObFmHjFFVjWkaXtQk6ncFDS89FxU+/xqHHBz3r?=
 =?us-ascii?Q?YpC3fKY5yZQQMPEclgXM5ScYR8oan7U+EhQ+gZusZLM5V22PAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUhMrl73H5jBPe7zOpEIN1HEn4/VHAtlHQWqPsjq+1Rx4vd0MgTaXwnoqCeG?=
 =?us-ascii?Q?WDzk0eIRI2wZ/UbS7GnxtKSnDFlI30LqGvnUTDKmXRMdzZ7VjhFlN3Oaosu3?=
 =?us-ascii?Q?NWVjkXvEvyzb4X8vQ6j0K/mrn1l3iD/ZO7j1lOsHKk0ZJITZerJ3uv1P0IQq?=
 =?us-ascii?Q?kGukog3XAJsHdrP+3+MuZXFUWfP3C2XLA3nZXuQLkwyCmqM96CAL9lWazpGH?=
 =?us-ascii?Q?iA/14AfoSNNmhxbl/LVOoNx4mJt6O4Qlmf2IpZJonfmyojwQjETnnviFRIwB?=
 =?us-ascii?Q?Mqi2PaH0UMbx7NJox6rzAWiHxuIGSynPfi7Z0YFSgssxX3qS+feLxX0ftNAe?=
 =?us-ascii?Q?ZQPQF+AWZ5PhD9iNHSDXzZypoCi3y7W21128EVB3hnFYPANBP96D7Pv8dl7i?=
 =?us-ascii?Q?//RXheGEtVnRoBai7GOYtsx6Okb2lKb+qQSVIw/2vTycDrMDDmFJzQveCkAD?=
 =?us-ascii?Q?QjpJYAs8uuRwkXwUbgjdgMhq5tQw+qzR/oNpyhLVTTkAO2sSB2xvaFnN7dsM?=
 =?us-ascii?Q?/cT+qERHhREd0wOZDSp7wNtMAZ4oBCLz+Q5C5qJ4Gc/UejMuaGPUn9P43KGg?=
 =?us-ascii?Q?hdpFw2iTVAgCYH6msrr6D4TC5v//CJA+q4YL69g1vQeJQts8Ylboi5Xk7Omo?=
 =?us-ascii?Q?lWnoA/gtBYJm1PJ+MNleymyQk1/dlT+oM/sx2SRlrQzt3CryZj2/crukFZnC?=
 =?us-ascii?Q?H+HYm8JRP71Jk5U8ju/lf+VovIG75CkK77XvVpOH+6bMtg0AnA/fGu/41y6j?=
 =?us-ascii?Q?7yFN0A6s/LMegu3l/gL7YFnNREWp0HXbQWD3oIiz7jZjYdZvzfI+MVGbBFCX?=
 =?us-ascii?Q?EqUeB1uNqMMWLlJYIAVQ+APv6JmHOHzCUlQtP+RwKlwtfzLhGa11swiP+77l?=
 =?us-ascii?Q?XTG2f2BKZDphuod65dIi0GPmdVq6YP8l3+XB9a/wiX1f+nTMl4eckRnbz41Z?=
 =?us-ascii?Q?Sc5F0VeHTlkJc9HWgU4hPYbF6U/0RmdDUKtkdB+uRH57ziXUl/WbeikXooTz?=
 =?us-ascii?Q?47prcLVAls3H9KRo2d+soivvT9RTlOfRK3KjQutyVdPHOjfvd8TLoQXEej8G?=
 =?us-ascii?Q?ovrz70iB9ZU7z78MqxbgjJ98rkfJ1dqlPg0LUDnXbWz0q7UOYS8SqgeFsWGq?=
 =?us-ascii?Q?oTqDIFc8rNYFathsqZa9NMfS5kZlsC//mT0ZaZfWjZgY+mV7fcz6gZ+SCbk7?=
 =?us-ascii?Q?ky1xEwERzw1p9O8GhQeawwktILR0rstOrC1RJNwLVT5iaDDPKshO2Rvu92Dx?=
 =?us-ascii?Q?vPB/tTvfa6hCp70aukf1JSlcbnnv9DmoUCusa1UOsQmzfzvbODUBZ+gFv3Gr?=
 =?us-ascii?Q?lxpOqh31bFVvdL/ElP+d70QkrVJIIEkZMcL80s8mnjBO6zqpe3S33UiXkakO?=
 =?us-ascii?Q?PQjcp0IuLl1mqM8fh/2kIpdVLqzjnREPenBmZSiXUDuIsjXJnxJLZ3dFRMlo?=
 =?us-ascii?Q?V1rAGKZQ5ONnlRST3tDnQAQeiaLuSlnr1j2YaIKHV9lFZtsYXBL1nLpeVTmR?=
 =?us-ascii?Q?/tuxtmavTq5NtYXdjIAUr6ldnZtWKWphd3H5VyDGaLfs1gsphlfs4phjr++M?=
 =?us-ascii?Q?NzYWQ0i+ZcJHDWu/qkEdmTkXwE1ZOi2smVOVHWC8wSc/+uk8MsWNZTdXch+e?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a271c14-d2c3-4e7e-3b58-08dd0e0cb581
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 11:23:10.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvSAi+CyW8ZcWuLPD99jYM4pHVVBRTKdDQ8xV6fMaFqXm0oWJkn4e5r87pY273S8EwtxTSuV0TYSXgggcPycP8QVHDFOwUU6K5lUeEgDpIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7106
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=6745afa1 cx=c_pps a=BUR/PSeFfUFfX8a0VQYRdg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=t7CeM3EgAAAA:8 a=wxn0Iau1ainUtKeLhj4A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: 7zZTqhaUZ0CF3-wFedGA-9ZJM11CxLKc
X-Proofpoint-ORIG-GUID: 7zZTqhaUZ0CF3-wFedGA-9ZJM11CxLKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_10,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260091

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 367cd9ceba1933b63bc1d87d967baf6d9fd241d2 ]

[WHAT & HOW]
drr_timing and subvp_pipe are initialized to null and they are not
always assigned new values. It is necessary to check for null before
dereferencing.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[Xiangyu: BP to fix CVE: CVE-2024-49898, Minor conflict resolution]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 85e0d1c2a908..9d8917f72d18 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -900,8 +900,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
 	 * for VBLANK: (VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 	 * and the max of (VBLANK blanking time, MALL region)).
 	 */
-	if (stretched_drr_us < (1 / (double)drr_timing->min_refresh_in_uhz) * 1000000 * 1000000 &&
-			subvp_active_us - prefetch_us - stretched_drr_us - max_vblank_mallregion > 0)
+	if (drr_timing &&
+	    stretched_drr_us < (1 / (double)drr_timing->min_refresh_in_uhz) * 1000000 * 1000000 &&
+	    subvp_active_us - prefetch_us - stretched_drr_us - max_vblank_mallregion > 0)
 		schedulable = true;
 
 	return schedulable;
@@ -966,7 +967,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 	if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param) {
 		// SUBVP + DRR case
 		schedulable = subvp_drr_schedulable(dc, context, &context->res_ctx.pipe_ctx[vblank_index]);
-	} else if (found) {
+	} else if (found && subvp_pipe) {
 		main_timing = &subvp_pipe->stream->timing;
 		phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
 		vblank_timing = &context->res_ctx.pipe_ctx[vblank_index].stream->timing;
-- 
2.43.0


