Return-Path: <stable+bounces-144475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34C4AB7D80
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 08:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC3986804B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6111AA795;
	Thu, 15 May 2025 06:03:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F7DDC5
	for <stable@vger.kernel.org>; Thu, 15 May 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289022; cv=fail; b=UWZSS4twYng9g+5ZOAeF40BOJrxw6ulk1psO0JWE0T8gGCujLjEue3hHom5ffc6Z3gPTak/E6ECoaPV4A+MFbx6/RaXfiMi6IaMVkeGJda82CdFxeUU11FQvNVyJ7xurx4fbn0UiC6WgNUfJ4Qns4mYS2NND4Kz/mPY9VjjiWX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289022; c=relaxed/simple;
	bh=9lik1HU7W9gg0QihtEwC4H1X5zI4SclNzjuguN3qHFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JFLioSSO5f2kWh2eF1V+hVD4EZUdxqL2Kk5UZX/aUXzpG5hpy3v1lw3YRAcHENDOifks4CqfZ3ahDKe95mfJMmi5A4SVgfZwoJmM/hR9d10n92sE1b9QfPxrZJaPHR/+ZhKgSzcJXZ9ttsE7jtwFENBDQ/67Qp6XaZOCzn6m87I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F5Ua4C012651;
	Thu, 15 May 2025 06:02:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbc8t7ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 06:02:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1nW1zZjNd2HWWXEWRoVigtDbliIODdwS+ebrX0BIDJVTDcZbX8OBAZiA104uPiOvL8MUkkfDPY8HZzGOTRlgC+1LZvtofkPaFLTJabuLi2TdzJLG8SmA/S8QGf7ZLsyrbouhLYSBUnbnm5TGqIjscnQJPrJyg5PYtrwDO6ZBqsIH5BHSGEvEiPO3q7yOTvptu6U26u4eUZiUCfyOvcGPBJ1H1fB5rsTNcX9dpKrDrLoo6BwfxIySp9OYfcq1ongbW43mE+5KPj4bQTrp6RsTGm8ZO5vSarusgCE75AZnYDsOkKNIkEne/ITVVrqxStjbmIxVPinwz7+7kIN4Dtd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+7c5efgLnWyKm5KtAnuJuDkyLjcphPNwCXifIb16Ig=;
 b=ev5vViRxBA+hWfjY9q2h4a6SFvVe5XWwoChgok8GA3ALt0FEFyrml9+m4G7pqPkeYMzthnz+xHsB+K/R05/MUDTTnHi2MfIXZCYuMPWw/lq5sRCm1yE/7MtUtjn1ujdjRdDsEidhksXZJsoe/cfF6pF3lHveMVdg9a39m1qIa3TWm11iddHozAZNoOw6UtjF7tZHf3HdJ6JaFTmiCvxiEaX62525GuQuCMLa3R2DeqnlF+wxAYW9CUz7BdCDMgKwGfXyHdiozNgOjs8MbFr6yK2x/UsAKLlXzIjrjonUDOWA6i67yTQhqRQLsQaRhMXcBpk2KydA4B6hxEU2rTST0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA1PR11MB7129.namprd11.prod.outlook.com (2603:10b6:806:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Thu, 15 May
 2025 06:02:51 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%5]) with mapi id 15.20.8678.028; Thu, 15 May 2025
 06:02:50 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: david@redhat.com, jannh@google.com, aarcange@redhat.com, hughd@google.com,
        xemul@virtuozzo.com, zhengqi.arch@bytedance.com,
        akpm@linux-foundation.org
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 6.1] userfaultfd: fix checks for huge PMDs
Date: Thu, 15 May 2025 14:02:37 +0800
Message-Id: <20250515060237.467793-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA1PR11MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 57beac35-b9fc-446f-4be1-08dd93761fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NypRm/XNmKz3NLz/W46NXr4gs7SEPQns+2YeUyIouO0G04BW4m2q/crnu4or?=
 =?us-ascii?Q?6WCKJubP3NiTEtfb5lOyxv6lZB6djtjzbWwUiudpUn2wPAN2q36y5B/0NtPc?=
 =?us-ascii?Q?+9DtzrYWb79v6lJrhWcD0igTPwu/OeoW0OGtZJ4PuqL4hUr8H/s3cKGw0BPZ?=
 =?us-ascii?Q?m1beqiQqnFDoXpVHNUjWeACsYFELaAXNxhQ8lueHmOPlbdS9k5ZqkxT1RaDs?=
 =?us-ascii?Q?jR+32DuuPWl85q4Nsfw4Ka2uMxs9QDAnvbu8K7z78lNFEdA49q7ZOeUFJ8+y?=
 =?us-ascii?Q?oG4ETgZhQqi/SkftJNtDf3aERTjb6ZNAwMy7cVEw5AXVRp5/15nC5lGGG+td?=
 =?us-ascii?Q?moqKV+aTyb1RCXmbLBtip8wiiRI1r4zMQV5dzYuG/dbOp4ae4ZWnXnCbpzJt?=
 =?us-ascii?Q?WdVPZDnFoiMXeKk+D5nvMWL0OlkGD0RT43e1PosCXNQBnd+HcucWSN9e/5S4?=
 =?us-ascii?Q?MJkUq2Ua259UyT2HAKZgVO9p3ZJOBZLUt5irz/VoCsd5BIK8jAtkYhs+BD3w?=
 =?us-ascii?Q?qVaq8SPDhTQljQmtpw4dRmcp4uM5RMeEHTFDx23Zh1siZd7fa8MqsGI0qCoV?=
 =?us-ascii?Q?FmeXSRVMKLClbs1wXD5s7kPfaKu1iR1eHsLRr84iGOz1syNawN0eBFYbaypM?=
 =?us-ascii?Q?ZVe25rWlZG3EAtWRBGDcAyJNn3bNimND77vyxi/wSAaH6KbPpzLlKKgWLlrW?=
 =?us-ascii?Q?JbXQa8RVBiXq7icyq7sGZzcqiUNYiBToMsTYOeK3rcKZFFp4G04IPRrrc67L?=
 =?us-ascii?Q?FcaXhqrI9mVSY5nV/z2raAuXc1a0I0tVMWndOenbY5JYb5yYJIgnARU4IMir?=
 =?us-ascii?Q?KRTD052bMxkVsedkEQ3DOpLUri5XnkW+JS+jbFeQ4RMwyI6AGrAqt9gKaLEG?=
 =?us-ascii?Q?IyvqZnZRirB24Oon/NlTacHQJoLuBJjX6m8aNnvtMDuPtsKMk+9xSJRESWol?=
 =?us-ascii?Q?+pqJIrCSBDr9ywS1Xjm8b2rdruSsXI9rqoxd+iwFou7lYH6bjemmHR3sg8oS?=
 =?us-ascii?Q?JbqZjkPom4pswzqH7MeGqDgJFrsWnWvYyiI+OfEHCYOrR9dB7KLlvf8FCWYA?=
 =?us-ascii?Q?4TFmEj10bS7WUdBnc/kTWlpYdV/vRtn4uSYuqfJQvPqpTE9sbMNGAe7EKetE?=
 =?us-ascii?Q?CTPX3iC9sus99oC5GmWMe0B9G3HYa9MoSCRPsXURKTER7kVgmbAFy42ClGyZ?=
 =?us-ascii?Q?TZx8zIr1TGm6W8sjh/ZLd5dprxSo0FONQZP0O4HCOSvKXMZGtRdRDJNhD0dk?=
 =?us-ascii?Q?JtySDj79t/xT8eaA5NiAwtfmBBhu9rUmOohuaubGXeBlUR6PA2qITS1zMt6H?=
 =?us-ascii?Q?Jrv6CcqPqZdZZ451n97zhYQ1ggeQbe7AzeyMCByNTmlURCJADjyfnBNN1mkA?=
 =?us-ascii?Q?Q4o9Dp7VNcSzvlKYFoSXdrusUS4u75w+Dwu77eFypJezsmAlE2M9o5718SMH?=
 =?us-ascii?Q?QkoVLq7GsLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COCl/Qt3mS6wTqfAp1KYvMSXEkVyoldojUwgVyFO5jXi3dhAMliTJZ4BwDrH?=
 =?us-ascii?Q?b1xD4eVW7oHaueZOE9U7ejy8eV7LGMnfOIQ/RGrkkQB55NXEWDehVzrMtwxP?=
 =?us-ascii?Q?3dEp+ORcMnLgybAVFnA2kgFCHm+Z83rM8ffoQCp4GGkTeHL/klKlpImUWOLN?=
 =?us-ascii?Q?CjXM4g7KW6RNPJ+Kuqt6ib0zMUZrgPuz3Rqk+EA9O0jHnoToj218P+JJ7EyE?=
 =?us-ascii?Q?AShS6PJiqpkia4qtw2eL96v89V/hKrlkZoXgA9hjIBDKnxnw73Md/C4yUt2V?=
 =?us-ascii?Q?BUvjrRoBCkSBJfp8ZQMe6o+/eeWI+eQLoFaw6p1DnSqUVsTERPQhD01CMo7X?=
 =?us-ascii?Q?/8qnJ9qiDZq6CwbRT/pvznXI5ZYkZiIbgMQiKzx593EWJGl3qLYyWd8c9FXa?=
 =?us-ascii?Q?DLNZ3B/dORTNb03BMXU+ob8Z9gizjzoxE6TXKwKkrv9defPCJke9ahdu7Onf?=
 =?us-ascii?Q?stetKMtYZ4KL134FVVSr8d5BZl8OgE3VFCbvxHsyiQ8rkOr85817T2n4W5zQ?=
 =?us-ascii?Q?RrYzN5p3+LxvWQLCxbokWOUX8G9exm/UYk3u5CChBEw+MJSnlDLFZ6YZ/R/W?=
 =?us-ascii?Q?XT6Qf0Z/16gNzXHTgIJGfP7cpG9tRlrSAuglGjrqGWvhQguZdrk0lr1OqNw6?=
 =?us-ascii?Q?ClLhT3x1P4G4cZmNxKhS+/aO6agzVtTWc+kG7giAHv9JnydOgf0tEed98WdJ?=
 =?us-ascii?Q?X4ZSn9xHvQ5J1AeKbPdx4eyfqCb2YvICyg7Zgac6R8JQL7gVubvWrIcuW04L?=
 =?us-ascii?Q?s6bt/lYxfn9HYQtOz9nTlHwi9DBsn1TG2YaQWklncOgql5CcIpAV/VfC0ATi?=
 =?us-ascii?Q?ByovpiB4JC2AbOpTW+F+Vc8b2XsPN1AVDvSBRJbuj5r5BdmJfUC2JodapdNd?=
 =?us-ascii?Q?BGhzjxnq0Kc3sOeYRWKLVWGTc6jYTN5VWY4zCXo1d3p92DK2yEmYeD/ynDQx?=
 =?us-ascii?Q?Ee3+JG6/4YVfXbuu2W8cHlWgwZ3+ibS/iWfNiaD8b1M7nMEmattVB6cT+eU7?=
 =?us-ascii?Q?mRdQaaMPNsEfu1TKJPgPzUYTk4VMgJdm1KWElzFNAVFy2UVw2NNcdpoGJjog?=
 =?us-ascii?Q?1twuKql90bpwy73anghkp47AjH18V4aqXmMFhFvU0335zkWzVXYDSeOt2Doe?=
 =?us-ascii?Q?9/7aKh2NQv1yd63zXyHiD8Zm1WWb8Y6zpLg2tFEotWz1gxbf+eaXC1MVJHz/?=
 =?us-ascii?Q?whEw1koywfA0p+J79p6mzx92nfaqM0ias4V+gi8qWUQ5NsaDwwZSzoCBvoZV?=
 =?us-ascii?Q?3z3foulgLkDxkKPks2BL4/YhrvCo/XE8IYnxIKW7rb4wRZbJU6gA/F2NKTMP?=
 =?us-ascii?Q?Qgx4q2YIB6g0+TMGWKhN+JCA+xxozGKVuTt9vpOX7QRgF1JXkUKEM28tvxyZ?=
 =?us-ascii?Q?tV4YTIgRD1XLJuV3DQJdzzeHOdySDf/fSO/rOqQXYEpdDQjbeKUuqjhkcE6d?=
 =?us-ascii?Q?pVhzQ7dsSHI6Ii7PCE0lQ08F+ctHuSgu7Z2OxnroOBkms206EfbcdoXpwxaP?=
 =?us-ascii?Q?ofbk8b3qokF9A742Pl9D9LTFjg9mex8Vsc/2oGlmhTHBqc6BJpQEzlJekzZ9?=
 =?us-ascii?Q?gZWEU4Vw95IolAkX/evEPxjJ09eFnHZqPCZljTZ8gvsZX6bWB1rczX6/Xfm5?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57beac35-b9fc-446f-4be1-08dd93761fbe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 06:02:50.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +q4o3tVLz9zu1CyRiL4vDVj9pI5gSMmYs3DDsls362n+3Vx2emjWrjJPuEXspKmw4wz8elUusrRHBn6nzJLSkHfn6HbaakT4Z6UrQEwUOyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129
