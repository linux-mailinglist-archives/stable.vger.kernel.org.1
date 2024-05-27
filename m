Return-Path: <stable+bounces-46568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5458D08C3
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4120C28EF64
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5213361FDB;
	Mon, 27 May 2024 16:36:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2065.outbound.protection.outlook.com [40.92.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16273477
	for <stable@vger.kernel.org>; Mon, 27 May 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827769; cv=fail; b=EMLSnM1tf0i/fvJgGSZsoxNBTGCsw+7dnmosDpZJIPCObv3AenHZsKxqdwik47/7C6ED+KNrNGg8CYBLxs6j/77QNgAlL4Z7UDORPaIwCmFAdqWSiXy/kcc9mB+wfz2tFXZBNURtMgDmjh3uMjn7vmGQY/5BcbmeB9LM0/LP37o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827769; c=relaxed/simple;
	bh=MFTLs0wqzjN+AY8HOE4DonFdt8iHr1Am/O7TuM2fhAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pR7ERPyHD/N/CQ4rXP93J0Z20q42KErjYKSB/cIxGU2pIa9lgqCLOfYMhPpd+lUaJKtZkO7R8SgG+cIYY5k8juabbNfFY+EtVOyLDikjgENnFLO/HOyWF1TmT3nDZucTMQiFSf3hVd7s4PJ2se8epSJXreRmAaen50cl5KMVTc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; arc=fail smtp.client-ip=40.92.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTMfvoCRUPlPvSRuE0vAD3xPVgqwzkq9zIg3d5f7doaBYVFZw1fTjv1SoT+9C3XtQC5ICNmLLwprHZ5uEp8w3zNc1qp/sJrzMCrK7a5TZd1N3rGqg/ODLnDjzMn32qwFntFocfNMbtILI7QYvHBzo9ZoiqBvkLxriAYfPKfVnwmUb3OGtM5dEQgv/zawf1/bUFTEh84L/u6W6hbLwjeZPfh0crGScm+qk/wwdJz5R0Fos+TLOKallDu1LbIF9y9fnRLmJgaYDcOkyqskbI8T9V5fPVSFekkjnnOh+Py2rG6E0kJ4EDHNxDD4l88/NpkPB6t03kbPuCKcubyK1KBSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s56yG+jy/dsPlBBvi8NGufcuuAkDNvzTXSA6fp6OnoM=;
 b=dk3NpdxjSwu4d/A1mzOIVgks5J51/Ocy3gKdd6yIBDwIJeDMNqudDUmwhPNuSOvfhLaRUaNtVGDMNuBed9trmbX5OKSw+kn9Tg/XTPrPzIUEdHoIem9zyGzgImL7GYptJXtP5eD75dNkHS7c9/KEJUb7sjCmz2TOEARWecXJDptKJTzA9iNcL6r5EEMOjcV/mApH8MGwcyJXS1pmZ8nLA9K0ylhY56ajozUvWM/QtPCfSYxTe3h0Tn6NUn4Ank9vuVGZn8GHcHhOW6pnAhAJg8MEBGSPbwps+xydizcsmDjZ69M3ebdY3XLKl/fakO1V3OVFoImppZTZ4fTvAvQhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PR3PR02MB6012.eurprd02.prod.outlook.com (2603:10a6:102:69::18)
 by DU2PR02MB10229.eurprd02.prod.outlook.com (2603:10a6:10:496::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 16:36:03 +0000
Received: from PR3PR02MB6012.eurprd02.prod.outlook.com
 ([fe80::15a3:e65a:6972:b802]) by PR3PR02MB6012.eurprd02.prod.outlook.com
 ([fe80::15a3:e65a:6972:b802%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 16:36:03 +0000
Date: Mon, 27 May 2024 18:36:02 +0200
From: Tim Teichmann <teichmanntim@outlook.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev, 
	x86@kernel.org, stable@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
Message-ID:
 <PR3PR02MB6012EDF7EBA8045FBB03C434B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <87r0dqdf0r.ffs@tglx>
 <gtgsklvltu5pzeiqn7fwaktdsywk2re75unapgbcarlmqkya5a@mt7pi4j2f7b3>
 <87h6ejd0wt.ffs@tglx>
 <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <874jajcn9r.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jajcn9r.ffs@tglx>
X-TMN: [ASpYzi+zeop+oKT8KkkB6Pg1cGgUUlY/CmX7CLF6jLPqv+jiuplWdJAoZUSJHf/B]
X-ClientProxiedBy: PA7P264CA0299.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::10) To PR3PR02MB6012.eurprd02.prod.outlook.com
 (2603:10a6:102:69::18)
X-Microsoft-Original-Message-ID:
 <hhex7ifj3flkvfzpq3so55gzkz5xm5m2hqg73dh6a3kzlvgr7m@efsjmgebzw7p>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR02MB6012:EE_|DU2PR02MB10229:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ec0e99-3737-4665-b03e-08dc7e6b1977
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	2AeHEB0S9syQ0DUzINbKdsGnK2deSnJkqHsLb/YzjjcdpnBFajI2F+z7y1hebnjD3jVD7K6UEmwRn7FfVN9Rs94Nxq+st8GXm6U8yTZo2RzuKO4IVqgbr0NtPjMXXo7EkirLFlev8JrxNVieQkg5iHvTq/aoNNwYhceiAzYZ67L2JsRmFE9fszoGtRahZXI4Fl/3EeZuRMdtXuS4uC3zgbR9Lp6kgEwIjFDvyh7t7ChIMxReS0RCSlUDCQY5rm63fYRN9nA+jvHRUbNfdAvcPmjb94RaFBE3KVN4CmDR03XXQN2BcS5zcyGd8oJiOGXiEwU5epQLgaBQp60U4rX2wgziWga6ybU9lNSohOauad0VHLS5MNWU19iLGZ5Rhn3V85Sl+ypVgK+ad1grvDL8dOzr2NCMzvpcey1X6ZtukEreRHsBQOZTougbYecgv0Qwtqc+qu+zhSAGhXpLD/8dyYbZQpzcshRJGYMGqZUforBSfSMQbNoLHnxsrnrfwmmuEh7Rpk6uPPDKF6FOimY0mMtKf6L6E7WuiTdG4KfzrenBCbdLfhtvSpQfQfKjVCK6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oTePsso2/D33nC2tinVl4ggxPlj8lA7AMoTWz50cZxdGPA/xyYF+L/DVCsR2?=
 =?us-ascii?Q?cV3lCHGUw5+MoL+AteLyxA82Wdm2dD9fFzBSviMMGHjybvjeAuhFcgybhK8w?=
 =?us-ascii?Q?Gn9Np6/R5eMnkJk9cyIqMMrI/ELoS/gzyFEm99sVaZl+bG3HNW+UF8uTF9yT?=
 =?us-ascii?Q?zyaKhoKdzrj4UA83XZIvU95kUGrwMjlirDyccuV1+5Fl9t6gty6k59j8BROu?=
 =?us-ascii?Q?m0pzEnpS4PGnXHVLijnhjPFU2ItF/8+ZN8DYK323/Tt+rScEl4//FSgypzVG?=
 =?us-ascii?Q?QQYF9jS3oDxdRdekFySS3K87r3LAJlDbLRTRxibcCIad550aOYTKeCOzXm/S?=
 =?us-ascii?Q?rhMponQJFuK/P8pWoHvXxo77aPBnwqefUehP3yswfdL6/VDpMti1e45Qo5xn?=
 =?us-ascii?Q?xgkv0h7WYhQJbb/xai2Aiill+ngqvVdzO7h6Faj1jYjWXA74OzFWmeN9F9uw?=
 =?us-ascii?Q?J5on9tytlahwwbsT546hHkEKSRVlyMtPlXSkHq54uPaEslW/RXwv0fZIPRPl?=
 =?us-ascii?Q?H8e09+NA5agok+6vEVcKIhRqRiVAIQrf832owD2aQRNDPPri2HUNIr8q/7Ym?=
 =?us-ascii?Q?SIdTs4uTbKux1U0VEMawVFsJwMfmREYDvMhZsRN1iiUIznO4d9fxfTMZwmNa?=
 =?us-ascii?Q?F0RoftaAJILOxNjetMF/ni/sme1peK82Onknl2f0pBUqAlkT/LZT/hEGvAcG?=
 =?us-ascii?Q?xf2MgsV4cVppUBXl5syEgKZfHTi/oIlw41WprZYiYT3iVbar09bOMWE3QqZG?=
 =?us-ascii?Q?LRPD185HOUoKHsAwvXjwSGf57eCQhV6ISzyJrdJ3P8iMJxOCPoXZDfEzqxRH?=
 =?us-ascii?Q?4/u0NHi2aar0MKhAzX3H/+J0C+xfcXc3iWfq1mvk+Y/BG595JRQeQVtkY+cA?=
 =?us-ascii?Q?T320XD7AgQgUc968gOJiDrbHOQshnIUHemdZj50cGcaBWVg1yl39IeFNrU/s?=
 =?us-ascii?Q?8hJoFMcD+MFjrPjHAJ/hStPx1xV3HnAnl28cQmQXNUL8SM5gknepZ6Ym2d09?=
 =?us-ascii?Q?NO1rJihfPwZAyEPwon+3wuzXj6rCEX3lDUvez4463XApQIl/hAvA2oMEs2K+?=
 =?us-ascii?Q?ro6T8Vu1iDHiJHcL9kY0DfBI8yLnvWzZZlYt+Upv13CWyr71gZSLedvG6Zsz?=
 =?us-ascii?Q?poAivu83SbNLv6xNs1zBuDhfRwB5n6g9Y5EYb0hLMcwOsguf1RQl3HCjJq0/?=
 =?us-ascii?Q?XqYYSaNcRoLx/DyQYfkfyfhpkSbLEI8ezcXHkRmNt9FtilaMj7l9ihxNuLKY?=
 =?us-ascii?Q?/MJMIyVvg3LZiyY/4YKTQol1Ad9TZMC/eFIi4TKSb7rAcvPboRbvkj7Sk5BY?=
 =?us-ascii?Q?gQvfBiMSo26SCmdPD04LLMx+?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ec0e99-3737-4665-b03e-08dc7e6b1977
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6012.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 16:36:03.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10229

Hi Thomas,

On 24/05/27 05:01pm, Thomas Gleixner wrote:
> Tim!
> 
> On Mon, May 27 2024 at 14:35, Tim Teichmann wrote:
> > On 27/05/2024 12:06, Thomas Gleixner wrote:
> >> Christian! On Sat, May 25 2024 at 02:12, Christian Heusel wrote:
> >>> On 24/05/25 12:24AM, Thomas Gleixner wrote:
> >>>> Can you please provide the full boot log as the information which 
> >>>> leads up to the symptom is obviously more interesting than the 
> >>>> symptom itself. 
> >>> I have attached the full dmesg of an example of a bad boot (from 
> >>> doing the bisection), sorry that I missed that when putting together 
> >>> the initial report! 
> >> Thanks for the data. Can you please provide the output of # cat 
> >> /proc/cpuinfo from a working kernel? Thanks, tglx 
> >
> > Right here is the output of
> 
> Thanks for this. Can you also provide the output of:
> 
> # cpuid -r
> 
> please?
> 
> Thanks,
> 
>         tglx

Right here is the output of the

# cpuid -r

command:

Basic Leafs :
================
0x00000000: EAX=0x0000000d, EBX=0x68747541, ECX=0x444d4163, EDX=0x69746e65
0x00000001: EAX=0x00600f20, EBX=0x00080800, ECX=0x3e98320b, EDX=0x178bfbff
0x00000005: EAX=0x00000040, EBX=0x00000040, ECX=0x00000003, EDX=0x00000000
0x00000006: EAX=0x00000000, EBX=0x00000000, ECX=0x00000001, EDX=0x00000000
0x00000007: subleafs:
  0: EAX=0x00000000, EBX=0x00000008, ECX=0x00000000, EDX=0x00000000
0x0000000d: subleafs:
  0: EAX=0x00000007, EBX=0x00000340, ECX=0x000003c0, EDX=0x40000000
  2: EAX=0x00000100, EBX=0x00000240, ECX=0x00000000, EDX=0x00000000
Extended Leafs :
================
0x80000000: EAX=0x8000001e, EBX=0x68747541, ECX=0x444d4163, EDX=0x69746e65
0x80000001: EAX=0x00600f20, EBX=0x10000000, ECX=0x01eb3fff, EDX=0x2fd3fbff
0x80000002: EAX=0x20444d41, EBX=0x74285846, ECX=0x382d296d, EDX=0x20303033
0x80000003: EAX=0x68676945, EBX=0x6f432d74, ECX=0x50206572, EDX=0x65636f72
0x80000004: EAX=0x726f7373, EBX=0x20202020, ECX=0x20202020, EDX=0x00202020
0x80000005: EAX=0xff40ff18, EBX=0xff40ff30, ECX=0x10040140, EDX=0x40020140
0x80000006: EAX=0x64006400, EBX=0x64004200, ECX=0x08008140, EDX=0x0040c140
0x80000007: EAX=0x00000000, EBX=0x00000000, ECX=0x00000000, EDX=0x000007d9
0x80000008: EAX=0x00003030, EBX=0x00001000, ECX=0x00004007, EDX=0x00000000
0x8000000a: EAX=0x00000001, EBX=0x00010000, ECX=0x00000000, EDX=0x00001cff
0x80000019: EAX=0xf040f018, EBX=0x64006400, ECX=0x00000000, EDX=0x00000000
0x8000001a: EAX=0x00000003, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
0x8000001b: EAX=0x000000ff, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
0x8000001c: EAX=0x00000000, EBX=0x80032013, ECX=0x00010200, EDX=0x8000000f
0x8000001d: subleafs:
  0: EAX=0x00000121, EBX=0x00c0003f, ECX=0x0000003f, EDX=0x00000000
  1: EAX=0x00004122, EBX=0x0040003f, ECX=0x000001ff, EDX=0x00000000
  2: EAX=0x00004143, EBX=0x03c0003f, ECX=0x000007ff, EDX=0x00000001
  3: EAX=0x0001c163, EBX=0x0fc0003f, ECX=0x000007ff, EDX=0x00000001
0x8000001e: EAX=0x00000000, EBX=0x00000100, ECX=0x00000000, EDX=0x00000000

Thank you,
Tim Teichmann

