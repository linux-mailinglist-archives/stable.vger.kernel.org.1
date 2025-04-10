Return-Path: <stable+bounces-132043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD70EA83965
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD304463539
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4387204092;
	Thu, 10 Apr 2025 06:33:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D6204089
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266781; cv=fail; b=YSwF9tItmqqCU0FMuvVf3eW4VOuXytPuf6X9IMgGI09tQ2ccDRpnmdHTgovYLRHTxHd1fKq5PWbiUFeIxfHIpEZC08e3q899X4BsnEEN+K5sReund1Ae73A2HWKNue+AXH6mkqMGJxK0LiVL+i+RE80Y0dZiGMfmCGWKLNHtVPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266781; c=relaxed/simple;
	bh=sVS2bYW5LhqNVkZN+SPLqjrco0Nhj90p/n+nHgAFyCc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uokbcCa2LbCaimj5amEvXsCeWKsWOfZ64Dv8Y+R0RbfUg+Y+lHAnVx1lv1+9Hf2XpbV30q4p7WHPT7SqINeJwBcTLuT8Tc9KRmcOdDboS2fKzfepuEwneHwru8OMy6JfmIS+Xx7f+lLpeGMtqbmFj+2uYasD56SW99+1uAUkbnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A5U6IR003772;
	Wed, 9 Apr 2025 23:32:55 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4e8aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 23:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl/ZfbGhv2dZC9OoZU4pGdQBpVj6IpsW8vfDBi+tYigJ5urK3c8wPR2XqqCZRyV+xIqI9jBclRxVSkXZQ2pp6hsqUF4ok9iXQJV6gqUHaMB5tXoakxCXIzfiU6nM+iEgB4uK53LAarpMEuEQly2U7X20WHgqsgauGeI/UcP+uVaBo1Eoq4Y8TGXDOTG3qnn54ktIumml3LH53v+KOvVw1E3mMCKVLYVV7z6N7ZVMmPJURGywm+Pvg2A89b52tmvV7S55DdyJJU2kCzIOA6lTMSDjqPRFkV60WhF+RIMYgNFGdyLljzgKtgI5vfn89MRhxfHA8vTC8GAOPWJ8IWv/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MROlqIapcvaLcomMdWW8rBOIcqfMfHlE8Clpmhu2X7g=;
 b=MlVFRfUQAPAXGBRkHlREheyZGt2BmqEwPLznDoq0ce1n/5weyGoG/wRZ05J4ahud9kjpT470PFEZSnBlkMga+SolgBhZwUbQgr7NhMnubuUWZOQ1CWryTy7nIWnVaBOaXIRwr1a6LfgUk0swvrFKA1xWtKMvyluUbscCR5qDrUT1V3Wn+ng/V6XfqXhSIuVmHoZ6r4wIfZgtRsml1IjECrfdF53u51GZOQ4til9Hp8LJ4GkCyjFamPmV2mqLaSEXEhm460I/I4EbrFgL8mP1yA0t3kctOND0QWi2U8Q4gMyyZSPQihypkuxYwBQQm4fpViuELiFCErR8Q30YKcoLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY5PR11MB6485.namprd11.prod.outlook.com (2603:10b6:930:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 06:32:52 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 06:32:52 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: alex.hung@amd.com, hamza.mahfooz@amd.com, roman.li@amd.com,
        chiahsuan.chung@amd.com, srinivasan.shanmugam@amd.com,
        aurabindo.pillai@amd.com, alexander.deucher@amd.com,
        Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
        bin.lan.cn@windriver.com
Subject: [PATCH 5.10.y] drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
Date: Thu, 10 Apr 2025 14:32:34 +0800
Message-Id: <20250410063234.3056912-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY5PR11MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 861db1f8-5e10-43b1-6a3f-08dd77f9856c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zz4UEHzG4SRzLY3jatndOEC5Og9zH7skJoHk9eAu/7/dD5u/C3U1/Q8q+aSQ?=
 =?us-ascii?Q?12RGJQMebZV1J8It3eMuqNYLZku4Hl8FsMfPb3ix2oJTEDffRTXK+dWfJFPq?=
 =?us-ascii?Q?rsTRH8SKVi9+P/ICfDaPzaQrORJ3x0azcBVYvYMIn+F/f07n9x9+dISnYXIK?=
 =?us-ascii?Q?xAekzKmmghQGQFmN3uamBpp6UQ48jdT/UBMIiYuV5Wnn751Xt/am2kGNo2cg?=
 =?us-ascii?Q?X+qBmAxZ287fLeHNjM+4sRKYLA/lEykZbVS8pEFZVsNTCHwH0/VQDmipWzdP?=
 =?us-ascii?Q?hz5lcO5+9BXmPwBfinQq3i4Qp/f7drw2QKBcAV3WatlHjlYpMSeRLcBUwHZX?=
 =?us-ascii?Q?NB08ARzTFFfvtWVMvb0aAgG5bp00oWaL2dDUH6/HZVnq/WCszSOmAY3bTY/M?=
 =?us-ascii?Q?6c+202wbq+qPaZE5UWv2rol/ORxM0b4wvMtAbZajqfGXpgd+3rJhtoHQj01u?=
 =?us-ascii?Q?iSgQHZ45MrGB3I9WI05iw10sA4hLPmKqWyAJ523tX51hfZCedEZxAiQfF/qs?=
 =?us-ascii?Q?pwyWjV12ibbfplby76o5OAJ2nzF3494ne3snCU6mvkaEy5oC33FEgB4snnde?=
 =?us-ascii?Q?o2ily9dZ/EUHs1fAHW98cniLN/9LIk8ESAzE2daaFxaKKi4F/qYTWwm9xeXI?=
 =?us-ascii?Q?+xJSKGfqIOPYEPFIutLL2EF9KXa9OlkT0zdiYssu9UOtEcfuO1kndsA7sTQg?=
 =?us-ascii?Q?LvoODnlBbxTUivJVxYW7+6DK9bFgDDH1tiuG5S+5dBctzNxSwTEajdNKK3Qu?=
 =?us-ascii?Q?z5Kja1ca9JbcrPpv5OlswHEulR9wIQSHLsGmMh5dpCpL7y5ILl0wzqpjnDcM?=
 =?us-ascii?Q?vFZgZqrCoZWP6k/xWQRhx6fd3jxvfC8cnDdUtqJJO5OOxMfnnmPtxHGcsxW8?=
 =?us-ascii?Q?CqvTNSuft4J7JvbSb5ZQrlnkmHaMbfndIlNuHEqxpp7DlLmw9WJkiugLlD7M?=
 =?us-ascii?Q?JMr5i+FFZMw/XmmyyOF1+jQuPRGx0IYgYIswdeg2j1JLN6hKfZyuZpDRsyyl?=
 =?us-ascii?Q?NGqypP6K+Tc1JfOtDi+sw4xeW3ZxS3nKaF621sDJ0kmPmJ6W+E/n9LPGYb9G?=
 =?us-ascii?Q?X02p/ii3n8zxWdbgXQRySpqEoWrMuvdKwRdR69bDrVN+w7Tqr32ebSFtmqT3?=
 =?us-ascii?Q?qGfFesjxd7qd9L17dJFLT3nre+TIbjrqGlXOwjFKa9PEArRyhlYoh6Hz/U1H?=
 =?us-ascii?Q?q6eD1WEB9wxe/QqRbFRoOC1eIZlOB6g8Cp4BbYC6NkDJgT9BTN0J7RzPPt7d?=
 =?us-ascii?Q?IqDvUqilsDOcZRYSDzYy8jDastvSXINkoPQQjJOSHInHydz+zemjSOf7Hs3K?=
 =?us-ascii?Q?jnj8Aeo2NrUqqvELkkvI7s9IBI70Q09w0oNSnbemKOZW8CccThrOaxs/RlI9?=
 =?us-ascii?Q?9WxQ9LsO7CRV7qUkJL2d20isTzGynfLMVztsRVJ3t3Y3VsIJfbYWKs1qo9XK?=
 =?us-ascii?Q?p21q+TvHRY5ihDYxcoACkKz1mmDp4UT+z0zsf0PO4kZ55F2Lc8LusA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hTpBbieyBYQI8AVWAMpqI8YMnmw8w/3I4QvKWuqhNsxQES8tTw9LI4/CU8X8?=
 =?us-ascii?Q?dC/yfyGUvAwQGSF7GfQFZRvzJPaX6YUGR4pPBenf+WS9sGf43wW9Hljsir6h?=
 =?us-ascii?Q?UjWCXm+JI9ETi9NdNRM5qWDCLR9neDU926OVjhwxjJbkgLWgj4qX6/bb/znR?=
 =?us-ascii?Q?qlMZk76SaSe5aMcKbuaT/xNcQ1WJm/N/VhAorR35iHAe3s36UVxsNa30mXvm?=
 =?us-ascii?Q?P79MTqsMFox+FA77ykEfmYn48Zk13Q6b445XtYZ3P1BXYX9ee1LEH6z4Qtwf?=
 =?us-ascii?Q?YqVwEaWUiId25UdyOq8r7LnnRCNqqyUSc7P2Yl0U8rODeX3hXb99pceZkYlP?=
 =?us-ascii?Q?0Yta8m3eryg15/hb5NOwEJPUpWcvCnfGk29xX4N4OxGtK/lwYjlUwaP5k6qp?=
 =?us-ascii?Q?PC9jPpYYKA0Hv4jJq/I3EB+rGEmh5+QFfxBWyIyCypaUGZ1TjUt9YCPKOC0d?=
 =?us-ascii?Q?CvaVsfgvA4+qsSJIrpFge6jMGzu+ep2cldHo7M0T6v7oF/Sb+YpD4EJcy7EG?=
 =?us-ascii?Q?5ql9A1uTD+3YaCZ9K3+EuArUIJr3TNi8yEaWqFrgBNbUir98V6P9LIWhHQVl?=
 =?us-ascii?Q?qG89w6EvNdlvNURsoXTUhpd4pFDjXRXTp835YAhDKEw876ZKMISVgA3axrtF?=
 =?us-ascii?Q?eyPXmpnrJhwssrylrYw4roiBkuiebj7s5skF34S2IGCSyr2kZZE1oWQ9MFlE?=
 =?us-ascii?Q?fbo/DTkg25MVfcjh5N8UZRZbvZ6lRcIZ/MA2PWCI0pS8X+F7gTE58HJbZ7Sw?=
 =?us-ascii?Q?LNEOVnl6u4TXq0n7OWHa30VjT8fNkPpqRZGy22/VFuTrla/B22U5e1SEbGfx?=
 =?us-ascii?Q?v2E6wChaFU9UXHbQ4AbUF46BI0Ez4OeBpxw1urRKJLWxPD6/XdNIVP37wDB6?=
 =?us-ascii?Q?qIXH/pE8KFnHUg2pQrynHBlWwSWBkL52kK16F8ZKOIHabs68JKz4kyNvBw3i?=
 =?us-ascii?Q?wcHAyk83LWynZwx8vbaE1m5j208rp5QVTQoYmGlYXH1kkaQeAPiaHJx/Yjm8?=
 =?us-ascii?Q?g9FowPMXXlRrze2+wzZ657SQcD8emfg/4mMN4WoqdwkQZi8tPw4+yDodghHO?=
 =?us-ascii?Q?Np/c9v4YXubr+DPYXrntiL2YEn4thG0RsMwSKWxYMa6bXmkSgSNxZRwHW3PY?=
 =?us-ascii?Q?CyDcFv8T0wEau9fU6v9FH3jVABFmSwR2M3wq6cwk+SxBGlzpdEaYc3gkBrCL?=
 =?us-ascii?Q?b8z9vlKsuq2sPEUlV2w9v84DdxyUimYGIpI33Y6zXfy/BOmYHyONZMp1UK3O?=
 =?us-ascii?Q?k1Cra5VSPFyC46nUdx4/foicXc3K2kV8J/g6Nnw7pmWE0qmyxDeaZCz8ETmt?=
 =?us-ascii?Q?4hjvPQPjbJcJWu0a6WDemN0mz940MgxhpgqjGmliI1eKI7Y5N1X0kMDXuotF?=
 =?us-ascii?Q?Ech2YRzZ1CZtB/6+ZycZKfkNXv4x0T3SL7JWHOinBUkSG1tzBVQsL2PMc6l2?=
 =?us-ascii?Q?wKrqHdFyUmBU5KF+JKr9YZaFZKUA6wrX/6tPTycWOsB5as/y6GB5IgUUqkuc?=
 =?us-ascii?Q?1hJPZuhb0x8UY0DDVjjJwxdjsZGRanG3ojlnPg47gcDZf9maQTnF8erH3svA?=
 =?us-ascii?Q?nR3rtN5Q1645uRfqg1LPyhGQEKLaWH/gdiBftz5L8iYmcMbKapukJR8mWT+D?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861db1f8-5e10-43b1-6a3f-08dd77f9856c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 06:32:52.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBF+PWKlai7nqRGdMPg4GFHZAvWkVOW8rofucSHCUXUKRuZ/cXzUO9c30NOaQAe2VeUsAnImbeuU4aobbG1rUaUSPf7TBshSOcPhdCoBv0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6485
X-Proofpoint-ORIG-GUID: 3T2FSwGOmO9O2bvN8bILXQz5YyS4CB3j
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f76617 cx=c_pps a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=zd2uoN0lAAAA:8 a=t7CeM3EgAAAA:8 a=EfeH0R799gOdCVKhDY0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3T2FSwGOmO9O2bvN8bILXQz5YyS4CB3j
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504100047

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 63de35a8fcfca59ae8750d469a7eb220c7557baf ]

