Return-Path: <stable+bounces-95512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDD9D94B3
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 10:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C53B28683
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A931BDA89;
	Tue, 26 Nov 2024 09:36:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46A1CBE9D
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613764; cv=fail; b=bYLfrZgXBGBpA6X1AH56rKS5+KhhHBlvAw4bPUEAs1D+TR95JY7gZ1Xjam4sanGSxnvXdAlfS80eycA84JvBfpA9Gl1d/zwqFdhxahVjLkFUaFGTyIKL9aJOcysYdfN2epZajKlMIWHaIUMxDOBV7mUEJPAqbWkl3w7LPCtJzhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613764; c=relaxed/simple;
	bh=9GiURuSqsEBWlSt3ZHMX1CnpUSv/K3bCoRxMEB1Jne4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hqRy+cBOOcS+78kuqM3Vapgfk3TdjycptrIS07MbJSheb4TOuDyYapVPqAUoP/gg7b3up+PxF/wtQYREvPrkn/AFtVpWkFwyUVtg7s7tPdqU0oMIckFjcdq9nEdBqTvzcMqrMi25/NDm4jNuNK6VzO06CUE4k7T83Id12W3lMxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ4Epd5000357;
	Tue, 26 Nov 2024 01:35:52 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433feq2p5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 01:35:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW/1mGx2X6T09al8hIeehNJa+SnWiWo7WsmtPkSR6PF2wO4TfmHZnVtVn76I0pft1TJzG13H47gulLgG73HyBn5aSZHUx6Y4lCiA+U9bKVWrHXOguiD5PWvjktmgUYZxeEVe0G0XE07iKoFId4n/KjuRKRoOaa8JO7Qrc4d9LciM8EP+rpuJuBDjVRiIHDuxkuMlmWr54mTPyIWNrDsgD9ANfcGlZ1iVxGgZZo45+atn50oki2FIZGohPo0yelDKX8CmTSTNbmdP+fdKz84iZ7tDeMyjTGAYD1K+uKmeCN1J6fIskM9Zc7ib6s/6dZPUOudpCy0qwtfwtHoea8vKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ+kGDPBFuCboc/ILIBo6RIHAMe2/6QN1TppNQ7C0ag=;
 b=GAJ8RleBogeq9inIPG/WwGNRbrvcGek6Ax6guqfwfSSL7Vzn5blhR87Il3i66tvXs7bEyim35ppX9fuixldNy6TZlb5XEj/rnnGl5PxReEJjNXbJnlArff7naDDcjD77BgsEEW1mBPAFJtjkgw91BotJkhFegIeYpnNVZp6lI3tk11mDT0lWy1hphXY2x5tx35VzvJQh3WMfQAUSvxrPjMFcpwHFCX+yrNnYhu2kyDATO11sl/UraO7yUNdkvFepkT/eBUjcuEtC93h1jW830fBWKfXt+VOg07GMHp/p5tzt6XJ17OpCqbk4Ioj9dAzT8I2yKmqZ4kgsIkTdaHAIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 09:35:48 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 09:35:48 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: alex.hung@amd.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.6/6.1] drm/amd/display: Initialize denominators' default to 1
