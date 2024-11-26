Return-Path: <stable+bounces-95521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B74F9D9626
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 12:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44827281328
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04001CCEE7;
	Tue, 26 Nov 2024 11:23:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B364139D07
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620200; cv=fail; b=d9w6tKRew5hJtMKZItN8h5bSI9a5cusKeQAl8Fg0RY8iX0sp04IqH5gICThA5si3+qA5DUKwziphIWv/lCo/T7KrDVf43BAfMelzy9Ty5ueJryDhMlIq6P3XjNEM7aM6ueJrrpMhJNk1krDHxOEjUh4+2yRoglSiZK4r8EjL+Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620200; c=relaxed/simple;
	bh=leiA68xXVLEX+9A3N8Ummv2r8YXVBRIo5B4NEvJQURU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhjD4BdBSHjezzabLW//qz9rXXA9J04YA8swbNjla/TmtVfq1gMSzWIx86KR2n/nk8PNSM25HZsVwCFTo/OctjlHpK4e78TvKP4XcWUmlAJoWfH1E2JUBXcTxlRQmG0y4AMknMGVCe3ZzWjOKPdrcJLHPOQuMtGz/ZqDAL2c5Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ8O0c9011751;
	Tue, 26 Nov 2024 11:23:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491b6mw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 11:23:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS2IyXqdgspaVWmV3fZx3mflrRT0jjfc3a3A//MjpPdjQGiSbwBmsIaT+8hk7Fva6rgYZ0i2DIGqQatVBzqTaKS4vezWKyhMFDMnvX0sJwP1B6zVmZeqa0q9NWFqNTLZ6GkAuEeWRMBZCd7ySY6ff1RejZdWL/F7L1X/nkwmCJ8RfKOiyxUr4ONMSQmtcxRj5aK8e2vb/ERM61+H6Q3ivpseV3+y10kVAh1HbA2xdOzrbc7Li5YCPRzEpOqVaR5WEOuZpIZdPYikJZZJYwx6x3V00nCLVKfMZSOA/V9iW0Br4A55601lDWW3HKikeRaJLpkgTI5+TsZ2vgX9Dmsejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/B1s9srXE0VQGNSAfm9x57JHe7aKICPZECbryc9xWQ=;
 b=cL2wZbVWLVk6PeCbZQ2foXzzmouqAkyuHOh+KHXyrRaqrXvrbqWOLuCKYoJunMFTU4M0Y+xW9bIt+uoy6SAupb+aKjIMXBMeJoHH+qUKtPqrrlZ4Od8X7hSgV6/lyKHF7rSM1r2Re/hEp31DD2aJkYLOWcREZf3WHs5Z8S+35lGI7EpjzOMKxdqrSet7reLh/uvSLmNSzZ6EtfTBzwxdR/QXfLOuUWrJsiP36vZWHZDpU7QmlR9WE6V/fL7WFv0CbE7TWFu6razf+HU2asHs7J9tr+pZyZPQM/MYcJB3r9NW5L42s72HqAKE5FvPTGJKQ6ssK5cixeFl6ATRkhGSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB7106.namprd11.prod.outlook.com (2603:10b6:930:52::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 11:23:12 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 11:23:12 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: alex.hung@amd.com, nevenko.stupar@amd.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6] drm/amd/display: Check null-initialized variables
