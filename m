Return-Path: <stable+bounces-145042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108DDABD2AA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A65188EA1D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8264521A457;
	Tue, 20 May 2025 09:04:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9262AD14
	for <stable@vger.kernel.org>; Tue, 20 May 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731846; cv=fail; b=IfMRVYo0Y3BxmzZIzZXBSWwrZEXRZtaFHjAdVzLCIynlg83JdaS9aPNoPGQQD4IkJeBAEqtOv2Lxcei31DwlgvexlRpX7I4Yg5INyj9XvugxDlBp23bAKAn9MnLLCUhF8iDLb+dK4tj7ctKGKPm/Z2cEBaN0examgD35+/FY5ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731846; c=relaxed/simple;
	bh=YB0COiXU0eICSBrW/ZB3CBtHMf/8CtCjfYHP7NwBzaM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pP3FVsWznephYJQXH17EGOyZ/1i6AueWaHkoCsftrGOhm7a/ixxT5FJzrTWFcTSu7SNGnhNQi/+Y6oSMVlHuaqIHpHadP0i9VzDvkO48wyRehVOPSGn+DwbOnd6qZruuK1SiGIErP5dnRNpBpTkzNXDBrnGXdg7oUlk7TpGQjr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K50mid003122;
	Tue, 20 May 2025 02:03:35 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46psykjpgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 02:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5LNmQ2cQmhVicNvu+eixusB5k+6+gFs6yMuleRiH8uPIqClGxyE7eVCyRLg5tyj2fK9tRbZ2sd0cTajr4qBy6hJJas9CGFd2APFmU1WGenQHyFV8lpZ8jsHo/IPdTrJBAV5YefPWCR3pSTvCeLFWg9cVH12htV2UFPm4+QneRwWYLjGzS9eDReCTZhKKECUNpbdVx7MRvAnKFwaSwrrQbew7nrxY2m1r/acW6dyjL5Xhhg8uhAuh5rjgHTY1fXQEvGqvPVFgBaW+ICzicKZfLzAV0HjgxTVk6sZlP7na+DyzJifEn2cBswlTHyZE5YVvDLqDnejXo3rC489caPifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtTM5tLPtoMDU2syrOSkntKVJaFH1tEWXipf4ff6a+I=;
 b=yN8S0cH6NIrZYxdGdK1akKkR0UutVwogH82n8ozivVNIp/2cJInSIHEeWy6NrcqHzRpPavZterxEwzFPYvzroRkltSr1jTrr7XdJZjkhaAkfw3uGH0IHdcGMGX3RviUIyl59ZfOufvqHiaglOGb2EATaRA6cspBM5aQpxb59nJFUXQUneVvxAOrG86KRZY5U00xSuNT3rD023gklYSUvX15gxhPxE7HrXc4/Nwh1o5cZJlVuCtDkDRVEZ7iE4WQz5i8FiYPZd3yGOewIKQ30LVqSFqyiXWIVCz8HVF8hRogPcEVVRIIgHzZXWToDy98Dr6Wi4abahwgUggeTAKD5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS7PR11MB7781.namprd11.prod.outlook.com (2603:10b6:8:e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 09:03:33 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%5]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 09:03:32 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: mawupeng1@huawei.com, david@redhat.com, linmiaohe@huawei.com
Cc: mhocko@suse.com, nao.horiguchi@gmail.com, osalvador@suse.de,
        stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 6.6/6.1 ] hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio
Date: Tue, 20 May 2025 17:03:22 +0800
Message-Id: <20250520090322.1957431-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS7PR11MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: da5a24c1-bca1-40b5-4c41-08dd977d3238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+uNbV2Ualk2693BZ9uLvwQKCc9nV3RUiFNjGopWaE3mxN91SlVyjtZW/VHw?=
 =?us-ascii?Q?T7cSCj6ueFPTn78sujp9yvyqCnQ5ucWOYvn1cS5/CcIZfDWg0rve42PyApUB?=
 =?us-ascii?Q?Os2lrHwYn4vddhnz28BDMq0GirPIKIQrYdkkc3cR290+y/oaaAEHGpj/6k0w?=
 =?us-ascii?Q?+c459ZBmm2iQnic4EM1cK8wFZNDPFDKydDC+QBduoNh8gcav3uxPN9iuATKd?=
 =?us-ascii?Q?Dsrb9rsx+vLTJ64CnwAdIeVdTcKN0xmge6x98/iDf/lCJSojLYbNOcMJRDWW?=
 =?us-ascii?Q?kUkbEfaVvE0shjhP19aIlOzruFyW9e67uywXP/HEvf6KmsM8zzWohBPEHEQc?=
 =?us-ascii?Q?GAxIMToxzlXNs78rHSDF1SY591Z+R8xmHGBSkDvRZ2elYRXPjHva+Q8eB+gY?=
 =?us-ascii?Q?Uv+aCllUNt01O9j6X0ryUZ5/ZZTNT8OTV/0N3EXgXwv2aul+CI7mqhGqHij+?=
 =?us-ascii?Q?RZfH2MZrptchc1XNWGRD8Eo0gO9HnJ5WzQ+nS3yH46x8tXgB7seGwqg2zpYi?=
 =?us-ascii?Q?WJ+buynvLSdf0jkzbfw8Ub3WyFiCZTJpbBiCsLePF9Sel3LGxZLIwh61neu/?=
 =?us-ascii?Q?wvYVdeFzg+HPOVmYPjrGtQ/XRjfh7eubkmaKQEg0SHYFNBYJxVhU/YUNlo3m?=
 =?us-ascii?Q?o0xRmsXuEPuCxTBjOMYZEPtctQq3q7eW7lCdd/v1kttK8z+eNuin3baK36J8?=
 =?us-ascii?Q?9YcF1l68j6WJj3yr9LHZFcNWdtRDZXOvRiIPCV9slzbkllFvUZyGWkCDYgrG?=
 =?us-ascii?Q?bpxOiNk4c07Zn74Seok4b4WcIw1cfBDJOinycOJ4q5fVJO1lokDpGj/j7VPy?=
 =?us-ascii?Q?MvL3y6VDIVwbdtD5x8TjsomMZm4+56nhNPsv5EOpvw0tdo1sBkP2MlGNRLIT?=
 =?us-ascii?Q?tpghWCLG5TyAJeHSV/Vl7+rYoZJSMaJIhtug9cykUDDf91EcJGTd1nep/4FS?=
 =?us-ascii?Q?Iml8W0JMm7CvAG+pBo6Ub7/jsAd67/ac2tUDZO43Rq3TwQ4tDkQOOmzgQ7p5?=
 =?us-ascii?Q?AeC2uUt66a7UDO+/QQhJwl1wFxdcWE9CMB9XiH1+5O4tL1TZC8rxkfiB2yzL?=
 =?us-ascii?Q?6thhgPcyodMtG6vK+VJG1eX6RUkhLkBYKe8/rB8/8RdQjWnuFuGVPApMYnEt?=
 =?us-ascii?Q?6N2AT7R777bCkbYJw3CI6fOg6UH6wEH1VIQ9XKACjw4lidDnBCwIRPY6ur4k?=
 =?us-ascii?Q?gx4KrwNQZEx+tI800CxRL/TaSkDDjmiu4i6rHO2xIB00gOeTrzFEPMYGJ9me?=
 =?us-ascii?Q?CwuH6uqlKm2ig2+WInehcFu3nI3d02wH1tmKxWqoIVWCnmFdoz2x5oLlQAGe?=
 =?us-ascii?Q?WtFGvNeE5JGfgZX2T0JI628dKNoDQPYAitiNXhyEjfAXRJcgN9cpls0c2z0a?=
 =?us-ascii?Q?JiyC33vIpkW6LZN6SfzkhVy6vBBjYCGcpsObRt3gDj7QjGGCGfC2kh9RrX+j?=
 =?us-ascii?Q?QSMG92aT2xs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CV6Ym9kHYzylDBx0jgHHliFlgAKFWhF0El/MHpfF0qEF0lsiUkVTxeTytR1I?=
 =?us-ascii?Q?3ZHL/ga7JnHw9ZnJ4+Q8ShHFY/9MB5fR+PQZ0BAgQSlKbmnH7x49mtARPrxw?=
 =?us-ascii?Q?dhizqAiGla/jGxovb79oF2F8xUGpGJLkEnj/wFTJfRsnSHDM/FSxJnN4A+I2?=
 =?us-ascii?Q?p9KJVEBA2iPzw2Jb/IxwmqIXVkz7LwXVDCZdA4TQlfqnTb4wXgXJ5W6YIjdW?=
 =?us-ascii?Q?8oEStiK6hl6BSOER8j/+UnsNpkaE+QL70ofAgurTFXSpk3RvmDKO10PlGYVB?=
 =?us-ascii?Q?+GM1aiQh+NaJ2g3b4c3gjpMOtUo6PyGsDrYXpLY6zIBMGWdcmAuYg8360Hdq?=
 =?us-ascii?Q?9VDOR+PdasBYLyYdzS4rLUm1hwqNl9jOM+n/pNvixgpglY3G4M1QOuoO/Oq9?=
 =?us-ascii?Q?pAh1Cpq6BQhEHy+q8OHTePMQFUa+jZ+jRdxTmUdUnFHXr/1vxzQTa+eldomm?=
 =?us-ascii?Q?12K518GEThVmJHiXejzIwbOUmiPhDkxVqdu17YrCK+wA9bcwuhJMdg9pipqS?=
 =?us-ascii?Q?7CItHZimQqMrs3drPafCS9LD8VI8sOk8296Bhy6DW2HiMrONezueoiTBKE0w?=
 =?us-ascii?Q?xW2ZPZHc3alxVtKzWHtvP/50GPlbmug3oBczDOaAMF7qJ1lQGJOfaxjICavm?=
 =?us-ascii?Q?K2LFJ5ZQEXsC2ows/s8cNbeFL0ywtWtBcxMjQznayLswq3Jq8w72yPZQsRft?=
 =?us-ascii?Q?2Em+7RH71meHBFeTfKV9O1On1dTWEDwFBgiVhvJu+ODkZJlxy45U3XL7S3df?=
 =?us-ascii?Q?1zun1gyM/vKdSHLxW/vDX38NFMx8VxUcuBVXMCrRU1prq0UH6ITLVa/8Spx3?=
 =?us-ascii?Q?IBGpyIrSAHdoWHT/62RS0tgG5q78U03nOMd3xp8V3nL1vllic03gEb2xcJu6?=
 =?us-ascii?Q?eaLOL5pO8PpuiGNr01ibxmhNH1qhT2It5DI0eqm0H4Hiaraap9s3Ih5+T9X0?=
 =?us-ascii?Q?A/90uZXrbMBJ0RA1c6S5ZIZsYz25jE44vrdmk9B5tqguNiT0wTVp/KYJ92J8?=
 =?us-ascii?Q?cZoyZHZCAu3Df79+gxHfRT1oo6jAd3JWvBmUp7V19iBj0dvGTm/2jFJOR65e?=
 =?us-ascii?Q?0kO036bZolxpdKND3zi00SETCzcaHcKtWnVsGmQ4TPk5uiFHVoEEzi7d4ZqV?=
 =?us-ascii?Q?nIRPNFsE49gv5RYYWlz60/vAgXkuBPvUN4Y5M/OYVb/A/5SEkdvRrfFBS3bs?=
 =?us-ascii?Q?Thw8fF3/YQi/ZZn7cqAt0OoboqHf76E8n70Unx+XR61H66qv5wIG2KgVHdj3?=
 =?us-ascii?Q?UgzExEF1r5c7YMCmB064ZwfVmHZWKKQGBivDz5e9Zl+mWRlkU0VOHxrxqC8S?=
 =?us-ascii?Q?3o0FX5xedCfDuOe71oeigLiwJTHXExN5aKFwhE76a1phdsPu/pSJKB+ku3vU?=
 =?us-ascii?Q?foqO28R/+2AIeqTDspKI6ut5cIaLMLVp1nZw7vb0RuGLVRrdQssefpno8Yon?=
 =?us-ascii?Q?Ll1i1zEliMmlc+VQ2hOjP14+rm89QGmIOGCakg9I0ER/ztyYgV1nyDHy975C?=
 =?us-ascii?Q?9NzZ1L47g2JSuPSpz/SgVJFwyK0QDYGlr0Cn/f7DoSMVBh6qMCGlT3J2P39d?=
 =?us-ascii?Q?Kk6ElHuR/Tpciuky7FSX+wD6Wfj3NOZGG1SaRFDVok0QyODX9CWjiavZIXs1?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5a24c1-bca1-40b5-4c41-08dd977d3238
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 09:03:32.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4mkZ9fswbVsVYDiQsZnwnNbGgwdlOCRMkXeaLgfbD6DuQ/us89DNgqLa4Xn5DqAQJyHkhadG+Xx1JBout/JFFW07IC7spLg+ToAH9eEzuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7781
X-Authority-Analysis: v=2.4 cv=a8kw9VSF c=1 sm=1 tr=0 ts=682c4567 cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8 a=07cXAkuOJHpLZClu4qcA:9 a=WzC6qhA0u3u7Ye7llzcV:22 a=HkZW87K1Qel5hWWM3VKY:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: j1SO-EZwYfbzXZiblhebebsvNm6NT6Lv
X-Proofpoint-ORIG-GUID: j1SO-EZwYfbzXZiblhebebsvNm6NT6Lv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3MyBTYWx0ZWRfX3XdaS3zt03TN CB+MX35J5GIEP0smBtFf6r61rA/ZugIVY4mBYYmpYJV/Cw3/6anl4v/I8rxeZBrDy3Gd7RgQ96p ZtKQP+LaDTpy1PvUzywB0nVU2ncMbWnOzt+ZzA4mJPaPoKDpjZKZMH5PT3c14jHXMwDdfuHdK7s
 +rfveKyp6eSDpv2WuJYofhLV08xuX28a3GlVT1LUMOVPlZOvLWp0Yj+pxy7s4nZSUsa+OcX/zF0 +KS17gASGPDQ15dmD+Bq1jhB+05vBuDjknbb6Ca+1mPRrjX9Qyb5X+57scxcX9KhR7mObzwQ4Fu QoD9KmykHZvx+Vp8TeIcH3ccgZ/1v7XT9Cn+5SLSca3n+ouydgqy1NzXRt6zDqrfGRetLjpyXPI
 hE1O9iDE5HDvwKzNSZVBI+SfZwFXyleQ3zxjVlP2KHxb1MaLFsygM9OQQwPWPHyoieiO57NM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505200073

