Return-Path: <stable+bounces-134519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431E6A92FF3
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 04:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D0B19E7B81
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB672673BD;
	Fri, 18 Apr 2025 02:29:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801BC770E2
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943381; cv=fail; b=rdAR0saim2DsSusuOevZ3Z7o+VQGtMSPzIJj51nM3Hyytf9jiyzeYufNrvY6/kLyFn9AI65UTIrjyARa5h/d+KdqQcLssIK4zuwpC440jEGam06mV2Nb+NUSo+lr0eFFEcfiz5vkmUBagESY+BSlJiaKe1+dOVJ6JFY6OJsDFGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943381; c=relaxed/simple;
	bh=AAZpuhTHyjlgZqH7XcoC7gUk0ygvABKMDvGxA1Qi7B8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=StChxqPoSZvV7UCphuFQRgHJ9D+qOV7Q+8yxmbLzAQethlvW7CK8M0X5sAzFr/Vh201svBcAYoMW/NiWefctn+4L9wftozPUwi5ABQjVbpzYkJVQQFEKS7n3amm4mBH4ff26B4U595jhtv2U/cZpBIP1eW/5uXYwe1uEBhDWLAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I1HQXA032740;
	Fri, 18 Apr 2025 02:29:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 461u2mbg8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:29:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK6FoEauVmK6u1MqnpruAwII3Lx+mDqyefoirH5IXsTjB4kXOXF/DETWjBVuGPrCpv7d/zypVvzj7ZTKdBgoizsf9zK/tPlhdzltRiVOyBSlA5FJIoya2R80KSLP7Vz8lI3vQS5vfh2xAtu4YWTaSKZAZ5icjH1ZHGaxgsVboMx5LjiFwNZr4jaIOZtMnJARV77AaR6ld1YJecXFxICcqjSRUoG04LLoPSn6TVknh/kQoOYh6/N2Cms6LH7tGXFwfvy1t9ivVj9sjIa1lTImrp+R3UXyIzBZZOUyODQcK5uVZ0C7DhyN4jbKHK0S0/J2qeqBLXpyQsMDVXhrotOtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06FQ428aF4pJYejDB20K4kT4Lruq3rgb4eWmGc+FZEg=;
 b=v7DuyLD2Rsb30cTt93XuFdur4aUEGTAbsYTfeziEIUZwchnh0mPeiFRIXvFd6Z4Lndeapzq3n95a0zQX7OMLqIah9QSCWJHShVeej+wrc/w9iz7ZuftE2B7uy8Q44DUCWYbOUxCaWZ+fJWTpWUjG3AJHXDMkDoblE3sjGF0AUeCX3IKniGDEyOmdd1LVhaWY/0SmR/3kUHhkKu+4UHOGdzT7RtQXwO+hCBlPcBEmSK76jU4WUhcmdq1PsbHkd+mzn9EryTwT1bt/euvbMk6UCmUsPDoF66915lDdkcdx1ogd9TCnLTaD39RdGOvyAfBHcWvkhCfp11rV3nrbU1fGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by SA0PR11MB4606.namprd11.prod.outlook.com (2603:10b6:806:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 02:29:31 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 02:29:30 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: duoming@zju.edu.cn, gregkh@linuxfoundation.org, sashal@kernel.org,
        Zhe.He@windriver.com, Feng.Liu3@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()
Date: Fri, 18 Apr 2025 10:29:18 +0800
Message-Id: <20250418022918.80411-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0194.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::18) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|SA0PR11MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 259f8a77-ed3d-462c-d04e-08dd7e20d939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZXvK9yKtEu1Z4HLD2tk+7oHiDvZC/nZUyC/cD82OwNgo5hucx2/8iVDq8jV?=
 =?us-ascii?Q?LayOhHshoIiDXjEsdFOuAxJWQSSxkowVL1+RMyvhWS/XfPF9M2dc/3NE5XSE?=
 =?us-ascii?Q?bBPKD6djHMe2gmUl0jB9y97zQrE0ag8avGJRATc9rviaXGeW0lkTn5BRUUiu?=
 =?us-ascii?Q?1yee+4m3uoedlefc8d/WcZHY4E4itT9rZr3OxH21Q4MvBvkp4n2kGHK5I6Fh?=
 =?us-ascii?Q?zdOjEd3wBuG2yvx2kWCiQ22rZJSQ/uequPjAMz/J8baxWAsOxetyY3wIpYmb?=
 =?us-ascii?Q?E87ooopYGv6MWDX6uLhs9mrYxViTC3QhN3groGzknqDLL0I9IwbivogsVvBc?=
 =?us-ascii?Q?+0b4v7JAGAWiOX0c5zR1iMPFy5hpk9Pf5e/3UpS0ZhbHJlzAuQzOErbrqTbs?=
 =?us-ascii?Q?+X2ylGs03PN8s3FKFPSsfvy99d34miOuz+LVH35GWtb0EjnWzuQE5/nN+RzD?=
 =?us-ascii?Q?5uQL1OPVcTrFijr6zgD2wdR+OLpu/2BHLCDW/c1WCY4M+xaW5WNCp2dwQHrM?=
 =?us-ascii?Q?l3lOcUBQSbCEIpVGB8q7QpXO5kdFeDDsjCHQnel2ZJi4jr7Jb4TkFUtwTJL3?=
 =?us-ascii?Q?qu+9PBqiYTWVq2Hh+IEfilclmdDvUf0HF7QsBjFKFbYC6H8UFtUlzO+FiRZo?=
 =?us-ascii?Q?RuIGKL4crRlWhyQQnrSL/jbeAmVRBHnu56Chp3VL3cpPbBGNTm4OTjtPPx2x?=
 =?us-ascii?Q?+AmqQgZodKuD7MTkS2+wDV7zNm7QPz5Ykt0BeZOUo2q/eRHd1p24yHFm6ftM?=
 =?us-ascii?Q?judmuJqRzHtlUv+jJxLc7yXt0qRjFt85OF8Qn9TAej8wQ1DayZZN8wVj3xuc?=
 =?us-ascii?Q?iKIfWdXZOBiqxVHzUKfBcB+DL/jzv5kUJ6RPywbPi8+nURmN0MlAZ5si8wjY?=
 =?us-ascii?Q?2TaxoRrJ/ax/FC7JYZUUU2DqhNfXH4U0+wR78g0+FDf4kG9i3lRsWOCSKr6N?=
 =?us-ascii?Q?I8k1+FyN1ch5+Y7fHLOs3SQKq4l8tNZQw9p+ukFlfc5RcgVUU42bYTMRX+Vd?=
 =?us-ascii?Q?uLIQjEF9pKIl49BLSxzFFIypQZFQUJiE8r7x51pyYJ+5LULnt/yCLFsZsDLR?=
 =?us-ascii?Q?5NznsLFCscVKtF7BpyrPJKIBudHxYILq2N7onVptlLBRppvShDiTRZ2ekTHF?=
 =?us-ascii?Q?rtdq3pdcxhuidwob6YooSCq69jyGGWuho+241WwdI9CE5Ym1k6lSl8xeOfxs?=
 =?us-ascii?Q?3+Zujae3vUZ2ec2eXQgF/0bNSx3CH+g6MhPl5nC1pT9TuwDCNzFM4z9y0K3v?=
 =?us-ascii?Q?nc9EHexu1/rCA26qmD2JRWz2wvTCLiCYOw647tY+gPig5pa1CDTktNYAxSR6?=
 =?us-ascii?Q?a8f6Ksu9lw1OGakweriJyDrxMovBMtn2tWNMpNtg3jwjakooyS8sf7IZZj11?=
 =?us-ascii?Q?fgX4SJv7WdWPxcJpojUX+Om0w4E6ssxnaDsB8x6zyKn1j1tOdVsUk7I5tRWH?=
 =?us-ascii?Q?ZRF/8jnzklE46aHKCJ0gAn3rmF+QSW+eRjmwOuKpsBM/T5GRGEFLwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0a06QWo0kD/E7i8OyeyUvRrYVr+yYrydnWWIAwHpjAU5WM8Em33fzVhzYqbj?=
 =?us-ascii?Q?RKz12z5lzEbRffZHCHBJCKJSzVO9s1kEsUWsodPywUHMaTsuGcjne1Uk9G81?=
 =?us-ascii?Q?rdl0HiQaneZzE4905Kfju3ghi6Lf1fP/dlN+WMMRlkGXge2y0G7P0SGC8JeL?=
 =?us-ascii?Q?GzHqhgPzDAwfSdvCd1D0FlGy/eswN6Ob8jzzxlFtz/Tu8B2r79Gcx5/nzTPL?=
 =?us-ascii?Q?JRr+UApNOOSo7uhW22xN+grJinBvs3dpOyF3nbiixIEP0osQ2GdYeI/hk/GA?=
 =?us-ascii?Q?erAsXi7RNyRoe3DU92unz81PhuWnFLEjUKNWAzldzmTTHwGo0eHge/YYHzZX?=
 =?us-ascii?Q?j9OUgFnznISHlGMgw3O1aeFMR8f1sAh61KBeU9oeJMsYQGYHzT/0Agyi6Vdg?=
 =?us-ascii?Q?CQy4e7A4SrcNw1WLtOexgLEZ8OkPJOfjPcez05o6zJDbLX+0bkK90S/Vej22?=
 =?us-ascii?Q?Hl83g5FD+EQ1iqxCXRt9sg7oYVH5DWEf0EqDRf79/E5gpYgZa9nvBqDI7YtB?=
 =?us-ascii?Q?t1benWQnQglR78pKcm/8XKIpWNpdT/GkCe0hMPKpf54FsPx+SBXFGSPWIJL5?=
 =?us-ascii?Q?m076Sed+FXWTy1XH5F/ufBe479pIVD1m5PM49t8Ak0gGoNDSgkMAERKQyr5L?=
 =?us-ascii?Q?POJoxW+5vDwF7grr5LMYWZqALsicciO2Q9R3VxFP2AV6DYoLDA1ZYJhFibA5?=
 =?us-ascii?Q?zVHOb5O6ffUdSPG+j/3//Y3DfWR0IX7ZcCYqGJCQ6Pj70FNvb6w3Bqp5v2+k?=
 =?us-ascii?Q?5V0+Zkv6WN64af4IOG3TB98ipv6EWJhM86FHuhUALRQxXXAeGByr9Ah/ZEuT?=
 =?us-ascii?Q?C7dTTcQRNMgknx+MzwBWNz+wDZuBh8EeCobnGQDBTDj//8Jj8827+aeEKCM0?=
 =?us-ascii?Q?Dj73drnnsMbHRTamOKhUJ24Qkh2IgfU2KIjCQJfkjhrZvPoT1mda5j1T/Xp/?=
 =?us-ascii?Q?IRiZ4lPr1cjd71l85kDPyd0PJxq8FRbTZiD2+pzy7njq4exx1zqOL4mTjvrq?=
 =?us-ascii?Q?4gTsYXWm2Z6E+SicMdDI+araQsJZQrU5FxHGfBnt71/d5m7JbvW1jQszvywb?=
 =?us-ascii?Q?qO/KOixQ7R1k+hRK1bBASW/jhetfNYpZPQfI6tkNGq7xiFhXW6K6pXkSJgHi?=
 =?us-ascii?Q?gsC8YRhouu037Lubb9aaRGH30ipnt4XnjhTH+0bF3BPVP+xuMjLgZpe8hHg8?=
 =?us-ascii?Q?Tlo0uiCHHvT+wfrtbBlYZY1PWtTCaPE9afBCQLoRlNKXrU3+vAM18Vr7Woew?=
 =?us-ascii?Q?jIxXTA+V1eBOmoOltz7EN9dr5kKyZXBvwcGgDgskDOsDMLkoGbTOgZNdq58m?=
 =?us-ascii?Q?k3bHErCXrvkrG3yF6SAVNn0OxOx9IPpmpHNOeF3SIgOVcj96EsD9B7PLcUhf?=
 =?us-ascii?Q?pzpO+ZOqpKkFC+3q7cLyRf4SM9UQHGR+/p5aHi8uvf1Kk+Ig2nMAoz2HaHYV?=
 =?us-ascii?Q?Bp/BDlUlbCw6PnfEXCi3yH1aaqL65UvLRcw29I/6ewpERCkOIK8Hs13w3MOj?=
 =?us-ascii?Q?1I9W91EQ24VSs9mn4gkD6wNCFm+rzgTYfBigomAbOPqpXqho23lQKlGGe3/Q?=
 =?us-ascii?Q?gx2oU/q4BSeE3a7xiYPAzeB23pL4QHTWTOQfpyxO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259f8a77-ed3d-462c-d04e-08dd7e20d939
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 02:29:30.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvdLhgVO0VOFGFACKwgM1HBBuJTcTPMa09skvOgh/CqLqWf1Q/5JD7munFC3PajIZdfeHstAPc2YKXjeWxXzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4606
X-Proofpoint-ORIG-GUID: Cu1kJg75f-prPYIPCgSvd8WRKrQIX9lx
X-Proofpoint-GUID: Cu1kJg75f-prPYIPCgSvd8WRKrQIX9lx
X-Authority-Analysis: v=2.4 cv=BaLY0qt2 c=1 sm=1 tr=0 ts=6801b90e cx=c_pps a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=vmEiP6sn-Sb3TKX9y2QA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504180016

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit cc7ad0d77b51c872d629bcd98aea463a3c4109e7 ]