Date: Tue, 26 Nov 2024 19:23:26 +0800
Message-ID: <20241126112326.3844609-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126112326.3844609-1-xiangyu.chen@eng.windriver.com>
References: <20241126112326.3844609-1-xiangyu.chen@eng.windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4a44761-e4f1-4d4e-445f-08dd0e0cb69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KrnFt/IHD3pFr78IwruCm7wV6PAawnYmT0KEwDn89qJ9PV9qW/+OWtJo/DvR?=
 =?us-ascii?Q?Z+WXYUgLv6x4yxz+aZar4cppd3K49L+LAQ+f23NYGoGaNDyyhDCXzxP/E/xR?=
 =?us-ascii?Q?QUBOwm/+8+XlFxowRa0lLv+OJ9hUb2pZJj1FLxjZax0CplsNunAKSkh5ZA+h?=
 =?us-ascii?Q?rdjnuVNPadskZDEH+2nbqpAd6H+jx1dai2iuqUSyaFYXozyRx81Jzv2IMPuo?=
 =?us-ascii?Q?ZIV4bGz2BzeqsCUOX4sIMUDY92Z/XBeQgqrUVzlZHNAuDWzW7U+L+4ZQIlft?=
 =?us-ascii?Q?KP9TGMiyjItrOlj5YFNcFNbfdSRiBdbwWXMoeJ0Xkv4aHcl8lnTyb0Oh912b?=
 =?us-ascii?Q?uMuKtmkK6Fqnmf4LQbXqMTm3xPsa29JexsezlSWYi6VHVNnuvk5bugAIPu5N?=
 =?us-ascii?Q?FCZY3jU9zaiVRCcrz30W/0DgyQw9OelfGfSf/GP4oU4zQPfoZLMeBcgGXJpQ?=
 =?us-ascii?Q?0Vq3vTqOlw7Nl536VaFquz8kq5gqaxRkRCvqESN1qQTpEi5+qDypxl2NCY7U?=
 =?us-ascii?Q?/7U//Mmm7BWDkanQWiacmgp8CUZD9FQ8hIR2KcH7+rsgbo75mplmD+DrsZg/?=
 =?us-ascii?Q?PzlaupGs6aYJhwR8RhMudQNJsO+Qrb/pcwUwm6ENvUMWsc3D/rxpG2wQyP67?=
 =?us-ascii?Q?P6gxorUPfcLyyopGpOHlbisbZgDgpbHE5wUtOX7upvsi4slkhsXAjTSpJBV1?=
 =?us-ascii?Q?Ug3txafPuvwtskiLjzJGKFodHpEFetP3pQhzlwA/BtmqByRP7lSN05XeigKy?=
 =?us-ascii?Q?Tb8vXD5w+QyYd5c9A2SGit9rzpo9A/NIGG7rLsHfGNRrHDluAE1BMEcT82nN?=
 =?us-ascii?Q?Q1sRHAKvMq+Gw1Q9qYBUUJGvmcemlo/rPhUaCTgFGuPhorL7n5r9uqWONIYp?=
 =?us-ascii?Q?IqUCXcAW2Z2L68OcrSshFe4SZH+beecCZN0cDFDATkCAJqXLSyx9js70E7jd?=
 =?us-ascii?Q?zyPZdZ6DgcmPvgfFc3awzcu6iTHc022yBrxhPtd9vIPKNtw+1Bd1NuCeOMEw?=
 =?us-ascii?Q?2h+i3aEHmSywzQ5OkZ4DBK6arwjgFokmjPza6fUExZPBi5kLDf3/+79wnouV?=
 =?us-ascii?Q?CVI3euYQmbMCzls390Dmod2Q5v+5Pf9qRLBf+glqNZerYQLjlJKjQ/+wXVB/?=
 =?us-ascii?Q?LUEzhkstUuLt2DhoAWprXQiSAlFzFctLc66CiAkOPXZwdHmUAeit/04jZU7W?=
 =?us-ascii?Q?FZ3hqjiSdxkb646bGPA9//jAsyyHnMQINMuwnhhtPcADi6rOhzDAPAeO9cyZ?=
 =?us-ascii?Q?GzQe8HrQj3FsJxloNEgBcoMk4ALrNExbHDq473NckPEXbSCUiIxn+uSMdvez?=
 =?us-ascii?Q?55cLpcYelivMnC6YtLqKpGv56mb90vcLUQI2g0T9naMvE+Q3grWk2Qtm7+7u?=
 =?us-ascii?Q?zKtZXpq2IkKvoBTIpCniUDHJopOXKEc/kZTK/XOq2BjRdjomkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCEgM/lrGI/TlI/qc96yBfGIqfB4Fy6Fgp8fko+J7k27Hm2OGybBebkGJbE/?=
 =?us-ascii?Q?t0D9yBCHVVCX75WZyMofT6l+NaTVtDhKP9mdkdquqNrRmuSYh+Efda4Hfn+v?=
 =?us-ascii?Q?91plp8Cb6d/L8l3R4ZNpG5orMbAqyNtQxxvTwTlZ4mVCo0aTRyoqX6Al/YuC?=
 =?us-ascii?Q?gqEX7OgxDr507IyjAxKTJjTN2HJUaRZO2ArdRo7lOQnFQVZ4GiWFpu97yc+X?=
 =?us-ascii?Q?w6M9mFyo5d+PDaq8DcLSbAtpPdKyEc/pL5/y5EHdj2pV/ZqWq7JwZS8wNFWb?=
 =?us-ascii?Q?7ktjIPDiu+7usxqs05ad3usIc8kr+Iqzyi6uVTSfpq++oGSMa8L8l2tyQumA?=
 =?us-ascii?Q?hUu0HA4iUl7XDtMvmN50WBxPju2bn1OHCVaeSnhGU/rykW2QSV0MzN2dfjYu?=
 =?us-ascii?Q?kDWGdVcsLbG+P9HOxmVy3a1aoSJ2qPlUxRZvtFOYr/W7zRO8SYj+qmYYvym1?=
 =?us-ascii?Q?R5mYinXBS5cxftj1WqzoMnVL2wbZ1+K0vNXQmNEgV5x9YHYiYa3qd9ni16it?=
 =?us-ascii?Q?attXQ4m7pSAJRPgdgDw39FTui4zcsqxSqOBydlAeK2SVo/ujo217e+x+khhe?=
 =?us-ascii?Q?DK3LBX1/3wtTxZY3OQq8KHVqzD9aASbOX26p1x+GlaYVL1FkdLVSu11vAAgz?=
 =?us-ascii?Q?uvTXZDQNmPE2opOWbXmQhVFJUQCQssHxtfZ4L1SOQUkzXuwz4fwphepeltA7?=
 =?us-ascii?Q?JH1Qf8h0UAaTZhjDfpMapOXd0OqZ6B3JtE/Y1FcL7KKAwSpOxHnmtLZ+jJom?=
 =?us-ascii?Q?ryIBnT/bZ/qxhT21ZSjHr3poaFsJNGN3TmKw+Gw9ULDWd7IZff5+J+/nebuU?=
 =?us-ascii?Q?dz52f8JMPjtbds0w/fNg7o2F3QgVaedGN6qVSZq7R5XnLJqUxmWtLNThuNcX?=
 =?us-ascii?Q?0rwiBgAeGS9JU5Q7Ayq2aXf9sUaYKMTXz5nTxBQsj6J0E2Qf69hpYQIrykrB?=
 =?us-ascii?Q?5M0SpiWgkR58ZRExoOtmeX05z5dQe6IeCDJlwMtsXdZiZLOttP7d7op3Madi?=
 =?us-ascii?Q?9fbbz7uyQ9hi0ieNBdHNC7WkTsTCMNiDLODFpzYLWgJJvRUnQXnE+T81wkQI?=
 =?us-ascii?Q?KBU+76vtE0w7i92Fw85cKRKIiP3Nhk9cECHNnFOby5vCBKiXowZmL84Q3tX2?=
 =?us-ascii?Q?+hD9g3EXFfGZdkkwZTnudlZi/feHeyJ12+sqBuYrbpNt7T2FGCctxi9a7Uen?=
 =?us-ascii?Q?wQM96+ctvqaTIs4FoGETvA3R6u4Iqwa58hvwbcL9HKFie1nucRVNiG/Wixa8?=
 =?us-ascii?Q?VuEuBzmkYeAlAuIwfVafzcxf4yDNr9ubCvFs94Ig4tRSuoNTabeSqjgJMPO1?=
 =?us-ascii?Q?3xBj1P8kXvMYiVXGOrg+rOtZC00ucvqcEyzYUSYKaRuoeVhTn1Bb2uvUMCId?=
 =?us-ascii?Q?hQclvcS5vqq/fPCEL9/Dj27qqWURvcSth401H6pzdi/+cEU4L12YCseMe2we?=
 =?us-ascii?Q?ERESKfp0zElFQ84T8H1Jp630NM777XVhegckC2uMFQruqDIikSiQkubGhTLN?=
 =?us-ascii?Q?SKImav75ItIwGI02y39YCpI5tOMbfttoHXvaII5WhblyfPsIVX/mYgzRWWQx?=
 =?us-ascii?Q?PQtXeC3b4+V17UZcG3C0zfmnFAJEy9lcl8Y47/JRgCOT2c+fZ3/zYXm7twJi?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a44761-e4f1-4d4e-445f-08dd0e0cb69f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 11:23:12.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GCGQ5X45510WPrLe5DDfx+iVIZNUWc6Duesk6ZKC5PzM05i8CxX6EJR+e71MYC+AqyOCi6NZZ+dL2Fajwo7gsfGv47w0lO+WdAB5ef7jPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7106
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=6745afa2 cx=c_pps a=BUR/PSeFfUFfX8a0VQYRdg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=t7CeM3EgAAAA:8 a=wxn0Iau1ainUtKeLhj4A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: kndhCZUb0-g0h5DTKqmV7YfCY430cvpu
X-Proofpoint-ORIG-GUID: kndhCZUb0-g0h5DTKqmV7YfCY430cvpu
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
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 3d82cbef1274..ac6357c089e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -932,8 +932,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
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
@@ -995,7 +996,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 		if (!subvp_pipe && pipe->stream->mall_stream_config.type == SUBVP_MAIN)
 			subvp_pipe = pipe;
 	}
-	if (found) {
+	if (found && subvp_pipe) {
 		main_timing = &subvp_pipe->stream->timing;
 		phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
 		vblank_timing = &context->res_ctx.pipe_ctx[vblank_index].stream->timing;
-- 
2.43.0


