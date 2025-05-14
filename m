Return-Path: <stable+bounces-144363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C91AB6A9B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECADE1893E0B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71359274668;
	Wed, 14 May 2025 11:54:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F21C3039
	for <stable@vger.kernel.org>; Wed, 14 May 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223687; cv=fail; b=WKZlWiP7Qr04mnyXBXwSSPOL0imP2Wr1uWBjgy82jcyRs2i4N6SHH6LMJcDSlP84g3cxxks+bN5HF3q1Z9lcxnDt6milzqVKTNS35M0sMURoU/KN2mUyR4pMLjkV2FU6hN1atDAAaja0gZWrdVp2JRHHEBhEThc4Siv24OD8IYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223687; c=relaxed/simple;
	bh=9qgc2icS9iAe8LcIR5+FdYm3gdtiNbmZSoWVSjZxhdY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BGOsEzTv9YL06NRk/PUIUZwa9sKY6TVslY/PcvMeo7uzR7XaNkQDpKnOOnp9xJMs/rUY8NX6RHMcb6q2PmQvfTcY1zuYDoZoOrtUycFBKuS7UAJxoi2QrsyknwjqAQPFM9EP5v54RCfSgHnU5uQVpXNWi7Ei1EUEaO2/GC7x0As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EBP2sk022188;
	Wed, 14 May 2025 11:54:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbcjryau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:54:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rK4mWWs9mAtgRFAv7cvdodzDe07ifmKf9s5DI2CzxY8/0XgiU9WJLc2bIn4jzjw4HHAtO9zzXgODB7adZtuSv5sHfRG8sfK+omAiilh9xznxR+oVrmSt35EFsfWsOsq6YrXq7sCpfthMRA36N3J5XI93prfBCM30SpIJAdOK55XxMUFI6DIcWMgr7UxOGPWgbktN8dvuT835UFvf/Yi/VVbH8jGBd+TrFPm7MdkxQ4MWURx4iynAWohXY2Bf0r9IEP6RiBHEdyUzDBOoT3cg/9tIZQHN3YVNeYXTVWDvNYKu3fAFK9cVJsNEWzsMC4m5EUAcxjdld9XG8Jgb28QspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ccOoIQBihNLtjjP4HCteZgmSSdY/vDAI9FyYPXoXw4=;
 b=FgtCqgb4uiUqq1XYt9KYRxQ1GUV/X+Po/PiPA89e2jJ+T1XeSjVx7ECmNT5q06ZmyMAuADqEOmvxcpJ2DyH9jjng2NlaAxPfbClG06m1yTZgo+OqV1dLGIqBdTxvqNh7/imqcZjxvSMdro3cWni+MyUSGxfScdtUT7xgRrXzzuFPxj2vKlFklA7twJS4N+udYBwoTVNH7lbYGND9R8Z8CsBdJ7n07rRSfUSJiOXCFM5S4LMnh51kltzHvTD/AWvU54wf7qETNMP57uEhxk27uqSpnnLn7Y07JHebSg5k1ri/s+sKr8y62YrKJc8py3YLFXxRIVoWi1y4vh3oiTiBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by BL3PR11MB6458.namprd11.prod.outlook.com (2603:10b6:208:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 14 May
 2025 11:54:31 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 11:54:31 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, bin.lan.cn@windriver.com,
        nnac123@linux.ibm.com
Subject: [PATCH 5.10.y] ibmvnic: Don't reference skb after sending to VIOS
Date: Wed, 14 May 2025 19:53:47 +0800
Message-Id: <20250514115347.3492228-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|BL3PR11MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 857444ea-914d-450f-7612-08dd92de1687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YT8O15YsIhVgpSsV7BEfpJQ9tQVA/kC6sSf8zuI52AWidQDwRBeWbSnBzgAq?=
 =?us-ascii?Q?DJDDy6oKnxjdifxIDlfEwSCg/r3Ud3Udy90vb3Y4WZHxIyujMlcxjoRY0wCB?=
 =?us-ascii?Q?QT87zMKyHETeNhYB4GVwwoNNY7kXZ9fBlc1Wg/ngQNcPECK9WNpOTdyJ1vkr?=
 =?us-ascii?Q?ndHI+uObvqmQ7MEhtb+EMsbGx0HMrDVotvMp85hrwrBXaD6A7xOvK5d1g3Bt?=
 =?us-ascii?Q?/10QdGEvZKYL8tZa9dZ559C6RPStRJSGVAf3FhTlv4TdvPyGadTk7IxrNCP/?=
 =?us-ascii?Q?W7bKSdImXSqyWAqFbtOw9Cz+JgqOFLSwTvxq4Efm/6Ib4pV91VRXpgrXkEKQ?=
 =?us-ascii?Q?oGGW+9fpWTuYKk3c4Yxp8UKNKi9aoRnf0+CuREI8z354E0eIaZG7YFzXvmxC?=
 =?us-ascii?Q?XA03ocOfSRqxKFnzf/hsoFLh52em/4H6DFsJRfMnq5vn1p6AMcXKwb+A6pk7?=
 =?us-ascii?Q?ybOyliXyGIhxqpy6XYzqmEfD+D6cBRAmnvkXkXdVMLnDL3zp10V4Wm9piLeP?=
 =?us-ascii?Q?M/mQ7wxm7bG+hYcwzt9VpaKPhXQHF6U6Bx2dMRIq63aweNftH7kiMEuaTbAd?=
 =?us-ascii?Q?6VOe5TWGucF/5U3ND0qyOe12xY+BlhqA+bJguQAk/xvqTgUC2rX7jv8fElWE?=
 =?us-ascii?Q?ce+WsNNBp3qA4pFk7ouat+zTnefFiB4dPNLae/JPkELpYCVqB+WT42xV2G6x?=
 =?us-ascii?Q?98wByfHxCcd41heNo4IxSS3YPWh2UqZniYTM2Re3AUQ/9WT9sp5DFJ/DZU26?=
 =?us-ascii?Q?UcVFZ7+G0aAmS1fGXN4eVTFDuVRyHXpfnW90evU4tvoNSnZ+snDK5JNW6AOc?=
 =?us-ascii?Q?KODcti3LCtPNKnr2/K5S+zQeTUlJsqoiBCA8HPxoS4lVDGuhG0JsPYDZBci5?=
 =?us-ascii?Q?9OI9FOUOdYyvaflLgRSGq8gGPw+1qEDtk+3Ai0DYfGn3FJfkSh53oO0+tWE8?=
 =?us-ascii?Q?pe7oqdVApA8kbAJFgSwZCwi3hLWoU/2ALsJYPcXGYerNQ6e3jgdi02lDw0hs?=
 =?us-ascii?Q?IdbvXdQhfPskxO9N5ZLiZw26AJRzlWNBJ/7GavXa1iy9EixiEFJQ+Qtmc1AA?=
 =?us-ascii?Q?kMMre0F4FOViT0XdKkZmz/ebUBzE3Jova9NTRg1d0Jg0qLsRt7K/3MGMFnI4?=
 =?us-ascii?Q?XjDCu18M27dvH7N1B8aeCxKNhlDVjHGjD/H4n+NEiDdlQhwOPbwTlNQAHjFU?=
 =?us-ascii?Q?kU22QyNC4qzpcnW5p7v/0XXa3yRNe2ltg1VetBt5C/67+sKtW+2mVA8SBCAJ?=
 =?us-ascii?Q?IRmLeJeILF64h7NukugXbgo0c6V1qKLZJJcTnvFXvvnOSJm3FYweg5BxtoY/?=
 =?us-ascii?Q?naQZDqlRqvtiRLob3C97iOIPr6k7H/VCgRILOc8QFuCK+uKTP2uF54ZVR69I?=
 =?us-ascii?Q?2x+1kT+8gdh3WupZuttdH+giuZ09Q9u37ves6NmpSFoy64ysSxCmmChzSjwz?=
 =?us-ascii?Q?zHav90x9CdE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzseIp57NmLeHeIGHNJFiwOtaUHaiNZvqplUMqQo7nRymUisfFNE1q96ws9t?=
 =?us-ascii?Q?sKdfLTdfxtYrtb3cjiLW9LgDo6CxMFudW9X3VyNMxRrQCw1ZauzxqP0l9Zj+?=
 =?us-ascii?Q?A+ZOqBp4nmaxxsOTP9WIWMBPo2ekdcQdW6mW4F3ZCEg/LXcu72NvSrDD0Bpe?=
 =?us-ascii?Q?HOYbQdhXoqzKvDY5sw5+tps/aeZdjcQOk7kfRyQYpK77xhK8n8M9aCJVqN2M?=
 =?us-ascii?Q?uaELeUMVVVfH83uhZqehkah4h0UO7mETEnYW78CIuvdNBfrYlU2Lbrz7Kdfr?=
 =?us-ascii?Q?foh52hDAgh0Qmr+B5Ext8UmnVKa7IGIA9sZOPd1QL9uWVkTswjx3eZXsnzAq?=
 =?us-ascii?Q?kxpuuj5kcVfukqfqcxC5cur3nBJ3+P9k/wQ5pnDsjWPMAQwlNbjdOZhvn2vF?=
 =?us-ascii?Q?xJLeYakrs++VB70h4kNxvBUhFCfhwcjh9+7XIzzDwcN4nxTk49KTFdD7S9XI?=
 =?us-ascii?Q?57+KTIqFbv4Xa2FjgPPOzmxpyLYAREqs9thJ6OZR9BZwMgoRqKdDy5GvZnOD?=
 =?us-ascii?Q?EcRhpti7mux/sPdu7SiTvYWXvMeLRk79W0gIvtW7hbzvH4QscEkfFzLDY1PA?=
 =?us-ascii?Q?m+FO0Dip3LFbbSKf12mL5mehirt+h02BYhXX8SWyO/gBTWG26KIOD+UfIkMu?=
 =?us-ascii?Q?a2kapXhkTsK40j3ndtVlgn0N8x4saUXwJFOWGQoct5pRZOgW2LguFxcLsAjM?=
 =?us-ascii?Q?EcJiDPhsd/zsxOyIkG9ZzChyzbyhcNdBAdh+ab8HhJXwRM7MLyPG25b8JemQ?=
 =?us-ascii?Q?5xXsxaMQsK5NgSJ6WNhm7hvWAE0PuHr4LMimuHj6J+gTyjfhDGVoMN35FYS6?=
 =?us-ascii?Q?/lU4oV29l8NtfKwz6ATSzkos6WK3LN7xedvUROfYctjeKqNaQ60Z+zHQqiwO?=
 =?us-ascii?Q?zFdl4gOR2YThSSvGQu38dfVnotsFtxpUj5jpbISMof3ATulao8KmNgpImMz6?=
 =?us-ascii?Q?X4vXnJQuJ8EUSe74nOh8f4F4SrFBUWBeSt6zISFDISZpzwfrvwjOh7ZKJQts?=
 =?us-ascii?Q?Gjrl8rqZX5bnTFqiKjsTygvg+1BHbDOQe4zcH4tHMqulQx6CiL3x3qCJK36T?=
 =?us-ascii?Q?Sc8922zhAWPgtsmnpQYC7KgcrxtVIyA2mpOor/86XIemyPvfbmcAk132nPHT?=
 =?us-ascii?Q?sZpzChDXwk8HBqnJGmvmX6V+damFNgwZcfF8HuUNzb8tcCiPabEUj0opJmOD?=
 =?us-ascii?Q?K/zSzEkJHvIGuVIdFLWHX/WhMllzHRvpSSdJGdzgF9v3LlV/dwZmC63Zsfvg?=
 =?us-ascii?Q?36ekIyJ6pbedn7ZMOmZ36h9lslN9lc0C7gg5s4pJqnWthlYsXu95KvCZ4uKI?=
 =?us-ascii?Q?vcl9pNvswhajt+ZOgJLrvimEDXNsg1uk3LnagoL36WJfILgPbnNZBFo5wQFB?=
 =?us-ascii?Q?ZMA0ovsP6Cy8QLFC4Ot40w+FSh/m9G0BrrQxeOMhExg6Tk8lAABEBhgEkRTR?=
 =?us-ascii?Q?QDDtE9Uk4goWVXK+dkVPSHw/wBxfag/Er1HwJPIGWU/VOY2gvJ/SuIWM9pzm?=
 =?us-ascii?Q?8Sm5mdjwMIuHVIwm9oXlOobqLm59NmSQFYpq7aVGIm8wZmK+boECUreJzqeu?=
 =?us-ascii?Q?M5XSh/q3oFi7GAnLjHAJuQPMRjLyJ0maC8a8mWkCqJjUz1r5CEJt1FmL5wkH?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857444ea-914d-450f-7612-08dd92de1687
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 11:54:31.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNmxsKDYjOeLDqiI1iWobzHYdMkmlqkfGlXZlulO11UO6y4mg6yyT+mSUNarIIM8kOmUaH0fjtccNrHSGq1S1OKT1pTZLDWHvl/8z5+VE5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-Proofpoint-GUID: yPmszRFIipQhUeGdW2cskbgfT97Z8sfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEwNCBTYWx0ZWRfX+XLPnedKWcCB P6O6hMddMqrIj7vGqKaP1cxyNeGiV+0UnlqCw0eTJxfb5wN2tEcCJG2Xcmg1jdflGXinaWSvbrF DmCuzp9fKK5kwHuJXOk7xsIEaX1IHq6Q07hsvBN74sq4NU3E23HBHs4z1IiLI+xEVQvGODbSRwX
 PfM/UMaYX5+0U5avBLLMkRZ9J4Y03j5CxnN6qggEmSkLJMmAqxncuqGXYXSyqy1kEAbkqtJKxLM g0WDCTwxA6ZPdFkUy5g7qgVxzMklDmwP+Nc2R739mhYUYWxSi/A9CEgMbkfhbk8TLjMnDtIVWgc PYsEoEIF2zaEyiSfvcgYl6kgCzm4TDkG0oLb7lYbwM4IUEzPLNqEnPTxYIPvReMC68jKUkqE+FG
 drC9LWFyXUuXrji7YSFQ06LPuwmPiwCqc96VChKI25j+5lmAITcx/zDdAQ1lAjX+4xocr9OE
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6824847c cx=c_pps a=F7QtyTBSWJEVkVFduP+sHw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=Yc5L10HpTH3LqOobwVEA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: yPmszRFIipQhUeGdW2cskbgfT97Z8sfI
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=878 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505140104

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit bdf5d13aa05ec314d4385b31ac974d6c7e0997c9 ]