X-Proofpoint-GUID: _NpYbRlG_oQLkfzebT8sR2fiOcoovQIC
X-Proofpoint-ORIG-GUID: _NpYbRlG_oQLkfzebT8sR2fiOcoovQIC
X-Authority-Analysis: v=2.4 cv=IIACChvG c=1 sm=1 tr=0 ts=6825838e cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=TYBLyS7eAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8 a=RU-NKkA4J28zLw9J3hsA:9 a=zvYvwCWiE4KgVXXeO06c:22 a=HkZW87K1Qel5hWWM3VKY:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NyBTYWx0ZWRfX9r0hk65FGujz Oqn1wgTN8+xmk0QgsTP1igKMnwesdGS5IHmC4e1EQkedXkKwvpWCh7zMkwrmk9gxOc7qq/Is1Ms Z5vr62JjS9nNyVI17tLLVeK4QhyRii5hJC4c8Xr8g4SfIx3vtbe8g6LY+eRkSwdxrAHg/kVnU1h
 /pDGITfNE/IzWk+KNvoch7ljUtKGKw3BwNx4cA/Un4YVYDwcsYKQSMJTYWbxtJzVy+M5DhoHg8o U/4o6ybaoy0qRJdBdCNZ/0yLP/L61i21hnHTD9xrozRZURGJWTBQzCeul7i9q6Q+y/CCO6QiKzQ 9TMVT5OV8N1W3b2ViPGYu4Kt9Ze0lRddkiYT22vXL3UR3Z9vxYbnH3Ak6CtWXeZyDEkl0Ljze0s
 zf1Qf6bJS/IaaCLMZJ3SmyVfWhMAPa/Qflgvmg6wavlYFvCR6iMG+4pgRDq0/gGUMO8rHrZV
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505150057

