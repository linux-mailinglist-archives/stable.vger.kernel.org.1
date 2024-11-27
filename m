Return-Path: <stable+bounces-95610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350939DA4FE
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA10DB21B6C
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B817193435;
	Wed, 27 Nov 2024 09:45:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB713A888
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700702; cv=fail; b=UyRQHhN4EusQ3DRvK4EMmc6rs7pyAzQM9O4JgOphQKNVn8at2t/u4RgNXvqW7qWai5MvtD7+ySx6A+pcPwE+RdMhdTjdxNFDs/REvkjVUtGt6hhO6DYnACFG0r5aaSi5AJs9J+NhZhuc4AEa4mv25WGxgc3gu7dvMfkxRwDdf/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700702; c=relaxed/simple;
	bh=Lfk4KgvaYci33P1kBV8leX3nGEdoG44EuD4pJ2WB12s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KmBgJqpEjLXWOy/hYB+KJw1UQaOpJrXN56O8G3h6FaeITcaL2RcwyQSe8pcdqfRACCfytUGFxspnOzOOib+MNTaBJmv1xVb6dOTR5HqcmrHoK+gJ5EVidOTrMG66e/i4ivM+5VIZ88llAfyejjPyz5nLo2a2um7S1d6GXMqx4N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR8qaMc003813;
	Wed, 27 Nov 2024 09:44:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433618cbpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 09:44:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS7IB2Gih0Uzj5bpr8lh3Z9b4bYuiMpHNmmNSYG8BSH//wHAZqB7V1EqfKsQV392kkGjfJ5NyxUKtS48DNFbap2WRrfNnBF0c8otMXjm9N+iGzwqEK0Tv2PWRNOO6V22Ed3pBXujzWN5+ndj0sHwkJqL73OJ2kGUne/KWuwi4jA77O4sa+2Sil1xwLimDobsrxDAtgWfNHIPp3XMMZSNbO5/RwPB0zJfmwPg9nqqHqvd6MwHlJUU8zWEWF8vTVHAAjX5O9NUXgplDsP6anJTnjQlGnWArMvfIUMcdM3LgqqZGKvuZTKd+IcvQv9wsO60amAqq1tyXNxLy0f2YyJ3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N7ekd/hPgI9ewqQpaKJrmQcLLGFwZS83EKI1rVpIYQ=;
 b=e0M3nFpl1jzKex4DfpqdtmXscGEsyE7fo/WTDMtXM24U+EYfSctMwhPENuPXyND/MXLKjMsgxEQ9MNSk7ZoATX73gpga8DPhRmgGrpDTx/CzBlNutE+UqCaCra4621E3PxwnRAG2snvHGxeR57D5t5I4mK+jWs4O/+oRN4GwqAp4hJlKqxU9AhzD1b3zTKlRk4H9ZqKKwx4hkvj/+Di79/HOkhE3YFNjXTelcvltdGYVF8l3vzmciyIHlsB1tHFqqmeP7h4y9hk3cPG1xejcnHZCdmXJ+1ne3OGj3LMbyly1wkkIL+7IAACH/eZeZ/fIpp3Cv+kW5OVDCWPd4qqUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 09:44:52 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 09:44:52 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: srinivasan.shanmugam@amd.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1/6.6] drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw
Date: Wed, 27 Nov 2024 18:42:29 +0800
Message-Id: <20241127104229.1559467-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ0PR11MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 83385200-1a97-4a88-cac0-08dd0ec8243b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56PbhV1oMDL4WJxtFR+cTqIZgMInE4pedH6J/dAmgfhH53VQUQR0vyQFMEr9?=
 =?us-ascii?Q?16cvFh85ehIOerMm0Bxf9CMEZf1f5+h1hcfKkVFy4RDjzm8/BC8vBYfAcsQ8?=
 =?us-ascii?Q?13jno5b7qPxpKDKRGXMrK5cduDEhJS1/uyPl/VgQYX4n63g9A58kpMcn5VUS?=
 =?us-ascii?Q?XDCCsT+3h8AVMRCL7GkMj5Fsb7KCyUWsMfcKwNaH/v7+rgP6f0tnUgD4FEyv?=
 =?us-ascii?Q?FsazyeILMabDO31kT/OwgYu7I17iehbcobVBqISOV7wLTeIfsd2AnGx5hP0q?=
 =?us-ascii?Q?oYsjlwbWolDnd4W9+FSVnDxHc+eS9CRbkZmlG7ORkc/O7B5Z8rih2y3pHHtQ?=
 =?us-ascii?Q?wRDwop0QJUU0Cg6Iq6Z5V0hhuaiVMix0P/BPk4j/gUWM3xT9exYeFrt4BgrX?=
 =?us-ascii?Q?vp4b+tRcVY1K8EZcwG1OOG/rBjZiWo9VWc6QGNJo/7EmsR41tee+FWnglKcL?=
 =?us-ascii?Q?MZ1LidrR9akBszJ2Al1dCWIIHWOMeKYhg0qcL6lExFS122DNBu++yyG3H96c?=
 =?us-ascii?Q?QkBC2dbBH9RhuvhnXpiiG00Wz6ogYtKzwY3TSp5pI7kJJJ+tXNfMI8vs5j7c?=
 =?us-ascii?Q?FgFWz3h5g+mbbKr+pxNt1aZuhIc0sm+3mlIcQVfvLpYezeq3a79bqgfGf3wg?=
 =?us-ascii?Q?R2MxgB7R2dQCyln9tOnY0g/o+VlIKWgtL8hHB7Dqnlx2jr1uHv0e+GFmaMj9?=
 =?us-ascii?Q?ZhzlXJy0uoRBrarjvhYzlRWuBR+4UDzxxlkkj9478esJ7MUp9HOvafz6rRyK?=
 =?us-ascii?Q?09wjumADUT+V5xckdCrt/P4fYDa9ZEqaTg3a97TGOC4jZmmSaxbXFtr188tB?=
 =?us-ascii?Q?yMOatXH298ceiZ6JSCFJBGGfOtosQfciIcfijyXYDD9iEzpSopewlSxmEMQ6?=
 =?us-ascii?Q?/z9NRsDFl+eelbsw/UEANpiA5wNTbzwiyduKWl8uuAD/rgVwSowvXh9JPb+F?=
 =?us-ascii?Q?DOnGX82TFnEP1miL2GPK2HljGaidJaXAGfbtplW5IZtlHT+lvRg4l7+3ap96?=
 =?us-ascii?Q?luk+9EBOJD1rfFnpzerrwHonofcXDgGmYw65hli0qD80kneOc1x5hwJjyN3o?=
 =?us-ascii?Q?XB4NXlBi/OGO36RVXnJukMFJskJSeS47i8f2+VCxWzvbcbQ1DTjDL/d0DN8Z?=
 =?us-ascii?Q?O4pimnhywyQY/Ug8FNiHABTpHsTwWYUuE4oyp/Z1IwyDoHXyNiEp5BmD/sBK?=
 =?us-ascii?Q?8IJvm03ohbfHzSzB+1bC+EWMmmSdSIixRS7oE86mbEPpeRfs9TGY5GRePOrT?=
 =?us-ascii?Q?cI7m1LlGnmrcDHlhJRwNYrJkcx1D2MeGO5u7jIj0tL3e/bZSDnXuDbpQEaNO?=
 =?us-ascii?Q?bdw5fnU0OukqijB9H76MwHP5Kqf7sF6VTcRpbhtYI0J9AbrweJvR9ug5fV6e?=
 =?us-ascii?Q?bbP4kYIaX9AYyBUGFa5vP9ZZlWftq3fVcKTThcwEdUepeQYkKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxSECDcugfKtURxF8i0R9cdPXTN0BLXgGCC24JE36pfJIo7JtB2xKJGpb0uc?=
 =?us-ascii?Q?gh4E0L1EP4h4Ku1OD1CWoHrZmfexWCE8YWFOZlvheCE8LRT1z3FSMQVrvVOh?=
 =?us-ascii?Q?r72enmp/G1CPjeKSNdIqACXs1bTwnxe1nAAFmAbYgkZnV5LHIpxu5fdJQMj5?=
 =?us-ascii?Q?t8bbRLyTsFeu02yQr7i0Vs70TQEq0jIqDdqECIGz085m2CW9IIfSopiRF9ql?=
 =?us-ascii?Q?CDcJNrmB66KPy7LKFNTIUtRliHvJo5O6vmUYtyZCGnhNCb1TdWuR1btSiOnJ?=
 =?us-ascii?Q?/QJgxpfEvXaOiXJ/lsVvhSOV5oprNkKS0j+OjKww8JP5bk2LMJrdyFt82/6Y?=
 =?us-ascii?Q?V/DOPrjNmbSRMGcRODMESF7WBZrbvnQ++BQSEciDB2eeAxXYK41nRGlsADcW?=
 =?us-ascii?Q?msiowCLmJS60+sempb5oRFrsWWElXZPOzmLfO06W4yRjhGu+RG+pxxryJIi6?=
 =?us-ascii?Q?n48Eo497ytg0xYrP6hO5DCLOB0J5vUmT4uwKVBw1bNp0hL1wLvwjr0jDZqkq?=
 =?us-ascii?Q?9f7WRg3eoOPS4yHks+WVqLK5cOwABARo7XAYFIeURH5ehTDmT3Ot2IR+YE9J?=
 =?us-ascii?Q?B3K4VS2y11mWx13xXWv6Wl1Z9tR14RR3QE1U4ns6kmJPFhHaN1ihKmiXoZQe?=
 =?us-ascii?Q?39MHjqfAgsuYn34oaNmy6Yh2ndS60abztfA4njsokgbzrjR3vcjpYJZxKZwE?=
 =?us-ascii?Q?BiXDMYm+gKkKGKSoLawCAXs3P8cveW7NoD7l7Wk+VaMfkTQSjkidsGNetTFR?=
 =?us-ascii?Q?o+eafEIQOgWmtb8iPaFOPp/dCqtfah2QDMW840HxeIqQevKy0TRhvZ/EkfTO?=
 =?us-ascii?Q?HSeujwnWXVov8ZrmjPuR9a9Ja/LyEJywq1qBeSRjLdU2gm/X70pVeTHKRfRd?=
 =?us-ascii?Q?z++vX/3BSDLIVCZD2i4n93CuwwpK6n1/I2TwC4lWKskT8vsXMKdVpGYdYeDa?=
 =?us-ascii?Q?MTAhOP0/vFCZ8ysYyjLNs/J3e8L+++xwmnAs4+9+kp9cML2fYzEprHCEbcB6?=
 =?us-ascii?Q?9gLFpehsxzqttok1mDkMKf1L/gs6YLKp7Wnzg1Hte0jeiqdqLoM9FHSD4G1M?=
 =?us-ascii?Q?DjjXrhsKxz+N4DGzkmNj53yfOjB27uU0quVAZ91/Lkc/3gN8MJCu20okXACm?=
 =?us-ascii?Q?V5ERTXxEADQkrWRkZ01MO9yyHXbk+qjVbfbsjCcEHeMxoe5Dp71taCCuU3M7?=
 =?us-ascii?Q?iGQwdef9xG1KrvrQoywfEbys0mClHOH2WBOdh5cxZceyMuTs/dNtdYI0/PP7?=
 =?us-ascii?Q?MEL/sEc0adleUQhqaNS8jp8flj9aFGbHJuLLS0IDoyEW5FYf7wZq5uLp9sq2?=
 =?us-ascii?Q?qqkodlKWu4YVqjG4vGAUYJKJxC2ygo9dCuCXZaUomvCZMy/L5gi4xRXguWUA?=
 =?us-ascii?Q?xewNQpR1UHTVwQ5fjsD6GQEA3lhY65hm9YpsJipeuppiu3Gm/z8PMIhy+qFZ?=
 =?us-ascii?Q?NoxpkEXiUbf+JMSBkxcZ/rmxKLkmD9xGqUYbew+7wEVjAJtFmpPQDYZyyouS?=
 =?us-ascii?Q?X3NIvBasQwRBBvFywH604+TfqsesHVv0rSQ554CLdc9xcNHDamZI+gB8rM4s?=
 =?us-ascii?Q?OaFH2KJkprDaL7Vkw2d5C/Ga7kQTra/V6b+4AdSt6pc4ywij2Cixs028iKgJ?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83385200-1a97-4a88-cac0-08dd0ec8243b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:44:52.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cWuAqnv/c9BFQTFgRVeuShqzzxpuk8bfWT+6NBGnszBoKLNaxbHE/JKuvy8xbZNF9Es8hOHUuj9KjVo6Qg8rDZfoHoKBjT7IIPU5GH8dyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-Proofpoint-ORIG-GUID: LbFFunoqFwqq5-0o0gB1Srm3gdu6vO0_
X-Proofpoint-GUID: LbFFunoqFwqq5-0o0gB1Srm3gdu6vO0_
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=6746ea17 cx=c_pps a=mEL9+5ifO1KfKUNINL6WGg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=gw-UdbIikuf-w9F9bWgA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411270080

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit c395fd47d1565bd67671f45cca281b3acc2c31ef ]

This commit addresses a potential null pointer dereference issue in the
`dcn32_init_hw` function. The issue could occur when `dc->clk_mgr` is
null.

The fix adds a check to ensure `dc->clk_mgr` is not null before
accessing its functions. This prevents a potential null pointer
dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:961 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 782)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: BP to fix CVE: CVE-2024-49915, modified the source path]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index d3ad13bf35c8..55a24d9f5b14 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -811,7 +811,7 @@ void dcn32_init_hw(struct dc *dc)
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	// Initialize the dccg
@@ -970,10 +970,11 @@ void dcn32_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.25.1