From: Ma Wupeng <mawupeng1@huawei.com>

commit af288a426c3e3552b62595c6138ec6371a17dbba upstream.

Commit b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to
be offlined) add page poison checks in do_migrate_range in order to make
offline hwpoisoned page possible by introducing isolate_lru_page and
try_to_unmap for hwpoisoned page.  However folio lock must be held before
calling try_to_unmap.  Add it to fix this problem.

Warning will be produced if folio is not locked during unmap:

  ------------[ cut here ]------------
  kernel BUG at ./include/linux/swapops.h:400!
  Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 4 UID: 0 PID: 411 Comm: bash Tainted: G        W          6.13.0-rc1-00016-g3c434c7ee82a-dirty #41
  Tainted: [W]=WARN
  Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
  pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : try_to_unmap_one+0xb08/0xd3c
  lr : try_to_unmap_one+0x3dc/0xd3c
  Call trace:
   try_to_unmap_one+0xb08/0xd3c (P)
   try_to_unmap_one+0x3dc/0xd3c (L)
   rmap_walk_anon+0xdc/0x1f8
   rmap_walk+0x3c/0x58
   try_to_unmap+0x88/0x90
   unmap_poisoned_folio+0x30/0xa8
   do_migrate_range+0x4a0/0x568
   offline_pages+0x5a4/0x670
   memory_block_action+0x17c/0x374
   memory_subsys_offline+0x3c/0x78
   device_offline+0xa4/0xd0
   state_store+0x8c/0xf0
   dev_attr_store+0x18/0x2c
   sysfs_kf_write+0x44/0x54
   kernfs_fop_write_iter+0x118/0x1a8
   vfs_write+0x3a8/0x4bc
   ksys_write+0x6c/0xf8
   __arm64_sys_write+0x1c/0x28
   invoke_syscall+0x44/0x100
   el0_svc_common.constprop.0+0x40/0xe0
   do_el0_svc+0x1c/0x28
   el0_svc+0x30/0xd0
   el0t_64_sync_handler+0xc8/0xcc
   el0t_64_sync+0x198/0x19c
  Code: f9407be0 b5fff320 d4210000 17ffff97 (d4210000)
  ---[ end trace 0000000000000000 ]---

Link: https://lkml.kernel.org/r/20250217014329.3610326-4-mawupeng1@huawei.com
Fixes: b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined")
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified on build test
---
 mm/memory_hotplug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9beed7c71a8e..aab166905452 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1735,8 +1735,12 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (PageHWPoison(page)) {
 			if (WARN_ON(folio_test_lru(folio)))
 				folio_isolate_lru(folio);
-			if (folio_mapped(folio))
+			if (folio_mapped(folio)) {
+				folio_lock(folio);
 				try_to_unmap(folio, TTU_IGNORE_MLOCK);
+				folio_unlock(folio);
+			}
+
 			continue;
 		}
 
-- 
2.34.1


