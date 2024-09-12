Return-Path: <stable+bounces-75967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5EC97636A
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 09:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23904B216DF
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589218FDC2;
	Thu, 12 Sep 2024 07:51:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69F18FC89
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127501; cv=fail; b=POWzAsHaQ8oqRKSFHeKAlhDpUKT+jH2qYFvaoivYGPJrdEPiDhERnLO9yHOtUt5W5iaiddzsKtALjgxlBY6PJ0KfYQ3J8CTCHHFLJkuiMFv49Bo8/fuXVXjWB44hYkDejr4s1bXAZOJinEc2uAkJGdXMmYjhJMbvSI0Q/b4iRj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127501; c=relaxed/simple;
	bh=C4sN4wx6OTBLutbvPGMtmlX92wPLzed0Wo9D0ynqHco=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MFm9SLW7qMqClHqr/YcSW7+XCuS6xjfrRYWPlmJOrKIet/Eu2uD4+dNOvIhqzdslEKEFfKGdAajdlcbawRFiSYm1aySJgWJ16xpLkGu05jdV2MrkSO1UjAA8/zhT6zfmPhCtbMnOKQHyUip0kju/3EJCE1cbNbiDGbnHH0//CRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C67P4Q030475
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 07:51:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gc215tf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 07:51:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYcQwWF+WZ5MZ3xz2zw94qJR7W0js+HRRgRwcQ8qqk6GX8KcG1s0eEcopYPvrR0ObrX3mYptoSGeoOJturocu0t8pwTqEQf24ck0MUX1zChwEe3hmSDMnCl8e0jNYOWd3r8f4kNNaho57CxZ6Wn095s0/1AmdCMyMGqEUVXiO3yicl5FeXOAQCeID7rk8hv3fFL7xztL0ABSUyKTaheOTXCC2kqRczcyoCv8c+4rrJHvDiVBPnceF/Y1kN85we3Vso9VITvZYZrzwIOCOBhK0TKjOFsuvQbh8i7Dyc2cQ36UYRx2RyWJjL0hURLon4DWVeX/zLXPTK3eXv+yMP3Qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwpu+cCIasGKWYdukD6shGRuWFqKsQxdDW/54RoroZg=;
 b=Oo6wcyzD5HTFQ+1hsErsQdWBH9urZCteqEAoRgzc0A+m/9ENRk+sg/gDvv0JsoTQD079WCRGFcZ/r3ZFipy4Vb1fKBnlc2KQGAKQ58bTi2TEnjqlzZbQfVTP/gurXfNzQMP9+fxonTjY4auSYCjbDSinxF1nrtFTxWxVwvoMpn+k9HEGXIFbwD2f4CjZmfLXIRLjdO83ibXXAwMqDqLUzL7AJLh64ktr/edaQyGAWbrZpmDK1MvIcMC2pn8LHvkrdhnG3R+oCloZIByrAAbbjlfZhMoqRAlWog+FZ3CXPf3nCfnhR8alksTmzx51iQm55fWhf2DWLuhMeZi1vuBvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 07:51:35 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.7939.017; Thu, 12 Sep 2024
 07:51:35 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1] soc: ti: omap_prm: Add a null pointer check to the omap_prm_domain_init