Date: Tue, 26 Nov 2024 17:36:04 +0800
Message-ID: <20241126093605.2137050-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::27) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SN7PR11MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 536cb636-0082-403e-2708-08dd0dfdb5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3bwMrDkrNJa3rji8XRFb0upFwrVXqRc9b0L3UgRFO015RZQCDOyJ9kpe5SGL?=
 =?us-ascii?Q?wz8y+6jNJMJkJA18k82C8B+HgWY++3uFwWMK4ex//V5PxbZVuVtDUseZlyMR?=
 =?us-ascii?Q?LaIruReEMAaPp1Pnhk9lnVi9llIZ3MtZPhzaz6JyDsQj6VhRmoMuhvLerJh6?=
 =?us-ascii?Q?tm8hh/5ZSEAw9T1G7MDYCy45KQIP1OX6gNsfGkGymr0fAf0SRF28wfsEbSBv?=
 =?us-ascii?Q?nHAqwtE+0h3N+Z0Z9kPV785dwr2rNaN7iyP83EhCMX15HJ6UoPSsfN33X8Eb?=
 =?us-ascii?Q?X9o75yEYS267AG/VIDk1+TO0oOAH05iA6J2WKTtofSNW9OlXa9M0Ki1dK5Fm?=
 =?us-ascii?Q?siUU9tBn9lbI+zOE8m9PZzqUu+uvZhaR/QhWh8jRaukyxGjf/n1asU/XrPSG?=
 =?us-ascii?Q?gonsvGiIXrA2fWyhYEEb/tJoHrTaJNBciq0EZ3JxAbWhk+f8vQolk0OqBeyD?=
 =?us-ascii?Q?7NYe/D8d35WC1xBRglxx9JBkGw+H0ip/TcXnmH5LuT2pZNx72LTDod324ApP?=
 =?us-ascii?Q?RK7xKqufQbQC+quKjb/IyKt5kpJ9I9ucHcwa4QLwZEPuPdpAfMk9fizLFVI3?=
 =?us-ascii?Q?tDxKb5OqHynAjMn/tN5uXuyy0RP6GdqRxwAJDOA/5khd76PFmr2JncfJvpDC?=
 =?us-ascii?Q?SrBdVwkM0+KyyUHLPl+5Icpd8k/owmdyS8SMv4DSI1NUvBRBBeQYw3QM8pcp?=
 =?us-ascii?Q?qF6uUYQpFCqBmWzkJn4bjb/3nzsc+tUuU1eLy2hGoZlS1MHHRtPUwOqqJmxL?=
 =?us-ascii?Q?rKT3jkLQRY0DcCjXL3ipu238+78VAzwziLgHow53KFDccrWFVJbjz/5KPq4u?=
 =?us-ascii?Q?HvSLX+gZXvAYzfKdp3nKhgnkjzS6p1u6N8g1a0DfUAXUqsl9YNHxi8yjRgG3?=
 =?us-ascii?Q?Yq9FBQLXALtHZycCWijAeauskSijQUqDQUEcDP8FedTrKfTlfDf8nEbCPKXq?=
 =?us-ascii?Q?iOWI3XsIOxPRZX8pSi7dFQ7tAUxQBSz8l7pvvXOgd7SQVEKLU7U1V6h5i21c?=
 =?us-ascii?Q?co+rph18RHiPc0nVSgvHDLYUV9/W8kg8fWQi8rgePQPrw7Yw7ci1OOSobt8q?=
 =?us-ascii?Q?I7/VNLwziP2VYpXoJbpHeE8fgPD0TwwHoq0Q0iP3TIJCpetskELaR99BNwSj?=
 =?us-ascii?Q?Q3wE+JSlRXBcZoAkXOZtX+Eb2Lo1+xUN/ALj/buSG9i13nm+CkFuF9dLIaEs?=
 =?us-ascii?Q?SQxtEIP50Tk6dDB/SMz2+NQvT5eViBlGb9Sz3EA7JTfw6IBahssOtsVUrXds?=
 =?us-ascii?Q?AKyA5Bjec5E2eCAzZkoQjOtlM7YpUkqbDbNX5K03qhWwnIOi+NsNeX9QNx6h?=
 =?us-ascii?Q?OQe8w1tSU+jqyZFi/SOKn2JhjjFjw59pBJLET/lsswoAyEnG1Xu/xGaPEbuA?=
 =?us-ascii?Q?AbBz9mTjqVld0wF4fp4/lqLQc9kA7DEiw3XfGU/deMGmjbmKAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVTZVdYVUEqHvrtXNtE6rtjn//vsHGh6WQhY5YO/HXdEUcG2eJclTzGzM7BB?=
 =?us-ascii?Q?vdYtAxL9xBeXS1w9msX4FsC6nvYbsjzILRrYXp/YECxI+Q8nCWMhXWzCb014?=
 =?us-ascii?Q?bLyH9AFcMYYJp2Qfuj+2UFgoAdg+Zp/AeFMhxDKLG3nzq/8XHyRWMgQ12BfK?=
 =?us-ascii?Q?Pt35OvW85+0kyAP7/GMMDR+qFOIj93kHdjyLZ5JwT4hDW+/a3137Uk8jGyDK?=
 =?us-ascii?Q?Tqf5lTnL1cAkfD9FL5CoiJZLS8tePCnN1xrPbJo4gf1o9uzdLSAVzFN7k2pG?=
 =?us-ascii?Q?xynm2G1T5tBPQ8VuWTRrBdgQS63sufr7+i0GHsUHBrM660ECWGCNxkwrLP4E?=
 =?us-ascii?Q?BORCiF4BoNlfAK8xXoV9YTKRsJtmhGHVnsNvu29eXSw/UIJ57FxNAuYNlnAr?=
 =?us-ascii?Q?wl3d43Cc+nhWibMIAYKSEvFIZCsx31VIu/SSvBu/9KUXJnGQKfJd5r+BTSz8?=
 =?us-ascii?Q?fS7AaYRZ1Y0EOFEsri1EEIBVkak49sU0I8rXCzY7+9NauFaXJ8lfyJFx55Yo?=
 =?us-ascii?Q?j+VdbSV3ke7IwR6UUTjPYNsXYmv/EsNvsyRgSSiQfh6dFCgRUzQe7Avp27P9?=
 =?us-ascii?Q?Au/2KG40NP7wFwGKpmXh8hpeyUMgwFNYKO2T5cT+t/RGSFuhOWe+d3v3+K+l?=
 =?us-ascii?Q?nLOl7pvzHKvSkqokX7/BULT9pgf6h8i9sNfcumQHzEP++XNvH24FTdNWyQ6S?=
 =?us-ascii?Q?RCEqy1ptHS6K5AWLtsxhoiXnlcqcTQ7xy0eUCTc9zic0o0GClqdc/gt5tw2F?=
 =?us-ascii?Q?1b55COszFedXKQXMRG2bVJsjute8195OdxtEmv6rBPNber1T1jfUr59nb/cM?=
 =?us-ascii?Q?l08XSQF8lYP9gGw4qL2fv0vK83MZq/8HcOYX07NDUL5O8TeOtH+Lnywxsm9q?=
 =?us-ascii?Q?Ykl3+YIKU+kfsruk989emQsvGD7AWH2h4VgyNMjqw51GS0hbwWJaxLsEysVJ?=
 =?us-ascii?Q?mw976P+PVMi6+giLLeaKVNt4gqBNxK09bbVa2x0HwcTQKbZlw9wK/iICrah7?=
 =?us-ascii?Q?16k2cndsrmgxt1BBAR+qgA2RbaI6RMap7mgn9eisNBtVdqRVWBqyfJo4pIV/?=
 =?us-ascii?Q?k7HiJ6XPFJw+5guPdUmbTPLlHPSNVScK7/3vICtlvwKkdtaf9WkrhmgiXrRy?=
 =?us-ascii?Q?lsJZFMsV+GuT/9ZFehf21EuJ3MukOE3JXs9eQL/zsw08DbjEr6/4sUoZiPbr?=
 =?us-ascii?Q?VqM/vPsj6XaOoBGLxWmGhNR5Z+A8zhUG8t60dqgCjtstRwz318jeIRI1RtU3?=
 =?us-ascii?Q?LUD1p8dj2CMI3ITePDFL+s7/1WyGRRp7HbCz9zdiEjbNvHilIvxFQl6goTB5?=
 =?us-ascii?Q?yLNkSWTV0YKM/0zfvmtBjn3nu/V2i3AJ5WWsVU2DNn4iue8rKU+s8tuY9dju?=
 =?us-ascii?Q?Tl84uSt6lmJjDPEfspEFaBd9Jfv+kNaSlMnibabqedm2o97prXbrrcs4dv28?=
 =?us-ascii?Q?d+4Xgu2Z/gd1UcmspcYV26hMl3OpKum4d3htJ6nF+ROlBYrLUskiUcEEkjU/?=
 =?us-ascii?Q?zLDOFvKxZVWY4OG0ME0Wltvdoin9nub/o+qX6Fwtk1+1Pp+rNeDdWjpZVlB5?=
 =?us-ascii?Q?iC2A6oOFtaTjsC9ElKfmwtInYjXm+nQRkZ84bUIwMQart3O+mO64XNwtgfvQ?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536cb636-0082-403e-2708-08dd0dfdb5b2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 09:35:48.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBwaGX8ZZLHG7v0e5eNEOAxMUkjn8tql6yKf584UotxBNXsO1hENEJJMeV0U0scmzm0VJulHfB0gyJO8eCaDtGsqb6XiYmDXqIBUxhAcI2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
X-Authority-Analysis: v=2.4 cv=c+L5Qg9l c=1 sm=1 tr=0 ts=67459677 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=t7CeM3EgAAAA:8 a=eOkc4m_6g9kYGJwcdzkA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: XCBVMUHJGw8K3xe9aG2xC2YKCPsuAnqG
X-Proofpoint-GUID: XCBVMUHJGw8K3xe9aG2xC2YKCPsuAnqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_08,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411260076

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit b995c0a6de6c74656a0c39cd57a0626351b13e3c ]

[WHAT & HOW]
Variables used as denominators and maybe not assigned to other values,
should not be 0. Change their default to 1 so they are never 0.

This fixes 10 DIVIDE_BY_ZERO issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[Xiangyu: Bp to fix CVE: CVE-2024-49899
Discard the dml2_core/dml2_core_shared.c due to this file no exists]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 548cdef8a8ad..543ce9a08cfd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -78,7 +78,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index 3df559c591f8..70df992f859d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -39,7 +39,7 @@
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
-- 
2.43.0