There is a deadlock in rtw_surveydone_event_callback(),
which is shown below:

   (Thread 1)                  |      (Thread 2)
                               | _set_timer()
rtw_surveydone_event_callback()|  mod_timer()
 spin_lock_bh() //(1)          |  (wait a time)
 ...                           | rtw_scan_timeout_handler()
 del_timer_sync()              |  spin_lock_bh() //(2)
 (wait timer to stop)          |  ...

We hold pmlmepriv->lock in position (1) of thread 1 and use
del_timer_sync() to wait timer to stop, but timer handler
also need pmlmepriv->lock in position (2) of thread 2.
As a result, rtw_surveydone_event_callback() will block forever.

This patch extracts del_timer_sync() from the protection of
spin_lock_bh(), which could let timer handler to obtain
the needed lock. What`s more, we change spin_lock_bh() in
rtw_scan_timeout_handler() to spin_lock_irq(). Otherwise,
spin_lock_bh() will also cause deadlock() in timer handler.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Link: https://lore.kernel.org/r/20220409061836.60529-1-duoming@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 9531ba54e95b..ba289572fca5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -826,7 +826,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
+		spin_unlock_bh(&pmlmepriv->lock);
 		del_timer_sync(&pmlmepriv->scan_to_timer);
+		spin_lock_bh(&pmlmepriv->lock);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	} else {
 
@@ -1753,11 +1755,11 @@ void rtw_scan_timeout_handler(struct timer_list *t)
 
 	DBG_871X(FUNC_ADPT_FMT" fw_state =%x\n", FUNC_ADPT_ARG(adapter), get_fwstate(pmlmepriv));
 
-	spin_lock_bh(&pmlmepriv->lock);
+	spin_lock_irq(&pmlmepriv->lock);
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-	spin_unlock_bh(&pmlmepriv->lock);
+	spin_unlock_irq(&pmlmepriv->lock);
 
 	rtw_indicate_scan_done(adapter, true);
 }
-- 
2.34.1