Date: Thu, 12 Sep 2024 15:51:19 +0800
Message-Id: <20240912075119.3682507-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ0PR11MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: 808fa34a-430b-43ec-b5fd-08dcd2ffb99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdcVt3JR7jly349Camvuom4oua+poL9SRrw6Sz6UexyN68kxvP7y54J3vcps?=
 =?us-ascii?Q?eIzQKUOHqTg4fZ/ZJoOFklnvOvkXv3r7LR25syAT9FGrJSjDzX48hCjwucs6?=
 =?us-ascii?Q?72owBgJLQX4hRSK4va6AE9uAx3Ji9YL1BAEWBGzcrgmEvLED+JrdRNDVSio4?=
 =?us-ascii?Q?khqY8J32Lu30Kg5lrTtWU9UAeLWJquC/aShbhQbPIlrIo9BNPKgzCrGL04G8?=
 =?us-ascii?Q?+T3cSwEhotVw2eialZeJOELvOL2hozazubq3bfe+uJOIU8qL6ftTDl0C0pBs?=
 =?us-ascii?Q?yXwqsVnI9s3N1uF1VZwdghys7SmyqQ69XQ86fK+3qouCiJxWfakr3d4Q9C6h?=
 =?us-ascii?Q?Ih4RaUDfAXdohbYZ+CxFLXyWt589H6yZMtz34i7MPFg+75Pdn5yQd+MGH5w9?=
 =?us-ascii?Q?CFeMbD8VY4lgjhmNM05I/bM85VVUbSUDc+pBfSRgmTBrOqT3iLLLqvVDMQT2?=
 =?us-ascii?Q?sEry9K6KiNtd4ZUzeikXeArWd3NgAG3X6C5Mq3B3co+JNilvBgltnnht0wm4?=
 =?us-ascii?Q?U/MlviVGZ8dwUpSJotJo6noq8qejUSq8HrpKloMo9b2xR9iB371PxnJtcVNF?=
 =?us-ascii?Q?G6FEwG7mfY5Ob3anxw31/HZJef9eajgLZFuSKeP015EZSS4KQYtQdqvwjUBK?=
 =?us-ascii?Q?ZeSdLV+ys8yroEhhlTPqB0TczH1mXqWAzHrd3oXFiV6PUjkdOtdMnX2a9KgX?=
 =?us-ascii?Q?Fsr98AAiTMlxMwS8+qBKHlK71Lxe9Kxmxr/WyfhaLkE+hOCQxE3AgzQETWHo?=
 =?us-ascii?Q?jC973I3GqSa0W69coSPv3zQY6iSgOJG7xNxYhHPiQshv63IESH9PurI9S8Zc?=
 =?us-ascii?Q?LOSV6lKtJ5Q+LHi6xLxPPelcD4esojx87uX8FLcrcvbcJtAx9iM0ACd64Lfr?=
 =?us-ascii?Q?WY+A1iYUQz+jQvjTlF9HiD3De4RM10kPe0PXDv46UnQBcGF/+glK3KRbypee?=
 =?us-ascii?Q?GNDQ9qcmCMVKvfYIOz5OheiBi9QAyf9DZCxYdORgc99B1hgyBxS5g3x+Pc9p?=
 =?us-ascii?Q?TP7Lqys4v3AE6mXWzwEWKs4XUhDgcsezoMBYMUeJAKfWYMFYRRv20aTuoC6B?=
 =?us-ascii?Q?kZQQ4jGBQUhI1jwhlPVM9KBN+/TpKLHWEKJvwFUZ+Sc7f6BPs2LaxZAxSufg?=
 =?us-ascii?Q?5uWk8I4tk+Cm6UsKMITpWhz7KlRf6Jl9gd+iUPEvW38b7g2BZENgf/OP0DIS?=
 =?us-ascii?Q?ZR3vtkCRNf1iZsjJq/FZZnM1WjMSbgphaWwMCY8deq3OY13dXl8dZ5VbhZ31?=
 =?us-ascii?Q?kRpFJS8WJBmfRELg7DEzkCnsvV6eMy6GpmPzJcDNYQSTuN4nF4areWVnrQkJ?=
 =?us-ascii?Q?wSopxuiPyEC0fxXxFK7iReEANhSzbnz4KOipKzSfJNl4n2YQ/ij0rRlLgaIG?=
 =?us-ascii?Q?wQn1tIg6a6f5kGMpz461mtirUnTYT4P9bIbinzm+uZY/b7xf9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UNM1Ojf2alvLROASWKgDwwIJr3jNWrFN5Ilaof1vuWyobVL44yRWRT/ULyTR?=
 =?us-ascii?Q?1D6ldH6lY9V46x17AzqIdJDAju1T6szcpAGLx0FEXZw3fHcBjDtF8JU3x005?=
 =?us-ascii?Q?aKXI7QjZv5k13DrkF1uKqF/IU11rDGc2pz4l6GH9q5Z8H1BgRhVn69B5jCYo?=
 =?us-ascii?Q?Y76EZ19fj6KA+wDuDmsd/dLlN0W8tyRlfk/hMM3S6p80gPSp9/0o68u/nURz?=
 =?us-ascii?Q?DqItDikRg+XQk96qEOYilASBpSbJXU6tIhGgVzu1kd2L486S80xaPAIXen37?=
 =?us-ascii?Q?ozNs348aJ5CheqjuAEfu9zfHLXbE8KYh/Dn2owxQhOX9G7CH3CWWGRMip66d?=
 =?us-ascii?Q?u7sypA+5e3QEG+9LL+WQ9ouoofr6SWAkS+VxAQ0bgZpI6wMPEtrToDAuUdw9?=
 =?us-ascii?Q?7B2FI23jldfVusW1VvcC5mRiWFjtafdyFE/0eQCkbF8DnUToOSMmNLdj5C6M?=
 =?us-ascii?Q?RUYCN6hwS5Pms/0oVW1/LCHaD0ATsRAghssdNMBZugN6d/oMRbEPwyOK7VME?=
 =?us-ascii?Q?QCtM2jWBTJDRHWF/jIWDRbuX/jVjlT18WT0KrZMMr9ii51OqXKiz5EDuJmuB?=
 =?us-ascii?Q?D0sa7O/+Jvmpkdpn4ouAQxcyrn9aNU1Ad975kxUI04z3uWAvgKiMK4WPHG17?=
 =?us-ascii?Q?o8W3tfYV6myPDFTudYTG7GPWHeg4P7qUU0+JOxAxXAkabNzaA80N7wvBx2d6?=
 =?us-ascii?Q?+0b0kgYQH1/nhwfHkJIb4R+7KliRssXGjqHriNvzh5Vfhiyb4UzXkiBR6xnT?=
 =?us-ascii?Q?bYa0z3bPWJ8hYMLODJBAKfPxUu3YuFhOzvYeNZkggsx3YLiiHmNCCT+wqOVZ?=
 =?us-ascii?Q?1qcSVn/i2ljJlUY8jKlODQOctznOJpG2/cpA1ZCFSOlUb2uqqquBh3xJva4p?=
 =?us-ascii?Q?gBYivnNtz21jfya2wFs2VILqhsb+zfHeevJN6q8riJDnha7Iz3SqyL1QqUNc?=
 =?us-ascii?Q?HWOKBgO3oYb9VoydKd8JrXz8QrWjkJmd3s879Q1YlKwWeZgX+y0TaDbDaFoX?=
 =?us-ascii?Q?NSmKEsTVLYyphZIfRwY3AT0EPXkV8JxFZCWEc2Fbz3mN8WtHXU4O/NaXfqem?=
 =?us-ascii?Q?/vPlINwdLpXFfplWHEjF8fPxsQU+IEofS6kcGogj07m35xSI0q8Z3D2oW7aw?=
 =?us-ascii?Q?GyV728MIbs9mvkanBCTRyNSD1+ltAp2PIbSqHWmY8QwNodAC9wMBdGxRLXyX?=
 =?us-ascii?Q?HRlgoiVWEgTMLWfeiA5jLzlXvaYTru2iNRKUyzALbkTsajpubAA4wjbxtFRp?=
 =?us-ascii?Q?7s5uKti9P0EnJQnflt4KHm1Zt3KugVDZ4rZNYMrOoXhvyt5LbBwwtqmoFpiR?=
 =?us-ascii?Q?LUrABrJnNh4DKveZSpR9l/9os8VI2EBrMi3vS3pfp+CZj9estUzJRT4VYAOL?=
 =?us-ascii?Q?LV8Rg3udikWQ8VVb0oH/jCD2pQYAiXOqx74xTqIxFRI2zDjgeBZOa1r6WoNr?=
 =?us-ascii?Q?4lHSPO0qp4gaBdYmuOUQC5KUziXg59WjYLM83oxBF1Xu56KKpQTf45sWAvJp?=
 =?us-ascii?Q?67ippyw2VSiUFI5qBRr/MH2xpTCBpSWJNg5oMH78xMd4HcCcKSlCX1P94Arr?=
 =?us-ascii?Q?1+IaQq9KE7tzdFdtYD09QTdBo+tya6Rf9NtHp4B4kkeuZABC00GUMU6qdecZ?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808fa34a-430b-43ec-b5fd-08dcd2ffb99f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 07:51:35.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw5D519c7dQOE4+HmZi5RuKZ2Lc7GQmmCh2p4YBzWVlec9ij3nEtubBQgpRoa7ie1Qi/9CjwZVEdFKO+ud3TJwSUyAfxNL1siQlaabm23+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-Proofpoint-ORIG-GUID: Jw1KC7tYFIEmFFN8KZzJmXslTJq7zNVN
X-Authority-Analysis: v=2.4 cv=PvDBbBM3 c=1 sm=1 tr=0 ts=66e29d89 cx=c_pps a=DnJuoDeutjy/DnsrngHDCQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=t7CeM3EgAAAA:8
 a=-MYwQdQDn_qFyHks7dsA:9 a=cvBusfyB2V15izCimMoJ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Jw1KC7tYFIEmFFN8KZzJmXslTJq7zNVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409120054

[ Upstream commit 5d7f58ee08434a33340f75ac7ac5071eea9673b3 ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118054257.200814-1-chentao@kylinos.cn
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Xiangyu: Modified to apply on 6.1.y]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/soc/ti/omap_prm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 913b964374a4..33ef58195955 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -696,6 +696,8 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
 	data = prm->data;
 	name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
 			      data->name);
+	if (!name)
+		return -ENOMEM;
 
 	prmd->dev = dev;
 	prmd->prm = prm;
-- 
2.34.1