From: Jann Horn <jannh@google.com>

commit 71c186efc1b2cf1aeabfeff3b9bd5ac4c5ac14d8 upstream.

Patch series "userfaultfd: fix races around pmd_trans_huge() check", v2.

The pmd_trans_huge() code in mfill_atomic() is wrong in three different
ways depending on kernel version:

1. The pmd_trans_huge() check is racy and can lead to a BUG_ON() (if you hit
   the right two race windows) - I've tested this in a kernel build with
   some extra mdelay() calls. See the commit message for a description
   of the race scenario.
   On older kernels (before 6.5), I think the same bug can even
   theoretically lead to accessing transhuge page contents as a page table
   if you hit the right 5 narrow race windows (I haven't tested this case).
2. As pointed out by Qi Zheng, pmd_trans_huge() is not sufficient for
   detecting PMDs that don't point to page tables.
   On older kernels (before 6.5), you'd just have to win a single fairly
   wide race to hit this.
   I've tested this on 6.1 stable by racing migration (with a mdelay()
   patched into try_to_migrate()) against UFFDIO_ZEROPAGE - on my x86
   VM, that causes a kernel oops in ptlock_ptr().
3. On newer kernels (>=6.5), for shmem mappings, khugepaged is allowed
   to yank page tables out from under us (though I haven't tested that),
   so I think the BUG_ON() checks in mfill_atomic() are just wrong.

I decided to write two separate fixes for these (one fix for bugs 1+2, one
fix for bug 3), so that the first fix can be backported to kernels
affected by bugs 1+2.

This patch (of 2):

This fixes two issues.

I discovered that the following race can occur:

  mfill_atomic                other thread
  ============                ============
                              <zap PMD>
  pmdp_get_lockless() [reads none pmd]
  <bail if trans_huge>
  <if none:>
                              <pagefault creates transhuge zeropage>
    __pte_alloc [no-op]
                              <zap PMD>
  <bail if pmd_trans_huge(*dst_pmd)>
  BUG_ON(pmd_none(*dst_pmd))

I have experimentally verified this in a kernel with extra mdelay() calls;
the BUG_ON(pmd_none(*dst_pmd)) triggers.

On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
pte_offset_map[_lock]() to fail"), this can't lead to anything worse than
a BUG_ON(), since the page table access helpers are actually designed to
deal with page tables concurrently disappearing; but on older kernels
(<=6.4), I think we could probably theoretically race past the two
BUG_ON() checks and end up treating a hugepage as a page table.

The second issue is that, as Qi Zheng pointed out, there are other types
of huge PMDs that pmd_trans_huge() can't catch: devmap PMDs and swap PMDs
(in particular, migration PMDs).

On <=6.4, this is worse than the first issue: If mfill_atomic() runs on a
PMD that contains a migration entry (which just requires winning a single,
fairly wide race), it will pass the PMD to pte_offset_map_lock(), which
assumes that the PMD points to a page table.

Breakage follows: First, the kernel tries to take the PTE lock (which will
crash or maybe worse if there is no "struct page" for the address bits in
the migration entry PMD - I think at least on X86 there usually is no
corresponding "struct page" thanks to the PTE inversion mitigation, amd64
looks different).

If that didn't crash, the kernel would next try to write a PTE into what
it wrongly thinks is a page table.

As part of fixing these issues, get rid of the check for pmd_trans_huge()
before __pte_alloc() - that's redundant, we're going to have to check for
that after the __pte_alloc() anyway.

Backport note: pmdp_get_lockless() is pmd_read_atomic() in older kernels.

Link: https://lkml.kernel.org/r/20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com
Link: https://lkml.kernel.org/r/20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com
Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ According to backport note in git comment message, using pmd_read_atomic()
  instead of pmdp_get_lockless() in older kernels ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified on build test
---
 mm/userfaultfd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 992a0a16846f..998c7075c62a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -642,21 +642,23 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 		}
 
 		dst_pmdval = pmd_read_atomic(dst_pmd);
-		/*
-		 * If the dst_pmd is mapped as THP don't
-		 * override it and just be strict.
-		 */
-		if (unlikely(pmd_trans_huge(dst_pmdval))) {
-			err = -EEXIST;
-			break;
-		}
 		if (unlikely(pmd_none(dst_pmdval)) &&
 		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
 			err = -ENOMEM;
 			break;
 		}
-		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
+		dst_pmdval = pmd_read_atomic(dst_pmd);
+		/*
+		 * If the dst_pmd is THP don't override it and just be strict.
+		 * (This includes the case where the PMD used to be THP and
+		 * changed back to none after __pte_alloc().)
+		 */
+		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
+			     pmd_devmap(dst_pmdval))) {
+			err = -EEXIST;
+			break;
+		}
+		if (unlikely(pmd_bad(dst_pmdval))) {
 			err = -EFAULT;
 			break;
 		}
-- 
2.34.1


