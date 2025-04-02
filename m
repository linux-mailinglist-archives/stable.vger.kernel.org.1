Return-Path: <stable+bounces-127395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68854A789D4
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755E116A3BD
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B026235341;
	Wed,  2 Apr 2025 08:28:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6E234977
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582514; cv=fail; b=YHfYvCto1xFNWeVgiDXviwkK7hZsf5YEvsisTDSkBuqyj+EAvp1aBW5Q7T39VFP1fh08VF6jr0S7cNZiSMTQm/BqMeEV2sY5iTrZGjskXkud7Dsdq4IeQrG0Nkj58uLN04Psse2pLMkMTT9SnxE3sqrajXbnwrB4YulqbxNYiwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582514; c=relaxed/simple;
	bh=+yKc69Imdp0bsOPpPFFgMztxu2FG7ruEA00yvSVMPFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cp+srdSmMYhlbDbQw6B5G0u9IxItqsmyRxhU0szNmLWO10Lp5AyXtNp9IVYVJ7DyxE6sScJVZcnGUyfbp2zik4XhgHWXsFiIywxt0LSySq5KzLMH3K68tKZAqAbLRSBzENxCfyPq/SxuG9sPX/+99h35xJct4Em4ZLd0LPwAFUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5326PgIh015434;
	Wed, 2 Apr 2025 01:28:28 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtf2ggqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 01:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy8yPei6TonC3HtjqvbP3pHJ19VS4+r4SNNYpSVGoZRUBNWWYgGZL3zpl4DrNRpepWRUqiuVLPg0sNjjozRXgNZ4HJD+nksSWLsfUg/6qRPhka9tqXUp84eC1QTY+MYqsLZKNl1eoBAysc3Gqud1MWGbwOkPZaOk6WzGtvPNQa8azJhdIpa3IlG8czHgCSFUnZlfX+Lxq8ZH7jc+LS7/VXu/iXRgvbJS7EHUJrkcqcAXmC5oU6nFEQxIPnvOKgkThDJth7s+Y+CpjorijM/BmclRMzLNNvUEKVGxLXHcpE2F9Uw/cJjqETKr03Z0aPGZLiUQkBvtz/Mf79eKLuAWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agKEmhus6kxWDB0M56FdIPiahfIGwM6Tj6a6HazdvjQ=;
 b=PbeS2se7v7frQc088ly5ThOmuT78VPFZL02eTEiHTZetcJgfGoPW4z6OE5g0mE8wtNn4xvrd0k4dUqlE9BppKBRDXWIjVB3RmVdvcSak5Y+fyvkgIABZikj/TUtK1C8NYwey+2QdL/8F452bt9Fwpt5Ko3POIwNS2MkamJqOH8qunnciSHHuzkkPpHscpNaCXOixkx7n+yha422WiAcMyiuufnkw3sEAkO8mBg32e1q9jzkhmrv+qiamk3qrXdwzW+1602EIJeLNCWFNtshR/PGxYSVEb6oVreyp1IpzxNoNc3fpH8FFYzAwx+mD6fVDjZndtPSLe5IhcaKEYQbp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 08:28:25 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 08:28:25 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        wenlin.kang@windriver.com