An issue was identified in the dcn21_link_encoder_create function where
an out-of-bounds access could occur when the hpd_source index was used
to reference the link_enc_hpd_regs array. This array has a fixed size
and the index was not being checked against the array's bounds before
accessing it.

This fix adds a conditional check to ensure that the hpd_source index is
within the valid range of the link_enc_hpd_regs array. If the index is
out of bounds, the function now returns NULL to prevent undefined
behavior.

References:

[   65.920507] ------------[ cut here ]------------
[   65.920510] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn21/dcn21_resource.c:1312:29
[   65.920519] index 7 is out of range for type 'dcn10_link_enc_hpd_registers [5]'
[   65.920523] CPU: 3 PID: 1178 Comm: modprobe Tainted: G           OE      6.8.0-cleanershaderfeatureresetasdntipmi200nv2132 #13
[   65.920525] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS WMJ0429N_Weekly_20_04_2 04/29/2020
[   65.920527] Call Trace:
[   65.920529]  <TASK>
[   65.920532]  dump_stack_lvl+0x48/0x70
[   65.920541]  dump_stack+0x10/0x20
[   65.920543]  __ubsan_handle_out_of_bounds+0xa2/0xe0
[   65.920549]  dcn21_link_encoder_create+0xd9/0x140 [amdgpu]
[   65.921009]  link_create+0x6d3/0xed0 [amdgpu]
[   65.921355]  create_links+0x18a/0x4e0 [amdgpu]
[   65.921679]  dc_create+0x360/0x720 [amdgpu]
[   65.921999]  ? dmi_matches+0xa0/0x220
[   65.922004]  amdgpu_dm_init+0x2b6/0x2c90 [amdgpu]
[   65.922342]  ? console_unlock+0x77/0x120
[   65.922348]  ? dev_printk_emit+0x86/0xb0
[   65.922354]  dm_hw_init+0x15/0x40 [amdgpu]
[   65.922686]  amdgpu_device_init+0x26a8/0x33a0 [amdgpu]
[   65.922921]  amdgpu_driver_load_kms+0x1b/0xa0 [amdgpu]
[   65.923087]  amdgpu_pci_probe+0x1b7/0x630 [amdgpu]
[   65.923087]  local_pci_probe+0x4b/0xb0
[   65.923087]  pci_device_probe+0xc8/0x280
[   65.923087]  really_probe+0x187/0x300
[   65.923087]  __driver_probe_device+0x85/0x130
[   65.923087]  driver_probe_device+0x24/0x110
[   65.923087]  __driver_attach+0xac/0x1d0
[   65.923087]  ? __pfx___driver_attach+0x10/0x10
[   65.923087]  bus_for_each_dev+0x7d/0xd0
[   65.923087]  driver_attach+0x1e/0x30
[   65.923087]  bus_add_driver+0xf2/0x200
[   65.923087]  driver_register+0x64/0x130
[   65.923087]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   65.923087]  __pci_register_driver+0x61/0x70
[   65.923087]  amdgpu_init+0x7d/0xff0 [amdgpu]
[   65.923087]  do_one_initcall+0x49/0x310
[   65.923087]  ? kmalloc_trace+0x136/0x360
[   65.923087]  do_init_module+0x6a/0x270
[   65.923087]  load_module+0x1fce/0x23a0
[   65.923087]  init_module_from_file+0x9c/0xe0
[   65.923087]  ? init_module_from_file+0x9c/0xe0
[   65.923087]  idempotent_init_module+0x179/0x230
[   65.923087]  __x64_sys_finit_module+0x5d/0xa0
[   65.923087]  do_syscall_64+0x76/0x120
[   65.923087]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   65.923087] RIP: 0033:0x7f2d80f1e88d
[   65.923087] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
[   65.923087] RSP: 002b:00007ffc7bc1aa78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   65.923087] RAX: ffffffffffffffda RBX: 0000564c9c1db130 RCX: 00007f2d80f1e88d
[   65.923087] RDX: 0000000000000000 RSI: 0000564c9c1e5480 RDI: 000000000000000f
[   65.923087] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000002
[   65.923087] R10: 000000000000000f R11: 0000000000000246 R12: 0000564c9c1e5480
[   65.923087] R13: 0000564c9c1db260 R14: 0000000000000000 R15: 0000564c9c1e54b0
[   65.923087]  </TASK>
[   65.923927] ---[ end trace ]---

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 01c4e8753294..f02305089b56 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1698,7 +1698,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.34.1