Previously, after successfully flushing the xmit buffer to VIOS,
the tx_bytes stat was incremented by the length of the skb.

It is invalid to access the skb memory after sending the buffer to
the VIOS because, at any point after sending, the VIOS can trigger
an interrupt to free this memory. A race between reading skb->len
and freeing the skb is possible (especially during LPM) and will
result in use-after-free:
 ==================================================================
 BUG: KASAN: slab-use-after-free in ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
 Read of size 4 at addr c00000024eb48a70 by task hxecom/14495
 <...>
 Call Trace:
 [c000000118f66cf0] [c0000000018cba6c] dump_stack_lvl+0x84/0xe8 (unreliable)
 [c000000118f66d20] [c0000000006f0080] print_report+0x1a8/0x7f0
 [c000000118f66df0] [c0000000006f08f0] kasan_report+0x128/0x1f8
 [c000000118f66f00] [c0000000006f2868] __asan_load4+0xac/0xe0
 [c000000118f66f20] [c0080000046eac84] ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
 [c000000118f67340] [c0000000014be168] dev_hard_start_xmit+0x150/0x358
 <...>
 Freed by task 0:
 kasan_save_stack+0x34/0x68
 kasan_save_track+0x2c/0x50
 kasan_save_free_info+0x64/0x108
 __kasan_mempool_poison_object+0x148/0x2d4
 napi_skb_cache_put+0x5c/0x194
 net_tx_action+0x154/0x5b8
 handle_softirqs+0x20c/0x60c
 do_softirq_own_stack+0x6c/0x88
 <...>
 The buggy address belongs to the object at c00000024eb48a00 which
  belongs to the cache skbuff_head_cache of size 224
==================================================================

Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250214155233.235559-1-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 84da6ccaf339..73e3165aa9ae 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1548,6 +1548,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	dma_addr_t data_dma_addr;
 	struct netdev_queue *txq;
 	unsigned long lpar_rc;
+	unsigned int skblen;
 	union sub_crq tx_crq;
 	unsigned int offset;
 	int num_entries = 1;
@@ -1631,6 +1632,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->index = index;
 	tx_buff->pool_index = queue_num;
 	tx_buff->last_frag = true;
+	skblen = skb->len;
 
 	memset(&tx_crq, 0, sizeof(tx_crq));
 	tx_crq.v1.first = IBMVNIC_CRQ_CMD;
@@ -1733,7 +1735,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	}
 
 	tx_packets++;
-	tx_bytes += skb->len;
+	tx_bytes += skblen;
 	txq->trans_start = jiffies;
 	ret = NETDEV_TX_OK;
 	goto out;
-- 
2.34.1