Subject: [PATCH 6.6.y 2/6] binfmt_elf: elf_bss no longer used by load_elf_binary()
Date: Wed,  2 Apr 2025 16:26:52 +0800
Message-Id: <20250402082656.4177277-3-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250402082656.4177277-1-wenlin.kang@windriver.com>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb8250d-4864-4f68-e81c-08dd71c05653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/SgHkndv6Rx6n0+MrSuXz9xPEReIVzefs7C3991Whag8Z8atf4VKu67qBN6?=
 =?us-ascii?Q?EcArqSjSP5b34j7t4B/V8Rguh2761a9+406ELXA5VTdIChHAjNrhb2lCrDVn?=
 =?us-ascii?Q?rTtoATrn99kQIvTE7OWRTDuk/n4bhdUYBdroI0HpzVKZHSTvKGMugrIbR5mB?=
 =?us-ascii?Q?NqN0KjSUXPVUJq+Ut8Ugu3FAn4vAnxV5pIXfzrdEn+x8zKfQwIR2Q72ziqHA?=
 =?us-ascii?Q?G/tZc9N/UGo50gRM1NCmmmJOGfsmfgElAceEJD4qlCxxRHLPZOodiptgwfPT?=
 =?us-ascii?Q?6h7Pam22VGJQyjQioqgGh+AqxF616PTAyXv/z/Qm7TLc+iFMgHUqghPiC8gb?=
 =?us-ascii?Q?USDAfT0KPIOMcLgW0V5ZipEvboO0yoispQhTKRoA5jROwwHKBhKvbjt4iWE7?=
 =?us-ascii?Q?TkIFEWd/NUhHux1u6Cik4yEGw+6Urup7FvSYvKx38F3NNMnIhx0qZBZc4BIq?=
 =?us-ascii?Q?XEV3fRgComrtwOEQ4QGNaYZLlNNzB9Ix+4S0Tvx/lNzFLSxyn2H8GSmRnhX5?=
 =?us-ascii?Q?ZMp3QoGhVqPczCX/8+4v5ay0JgQ3OwJ4zw39bnuEAX48JylPg4f6yKX+Bx9l?=
 =?us-ascii?Q?UsqZkLgT4j3dRNgStT3OwmM0QTJYQxgdQjwiFVgRvHXsV6ff6unGbHWeTEm8?=
 =?us-ascii?Q?MbjRhHGIufWbH1DWIBG1z8fh+Vu9lZuV60zpLIbfXjseuaI9hZ6ZZGQc3E5h?=
 =?us-ascii?Q?OdataN3uNp5FMYWV0nrynOtELgQ8ULaF8sp4xRgqgFCRLYdZapsdodsJX3jj?=
 =?us-ascii?Q?hdXRnvHagVAr7+VA5JO46zMq/WmM7FAPnFSxHFkj/excdIS6a5Hq8j/l/9sW?=
 =?us-ascii?Q?Pxw7uQSZh2tErdUbwjCIsBZJZ1/yldd045wrFq+GOFKEqtSHZCZfpsnEers8?=
 =?us-ascii?Q?0TFv2YZvtjKQ+897qYFkwSQ/5Vb9k2Oxm4Ya3PBeQFbOcNKET3XWFFXI6Q0k?=
 =?us-ascii?Q?tHsxiNpABAzVTVYqm8TT4WXQBinGgv/WIA6V0AURfl+CkDpC28yAWBrVEdni?=
 =?us-ascii?Q?HIHF1CILadqsTLP5LOUSnPwSH4aj5swi5uXPJgetWhsKx6v6pGLKEUM7Cykh?=
 =?us-ascii?Q?rs8geMPBosc/CPjt5zx3N/8tZUzmWvf2TNslVaSoNWOTaDP2QVyECzEEDNRh?=
 =?us-ascii?Q?G6Kj46+1FDDWHZhSye/8bGNWuHK5a34efCdSj854mFntBA8fr9FloP7NKDtf?=
 =?us-ascii?Q?126GBmluWX5xvr7Hw5Gqn1x7i0RGiKqtkWQuFnY3uVIXPaSJi7RqBeAg23rg?=
 =?us-ascii?Q?1e5JH7He99EGHf3DaljN3rIkyBSf7w14wsEBeP16LqTCJdThTXOdSCLrZ60d?=
 =?us-ascii?Q?YISEU1EB4lylFy+0bMVcNKjakdJ1YptsUrBLGFrU2Poe9Yn1OOS2Kw4Uz/z+?=
 =?us-ascii?Q?vr5Sq23xs9vJAJyvG3AmHo89no3gVcF33R5l9DbUPbkPMhUXq5zL6c4jTyFk?=
 =?us-ascii?Q?5l5AenYDVGbsVdVDro5RrakMNQ1xZC7j/1XflPrY69DrdB4aHK1VCktv2hQ3?=
 =?us-ascii?Q?1SrLuGQ+fjBB1ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p58hYPrJf4B0qjutP3qyKtrrDgOe7mMI+UAuiSofmYoXbk63vZUcW0hTPbmc?=
 =?us-ascii?Q?ln64MU7ABMUoq6q4W7vJNhOSGjcAC0aJq+FhldHRIBErR2QBDNVv5C+d92OM?=
 =?us-ascii?Q?yGVPoergqfMNfK854ZkCN0J6iFtJOvtBZ0ShTqXfIBWt+f/gWnf822y3mdLM?=
 =?us-ascii?Q?vuwYRA82QUu8hoko26olrJ/KqkjphGg45wpWBmUFkFqYgBZAKOBm5gjHKBVH?=
 =?us-ascii?Q?K9B83Z9vLjAxjsAC0k+BSxhvWwm4bLA0S/4NHe4klqxyQtmY0b2T/BWcbZQu?=
 =?us-ascii?Q?4YQ2dh4yHa6V62oIDI+8QRjAq6fHoOKZWBeJ+psl7nREJOEQQCc2QdiQJg55?=
 =?us-ascii?Q?fzgXwsTZTsEvY/5UZLIpSkWmuUNY1SzSB5XD/RQNwuFBmVXugdqGeRnueS60?=
 =?us-ascii?Q?QVKhRLQD98LHGIMACEukW6dSdCDJ1yF2HKlbCJPRObmStF5HJcWQEbNZBr7C?=
 =?us-ascii?Q?/lnM1uoOz3d/ZQicvQXKm3vcRMWRJ5/jMei5VltLv5hT61oga+YebJLs+8un?=
 =?us-ascii?Q?bKWToG/f00Kbm5TxXw2fZSn4WSZMAcuvtUHwBS6XYQpbSrDl+upbi8pCdfRL?=
 =?us-ascii?Q?DCo10tZqn3AMEcCkMgT5/5I3YAqn7uDMjVQNl9tLixI4XDLPUQc8KHlO350+?=
 =?us-ascii?Q?Dp8ImvZ9cH0jHtOit2TVgLhBOMMLjN8JUmzKpeLA6Dp1Yyyd/Dv8D+ptvVL7?=
 =?us-ascii?Q?xwOqcRxqh9/QFr7LoJTfQRiH6lf8R4F+AkTBScu/E5Rhy3mBhwMK0xQG9i4E?=
 =?us-ascii?Q?ZQzSIAc91/oE562l9DS5mqCBUI5eLN5c6R/miqh55z+RA17SPpThFmS6Tqgc?=
 =?us-ascii?Q?Gh51b4I8NJA+IBR3GMzeU5mqjWgkbpnCi5OSZIDry/enRvjVuKWd1xeQKezV?=
 =?us-ascii?Q?5R8VCcvuLS41rBgYBuqpr812qb0qLTLudUhcjPVHp6POiOYOaMd5qbSVfCIy?=
 =?us-ascii?Q?1zHL0C1wPraVDoUrHiZ15VdZGjVvIsVRXAgTpiudxWzSfVoF3+XdLvBZrIOd?=
 =?us-ascii?Q?VngqXUF+gYea+D5Xqct9zjmnriipR7wgX56CtPBQAr2Y0dEzD3UylYmg2iQZ?=
 =?us-ascii?Q?mVYZqSDFFpkSn4PLEBvFkFqGfvZquLz2nqaOLQbSoqSBBi8i0sBNtePRfn7x?=
 =?us-ascii?Q?DE1NxY8zeKo1k0aL48kBuY+Mj2F6bbD81pORErj478OVzrkiC1P+Tg4i5eYo?=
 =?us-ascii?Q?5b3FxDFRG4sZxC0EIQvdrTVq6gKeatq1Xm5QRajgu2+ha5GO/n5z2xWKHj3r?=
 =?us-ascii?Q?rwnYcQEgLDSWFJNHiPMnC0h47K9Mxq5rFgld/B7qbw/4gEjlsaD8TynvGdnA?=
 =?us-ascii?Q?EKLHIaJG3JKSaq3eJNMCmYg3YblpFfJMrTtHfuCvujm20mtvijwjQM3YbWze?=
 =?us-ascii?Q?MtSSvalyVpSjnV8EYn4V/wAVkjiwcybkAp1ugBTkArMP8B7o4AEaJgcLQPJg?=
 =?us-ascii?Q?Tnq8e2vyWYFrrsrFWNsqq4t5bWsYRy8eG6jaCx1NX/m9TzTvNHq5npWMjdNH?=
 =?us-ascii?Q?9GQq78VDXzzrc8cJlet1/EAOUY4WQNC+ChUm7hIo4yEabr9hSlrIkDjw5lCR?=
 =?us-ascii?Q?GwCd7zLrkiN8x+Hxf6Xc7IEe4muc8ZMfsUXNiLltrLAIKgUsk0OYNbfLlJ/L?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb8250d-4864-4f68-e81c-08dd71c05653
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 08:28:25.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMMLdPkZB6LasuXzKtwXAaU0k/ZKgYm/K1WnPIlLYcgjCi4X/FguKHeQ1SJ6HO9RM1OrRRC7v9+GnlxczdmQac2gwN4w6aD4xctr5C1WPlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-Proofpoint-ORIG-GUID: LGOydyn2PM-LxY2Ied0KVjZgBGHBvTGq
X-Proofpoint-GUID: LGOydyn2PM-LxY2Ied0KVjZgBGHBvTGq
X-Authority-Analysis: v=2.4 cv=fM453Yae c=1 sm=1 tr=0 ts=67ecf52b cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=PtDNVHqPAAAA:8 a=drOt6m5kAAAA:8 a=37rDS-QxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=4SbYnOkRrUTJkninE0wA:9 a=BpimnaHY1jUKGyF_4-AF:22 a=RMMjzBEyIzXRtoq5n5K6:22
 a=k1Nq6YrhK2t884LQW06G:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020053

From: Kees Cook <keescook@chromium.org>

commit 8ed2ef21ff564cf4a25c098ace510ee6513c9836 upstream

With the BSS handled generically via the new filesz/memsz mismatch
handling logic in elf_load(), elf_bss no longer needs to be tracked.
Drop the variable.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-2-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d59bca23c4bd..02258b28e370 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -854,7 +854,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
+	unsigned long elf_brk;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1046,7 +1046,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto out_free_dentry;
 
-	elf_bss = 0;
 	elf_brk = 0;
 
 	start_code = ~0UL;
@@ -1209,8 +1208,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
-		if (k > elf_bss)
-			elf_bss = k;
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
@@ -1222,7 +1219,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
-- 
2.43.0


